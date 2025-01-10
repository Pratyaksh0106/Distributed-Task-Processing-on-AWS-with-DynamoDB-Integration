from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/task', methods=['POST'])
def task():
    data = request.get_json()
    num1 = int(data['num1'])
    num2 = int(data['num2'])
    if num2 == 0:
        return jsonify({"result": "Error: Division by zero is not allowed."})
    return jsonify({"result": num1 / num2})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
