import requests
import json

cotacao = requests.get("https://economia.awesomeapi.com.br/last/USD-BRL,EUR-BRL")
cotacao = cotacao.json()
cotacao_dolar = cotacao['USDBRL']['bid']
cotacao_euro = cotacao['EURBRL']['bid']
print(cotacao_dolar, cotacao_euro)
