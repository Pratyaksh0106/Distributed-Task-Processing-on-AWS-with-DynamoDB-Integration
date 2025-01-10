provider "aws" {
  region = "us-east-1" # Replace with your preferred region

}

resource "aws_instance" "flask_app" {
  ami           = "ami-01816d07b1128cd2d" # Replace with a region-specific AMI ID
  instance_type = "t2.micro"

  key_name        = "Project"
  security_groups = ["launch-wizard-2"]
  iam_instance_profile = "instance6role"

  

  tags = {
    Name = "Flask-Distributor"
  }
}

resource "aws_instance" "instance1_a" {
  ami           = "ami-01816d07b1128cd2d" # Replace with a region-specific AMI ID
  instance_type = "t2.micro"

  key_name        = "Project"
  security_groups = ["launch-wizard-2"] 

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y python3 python3-pip
              pip3 install flask

              # Create Flask application
              cat <<EOT >> /home/ec2-user/instance1a.py
              from flask import Flask, request, jsonify

              app = Flask(__name__)

              @app.route('/task', methods=['POST'])
              def task():
                  data = request.get_json()
                  num1 = int(data['num1'])
                  num2 = int(data['num2'])
                  return jsonify({"result": num1 + num2})

              if __name__ == "__main__":
                  app.run(host="0.0.0.0", port=5000)
              EOT

              chmod +x /home/ec2-user/instance1a.py

              
              EOF

  tags = {
    Name = "instance1-a"
  }
}
resource "aws_instance" "instance2_a" {
  ami           = "ami-01816d07b1128cd2d" # Replace with a region-specific AMI ID
  instance_type = "t2.micro"

  key_name        = "Project"
  security_groups = ["launch-wizard-2"] 

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y python3 python3-pip
              pip3 install flask

              # Create Flask application
              cat <<EOT >> /home/ec2-user/instance2a.py
              from flask import Flask, request, jsonify

              app = Flask(__name__)

              @app.route('/task', methods=['POST'])
              def task():
                  data = request.get_json()
                  num1 = int(data['num1'])
                  num2 = int(data['num2'])
                  return jsonify({"result": num1 + num2})

              if __name__ == "__main__":
                  app.run(host="0.0.0.0", port=5000)
              EOT

              

              
              EOF

  tags = {
    Name = "instance2-a"
  }
}
resource "aws_instance" "instance3_a" {
  ami           = "ami-01816d07b1128cd2d" # Replace with a region-specific AMI ID
  instance_type = "t2.micro"

  key_name        = "Project"
  security_groups = ["launch-wizard-2"] 

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y python3 python3-pip
              pip3 install flask

              # Create Flask application
              cat <<EOT >> /home/ec2-user/instance3a.py
              from flask import Flask, request, jsonify

              app = Flask(__name__)

              @app.route('/task', methods=['POST'])
              def task():
                  data = request.get_json()
                  num1 = int(data['num1'])
                  num2 = int(data['num2'])
                  return jsonify({"result": num1 + num2})

              if __name__ == "__main__":
                  app.run(host="0.0.0.0", port=5000)
              EOT

              

              
              EOF

  tags = {
    Name = "instance3-a"
  }
}
resource "aws_instance" "instance1_b" {
  ami           = "ami-01816d07b1128cd2d" # Replace with a region-specific AMI ID
  instance_type = "t2.micro"

  key_name        = "Project"
  security_groups = ["launch-wizard-2"] 


  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y python3 python3-pip
              pip3 install flask

              # Create Flask application
              cat <<EOT >> /home/ec2-user/instance1b.py
              from flask import Flask, request, jsonify

              app = Flask(__name__)

              @app.route('/task', methods=['POST'])
              def task():
                  data = request.get_json()
                  num1 = int(data['num1'])
                  num2 = int(data['num2'])
                  return jsonify({"result": num1 - num2})

              if __name__ == "__main__":
                  app.run(host="0.0.0.0", port=5000)
              EOT

              c

              
              EOF

  tags = {
    Name = "instance1-b"
  }
}
resource "aws_instance" "instance2_b" {
  ami           = "ami-01816d07b1128cd2d" # Replace with a region-specific AMI ID
  instance_type = "t2.micro"

  key_name        = "Project"
  security_groups = ["launch-wizard-2"] 


  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y python3 python3-pip
              pip3 install flask

              # Create Flask application
              cat <<EOT >> /home/ec2-user/instance2b.py
              from flask import Flask, request, jsonify

              app = Flask(__name__)

              @app.route('/task', methods=['POST'])
              def task():
                  data = request.get_json()
                  num1 = int(data['num1'])
                  num2 = int(data['num2'])
                  return jsonify({"result": num1 - num2})

              if __name__ == "__main__":
                  app.run(host="0.0.0.0", port=5000)
              EOT

              

              
              EOF

  tags = {
    Name = "instance2-b"
  }
}
resource "aws_instance" "instance3_b" {
  ami           = "ami-01816d07b1128cd2d" # Replace with a region-specific AMI ID
  instance_type = "t2.micro"

  key_name        = "Project"
  security_groups = ["launch-wizard-2"] 


  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y python3 python3-pip
              pip3 install flask

              # Create Flask application
              cat <<EOT >> /home/ec2-user/instance3b.py
              from flask import Flask, request, jsonify

              app = Flask(__name__)

              @app.route('/task', methods=['POST'])
              def task():
                  data = request.get_json()
                  num1 = int(data['num1'])
                  num2 = int(data['num2'])
                  return jsonify({"result": num1 - num2})

              if __name__ == "__main__":
                  app.run(host="0.0.0.0", port=5000)
              EOT

              

              
              EOF

  tags = {
    Name = "instance3-b"
  }
}

resource "aws_instance" "instance1_c" {
  ami           = "ami-01816d07b1128cd2d" # Replace with a region-specific AMI ID
  instance_type = "t2.micro"

  key_name        = "Project"
  security_groups = ["launch-wizard-2"] 

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y python3 python3-pip
              pip3 install flask

              # Create Flask application
              cat <<EOT >> /home/ec2-user/instance1c.py
              from flask import Flask, request, jsonify

              app = Flask(__name__)

              @app.route('/task', methods=['POST'])
              def task():
                  data = request.get_json()
                  num1 = int(data['num1'])
                  num2 = int(data['num2'])
                  return jsonify({"result": num1 * num2})

              if __name__ == "__main__":
                  app.run(host="0.0.0.0", port=5000)
              EOT

              

              
              EOF

  tags = {
    Name = "instance1-c"
  }
}
resource "aws_instance" "instance2_c" {
  ami           = "ami-01816d07b1128cd2d" # Replace with a region-specific AMI ID
  instance_type = "t2.micro"

  key_name        = "Project"
  security_groups = ["launch-wizard-2"] 

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y python3 python3-pip
              pip3 install flask

              # Create Flask application
              cat <<EOT >> /home/ec2-user/instance2c.py
              from flask import Flask, request, jsonify

              app = Flask(__name__)

              @app.route('/task', methods=['POST'])
              def task():
                  data = request.get_json()
                  num1 = int(data['num1'])
                  num2 = int(data['num2'])
                  return jsonify({"result": num1 * num2})

              if __name__ == "__main__":
                  app.run(host="0.0.0.0", port=5000)
              EOT

             

              
              EOF

  tags = {
    Name = "instance2-c"
  }
}
resource "aws_instance" "instance3_c" {
  ami           = "ami-01816d07b1128cd2d" # Replace with a region-specific AMI ID
  instance_type = "t2.micro"

  key_name        = "Project"
  security_groups = ["launch-wizard-2"] 

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y python3 python3-pip
              pip3 install flask

              # Create Flask application
              cat <<EOT >> /home/ec2-user/instance3c.py
              from flask import Flask, request, jsonify

              app = Flask(__name__)

              @app.route('/task', methods=['POST'])
              def task():
                  data = request.get_json()
                  num1 = int(data['num1'])
                  num2 = int(data['num2'])
                  return jsonify({"result": num1 * num2})

              if __name__ == "__main__":
                  app.run(host="0.0.0.0", port=5000)
              EOT

              

              
              EOF

  tags = {
    Name = "instance3-c"
  }
}
resource "aws_instance" "instance1_d" {
  ami           = "ami-01816d07b1128cd2d" # Replace with a region-specific AMI ID
  instance_type = "t2.micro"

  key_name        = "Project"
  security_groups = ["launch-wizard-2"] 

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y python3 python3-pip
              pip3 install flask

              # Create Flask application
              cat <<EOT >> /home/ec2-user/instance1d.py
              from flask import Flask, request, jsonify

              app = Flask(__name__)

              @app.route('/task', methods=['POST'])
              def task():
                  data = request.get_json()
                  num1 = int(data['num1'])
                  num2 = int(data['num2'])
                  return jsonify({"result": num1 / num2})

              if __name__ == "__main__":
                  app.run(host="0.0.0.0", port=5000)
              EOT
              

              
              EOF

  tags = {
    Name = "instance1-d"
  }
}
resource "aws_instance" "instance2_d" {
  ami           = "ami-01816d07b1128cd2d" # Replace with a region-specific AMI ID
  instance_type = "t2.micro"

  key_name        = "Project"
  security_groups = ["launch-wizard-2"] 

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y python3 python3-pip
              pip3 install flask

              # Create Flask application
              cat <<EOT >> /home/ec2-user/instance2d.py
              from flask import Flask, request, jsonify

              app = Flask(__name__)

              @app.route('/task', methods=['POST'])
              def task():
                  data = request.get_json()
                  num1 = int(data['num1'])
                  num2 = int(data['num2'])
                  return jsonify({"result": num1 / num2})

              if __name__ == "__main__":
                  app.run(host="0.0.0.0", port=5000)
              EOT

              

              
              EOF

  tags = {
    Name = "instance2-d"
  }
}
resource "aws_instance" "instance3_d" {
  ami           = "ami-01816d07b1128cd2d" # Replace with a region-specific AMI ID
  instance_type = "t2.micro"

  key_name        = "Project"
  security_groups = ["launch-wizard-2"] 

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y python3 python3-pip
              pip3 install flask

              # Create Flask application
              cat <<EOT >> /home/ec2-user/instance3d.py
              from flask import Flask, request, jsonify

              app = Flask(__name__)

              @app.route('/task', methods=['POST'])
              def task():
                  data = request.get_json()
                  num1 = int(data['num1'])
                  num2 = int(data['num2'])
                  return jsonify({"result": num1 / num2})

              if __name__ == "__main__":
                  app.run(host="0.0.0.0", port=5000)
              EOT

              

              
              EOF

  tags = {
    Name = "instance3-d"
  }
}