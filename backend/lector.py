from playsound import playsound
import json
import sys

def diccRutas(array, letra):
	dicc = {
		"e": "assets/Fonemas/Vocales/e.wav",
		"i": "assets/Fonemas/Vocales/i.wav",
		"a": "assets/Fonemas/Vocales/a.wav",
		"o": "assets/Fonemas/Vocales/o.wav",
		"u": "assets/Fonemas/Vocales/u.wav",
		"ü": "assets/Fonemas/Vocales/ü.wav",
		"t": "assets/Fonemas/CH/ch.wav",
		"θ": "assets/Fonemas/D/d.wav",
		"f": "assets/Fonemas/F/f.wav",
		"g": "assets/Fonemas/G/g.wav",
		"k": "assets/Fonemas/K/k.wav",
		"l": "assets/Fonemas/L/l.wav",
		"ʎ": "assets/Fonemas/Ll/Ll.wav",
		"m": "assets/Fonemas/M/m.wav",
		"n": "assets/Fonemas/N/n.wav",
		"": "assets/Fonemas/NG/ng.wav",
		"": "assets/Fonemas/Ñ/ñ.wav",
		"p": "assets/Fonemas/P/p - 2.wav",
		"": "assets/Fonemas/R/r.wav",
		"s": "assets/Fonemas/S/s.wav",
		"t": "assets/Fonemas/T/t.wav",
		"": "assets/Fonemas/TR/tr.wav",
		"w": "assets/Fonemas/W/w.wav",
		"j": "assets/Fonemas/Y/y.wav",
		" ": "assets/Fonemas/silencio.wav",
	}
	array.append(dicc[letra])


def stringToFonema(string, json_data):
    i = 0
    largo = len(string)
    cadena = ""
    while(i<largo):
        aux = True
        if(i<largo-1):
            if(string[i] == "c"):
                temp = string[i]
                i+=1
                temp = temp + string[i]
                aux = False
            if(aux and string[i] == "t" and string[i+1] == "r"):
                temp = string[i]
                i+=1
                temp = temp + string[i]
                aux = False
            if(aux and string[i] == "l" and string[i+1] == "l"):
                temp = string[i]
                i+=1
                temp = temp + string[i]
                aux = False
            if(aux and string[i] == "n" and string[i+1] == "g"):
                temp = string[i]
                i+=1
                temp = temp + string[i]
                aux = False
        if(aux):
            temp = string[i]
        cadena += (json_data[temp]["fonema"])
        i+=1
    return cadena


def fonemasToRuta(cadena, rutas):
    i=0
    largo = len(cadena)
    while(i<largo):
        aux = True
        if(i<largo-1):
            if(cadena[i] == "t" and cadena[i+1] == ""):
                temp = cadena[i]
                i+=1
                temp = temp + cadena[i]
                aux = False
            if(aux and cadena[i] == "" and cadena[i+1] == ""):
                temp = cadena[i]
                i+=1
                temp = temp + cadena[i]
                aux = False
        if(aux):
            temp = cadena[i]
        i+=1
        diccRutas(rutas,temp)


def reproducir(rutas):
    for i in rutas:
        playsound(i)


sys.stdout.reconfigure(encoding='utf-8')
filename = "/home/dymmon/Documentos/tremend/Traductor-MapIng/backend/data/diccionario_fonemas.json"
with open(filename) as diccionario_fonemas:
    json_data = json.load(diccionario_fonemas)
cadena = ""
string = "teni ke ser de uachipato niño"
rutas = []

cadena = stringToFonema(string, json_data)
fonemasToRuta(cadena, rutas)
#reproducir(rutas)

