import requests

faceEndpoint = "http://face:8080/face"
moderationEndpoint = "http://face:8080/moderation"

def getFace(imageBytes):
    response = requests.post(faceEndpoint, data=imageBytes)
    return response.json()

def checkIfContentIsExplicit(imageBytes):
    response = requests.post(moderationEndpoint, data=imageBytes)
    return response.json()


def processFace(imageBytes):
    return {
        "face": getFace(imageBytes),
        "moderation": checkIfContentIsExplicit(imageBytes)
    }

