import pandas as pd
import json
from flask import Flask, request
import joblib
import sys
app = Flask(__name__)


def getIndexOfAgeInRange(age):
    ageGroups = ['<25', '25-34', '35-44', '45-54', '55-64', '65-74', '>74']

    for i in range(len(ageGroups)):
        if ageGroups[i] == '<25':
            if age < 25:
                return i
        elif ageGroups[i] == '>74':
            if age > 74:
                return i
        else:
            lower = int(ageGroups[i].split('-')[0])
            upper = int(ageGroups[i].split('-')[1])
            if age >= lower and age <= upper:
                return i


@app.route("/predict", methods=['POST'])
def predict(request=request):
    df = pd.DataFrame(request.json)

    if df.shape[0] == 0:
        return "Dados de chamada da API estão incorretos.", 400

    for col in model.independentcols:
        if col not in df.columns:
            print(
                "Coluna {0} não encontrada no dataframe de entrada.".format(col))
            df[col] = 0

    x = df[model.independentcols]

    # Converter idade de volta para o índice do range de idade
    x['age'] = getIndexOfAgeInRange(x['age'].values[0])

    prediction = model.predict_proba(x)
    prediction = prediction.tolist()

    return app.response_class(response=json.dumps({"status": 'ok', "result": prediction[0]}), mimetype='application/json')


if __name__ == '__main__':
    args = sys.argv[1:]
    file = args[0]

    print('Starting Model server for file: {0}'.format(file))
    model = joblib.load(file)
    app.run(port=9999, host='0.0.0.0')
