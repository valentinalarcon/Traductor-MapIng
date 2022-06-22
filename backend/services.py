from traductor_ingesp import translate_ingesp
from traductor import translate


def t_ing_esp(data):
    sentence = str(data["text"])
    try: 
        traduccion = translate_ingesp(sentence)
        return traduccion
    except Exception:
        return "No se ha podido traducir"

def t_esp_map(data):
    sentence = str(data["text"])
    modelo = 'mapespanol.h5'
    dataset = 'mapespanol.csv'
    try:
        traduccion = translate(modelo,dataset, sentence)
        return traduccion
    except Exception:
        return "No se ha podido traducir"
