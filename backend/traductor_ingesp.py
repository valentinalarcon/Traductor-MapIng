#pip install googletrans==3.1.0a0
from googletrans import Translator

def translate_ingesp(source):
    translator = Translator()
    target = translator.translate(source)

    print("Frase original:", source)
    print("Traducción:", target.text)
    return target.text

