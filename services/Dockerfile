FROM python:3.7

RUN apt-get update

RUN mkdir -p /log
RUN mkdir -p /server

COPY . /server

WORKDIR /server

# Instala pacotes Python
RUN pip install --upgrade pip

COPY requirements.txt /server/requirements.txt

RUN pip install -r /server/requirements.txt

# Expõe alguns diretórios para o HOST
VOLUME /server
VOLUME /log

# Expõe para o HOST algumas portas, por padrão
EXPOSE 80
EXPOSE 8080

CMD ["python", "server.py"]