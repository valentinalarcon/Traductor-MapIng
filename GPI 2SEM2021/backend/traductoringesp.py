#pip install googletrans==3.1.0a0
from googletrans import Translator
translator = Translator()
textoSalida = translator.translate('cualquier cosa', dest='en')
print(textoSalida.text)