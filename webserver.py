from flask import Flask, request
import requests

app = Flask(__name__)

# Define instance URLs for each set
instance_sets = {
    1: {
        "add": "http://<instance-1-1-public-ip>:5000/task",
        "subtract": "http://<instance-1-2-public-ip>:5000/task",
        "multiply": "http://<instance-1-3-public-ip>:5000/task",
        "divide": "http://<instance-1-4-public-ip>:5000/task"
    },
    2: {
        "add": "http://<instance-2-1-public-ip>:5000/task",
        "subtract": "http://<instance-2-2-public-ip>:5000/task",
        "multiply": "http://<instance-2-3-public-ip>:5000/task",
        "divide": "http://<instance-2-4-public-ip>:5000/task"
    },
    3: {
        "add": "http://<instance-3-1-public-ip>:5000/task",
        "subtract": "http://<instance-3-2-public-ip>:5000/task",
        "multiply": "http://<instance-3-3-public-ip>:5000/task",
        "divide": "http://<instance-3-4-public-ip>:5000/task"
    }
}

# Round-robin counter
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

    # Get numbers from form
    num1 = request.form.get("num1")
    num2 = request.form.get("num2")

    # Get the current set of instances
    current_set = counter["current_set"]
    urls = instance_sets[current_set]

    # Update the counter for round-robin
    counter["current_set"] += 1
    if counter["current_set"] > counter["max_set"]:
        counter["current_set"] = 1

    # Send data to each instance in the current set
    results = {}
    for operation, url in urls.items():
        try:
            response = requests.post(url, json={"num1": num1, "num2": num2})
            results[operation] = response.json().get("result")
        except Exception as e:
            results[operation] = f"Error: {str(e)}"

    # Return results to the user
    return f'''
        <h1>Results (Set {current_set})</h1>
        <p>Addition: {results.get("add")}</p>
        <p>Subtraction: {results.get("subtract")}</p>
        <p>Multiplication: {results.get("multiply")}</p>
        <p>Division: {results.get("divide")}</p>
        <a href="/">Go Back</a>
    '''

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
