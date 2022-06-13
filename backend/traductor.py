import numpy as np
from keras_transformer import get_model, decode
import pandas as pd
from google.colab import drive
np.random.seed(0)

#leer set de entrenamiento

# Función que crea los tokens para los 3 idiomas, recibe un string con la ruta del archivo
# retorna 2 arreglos que son español y mapudungun

def build_tokens(filepath):
    dataset = pd.read_excel(filepath)
    dataset = dataset.to_numpy().tolist()
    general_token_ESP = []
    target_token_MAP = []

    for sentence in dataset:
        target_token_MAP.append(str(sentence[0]).split())
        general_token_ESP.append(str(sentence[1]).split())
        
    return general_token_ESP, target_token_MAP

def build_token_dict_inv(token_dict):
    token_dict_inv = {}
    for k,v in token_dict.items():
        token_dict_inv[v] = k
    return token_dict_inv


#Creacion de diccionario y diccionario inverso para español y mapudungun 

#filepath = 'gdrive/My Drive/DESARROLLO PI 2022GPI-I/D/mapudungun.xlsx'
general_token_ESP, target_token_MAP = build_tokens(filepath)
general_token_dict_ESP = build_token_dict(general_token_ESP)
target_token_dict_MAP = build_token_dict(target_token_MAP)
target_token_dict_ESP_inv = build_token_dict_inv(general_token_dict_ESP)
target_token_dict_MAP_inv = build_token_dict_inv(target_token_dict_MAP)
print(general_token_dict_ESP)
input()
print(target_token_dict_MAP)
input()
print(target_token_dict_ESP_inv)
input()
print(target_token_dict_MAP_inv)
input()