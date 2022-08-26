import nltk

from nltk.corpus import stopwords
from nltk.probability import FreqDist
from wordcloud import wordcloud
import string

text = open('comentarios.csv', mode ='r', encoding='utf-8').read()
text = text.lower()

text_sem_pontuacao = ''.join([p for p in text if p not in string.punctuation])

import nltk
nltk.download('punkt')

tokenizacao_palavras = nltk.word_tokenize(text_sem_pontuacao)

nltk.download('stopwords')
stopwords = stopwords.words('portuguese')

palavras_sem_stop = [p for p in tokenizacao_palavras if p not in stopwords]

freq = FreqDist(palavras_sem_stop)
freq = freq.most_common(20)
print(freq)

## https://www.ufsm.br/pet/sistemas-de-informacao/2021/07/12/introducao-a-mineracao-de-textos-com-python/
