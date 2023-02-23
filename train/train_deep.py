import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import sklearn
from sklearn.neural_network import MLPClassifier
import joblib
from sklearn.model_selection import train_test_split

if __name__ == "__main__":
    # Carrega os dados
    mydf = pd.read_csv('./data.csv')

    targetcol = 'Status'
    independentcols = ['income', 'age', 'Gender']

    mydf['Gender'] = mydf['Gender'].str.lower()

    # Remove rows with missing values
    mydf = mydf.dropna(subset=independentcols)

    mydf['Gender'] = mydf['Gender'].map(
        {'male': 0, 'female': 1, 'joint': 2, 'sex not available': 3})

    y = mydf[targetcol]
    ages = ['<25', '25-34', '35-44', '45-54', '55-64', '65-74', '>74']

    ages_dict = {ages[i]: i for i in range(len(ages))}
    mydf['age'] = mydf['age'].map(ages_dict)

    # Remove rows with missing values
    X = mydf[independentcols]

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.30, random_state=10)

    mlpc = MLPClassifier(hidden_layer_sizes=(8, 8, 8),
                         activation='relu', solver='adam', max_iter=500)
    clf = mlpc
    clf.fit(X=X_train[independentcols], y=y_train)
    clf.independentcols = independentcols
    clf_acuracia = clf.score(X=X_test[independentcols], y=y_test)
    print("Modelo 03 (classificador), criado com acurácia de: [{0}]".format(
        clf_acuracia))
    # Salva ambos os modelos
    joblib.dump(clf, './modelo03.joblib')
    print("Modelo 03 (classificador) salvo com sucesso.")

    pass
