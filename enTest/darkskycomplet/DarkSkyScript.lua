--[[ darksky.lua for [ dzVents >= 2.4.14 (domoticz >= V4.10444)]
lement un niveau peut être actif; commenter les autres dans la section logging
--]]
local scriptName        = 'Darksky forecast'
local scriptVersion     = ' 1.21'

-- Actuellement
local Vents  = {} 
local indexUV  = {}
local tempHumBar = {}
local visibilite = {}

-- Toutes les heures 1h a 48h
local h_Vents 
local h_indexUV  = {} 
local h_tempHumBar = {}
local h_visibilite = {}

-- Tous les jours j0 a j7
local j_Vents 
local j_indexUV  = {} 
local j_tempHumBar = {}
local j_visibilite = {}
local j_phaseLunaire = {}

--local proba_pluie_h     = {}
--local prev_wind_h       = {}
--local MoonPhaseSelect   = {}

-- Association des Capteurs
-- Actuellement
Vents = nil
indexUV = nil
tempHumBar = nil
visibilite = nil

-- Toutes les heures 1h a 48h
h_Vents[1] = nil
h_indexUV[1] = nil
h_tempHumBar[1] = nil 
h_visibilite[1] = nil

-- Tous les jours j0 a j7
j_vents[1] = nil
j_indexUV[1] = nil
j_tempHumBar[1] = nil
j_visibilite[1] = nil
j_phaseLunaire[1] = nil


return {
    active = true,
    on      =   {   timer           =   { 'every 30 minutes' },  -- remember only 1000 requests by day, 30mn = 48 requests
                    httpResponses   =   { 'DarkSky_Trigger' }    -- Trigger the handle Json part
                },

  logging =   {  level    =   domoticz.LOG_DEBUG,                                             -- Seulement un niveau peut être actif; commenter les autres
                -- level    =   domoticz.LOG_INFO,                                            -- Only one level can be active; comment others
                -- level    =   domoticz.LOG_ERROR,
                -- level    =   domoticz.LOG_MODULE_EXEC_INFO,
                marker = scriptName..' v'..scriptVersion
                },

   data    =   {   Forecast     = {initial = {} },             -- Keep a copy of last json just in case
       },
    execute = function(domoticz, item)

        local function logWrite(str,level)             -- Support function for shorthand debug log statements
            domoticz.log(tostring(str),level or domoticz.LOG_DEBUG)
        end

        local function quadrants(degrees)
            local quadrants = {"NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"}
            
                if degrees > 348.75 or degrees <= 11.25 then
                    return "N"
                else 
                    local index = tonumber(math.floor((degrees - 11.25) / 22.5)+1)
                    return quadrants[index]
                end
        end
        local function levelMoonhase(moonphase)
            local level = 10 -- level correspondant à Nouvelle lune
            if(moonphase > 0.05 and moonphase < 0.245) then
                level = 20 -- level correspondant à Premier croissant
            elseif(moonphase > 0.244 and moonphase < 0.255) then 
                level = 30 -- level correspondant à Premier quartier
            elseif(moonphase > 0.255 and moonphase < 0.495) then
                level = 40  -- level correspondant à Gibbeuse croissante
            elseif(moonphase > 0.495 and moonphase < 0.55) then
                level = 50 -- level correspondant à Pleine lune
            elseif(moonphase > 0.55 and moonphase < 0.745) then
                level = 60 -- level correspondant à Gibbeuse décroissante
            elseif(moonphase > 0.745 and moonphase < 0.755) then
                level = 70 -- level correspondant à Dernier quartier
            elseif(moonphase > 0.755 and moonphase < 1.00) then
                level = 80 -- level correspondant à Dernier croissant
            end
            return level--moonPhase, 
        end
        local DarkSkyAPIkey = domoticz.variables('DarkSkyKeyAPI').value
        --local DarkSkyAPIkey = "1a2bf34bf56c78901f2345f6d7890f12" --fake API number
        local geolocalisation = domoticz.settings.location.latitude..','..domoticz.settings.location.longitude
        --local geolocalisation = "45.87,1.30" -- latitude,longitude
        logWrite('geolocalisation : '..geolocalisation,domoticz.LOG_INFO)


        local Forecast_url  = "https://api.darksky.net/forecast/"  -- url
        local extraData = "?units=si&exclude=flags"--currently,minutely,daily,alerts,

        if (item.isTimer) then
            domoticz.openURL({
                url = Forecast_url..DarkSkyAPIkey.."/"..geolocalisation..extraData,
                callback = 'DarkSky_Trigger'
            })

        end
        if (item.isHTTPResponse and item.ok) then
            -- we know it is json but dzVents cannot detect this
            -- convert to Lua
            local json = domoticz.utils.fromJSON(item.data)
            -- json is now a Lua table
            if #item.data > 0 then
                domoticz.data.Forecast    = domoticz.utils.fromJSON(item.data)
                rt = domoticz.utils.fromJSON(item.data)
            else
                domoticz.log("Problem with response from DarkSky (no data) using data from earlier run",domoticz.LOG_ERROR)
                rt  = domoticz.data.Forecast                        -- json empty. Get last valid from domoticz.data
                if #rt < 1 then                                         -- No valid data in domoticz.data either
                    domoticz.log("No previous data. are DarkSkyAPIkey and geolocalisation ok?",domoticz.LOG_ERROR)
                    return false
                end
            end
            logWrite('heure systeme')
            local now = domoticz.time.dDate
            logWrite('now : '..now)
            j = 1
            for i = 1,48 do
                logWrite('j : '..j)
                if now > tonumber(json.hourly.data[j].time) then -- si maintenant est supérieur au timestamp lu
                    local h = domoticz.utils.round((now - tonumber(json.hourly.data[j].time)) / 3600,0)
                    logWrite("h : "..h)
                    j = j+h
                    logWrite("j : "..j)

                end
                logWrite('date :'.. os.date('%Y-%m-%d %H:%M:%S', json.hourly.data[j].time),domoticz.LOG_INFO)
                logWrite('precipProbability :' ..json.hourly.data[j].precipProbability,domoticz.LOG_INFO)
                if (proba_pluie_h[i]) then
                        domoticz.devices(proba_pluie_h[i]).updatePercentage(json.hourly.data[j].precipProbability*100)
                end

                local windSpeed         =   json.hourly.data[j].windSpeed
                local windGust          =   json.hourly.data[j].windGust
                local windBearing       =   json.hourly.data[j].windBearing
                local temperature       =   json.hourly.data[j].temperature
                local windChill         =   json.hourly.data[j].apparentTemperature
                local direction         =   quadrants(windBearing)
                logWrite('windSpeed : '..tostring(windSpeed)..' windGust : '..tostring(windGust)..' windBearing : '..tostring(windBearing)..' direction :'..tostring(direction)..' temperature : '..tostring(temperature)..' windChill : '..tostring(windChill),domoticz.LOG_INFO)

                if (prev_wind_h[i]) then
                    domoticz.devices(prev_wind_h[i]).updateWind(windBearing,tostring(direction),windSpeed,windGust,temperature,windChill)
                    logWrite('mise à jour du device '..prev_wind_h[i],domoticz.LOG_INFO)
                end
                
                if j == 48 then break end
                j = j +1
            end
            k = 1
            for k = 1,8 do
                local moonphase = json.daily.data[k].moonPhase
                logWrite('moonPhase day ' ..k..' : '..tostring(moonphase))
                logWrite(levelMoonhase(moonphase))

                if(MoonPhaseSelect[k]) then
                    domoticz.devices(MoonPhaseSelect[k]).switchSelector(levelMoonhase(moonphase))
                    logWrite("update selector device")
                end
                if j == 8 then break end
                j = j +1
            end
        end
    end
}
