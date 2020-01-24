--[[ IconesSaisons.lua
D'apres le script selection jour de la semaine et phase de lune de papoo https://github.com/papo-o/
icones : https://github.com/papo-o/domoticz_scripts/tree/master/Icons/Days
 Créé = 24/01/2020
 Mise à jour = 24/01/2020
--]]
local scriptName        = 'IconesSaisons'
local scriptVersion     = ' 1.00'
return  {   
        active = true,
        on =    {  
                       devices         = {18}, -- change to your device(s) separated by a comma like {2479,2480} 
                    },

   logging =   {  level    =   domoticz.LOG_DEBUG,                                 -- Seulement un niveau peut être actif; commenter les autres
                -- -- -- level    =   domoticz.LOG_INFO,                           -- Only one level can be active; comment others
                -- -- -- level    =   domoticz.LOG_ERROR,
                -- -- -- level    =   domoticz.LOG_MODULE_EXEC_INFO,
                 marker = scriptName..' v'..scriptVersion
    },

    execute = function(dz, item)
    
        local function logWrite(str,level)
            dz.log(tostring(str),level or dz.LOG_DEBUG)
        end
        local icons =     { 
                            [10] = 124,-- level correspondant à l'Hiver
                            [20] = 118,-- level correspondant au Printemps
                            [30] = 119,-- level correspondant à l'éte
                            [40] = 120,-- level correspondant à l'Automne
                        }
           
        logWrite('lastLevel '.. tostring(item.lastLevel))
        logWrite('level '.. tostring(item.level))
        if item.level ~= item.lastLevel then 
            item.setIcon(icons[item.level])
        else
            logWrite('No Icon change necessary for ' .. item.id)
        end
    end
}
