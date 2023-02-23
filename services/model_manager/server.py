import json
from flask import Flask, request, send_file
import requests
from face import processFace
from error_module import missing_model_id, invalid_model_id
from datetime import datetime
from zlib import compress
import io
from zipfile import ZipFile
app = Flask(__name__)

models_endpoints = {
    'model1': 'http://model01:9999/predict',
    'model2': 'http://model02:9999/predict',
}


def log(message):
    # Write to log file
    with open('/logs/log.txt', 'a') as f:
        timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        f.write('{0} - {1}\n'.format(timestamp, message))


@app.route("/model", methods=['POST'])
def pickModel(request=request):
    start = datetime.now()
    # Log current request
    print("/model: Request received with data: ", request.data)

    model_id = request.args.get('model_id')

    if model_id is None:
        return app.response_class(response=json.dumps(missing_model_id()), mimetype='application/json')

    if model_id not in models_endpoints:
        return app.response_class(response=json.dumps(invalid_model_id()), mimetype='application/json')

    print("/model: Request received from {0} with data: {1} for model {2}".format(request.remote_addr,
                                                                                  request.data, request.args.get('model_id')))

    model_endpoint = models_endpoints[model_id]

    _json = request.json

    response = requests.post(model_endpoint, json=_json)

    end = datetime.now()
    log("/model: Time elapsed: {0}".format(end - start))
    log("/model: Response from model {0}: {1}".format(
        model_id, response.json()))

    return app.response_class(response=json.dumps({"status": 'ok', "data": response.json()}), mimetype='application/json')


@ app.route("/face", methods=['POST'])
def checkFace(request=request):
    start = datetime.now()

    log("/face: Request received from {0} with data: {1}".format(
        request.remote_addr, request.data))

    png = request.data
    response = processFace(png)

    end = datetime.now()

    log("/face: Time elapsed: {0}".format(end - start))
    log("/face: Response: {0}".format(response))

    return app.response_class(response=json.dumps({"status": 'ok', "data": response}), mimetype='application/json')


@app.route("/logs", methods=['GET'])
def getLogs(request=request):
    zip = ZipFile('/logs/logs.zip', 'w')
    zip.write('/logs/log.txt')
    zip.close()

    # Return logs as download
    return send_file('/logs/logs.zip', as_attachment=True)


if __name__ == '__main__':
    # erase all logs
    open('/logs/log.txt', 'w').close()

    print('Starting Model Manager server...')
    app.run(port=80, host='0.0.0.0')
    print('Model Manager server ended!')
