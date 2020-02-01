------------------------------------------------------------------
--Temperature
/json.htm?type=command&param=udevice&idx=IDX&nvalue=0&svalue=TEMP

    IDX = idx de votre capteur. A obtenir depuis l’écran des dispositifs.
    TEMP = Température que vous souhaitez affecter à ce capteur.


-----------------------------------------------------------------
--Humidité
/json.htm?type=command&param=udevice&idx=IDX&nvalue=HUM&svalue=HUM_STAT

    IDX =idx de votre capteur. A obtenir depuis l’écrans des dispositifs.
    HUM = Humidité: 45 par exemple pour 45%
    HUM_STAT = Humidity_status

Humidity_status peut être :

    0=Normal
    1=Confortable
    2=Sec
    3=Humide

Ce paramètre est obligatoire, si vous ne savez pas quoi mettre, mettez 0

------------------------------------------------------------------------
--Baromètre
/json.htm?type=command&param=udevice&idx=IDX&nvalue=0&svalue=BAR;BAR_FOR

    IDX = idx de votre capteur. A obtenir depuis l’écran des dispositifs.
    BAR = Pression barométrique.
    BAR_FOR = Météo selon la presion baro à choisir dans la liste ci-desous.

    0 = Stable
    1 = Soleil
    2 = Nuageux
    3 = Instable
    4 = Tempête
    5 = Inconnu
    6 = Nuageux/pluie

Ce paramètre est obligatoire, si vous ne savez pas quoi mettre, mettez 0

----------------------------------------------------------------------------
--Température /humidité
/json.htm?type=command&param=udevice&idx=IDX&nvalue=0&svalue=TEMP;HUM;HUM_STAT

    IDX = idx de votre capteur. A obtenir depuis l’écran des dispositifs.
    TEMP = Temperature
    HUM = Humidité
    HUM_STAT = Status de l’humidité parmi la liste ci-dessous.

 

    0=Normal
    1=Confortable
    2=Sec
    3=Humide

---------------------------------------------------------------------------------------
--Température/humidité/baromètre
/json.htm?type=command&param=udevice&idx=IDX&nvalue=0&svalue=TEMP;HUM;HUM_STAT;BAR;BAR_FOR

Cette instruction permet de donner des valeurs aux capteurs Temp+Humidité+Baromètre

    IDX = idx de votre capteur. A obtenir depuis l’écran des dispositifs.
    TEMP = Temperature
    HUM = Humidité
    HUM_STAT = Status d’humidité
    BAR = Pression barométrique
    BAR_FOR = Météo selon la presion baro à choisir dans la liste ci-desous :

 

    0 = No info
    1 = Soleil
    2 = Partiellement nuageux
    3 = Nuageux
    4 = Pluie

-------------------------------------------------------------------------------------
--Pluie
/json.htm?type=command&param=udevice&idx=IDX&nvalue=0&svalue=RAINRATE;RAINCOUNTER

    IDX = idx de votre capteur. A obtenir depuis l’écran des dispositifs.
    RAINRATE = quantité de pluie depuis la dernière heure
    RAINCOUNTER = cumul de pluie tombée en mm

---------------------------------------------------------------------------------------
--Vent
/json.htm?type=command&param=udevice&idx=IDX&nvalue=0&svalue=WB;WD;WS;WG;22;24

    IDX = idx de votre capteur. A obtenir depuis l’écran des dispositifs.
    WB = Angle du vent (0-359)
    WD = Direction du vent (S, SW, NNW, etc.)
    WS = 10 * Vitesse du vent [m/s]
    WG = 10 * vitesse de la rafale[m/s]
    22 = Temperature
    24 = Temperature Windchill

les deux dernières valeurs sont TOUJOURS 22 et 24.

--------------------------------------------------------------------------------------------
--UV
 /json.htm?type=command&param=udevice&idx=IDX&nvalue=0&svalue=COUNTER;0

    IDX = idx de votre capteur. A obtenir depuis l’écran des dispositifs.
    COUNTER = La valeur de l’UV avec un point décimal (obligatoire : exemple: 2.0)

Attention il y a un « ;0 » à la fin, c’est comme ça , ne l’oubliez pas.

---------------------------------------------------------------------------------------------
--Qualité de l’air
/json.htm?type=command&param=udevice&idx=IDX&nvalue=PPM

    IDX = idx de votre capteur. A obtenir depuis l’écran des dispositifs.
    PPM = CO2-concentration

-----------------------------------------------------------------------------------------------
--Pression
/json.htm?type=command&param=udevice&idx=IDX&nvalue=0&svalue=BAR

    IDX = idx de votre capteur. A obtenir depuis l’écran des dispositifs.
    BAR = Pression atmosphérique en Bar

Créer ce capteur dans « Matériel »/ »Créer capteur Virtuel »

---------------------------------------------------------------------------------------------------
---Pourcentage
/json.htm?type=command&param=udevice&idx=IDX&nvalue=0&svalue=PERCENTAGE

    IDX = idx de votre capteur. A obtenir depuis l’écran des dispositifs.
    PERCENTAGE = Le pourcentage à afficher dans le widget

----------------------------------------------------------------------------------------------------
--Text sensor
Ceci permet d’afficher un texte sur un widget Domoticz.
/json.htm?type=command&param=udevice&idx=IDX&nvalue=0&svalue=TEXT

    IDX = idx de votre capteur. A obtenir depuis l’écran des dispositifs.
    TEXT = Le texte à afficher.

    Exemple http://IP:PORT/json.htm?type=command&param=udevice&idx=mon_idx&svalue=MONTEXTEAAFFICHER

---------------------------------------------------------------------------------------------------
--Distance
/json.htm?type=command&param=udevice&idx=IDX&nvalue=0&svalue=DISTANCE

    IDX = idx de votre capteur. A obtenir depuis l’écran des dispositifs.
    DISTANCE = distance en ce que vous voulez comme unité, la valeur est affichée sans unité. Vous pouvez envoyer des décimales (12.6) avec un point.

-----------------------------------------------------------------------------------------------------------------------------------
--Selector Switch

Il s’agit de piloter ce capteur virtuel nomme « Selector switch » ou l’on peut prédéfinir 4 niveaux (pour des dimmables par ex, ou des volets)

inter_sele

/json.htm?type=command&param=switchlight&idx=IDX&switchcmd=Set%20Level&level=LEVEL

    IDX = idx de votre capteur. A obtenir depuis l’écran des dispositifs.
    LEVEL = Un nombre qui fait référence à celui défini dans le menu « Editer » du widget
    sel_switch

-------------------------------------------------------------------------------------------------------------------------------------
--Custom Sensor

/json.htm?type=command&param=udevice&idx=IDX&nvalue=0&svalue=VALUE

    IDX = idx de votre capteur. A obtenir depuis l’écran des dispositifs.
    VALUE = Valeur avec un point décimal (12.345)
