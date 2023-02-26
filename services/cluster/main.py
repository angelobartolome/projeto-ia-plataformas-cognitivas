import pandas as pd
import json
from flask import Flask, request
from joblib import load
import sys
app = Flask(__name__)


def getAgeGroup(age):
    ageGroups = ['<25', '25-34', '35-44', '45-54', '55-64', '65-74', '>74']

    for i in range(len(ageGroups)):
        if ageGroups[i] == '<25':
            if age < 25:
                return ageGroups[i]
        elif ageGroups[i] == '>74':
            if age > 74:
                return ageGroups[i]
        else:
            lower = int(ageGroups[i].split('-')[0])
            upper = int(ageGroups[i].split('-')[1])
            if age >= lower and age <= upper:
                return ageGroups[i]


@app.route("/predict", methods=['POST'])
def predict(request=request):

    # Carrega o kmeans,labelencoder,scaler de normalização
    kmeans, le_age, le_gender, scaler = load('cluster/cluster.joblib'), load(
        'cluster/labelencoder_age.joblib'), load('cluster/labelencoder_gender.joblib'), load('cluster/scaler.joblib')

    genderMap = ['Female', 'Joint', 'Male', 'Sex Not Available']

    df = pd.DataFrame({
        "income": [request.json[0]['income']],
        "age": le_age.transform([getAgeGroup(request.json[0]['age'])]),
        "year": [2020],
        "Gender": le_gender.transform([genderMap[request.json[0]['Gender']]])
    })

    # Resultado da clusterização
    result = kmeans.predict(scaler.transform(df))
    # Resultado da clusterização

    # Média por cluster
    media = (0.264404, 0.208608, 0.246458, 0.372881, 0.304962, 0.224107)
    # Média por cluster
    classi = (
        "Masculino e LGBT com risco de não pagamento",     # 0
        "Feminino e LGBT de alta renda",                   # 1
        "Feminino e LGBT de media renda de 3° idade",      # 2
        "Homens 2° idade de alta renda",                   # 3
        "Sem definição de sexo oui homens de baixa renda",  # 4
        "Risco de não pagamento"                           # 5
    )

    r = {
        'propensao_media': media[result[0]],
        'grupo': int(result[0]),
        "classificacao": classi[result[0]]
    }

    return app.response_class(response=json.dumps(r), mimetype='application/json')


if __name__ == '__main__':
    print('Starting Model server for cluster')
    app.run(port=9999, host='0.0.0.0')
