import pandas as pd
from sklearn.ensemble import RandomForestClassifier as rfc
import joblib
# from sklearn.metrics import accuracy_score
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

    X = mydf[independentcols]

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.30, random_state=10)

    clf = rfc()
    clf.fit(X=X_train[independentcols], y=y_train)
    clf.independentcols = independentcols
    clf_acuracia = clf.score(X=X_test[independentcols], y=y_test)
    print("Modelo 01 (classificador), criado com acurácia de: [{0}]".format(
        clf_acuracia))

    # Salva ambos os modelos
    joblib.dump(clf, './modelo01.joblib')
    print("Modelo 01 (classificador) salvo com sucesso.")

    pass
