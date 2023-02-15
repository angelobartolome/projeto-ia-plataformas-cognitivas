import pandas as pd
from sklearn.ensemble import RandomForestClassifier as rfc
from sklearn.ensemble import RandomForestRegressor as rfr
from sklearn.ensemble import GradientBoostingClassifier as gbc
from sklearn.ensemble import GradientBoostingRegressor as gbr
import joblib
# from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split

if __name__ == "__main__":
    # Carrega os dados
    mydf = pd.read_csv('./data.csv')

    targetcol = 'Status'
    independentcols = ['income', 'age', 'year', 'Credit_Score']

    # Remove rows with missing values
    mydf = mydf.dropna(subset=independentcols)

    mydf['Gender'] = mydf['Gender'].str.lower()

    y = mydf[targetcol]
    ages = ['<25', '25-34', '35-44', '45-54', '55-64', '65-74', '>74']

    ages_dict = {ages[i]: i for i in range(len(ages))}
    mydf['age'] = mydf['age'].map(ages_dict)

    X = mydf[independentcols]

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.30, random_state=10)

    clf = rfc()
    # Opção de Classificador (comentada):
    # clf = gbc(n_estimators=300, max_depth=5, learning_rate=0.3  )
    clf.fit(X=X_train[independentcols], y=y_train)
    clf.independentcols = independentcols
    clf_acuracia = clf.score(X=X_test[independentcols], y=y_test)
    print("Modelo 01 (classificador), criado com acurácia de: [{0}]".format(
        clf_acuracia))

    rgs = rfr()
    # Opção de Regressor (comentada):
    # rgs = gbr(n_estimators=300, max_depth=5, learning_rate=0.3 )
    rgs.fit(X=X_train[independentcols], y=y_train)
    rgs.independentcols = independentcols
    rgs_acuracia = rgs.score(X=X_test[independentcols], y=y_test)
    print("Modelo 02 (Regressor), criado com acurácia de: [{0}]".format(
        rgs_acuracia))

    # Salva ambos os modelos
    joblib.dump(clf, './modelo01.joblib')
    print("Modelo 01 (classificador) salvo com sucesso.")
    joblib.dump(rgs, './modelo02.joblib')
    print("Modelo 02 (regressor) salvo com sucesso.")

    pass
