--[[ Commentaire long sur le script
--]]
local scriptName        = 'Darksky forecast'
local scriptVersion     = ' 1.00'

-- local actuelle
local summary			   ={} -- Infos generale maintenant
local nearestStormDistance ={} -- Hauteur du Soleil ??
local nearestStormBearing  ={} -- Az du soleil ???
local precipIntensity      ={} -- Intensit des precipitations
local precipProbability    ={} -- Propabilité des precipitations
local temperature          ={} --Temperature
local apparentTemperature  ={} --Temperature Apparente
local dewPoint             ={} --Point de rosé
local humidity             ={} --Humidité
local pressure             ={} --Pression
local windSpeed            ={} --Vitesse du Vent
local windGust             ={} --Rafales
local windBearing          ={} --Direction du vent
local cloudCover           ={} --Couverture Nuageuse
local uvIndex              ={} --Index UV
local visibility           ={} --Visibilité
local ozone                ={} --Ozone

-- local heures de 0 a 48h
local h_summary				 ={} -- Infos generale de l'heure
local h_precipIntensity      ={} -- Intensit des precipitations
local h_precipProbability    ={} -- Propabilité des precipitations
local h_precipType           ={} -- Type de precipitation
local h_temperature          ={} --Temperature
local h_apparentTemperature  ={} --Temperature Apparente
local h_dewPoint             ={} --Point de rosé
local h_humidity             ={} --Humidité
local h_pressure             ={} --Pression
local h_windSpeed            ={} --Vitesse du Vent
local h_windGust             ={} --Rafales
local h_windBearing          ={} --Direction du vent
local h_cloudCover           ={} --Couverture Nuageuse
local h_uvIndex              ={} --Index UV
local h_visibility           ={} --Visibilité
local h_ozone                ={} --Ozone

-- local Jours de J0 a J7
local w_sumarry                                 ={}  -- infos generale de la semaine

local j_summary 								={}  -- Infos genrale de la journee
local j_sunriseTime								={}  -- Levé du soleil
local j_sunsetTime								={}  -- Couché du soleil
local j_moonPhase								={}  -- Phase de la Lune
local j_precipIntensity							={}  -- Intensité des precipitations
local j_precipIntensityMax						={}  -- Intensité Max des precipitations
local j_precipIntensityMaxTime					={}  -- Heure Intensité Max des precipitations
local j_precipProbability						={}  -- Propabilité des precipitations
local j_precipType								={}  -- Type des precipitations
local j_temperatureHigh							={}  -- Temperature Max
local j_temperatureHighTime						={}  -- Heure Temperature Max
local j_temperatureLow							={}  -- Temperature Min
local j_temperatureLowTime						={}  -- Heure Temperature Min
local j_apparentTemperatureHigh					={}  -- Temperature Max Ressentie ??
local j_apparentTemperatureHighTime				={}  -- Heure // Temperature Max Ressentie ??
local j_apparentTemperatureLow					={}  -- Temperature Min Ressenti ??
local j_apparentTemperatureLowTime				={}  -- Heure // Temperature Max Ressentie ??
local j_dewPoint								={}  -- Point de rosée
local j_humidity								={}  -- Humidité 
local j_pressure								={}  -- Pression
local j_windSpeed								={}  -- Vitesse du Vent
local j_windGust								={}  -- Rafales de vent
local j_windGustTime							={}  -- Heure de Rafales
local j_windBearing								={}  -- Direction du vent
local j_cloudCover								={}  -- Couverture Nuageuse
local j_uvIndex									={}  -- Index UV
local j_uvIndexTime								={}  -- Heure Index UV
local j_visibility								={}  -- Visibilité
local j_ozone									={}  -- Qualité Ozone
local j_temperatureMin							={}  -- Temperature Min
local j_temperatureMinTime						={}  -- Heure Temperature Min
local j_temperatureMax							={}  -- Temperature Max
local j_temperatureMaxTime						={}  -- Heure Temperature Max
local j_apparentTemperatureMin					={}  -- Temperature Min Ressentie ??
local j_apparentTemperatureMinTime				={}  -- Temperature Min Ressentie ??
local j_apparentTemperatureMax					={}  -- Temperature Max Ressentie ??
local j_apparentTemperatureMaxTime				={}  -- Temperature Max Ressentie ??
local j_sunriseTime								={}  -- Levé du soleil
local j_sunsetTime								={}  -- Couché du soleil
local j_moonPhase								={}  -- Phase de la Lune
local j_precipIntensity							={}  -- Intensité des precipitations
local j_precipIntensityMax						={}  -- Intensité Max des precipitations
local j_precipIntensityMaxTime					={}  -- Heure Intensité Max des precipitations
local j_precipProbability						={}  -- Propabilité des precipitations
local j_precipType								={}  -- Type des precipitations
local j_temperatureHigh							={}  -- Temperature Max
local j_temperatureHighTime						={}  -- Heure Temperature Max
local j_temperatureLow							={}  -- Temperature Min
local j_temperatureLowTime						={}  -- Heure Temperature Min
local j_apparentTemperatureHigh					={}  -- Temperature Max Ressentie ??
local j_apparentTemperatureHighTime				={}  -- Heure // Temperature Max Ressentie ??
local j_apparentTemperatureLow					={}  -- Temperature Min Ressenti ??
local j_apparentTemperatureLowTime				={}  -- Heure // Temperature Max Ressentie ??
local j_dewPoint								={}  -- Point de rosée
local j_humidity								={}  -- Humidité 
local j_pressure								={}  -- Pression
local j_windSpeed								={}  -- Vitesse du Vent
local j_windGust								={}  -- Rafales de vent
local j_windGustTime							={}  -- Heure de Rafales
local j_windBearing								={}  -- Direction du vent
local j_cloudCover								={}  -- Couverture Nuageuse
local j_uvIndex									={}  -- Index UV
local j_uvIndexTime								={}  -- Heure Index UV
local j_visibility								={}  -- Visibilité
local j_ozone									={}  -- Qualité Ozone
local j_temperatureMin							={}  -- Temperature Min
local j_temperatureMinTime						={}  -- Heure Temperature Min
local j_temperatureMax							={}  -- Temperature Max
local j_temperatureMaxTime						={}  -- Heure Temperature Max
local j_apparentTemperatureMin					={}  -- Temperature Min Ressentie ??
local j_apparentTemperatureMinTime				={}  -- Temperature Min Ressentie ??
local j_apparentTemperatureMax					={}  -- Temperature Max Ressentie ??
local j_apparentTemperatureMaxTime				={}  -- Temperature Max Ressentie ??
local j_sunriseTime								={}  -- Levé du soleil
local j_sunsetTime								={}  -- Couché du soleil
local j_moonPhase								={}  -- Phase de la Lune
local j_precipIntensity							={}  -- Intensité des precipitations
local j_precipIntensityMax						={}  -- Intensité Max des precipitations
local j_precipIntensityMaxTime					={}  -- Heure Intensité Max des precipitations
local j_precipProbability						={}  -- Propabilité des precipitations
local j_precipType								={}  -- Type des precipitations
local j_temperatureHigh							={}  -- Temperature Max
local j_temperatureHighTime						={}  -- Heure Temperature Max
local j_temperatureLow							={}  -- Temperature Min
local j_temperatureLowTime						={}  -- Heure Temperature Min
local j_apparentTemperatureHigh					={}  -- Temperature Max Ressentie ??
local j_apparentTemperatureHighTime				={}  -- Heure // Temperature Max Ressentie ??
local j_apparentTemperatureLow					={}  -- Temperature Min Ressenti ??
local j_apparentTemperatureLowTime				={}  -- Heure // Temperature Max Ressentie ??
local j_dewPoint								={}  -- Point de rosée
local j_humidity								={}  -- Humidité 
local j_pressure								={}  -- Pression
local j_windSpeed								={}  -- Vitesse du Vent
local j_windGust								={}  -- Rafales de vent
local j_windGustTime							={}  -- Heure de Rafales
local j_windBearing								={}  -- Direction du vent
local j_cloudCover								={}  -- Couverture Nuageuse
local j_uvIndex									={}  -- Index UV
local j_uvIndexTime								={}  -- Heure Index UV
local j_visibility								={}  -- Visibilité
local j_ozone									={}  -- Qualité Ozone
local j_temperatureMin							={}  -- Temperature Min
local j_temperatureMinTime						={}  -- Heure Temperature Min
local j_temperatureMax							={}  -- Temperature Max
local j_temperatureMaxTime						={}  -- Heure Temperature Max
local j_apparentTemperatureMin					={}  -- Temperature Min Ressentie ??
local j_apparentTemperatureMinTime				={}  -- Temperature Min Ressentie ??
local j_apparentTemperatureMax					={}  -- Temperature Max Ressentie ??
local j_apparentTemperatureMaxTime				={}  -- Temperature Max Ressentie ??





--local proba_pluie_h     = {}
--local prev_wind_h       = {}
--local MoonPhaseSelect   = {}


-- Capteurs valeurs actuelles
-- Association des Capteurs pour les valeurs actuelle.
-- Remplacer nil par lídx de votre capteur ou par son nom entre guillemet 'nom de votre capteur' si vous ne souhaitez pas utiliser cette fonction laisser nil.
summary[0]			    = nil  --
nearestStormDistance[0] = nil  --Hauteur du Soleil ??
nearestStormBearing[0]  = nil  --Az du soleil ???
precipIntensity[0]      = nil  --Intensit des precipitations
precipProbability[0]    = nil  --Propabilité des precipitations
temperature[0]          = nil  --Temperature
apparentTemperature[0]  = nil  --Temperature Apparente
dewPoint[0]             = nil  --Point de rosé
humidity[0]             = nil  --Humidité
pressure[0]             = nil  --Pression
windSpeed[0]            = nil  --Vitesse du Vent
windGust[0]             = nil  --Rafales
windBearing[0]          = nil  --Direction du vent
cloudCover[0]           = nil  --Couverture Nuageuse
uvIndex[0]              = nil  --Index UV
visibility[0]           = nil  --Visibilité
ozone[0]                = nil  --Ozone

-- Capteurs Heures
-- Association des Capteurs pour heure = 1. Il faut copier coller pour chaques h jusqu'a 48h
-- Remplacer nil par lídx de votre capteur ou par son nom entre guillemet 'nom de votre capteur' si vous ne souhaitez pas utiliser cette fonction laisser nil.
h_summary[1]			   = nil  --
h_precipIntensity[1]       = nil  --Intensit des precipitations
h_precipProbability[1]     = nil  --Propabilité des precipitations
h_precipType[1]            = nil  --Type de precipitation
h_temperature[1]           = nil  --Temperature
h_apparentTemperature[1]   = nil  --Temperature Apparente
h_dewPoint[1]              = nil  --Point de rosé
h_humidity[1]              = nil  --Humidité
h_pressure[1]              = nil  --Pression
h_windSpeed[1]             = nil  --Vitesse du Vent
h_windGust[1]              = nil  --Rafales
h_windBearing[1]           = nil  --Direction du vent
h_cloudCover[1]            = nil  --Couverture Nuageuse
h_uvIndex[1]               = nil  --Index UV
h_visibility[1]            = nil  --Visibilité
h_ozone[1]                 = nil  --Ozone

-- Capteurs Journalier
-- Association des Capteurs pour les valeurs Journaliere j=1. il faut copier coller et remplacer 1 par le jour voulu de 1 a 7
-- Remplacer nil par lídx de votre capteur ou par son nom entre guillemet 'nom de votre capteur' si vous ne souhaitez pas utiliser cette fonction laisser nil.
j_summary[1] 								= nil  --
j_sunriseTime[1]							= nil  -- Levé du soleil
j_sunsetTime[1]								= nil  -- Couché du soleil
j_moonPhase[1]								= nil  -- Phase de la Lune
j_precipIntensity[1]						= nil  -- Intensité des precipitations
j_precipIntensityMax[1]						= nil  -- Intensité Max des precipitations
j_precipIntensityMaxTime[1]					= nil  -- Heure Intensité Max des precipitations
j_precipProbability[1]						= nil  -- Propabilité des precipitations
j_precipType[1]								= nil  -- Type des precipitations
j_temperatureHigh[1]						= nil  -- Temperature Max
j_temperatureHighTime[1]					= nil  -- Heure Temperature Max
j_temperatureLow[1]							= nil  -- Temperature Min
j_temperatureLowTime[1]						= nil  -- Heure Temperature Min
j_apparentTemperatureHigh[1]				= nil  -- Temperature Max Ressentie ??
j_apparentTemperatureHighTime[1]			= nil  -- Heure // Temperature Max Ressentie ??
j_apparentTemperatureLow[1]					= nil  -- Temperature Min Ressenti ??
j_apparentTemperatureLowTime[1]				= nil  -- Heure // Temperature Max Ressentie ??
j_dewPoint[1]								= nil  -- Point de rosée
j_humidity[1]								= nil  -- Humidité 
j_pressure[1]								= nil  -- Pression
j_windSpeed[1]								= nil  -- Vitesse du Vent
j_windGust[1]								= nil  -- Rafales de vent
j_windGustTime[1]							= nil  -- Heure de Rafales
j_windBearing[1]							= nil  -- Direction du vent
j_cloudCover[1]								= nil  -- Couverture Nuageuse
j_uvIndex[1]								= nil  -- Index UV
j_uvIndexTime[1]							= nil  -- Heure Index UV
j_visibility[1]								= nil  -- Visibilité
j_ozone[1]									= nil  -- Qualité Ozone
j_temperatureMin[1]							= nil  -- Temperature Min
j_temperatureMinTime[1]						= nil  -- Heure Temperature Min
j_temperatureMax[1]							= nil  -- Temperature Max
j_temperatureMaxTime[1]						= nil  -- Heure Temperature Max
j_apparentTemperatureMin[1]					= nil  -- Temperature Min Ressentie ??
j_apparentTemperatureMinTime[1]				= nil  -- Temperature Min Ressentie ??
j_apparentTemperatureMax[1]					= nil  -- Temperature Max Ressentie ??
j_apparentTemperatureMaxTime[1]				= nil  -- Temperature Max Ressentie ??

--MoonPhaseSelect[1]      = 63   --moonPhase day 1 selector switch -- soit idx sans les guillemet ou alors le nom de votre capteur entre 'nomdevotrecapteur' si rien mettre nil
--MoonPhaseSelect[2]      = 67   --moonPhase day 2 selector switch
--MoonPhaseSelect[3]      = 68   --moonPhase day 3 selector switch
--MoonPhaseSelect[4]      = 72   --moonPhase day 4 selector switch
--MoonPhaseSelect[5]      = 69   --moonPhase day 5 selector switch
--MoonPhaseSelect[6]      = 70   --moonPhase day 6 selector switch
--MoonPhaseSelect[7]      = 71   --moonPhase day 7 selector switch
