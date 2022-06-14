# -*- coding: utf-8 -*-
'''
@desc: 
@author: Facundo Alexandre B. (facundo.alexandreb@utem.cl)
@created_at: 13/06/2022 14:44PM

Cualquier duda sobre el código, favor contactar al mail.
'''

import json
import re
import sys

sys.stdout.reconfigure(encoding='utf-8')

with open("data/diccionario_fonemas.json") as diccionario_fonemas:
        json_data = json.load(diccionario_fonemas)

def get_cadena_fonemas(cadena_original):
    cadena_fonemas = cadena_original

    # 1. Utilizar regex para identificar los fonemas dentro de la cadena original

    for index, letra in enumerate(cadena_fonemas):
        # La "doble l", "ch", "tr" y "ng" son casos especiales, por tanto, se verifica primero
        # de forma manual.
        if (letra in json_data.keys()):
            if (letra == 'l' and index+1 < len(cadena_fonemas) and cadena_fonemas[index+1] == 'l'):
                # ll
                cadena_fonemas = re.sub('ll', json_data['ll']['fonema'], cadena_fonemas)
            elif (letra == 'c' and index+1 < len(cadena_fonemas) and cadena_fonemas[index+1] == 'h'):
                # ch
                cadena_fonemas = re.sub('ch', json_data['ch']['fonema'], cadena_fonemas)
            elif (letra == 't' and index+1 < len(cadena_fonemas) and cadena_fonemas[index+1] == 'r'):
                # tr
                cadena_fonemas = re.sub('tr', json_data['tr']['fonema'], cadena_fonemas)
            elif (letra == 'n' and index+1 < len(cadena_fonemas) and cadena_fonemas[index+1] == 'g'):
                # ng
                cadena_fonemas = re.sub('ng', json_data['ng']['fonema'], cadena_fonemas)
            else:
                # Por cada una de las letras faltantes (las que ya no vengan en formato de fonema /x/) realizar el reemplazo.
                cadena_fonemas = re.sub(letra, json_data[letra]['fonema'], cadena_fonemas)

    print(cadena_fonemas) 

    #print(cadena_fonemas)
    return cadena_fonemas

def get_cadena_pronunciable(cadena_original):
    return

get_cadena_fonemas("llichntallulng")

