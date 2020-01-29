--[[
commentaires long
--]]

-- déclaration des local du script
local scriptName = 'DarkSky'
local scriptVersion = '1.00b'

-- déclaration des local recherché
local probaPluie_h = {}
local prevVent_h = {}
local phaseLunaire_j = {}
--local probaPluie_h = {} // disponible.

-- assiociation des capteurs virtuels.
-- capteur probaPluie de type pourcentage.
probaPluie_h[1] = 23 -- mettre l'idx sous cette forme ou le nom sous la forme 'nom du capteur' ou mettre nil ou supprimer la ligne si rien.
probaPluie_h[2] = 'nomdevotrecapteur' -- avec ou sans espaces
probaPluie_h[3] = nil -- non utiliser

-- capteur prevVent de type pourcentage.
prevVent_h[1] = 'probabilité pluie 1h'

-- capteur proba pluie de type pourcentage.
phaseLunaire_j[1] = 23 -- mettre l'idx sous cette forme ou le nom sous la forme 'nom du capteur' ou mettre nil ou supprimer la ligne si rien.

-- scripts
return {
	active = true,
	on = { timer = { 'every 30 minutes' }, -- la version gratuit de DarkSky permet 1000 appels par jour, avec un appel toutes les 30 minutes = 48 requêtes par jour.
	httpResponses = { 'DarkSky_Trigger' }
	
	-- activation du tyoe du LOG
	logging = { level = domoticz.LOG_DEBUG, -- laisser un seul systeme log activé et commenter les autres.
	                    --level = domoticz.LOG_INFO,
	                    --level = domoticz.LOG_ERROR,
	                    --level = domoticz.LOG_MODULE_EXEC_INFO,
	                    marker = scriptName..' v'..scriptVersion
	                  },
	
	data = { Forecast = {initial ={} }, -- garde une copie du dernier JSON.
	},
	
execute = function(domoticz, item)
	local function logWrite(str,level)
		domoticz.log(tostering(str),level or domoticz.LOG_DEBUG)
	end
	
	local function quadrants(degrees)
		local quadrant = {"NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"}
			
			if degree > 348.75 or degree <= 11.25 then
				return "N"
			else
				local index = tonunber(math.floor((degree - 11.25) / 22.5)+1)
				return quadrants[index]
		end
	end
	
	local function levelMoonphase (moonphase)
		local level = 10 -- level correspondant a Nouvelle lune
			if(moonphase > 0.05 and moonphase < 0.245) then
				 level = 20 -- level correspondant a Premier croissant
			elseif(moonphase > 0.244 and moonphase < 0.255) then
				 level = 30 -- level correspondant a Premier quartier
			elseif(moonphase > 0.255 and moonphase < 0.495) then
				 level = 40 -- level correspondant a Gibbeuse croussante
			elseif(moonphase > 0.495 and moonphase < 0.55) then
				 level = 50 -- level correspondant a Pleine lune
			elseif(moonphase > 0.55 and moonphase < 0.745) then
				 level = 60 -- level correspondant a Gibbeuse decroissant
			elseif(moonphase > 0.745 and moonphase < 0.755) then
				 level = 70 -- level correspondant a Dernier quartier
			elseif(moonphase > 0.755 and moonphase < 1.00) then
				 level = 80 -- level correspondant a Dernier croissant
			end
			
			return level--moonphase,
			
		end
		
		-- cles API via variable
		local DarkSkyAPIKey = domoticz.variable('DarkSkyAPIKey').value
		
		local geolocalisation = domoticz.settings.location.latitude..','..domoticz.settings.location.longitude
		
		-- Inscription dans les logs
		logWrite('geolocalisation : '..geolocalisation,domoticz.LOG_INFO)
		
		local Forecast_url = "https://api.darksky.net/forecast/" -- debut d'url de DarkSky
		local extraData = "?units=si&exclude=flags" -- 
		
		if (item.isTimer) then
			domoticz.openURL({
				url = Forecast_url..DarkSkyAPIKey.."/"..geolocalisation..extraData,
					callback = 'DarkSky_Trigger'
			})
		end
		
		if (item.isHTTPResponse and item.ok) then
			--
			local json = domoticz.utils.fromJSON(item.data)
			-- le fichier JSON est maintenant en table Lua
				if #item.data > 0 then
					domoticz.data.Forecast = domoticz.utils.fromJSON(item.data)
					rt = domoticz.utils.fromJSON(item.data)
				else
					domoticz.log("Probleme de reponse depuis DarkSky (no data) j'utilise le dernier fichier démarré ",domoticz.LOG_ERROR)
					rt = domoticz.data.Forecast empty. Get last valid from domoticz.data
					
					if #rt < 1 then
					valid data in domoticz.data
					either
					domoticz.log(" No previous data. are DarkSkyAPIKey and geolocalisation ok?",domoticz.LOG_ERROR)
					
					return false
				end
			end
			
			logWrite('heure system')
			
			local now = domoticz.time.dDate
			logWrite('now : '..now)
			
			j = 1
			for i = 1,48 do
				logWrite('j : '..j)
				
				if now > tonumber(json.hourly.data[j].time) then -- test si maintenant est superieur au timestamp lu
				
					local h = domoticz.utils.round((now - tonumber(json.hourly.data[j].time)) / 3600,0)
					
					logWrite("h : "..h)
					
					j = j+h
					
					logWrite(" j : "..j)
				end
				
				logWrite('date : '.. os.date('%Y-%m-%d %H:%M:%S' ,json.hourly.data[j].time),domoticz.LOG_INFO)
				logWrite('precipProbality :'..json.hourly.data[j].precipProbality,domoticz.LOG_INFO)
				
				if (probaPluie_h[i] then
					domoticz.devices(probaPluie_h[i]).updatePercentage(json.hourly.data[j].precipProbability*100)
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
