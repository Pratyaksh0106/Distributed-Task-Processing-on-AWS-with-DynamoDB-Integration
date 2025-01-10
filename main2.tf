# DynamoDB Table Definitions
resource "aws_dynamodb_table" "db1" {
  name           = "db1"
  hash_key       = "OperationID"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "OperationID"
    type = "S"
  }

  stream_enabled   = true
  stream_view_type = "NEW_IMAGE"
}

resource "aws_dynamodb_table" "db2" {
  name           = "db2"
  hash_key       = "OperationID"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "OperationID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "db3" {
  name           = "db3"
  hash_key       = "OperationID"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "OperationID"
    type = "S"
  }
}

# IAM Role for EC2 Access to DynamoDB
resource "aws_iam_role" "ec2_dynamodb_access" {
  name = "ec2-dynamodb-access"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy for DynamoDB Access
resource "aws_iam_policy" "dynamodb_access_policy" {
  name        = "DynamoDBAccessPolicy"
  description = "Policy for EC2 instance to access DynamoDB tables"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem"
        ]
        Resource = [
          aws_dynamodb_table.db1.arn,
          aws_dynamodb_table.db2.arn,
          aws_dynamodb_table.db3.arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.ec2_dynamodb_access.name
  policy_arn = aws_iam_policy.dynamodb_access_policy.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-dynamodb-instance-profile"
  role = aws_iam_role.ec2_dynamodb_access.name
}

# EC2 Instance for Running the Script
resource "aws_instance" "ec2_dynamodb_processor" {
  ami           = "ami-0c02fb55956c7d316" # Replace with desired AMI
  instance_type = "t2.micro"
  key_name      = "Project"
  security_groups = ["launch-wizard-2"]

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "EC2-DynamoDB-Processor"
  }

  user_data = <<-EOT
    #!/bin/bash
    yum update -y
    amazon-linux-extras enable python3.8
    amazon-linux-extras install python3.8 -y
    pip3 install boto3

    cat <<EOF > /home/ec2-user/process_dynamodb.py
    import boto3
    from botocore.exceptions import ClientError

    def process_data():
        try:
            dynamodb = boto3.resource('dynamodb')
            db1_table = dynamodb.Table('db1')
            db2_table = dynamodb.Table('db2')
            db3_table = dynamodb.Table('db3')

            response = db1_table.scan()
            items = response.get('Items', [])

            for item in items:
                operation_type = item.get('OperationType')
                if not operation_type:
                    continue
                
                data_to_insert = {
                    'OperationID': item['OperationID'],
                    'Operands': item['Operands'],
                    'Result': item['Result'],
                    'Timestamp': item['Timestamp']
                }

                if operation_type in ['addition', 'subtraction']:
                    db2_table.put_item(Item=data_to_insert)
                elif operation_type in ['multiplication', 'division']:
                    db3_table.put_item(Item=data_to_insert)

            print("Data processing completed.")
        except ClientError as e:
            print(f"Error: {e.response['Error']['Message']}")

    if __name__ == "__main__":
        process_data()
    EOF

    chmod +x /home/ec2-user/process_dynamodb.py
    echo "*/5 * * * * python3 /home/ec2-user/process_dynamodb.py" > /var/spool/cron/ec2-user
    echo "Setup complete." > /tmp/setup.log
  EOT
}
