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
probaPluie_h[1] = 'probabilité pluie 1h'

-- capteur proba pluie de type pourcentage.
phaseLunaire_j[1] = 23 -- mettre l'idx sous cette forme ou le nom sous la forme 'nom du capteur' ou mettre nil ou supprimer la ligne si rien.

-- scripts
return {
	active = true,
	on = { timer = { 'every 30 minutes' }, -- la version gratuit de DarkSky permet 1000 appels par jour, avec un appel toutes les 30 minutes = 48 requêtes par jour.
	httpResponses = { 'Da'rkSky_Trigger' }
	
	logging = 
