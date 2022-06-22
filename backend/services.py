from traductor import translate


def t_ing_esp(data):
    return "Epicardo"

def t_esp_map(data):
    sentence = str(data["text"])
    modelo = 'mapespanol.h5'
    dataset = 'mapespanol.csv'
    try:
        traduccion = translate(modelo,dataset, sentence)
        return traduccion
    except Exception:
        return "No se ha podido traducir"
