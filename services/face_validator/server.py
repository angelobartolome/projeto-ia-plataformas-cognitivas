import json
from flask import Flask, request
import boto3
import os

session = boto3.Session(
    aws_access_key_id="AKIAYUKMBYARVMSUMW5B",
    aws_secret_access_key=os.getenv('AWS_SECRET_ACCESS_KEY'),
)

rekognition_client = session.client('rekognition', region_name='us-east-1')

app = Flask(__name__)


@app.route("/face", methods=['POST'])
def call_modelo01(request=request):
    # print(request.values)

    png = request.data

    response = rekognition_client.detect_faces(
        Image={
            'Bytes': png
        },
        Attributes=['ALL']
    )

    return app.response_class(response=json.dumps(response), mimetype='application/json')


@app.route('/moderation', methods=['POST'])
def checkIfImageIsExplicit(request=request):
    # print(request.values)

    png = request.data

    response = rekognition_client.detect_moderation_labels(
        Image={
            'Bytes': png
        }
    )

    if(response['ModerationLabels']):
        for label in response['ModerationLabels']:
            if(label['Confidence'] > 90):
                return app.response_class(response=json.dumps({'explicit': True}), mimetype='application/json')


    return app.response_class(response=json.dumps({'explicit': False}), mimetype='application/json')

if __name__ == '__main__':
    app.run(port=8080, host='0.0.0.0')
