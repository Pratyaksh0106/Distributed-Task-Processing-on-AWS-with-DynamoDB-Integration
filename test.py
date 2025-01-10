from flask import Flask, request
import requests
import boto3
import uuid


app = Flask(__name__)

instance_sets = {
    1: {
        "add": "http://3.88.174.89:5000/task",
        "subtract": "http://35.172.135.0:5000/task",
        "multiply": "http://44.204.22.119:5000/task",
        "divide": "http://3.82.246.71:5000/task"
    },
    2: {
        "add": "http://3.86.218.14:5000/task",
        "subtract": "http://54.173.113.139:5000/task",
        "multiply": "http://44.203.124.231:5000/task",
        "divide": "http://3.83.22.211:5000/task"
    },
    3: {
        "add": "http://18.207.197.161:5000/task",
        "subtract": "http://3.84.252.204:5000/task",
        "multiply": "http://52.90.29.144:5000/task",
        "divide": "http://3.93.24.80:5000/task"
    }
}

# AWS DynamoDB setup
dynamodb = boto3.resource('dynamodb', region_name='us-east-1')  # Replace with your region
table = dynamodb.Table('db1')


counter = {"current_set": 1, "max_set": 3}

@app.route('/')
def home():
    return '''
        <h1>Task Distributor</h1>
        <form action="/submit" method="post">
            <label for="num1">Enter first number:</label><br>
            <input type="number" id="num1" name="num1"><br>
            <label for="num2">Enter second number:</label><br>
            <input type="number" id="num2" name="num2"><br><br>
            <input type="submit" value="Submit">
        </form>
    '''

@app.route('/submit', methods=['POST'])
def submit():
    global counter

    num1 = request.form.get("num1")
    num2 = request.form.get("num2")

    current_set = counter["current_set"]
    urls = instance_sets[current_set]

    counter["current_set"] += 1
    if counter["current_set"] > counter["max_set"]:
        counter["current_set"] = 1

    results = {}
    for operation, url in urls.items():
        try:
            response = requests.post(url, json={"num1": num1, "num2": num2})
            results[operation] = response.json().get("result")
        except Exception as e:
            results[operation] = f"Error: {str(e)}"
    
    # Save results to DynamoDB
    save_to_dynamodb(num1, num2, results)

    return f'''
        <h1>Results (Set {current_set})</h1>
        <p>Addition: {results.get("add")}</p>
        <p>Subtraction: {results.get("subtract")}</p>
        <p>Multiplication: {results.get("multiply")}</p>
        <p>Division: {results.get("divide")}</p>
        <a href="/">Go Back</a>
    '''
def save_to_dynamodb(num1, num2, results):
    try:
        # Convert float numbers to strings for DynamoDB compatibility
        num1_str = str(num1) if isinstance(num1, float) else num1
        num2_str = str(num2) if isinstance(num2, float) else num2
        results_str = {key: str(value) if isinstance(value, float) else value for key, value in results.items()}

        # Generate a unique ID for the operation
        operation_id = str(uuid.uuid4())

        # Prepare the item for DynamoDB
        item = {
            "operation_id": operation_id,
            "input_a": num1_str,
            "input_b": num2_str,
            "results": results_str,
        }

        # Insert the item into DynamoDB
        table.put_item(Item=item)
        print("Data saved to DynamoDB:", item)
    except Exception as e:
        print(f"Error saving to DynamoDB: {e}")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)


