""" ?Arquivos obrigatórios para esse documento são
    dev.bat
    run.bat
    labelencoder_age.joblib
    labelencoder_gender.joblib
    scaler.joblib
    cluster.joblib
"""


''' ?Exemplo de post
{
	"income": 4980,
	"age": "55-64",
	"gender": "Female"
}
'''


# fastapi==0.92.0
# uvicorn==0.20.0 pip install "uvicorn[standard]"


from fastapi import FastAPI
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from joblib import load
import pandas as pd
app = FastAPI()


class Cont(BaseModel):
    income: int
    age: int
    Gender: int


origins = ['*']

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


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


@app.post('/')
def teste(cont: list[Cont]):

    # Carrega o kmeans,labelencoder,scaler de normalização
    kmeans, le_age, le_gender, scaler = load('cluster.joblib'), load(
        'labelencoder_age.joblib'), load('labelencoder_gender.joblib'), load('scaler.joblib')

    print(cont[0].age)

    genderMap = ['Female', 'Joint', 'Male', 'Sex Not Available']

    df = pd.DataFrame({
        "income": [cont[0].income],
        "age": le_age.transform([getAgeGroup(cont[0].age)]),
        "year": [2020],
        "Gender": le_gender.transform([genderMap[cont[0].Gender]])
    })
    print(df)
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

    response = {
        'propensao_media': media[result[0]],
        'grupo': int(result[0]),
        "classificacao": classi[result[0]]
    }
    return JSONResponse(content=response)
