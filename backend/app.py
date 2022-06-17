from traductor import translate
from traductor_ingesp import translate_ingesp

modelo = 'mapespanol.h5'
dataset = 'mapespanol.csv'
traduccion = translate(modelo,dataset,'buenos dias')

print(traduccion)

traduccion2 = translate_ingesp ('hola')

print(traduccion2)
