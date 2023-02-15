import json
from flask import Flask, request
import requests
import os
from face import processFace
from error_module import missing_model_id, invalid_model_id

app = Flask(__name__)

models_endpoints = {
    'model1': 'http://model01:9999/predict',
    'model2': 'http://model02:9999/predict',
}


@app.route("/model", methods=['POST'])
def pickModel(request=request):
    # Log current request
    print("Request received with data: ", request.data)

    model_id = request.args.get('model_id')

    if model_id is None:
        return app.response_class(response=json.dumps(missing_model_id()), mimetype='application/json')

    if model_id not in models_endpoints:
        return app.response_class(response=json.dumps(invalid_model_id()), mimetype='application/json')

    model_endpoint = models_endpoints[model_id]

    _json = request.json

    response = requests.post(model_endpoint, json=_json)

    return app.response_class(response=json.dumps({"status": 'ok', "data": response.json()}), mimetype='application/json')


@app.route("/face", methods=['POST'])
def checkFace(request=request):
    png = request.data
    response = processFace(png)

    return app.response_class(response=json.dumps({"status": 'ok', "data": response}), mimetype='application/json')


if __name__ == '__main__':
    print('Starting Model Manager server...')
    app.run(port=80, host='0.0.0.0')
    print('Model Manager server ended!')
