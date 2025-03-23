local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}

CreateThread(function() 
    if QBCore.Functions.GetPlayerData().job then
        PlayerJob = QBCore.Functions.GetPlayerData().job
    end
end)

rootMenuConfig =  {

        -- General --
        {
            id = "general",
            displayName = "Acciones",
            icon = "#globe-europe",
            enableMenu = function()
                local Data = QBCore.Functions.GetPlayerData()
                return not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
            end,
            subMenus = {"vehicle:giveKeys", "interact:carry", "interact:trunkin", "interact:trunkout",  "general:flipveh", "general:hotdog", "general:getintrunk","general:givenum"}
        },
        -- {
        --     id = "emotes",
        --     displayName = "Animaciones",
        --     icon = "#emotes",
        --     enableMenu = function()
        --     local Data = QBCore.Functions.GetPlayerData()
        --     return not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
        --     end,
        --     functionName = "qb-radial:openEmoteMenu"
        -- },

    -- {
    --     id = "TruckRob",
    --     displayName = "Reventar Maletero",
    --     icon = "#container-rob",
    --     functionName = "qb-containerrobbery:truck",
    --     enableMenu = function()
    --         local Data = QBCore.Functions.GetPlayerData()
    --         local isNearTruck = exports["qb-containerrobbery"]:isNearTruck()
    --         local hasItem = GetSelectedPedWeapon(PlayerPedId()) == `weapon_crowbar`
    --         return hasItem and isNearTruck and (not Data.metadata["isdead"] and not Data.metadata["inlaststand"])
    --     end
    -- },
    -- {
    --     id = "housemenu",
    --     displayName = "Cosas de Bienes Raíces",
    --     icon = "#animation-business",
    --     enableMenu = function()
    --         local Data = QBCore.Functions.GetPlayerData()
    --         return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "realestate" and Data.job.onduty))
    --     end,
    --     subMenus = {"realestate:addgarage"}
    -- },

    -- {
    --     id = "realestate",
    --     displayName = "Lista de Propiedades",
    --     icon = "#house",
    --     functionName = "qb-realestate:client:OpenHouseListMenu",
    --     enableMenu =function()
    --         local Data = QBCore.Functions.GetPlayerData()
    --         return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "realestate" and Data.job.onduty))
    --     end,
    -- },

    {
        id = "house",
        displayName = "Interacciones del Hogar",
        icon = "#house",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
        end,
        subMenus = {"house:doorlock", "house:decorate"}
    },
    {
        id = 'police-locked-storage',
        displayName = 'Almacenamiento Bloqueado',
        icon = '#police-locked-compartment',
        functionName = 'police:LockedCompartment',
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)
            local model = GetEntityModel(veh)
            return (not Data.metadata['isdead'] and not Data.metadata['inlaststand'] and IsPedInAnyVehicle(PlayerPedId(), false))  and Data.job ~= nil and (Data.job.name == 'police' and Data.job.onduty and not IsThisModelABike(model))
        end
    },
    {
        id = "vehicle",
        displayName = "Vehículo",
        icon = "#vehicle-options",
        functionName = "carmenuevent",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },

    {
        id = "policeboat",
        displayName = "Generar Bote de PD",
        icon = "#boat-options",
        functionName = "qb-rental:policeboatsea",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local Data = QBCore.Functions.GetPlayerData()
        local waterHeight = GetWaterHeight(playerCoords.x, playerCoords.y, playerCoords.z)
            return  (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "police" and Data.job.onduty and waterHeight == 1))--(not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and waterHeight == 1)
        end
    },

    {
        id = "cuff",
        displayName = "Opciones de Secuestro",
        icon = "#cuffs",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
        end,
        subMenus = {"cuffing:steal", 'ems:putinvehicle', 'police:drag' }
    },   
   
    -- Garages
    {
        id = "open-garage",
        displayName = "Lista de Vehículos",
        icon = "#garages",
        functionName = "Garages:Open",
        enableMenu = function()
            local pData = QBCore.Functions.GetPlayerData()
            return (not pData.metadata["isdead"] and not pData.metadata["inlaststand"] and inGarage and not isCloseVeh() and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },
    {
        id = "park-vehicle-garage",
        displayName = "Aparcar",
        icon = "#garages-parking",
        functionName = "Garages:Store",
        enableMenu = function()
            local pData = QBCore.Functions.GetPlayerData()
            return (not pData.metadata["isdead"] and not pData.metadata["inlaststand"] and inGarage and isCloseVeh())
        end
    },
    {
        id = "general:depots",
        displayName = "Depósito",
        icon = "#garages",
        functionName = "Garages:OpenDepot",
        enableMenu = function()
            local pData = QBCore.Functions.GetPlayerData()
            return (not pData.metadata["isdead"] and not pData.metadata["inlaststand"] and inDepots and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },
    {
        id = "open-garage-housing",
        displayName = "Lista de Vehículos",
        icon = "#garages",
        functionName = "Garages:OpenHouseGarage",
        enableMenu = function()
            local pData = QBCore.Functions.GetPlayerData()
            local isAtHouseGarage = false
            QBCore.Functions.TriggerCallback('qb-garages:isAtHouseGar', function(result)
                isAtHouseGarage = result
            end)
            Wait(100)
            return (not pData.metadata["isdead"] and not pData.metadata["inlaststand"] and isAtHouseGarage and not isCloseVeh() and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },
    {
        id = "park-vehicle-garage-housing",
        displayName = "Aparcar",
        icon = "#garages-parking",
        functionName = "Garages:StoreInHouseGarage",
        enableMenu = function()
            local pData = QBCore.Functions.GetPlayerData()
            local isAtHouseGarage = false
            QBCore.Functions.TriggerCallback('qb-garages:isAtHouseGar', function(result)
                isAtHouseGarage = result
            end)
            Wait(100)
            return (not pData.metadata["isdead"] and not pData.metadata["inlaststand"] and isAtHouseGarage and isCloseVeh() and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },    


    

    -- Police --
    {
        id = "PanicPolice",
        displayName = "10-13A",
        icon = "#police-dead",
        functionName = "qb-dispatch:client:officerdown",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()

            return (Data.metadata["isdead"] or Data.metadata["inlaststand"]) and (Data.job.name == 'police' and Data.job.onduty)
        end
    },
    {
        id = "police",
        displayName = "Acciones Policiales",
        icon = "#police-action",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "police" and Data.job.onduty))
        end,
        subMenus = {"police:cuff", "police:unmask", "gpsbutton", "panicpolice", "police:checkbank", "police:search", "police:checklicenses"}
    },

    -- {
    --     id = "police-check",
    --     displayName = "Comprobaciones Policiales",
    --     icon = "#police-check",
    --     enableMenu = function()
    --         local Data = QBCore.Functions.GetPlayerData()
    --         return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "police" and Data.job.onduty))
    --     end,
    --     subMenus = {"police:checkbank", "police:checklicenses","police:checkfines", "police:search" }
    -- },

    {
        id = "objects",
        displayName = "Objetos",
        icon = "#objects",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "police" and Data.job.onduty))
        end,
        subMenus = {"objects:barier", "objects:cone", "objects:tent", "objects:light", "objects:remove"}
    },

    -- {
    --     id = "mdt",
    --     displayName = "MDT",
    --     icon = "#police-mdt",
    --     functionName = "mdt:client:open",
    --     enableMenu = function()
    --         local Data = QBCore.Functions.GetPlayerData()

    --         return not (Data.metadata["isdead"] or Data.metadata["inlaststand"]) and (Data.job.name == 'police' and Data.job.onduty)
    --     end
    -- },

    {
        id = "toogle",
        displayName = "Activar",
        icon = "#police-mdt",
        functionName = "jobs:client:ToggleNpc",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()

            return not (Data.metadata["isdead"] or Data.metadata["inlaststand"]) and (Data.job.name == 'tow' and Data.job.onduty)
        end
    },

    {
        id = "radio",
        displayName = "Radio",
        icon = "#radio",
        enableMenu = function()
            local Data, hasItem = QBCore.Functions.GetPlayerData()

            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                hasItem = result
            end, "radio")

            while hasItem == nil do
                Wait(10)
            end

            return hasItem and (not Data.metadata["isdead"] and not Data.metadata["inlaststand"]) and (Data.job.name == 'police' and Data.job.onduty)
        end,
        subMenus = {'power:off',"radio:1","radio:2","radio:3","radio:4","radio:5"}
    },
    {
        id = "radio",
        displayName = "Radio",
        icon = "#radio",
        enableMenu = function()
            local Data, hasItem = QBCore.Functions.GetPlayerData()

            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                hasItem = result
            end, "radio")

            while hasItem == nil do
                Wait(10)
            end

            return hasItem and not Data.metadata["isdead"] and (Data.job.name == "ambulance")
        end,
        subMenus = {'power:off',"radio:6","radio:7","radio:8","radio:9","radio:10"}
    },
    -- EMS --
    {
        id = "ems",
        displayName = "EMS",
        icon = "#medic",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "ambulance" and Data.job.onduty))
        end,
        subMenus = { 'police:drag', "ems:revive", 'ems:heal',  'ems:putinvehicle'}
    },
    
    {
        id = "objects",
        displayName = "Objetos",
        icon = "#objects",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "ambulance" and Data.job.onduty))
        end,
        subMenus = {"objects:barier", "objects:cone", "objects:tent", "objects:remove"}
    },

    -- {
    --     id = "Bennys",
    --     displayName = "Bennys",
    --     icon = "#tools",
    --     functionName = "event:control:bennys",
    --     enableMenu = function()
    --         local Data = QBCore.Functions.GetPlayerData()
    --         return IsPedInAnyVehicle(PlayerPedId(), false) and InBennys and not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
    --     end
    -- },

    {
        id = "PD Bennys",
        displayName = "Bennys",
        icon = "#tools",
        functionName = "event:control:pdbennys",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return IsPedInAnyVehicle(PlayerPedId()) and (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "police" and Data.job.onduty and InPdbennys))
        end
    },

    -- {
    --     id = "PD Bennys",
    --     displayName = "Bennys",
    --     icon = "#tools",
    --     functionName = "event:control:paletopdbennys",
    --     enableMenu = function()
    --         local Data = QBCore.Functions.GetPlayerData()
    --         return IsPedInAnyVehicle(PlayerPedId()) and (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "police" and Data.job.onduty and InPaletoPDBennys))
    --     end
    -- },

    {
        id = "Repair",
        displayName = "Reparar Vehículo",
        icon = "#tools",
        functionName = "autorepair",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return IsPedInAnyVehicle(PlayerPedId()) and (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and InAutoBennys)
        end
    },

    {
        id = "emsDeadA",
        displayName = "10-14A",
        icon = "#ems-dead",
        functionName = "dispatch:emsDown",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (Data.metadata["isdead"] or Data.metadata["inlaststand"]) and (Data.job.name == 'ambulance' and Data.job.onduty)
        end
    },
    

    -- {
    --     id = "judge",
    --     displayName = "Juzgar Acciones",
    --     icon = "judge-actions",
    --     enableMenu =function()
    --         local Data = QBCore.Functions.GetPlayerData()
    --         return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name == "mayor" and Data.job.grade >= 2)
    --     end,
    --     subMenus = { 'judge:mdt' }
    -- },

    {
        id = "taxi",
        displayName = "Acciones de Taxi",
        icon = "#taxi-togglemeter",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name == "taxi")
        end,
        subMenus = { "taxi:togglemeter", "taxi:npcmission", "npc_mission" }
    },

    -- {
    --     id = "news",
    --     displayName = "Noticias",
    --     icon = "#news",
    --     enableMenu =function()
    --         local Data = QBCore.Functions.GetPlayerData()
    --         return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and (Data.job.name == "reporter"))
    --     end,
    --     subMenus = { "news:boom", "news:mic", "news:cam" }
    -- },
  
}

newSubMenus = {
    ['gpsbutton'] = {
        title = "Ubicación GPS",
        icon = "#police-panic",
        functionName = "qb-dispatch:client:gpsbutton"
    },
    ['panicpolice'] = {
        title = "Botón del Pánico",
        icon = "#police-panic",
        functionName = "qb-dispatch:client:panicbutton"
    },
    -- General --
    ['vehicle:giveKeys'] = {
        title = "Dar Llaves",
        icon = "#vehicle-givekeys",
        functionName = "vehiclekeys:client:GiveKeys"
    },

    ['general:flipveh'] = {
        title = "Voltear Vehículo",
        icon = "#general-flip-vehicle",
        functionName = "vehicle:flipit"
    },
    ['realestate:listofhouses'] = {
        title = "Lista de Propiedades",
        icon = "#laptop-house",
        functionName = "qb-realestate:client:OpenHouseListMenu" 
    }, 
    ['realestate:addgarage'] = {
        title = "Añadir Garage",
        icon = "general-parking",
        functionName = "qb-houses:client:addGarage" 
    },

    ['interact:carry'] = {
        title = "Cargar",
        icon = "#carry",
        functionName = "carry:Event",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"])
        end
    },

    ['interact:trunkin'] = {
        title = "Meter Al Maletero",
        icon = "#carry",
        functionName = "trunkgetin:event",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"])
        end
    },

    ['interact:trunkout'] = {
        title = "Sacar del Maletero",
        icon = "#carry",
        functionName = "trunkgetout:event",
    },
    
    ['general:givenum'] = {
        title = "Proporcionar detalles de contacto",
        icon = "#givenum",
        functionName = "qb-phone:client:GiveContactDetails"
    },
    ['police:unmask'] = {
        title = "Quitar Máscara/Sombrero",
        icon = "#police-unmask",
        functionName = "police:unmask"
    },

    ['power:off'] = {
        title = "Desconectar",
        icon = "#radio",
        functionName = "remove:radio"
    },
    ['house:remove'] = {
        title = "Quitar llaves de Casa",
        icon = "#house-removekey",
        functionName = "qb-houses:client:removeHouseKey"
    },

    ['house:doorlock'] = {
        title = "Activar Menú de Propietario",
        icon = "#police-jail",
        functionName = "openownermenu"
    },

    ['house:reset'] = {
        title = "Resetear Bloqueo de Casa",
        icon = "#house-resetlock",
        functionName = "qb-houses:client:ResetHouse"
    },

    ['house:decorate'] = {
        title = "Decorar Casa",
        icon = "#house-decorate",
        functionName = "decoratehouse",
    },

    ['house:setstash'] = {
        title = "Establecer Alijo",
        icon = "#house-setstash",
        functionName = "qb-houses:client:setStash",
        functionParameters =  "setstash"
    },
    
    ['house:setoutift'] = {
        title = "Establecer Outfit",
        icon = "#house-setoutift",
        functionName = "qb-houses:client:setOutfit",
        functionParameters =  "setoutift"
    },
    
    ['house:setlogout'] = {
        title = "Salir",
        icon = "#house-logout",
        functionName = "qb-houses:client:setLogout",
        functionParameters =  "setlogout"
    },

    ['cuffing:cuff'] = {
        title = "Esposar",
        icon = "#cuffs-cuff",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name ~= "ambulance" and Data.job.name ~= "police" and not IsPedInAnyVehicle(ped, true))
        end,
        functionName = "police:client:CuffPlayerSoft",
    },

    ['cuffing:steal'] = {
        title = "Robar",
        icon = "#cuffs-steal",
        functionName = "police:client:RobPlayer",
    },

    ['kidnap:person'] = {
        title = "Secuestrar",
        icon = "#cuffs-steal",
        functionName = "police:client:KidnapPlayer",
    },
    
    ['kidnap:trunk'] = {
        title = "Secuestrar al Maletero",
        icon = "#cuffs-steal",
        functionName = "qb-trunk:client:KidnapTrunk",
    },

    -- Police --
    ['police:drag'] = {
        title = "Escoltar",
        icon = "#general-escort",
        functionName = "police:client:EscortPlayer",
    },

    -- ['police:softcuff'] = {
    --     title = "Esposar Gentilmente",
    --     icon = "#cuffs-cuff",
    --     functionName = "police:client:CuffPlayerSoft"
    -- },
    
    ['police:cuff'] = {
        title = "Esposar",
        icon = "#cuffs-cuff",
        functionName = "police:client:CuffPlayerSoft"
    },


    ['police:checkbank'] = {
        title = "Comprobar Estado",
        icon = "#police-check-bank",
        functionName = "police:client:CheckStatus"
    },

    ['police:checklicenses'] = {
        title = "Comprobar GSR",
        icon = "#police-check-licenses",
        functionName = "police:client:gsr"
    },

    ['police:checkfines'] = {
        title = "Comprobar Estado de Salud",
        icon = "#ems-heal",
        functionName = "hospital:client:CheckStatus"
    },

    ['police:search'] = {
        title = "Cachear",
        icon = "#police-search",
        functionName = "police:client:SearchPlayer"
    },

    ['deadblip:sendBlip'] = {
        title = "10-11 Llamada de Socorro",
        icon = "#police-dead",
        functionName = "qb-menu:senddeadblip"
    },

    ['objects:barier'] = {
        title = "Barrera",
        icon = "#barier",
        functionName = "police:client:spawnBarier"
    },

    ['objects:cone'] = {
        title = "Cono",
        icon = "#cone",
        functionName = "police:client:spawnCone"
    },

    ['objects:tent'] = {
        title = "Carpa",
        icon = "#tent",
        functionName = "police:client:spawnTent"
    },

    ['objects:spike'] = {
        title = "Pinchos",
        icon = "#spike",
        functionName = "police:client:SpawnSpikeStrip"
    },

    ['objects:remove'] = {
        title = "Eliminar",
        icon = "#removeobject",
        functionName = "police:client:deleteObject"
    },    

    -- EMS --
    ['ems:revive'] = {
        title = "Revivir",
        icon = "#ems-revive",
        functionName = "hospital:client:RevivePlayer",
    },

    ['ems:heal'] = {
        title = "Curar",
        icon = "#ems-heal",
        functionName = "hospital:client:TreatWounds",
    },

    ['ems:putinvehicle'] = {
        title = "Meter en Vehículo",
        icon = "#general-put-in-veh",
        functionName = "police:client:PutPlayerInVehicle"
    },

    ['ems:unseatvehicle'] = {
        title = "Bajarle de Vehículo",
        icon = "#general-unseat-nearest",
        functionName = "police:client:SetPlayerOutVehicle"
    },

    -- Animations --
    ['animations:brave'] = {
        title = "Valiente",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },

    ['animations:hurry'] = {
        title = "Apurado",
        icon = "#animation-hurry",
        functionName = "AnimSet:Hurry"
    },

    ['animations:business'] = {
        title = "Empresario",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },

    ['animations:tipsy'] = {
        title = "Achispado",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },

    ['animations:injured'] = {
        title = "Dolorido",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },

    ['animations:tough'] = {
        title = "Duro",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },

    ['animations:sassy'] = {
        title = "Atrevido",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },

    ['animations:sad'] = {
        title = "Triste",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },

    ['animations:posh'] = {
        title = "Elegante",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },

    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },

    ['animations:nonchalant'] = {
        title = "Calmado",
        icon = "#animation-nonchalant",
        functionName = "AnimSet:NonChalant"
    },

    ['animations:hobo'] = {
        title = "Vagabundo",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },

    ['animations:money'] = {
        title = "Dinero",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },

    ['animations:swagger'] = {
        title = "Swagger",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },

    ['animations:shady'] = {
        title = "Sospechoso",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },

    ['animations:maneater'] = {
        title = "Maniático",
        icon = "#animation-maneater",
        functionName = "AnimSet:ManEater"
    },

    ['animations:chichi'] = {
        title = "Chichi",
        icon = "#animation-chichi",
        functionName = "AnimSet:ChiChi"
    },

    ['animations:default'] = {
        title = "Predeterminado",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },

    -- Expressions --
    ["expressions:angry"] = {
        title="Enfadado",
        icon="#expressions-angry",
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" }
    },

    ["expressions:drunk"] = {
        title="Borracho",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
    },

    ["expressions:dumb"] = {
        title="Tonto",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    },

    ["expressions:electrocuted"] = {
        title="Electrocutado",
        icon="#expressions-electrocuted",
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" }
    },

    ["expressions:grumpy"] = {
        title="Gruñón",
        icon="#expressions-grumpy",
        functionName = "expressions", 
        functionParameters =  { "mood_drivefast_1" }
    },

    ["expressions:happy"] = {
        title="Feliz",
        icon="#expressions-happy",
        functionName = "expressions",
        functionParameters =  { "mood_happy_1" }
    },

    ["expressions:injured"] = {
        title="Dolorido",
        icon="#expressions-injured",
        functionName = "expressions",
        functionParameters =  { "mood_injured_1" }
    },

    ["expressions:joyful"] = {
        title="Alegre",
        icon="#expressions-joyful",
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" }
    },

    ["expressions:mouthbreather"] = {
        title="Respirar por la boca",
        icon="#expressions-mouthbreather",
        functionName = "expressions",
        functionParameters = { "smoking_hold_1" }
    },

    ["expressions:normal"]  = {
        title="Normal",
        icon="#expressions-normal",
        functionName = "expressions:clear"
    },

    ["expressions:oneeye"]  = {
        title="Tuerto",
        icon="#expressions-oneeye",
        functionName = "expressions",
        functionParameters = { "pose_aiming_1" }
    },

    ["expressions:shocked"]  = {
        title="Sorprendido",
        icon="#expressions-shocked",
        functionName = "expressions",
        functionParameters = { "shocked_1" }
    },

    ["expressions:sleeping"]  = {
        title="Somnoliento",
        icon="#expressions-sleeping",
        functionName = "expressions",
        functionParameters = { "dead_1" }
    },

    ["expressions:smug"]  = {
        title="Presumido",
        icon="#expressions-smug",
        functionName = "expressions",
        functionParameters = { "mood_smug_1" }
    },

    ["expressions:speculative"]  = {
        title="Especulador",
        icon="#expressions-speculative",
        functionName = "expressions",
        functionParameters = { "mood_aiming_1" }
    },

    ["expressions:stressed"]  = {
        title="Estresado",
        icon="#expressions-stressed",
        functionName = "expressions",
        functionParameters = { "mood_stressed_1" }
    },

    ["expressions:sulking"]  = {
        title="Malhumorado",
        icon="#expressions-sulking",
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
    },

    ["expressions:weird"]  = {
        title="Idiota",
        icon="#expressions-weird",
        functionName = "expressions",
        functionParameters = { "effort_2" }
    },

    ["expressions:weird2"]  = {
        title="Idiota 2",
        icon="#expressions-weird2",
        functionName = "expressions",
        functionParameters = { "effort_3" }
     },    

    -- Jobs --
    ['news:boom'] = {
        title = "Micrófono Alto",
        icon = "#news-boom",
        functionName = "Mic:ToggleBMic"
    },

    ['news:cam'] = {
        title = "Cámara",
        icon = "#news-cam",
        functionName = "Cam:ToggleCam"
    },

    ['news:mic'] = {
        title = "Micrófono",
        icon = "#news-mic",
        functionName = "Mic:ToggleMic"
    },
    
    ["taxi:togglemeter"] = {
        title = "Mostrar/Ocultar Taxímetro",
        icon = "#taxi-togglemeter",
        functionName = "qb-taxi:client:toggleMeter",
    },

    ["taxi:npcmission"] = {
        title = "Iniciar/Parar Taxímetro",
        icon = "#taxi-power",
        functionName = "qb-taxi:client:enableMeter",
    },
    
    ["npc_mission"] = {
        title = "Misión de NPC",
        icon = "#tow-status",
        functionName = "qb-taxi:client:DoTaxiNpc",
    },
    
    -- ["tow:towvehicle"] = {
    --     title = "Elevar Vehículo",
    --     icon = "#mechanic-flatbed",
    --     functionName = "qb-tow:client:TowVehicle",
    -- },

    ["tow:checkstatus"] = {
        title = "Comprobar Estado",
        icon = "#tow-status",
        functionName = "qb-tow:client:status",
    },

    -- ["mechanic:impound"] = {
    --     title = "Embargar",
    --     icon = "#police-jail",
    --     functionName = "qb-tow:client:ImpoundVehicle"
    -- },

    -- ["mechanic:flatbed"] = {
    --     title = "Remolcar",
    --     icon = "#mechanic-flatbed",
    --     functionName = "qb-tow:client:TowVehicle"
    -- }
}

for i=1, 10 do
    newSubMenus["radio:"..i] = {
        title = "Radio\n"..i,
        icon = "#radio",
        functionName = "qb-radio:radialmenu",
        functionParameters = i,
    }
end


-- Citizen.CreateThread(function()
--     for k, v in pairs(Garages) do
--         exports["qb-polyzone"]:AddBoxZone("garages", vector3(Garages[k].polyzone.x, Garages[k].polyzone.y, Garages[k].polyzone.z), Garages[k].polyzone1, Garages[k].polyzone2, {
--             name="garages",
--             heading=Garages[k].heading,
--             minZ = Garages[k].minZ,
--             maxZ = Garages[k].maxZ,
--             debugPoly=false
--         }) 
--     end
--     for k, v in pairs(GangGarages) do
--         exports["qb-polyzone"]:AddBoxZone("ganggarages", vector3(GangGarages[k].polyzone.x, GangGarages[k].polyzone.y, GangGarages[k].polyzone.z), GangGarages[k].polyzone1, GangGarages[k].polyzone2, {
--             name="ganggarages",
--             heading=GangGarages[k].heading,
--             minZ = GangGarages[k].minZ,
--             maxZ = GangGarages[k].maxZ,
--             debugPoly=false
--         }) 
--     end
--     for k, v in pairs(JobGarages) do
--         exports["qb-polyzone"]:AddBoxZone("jobgarages", vector3(JobGarages[k].polyzone.x, JobGarages[k].polyzone.y, JobGarages[k].polyzone.z), JobGarages[k].polyzone1, JobGarages[k].polyzone2, {
--             name="jobgarages",
--             heading=JobGarages[k].heading,
--             minZ = JobGarages[k].minZ,
--             maxZ = JobGarages[k].maxZ,
--             debugPoly=false
--         }) 
--     end
--     for k, v in pairs(Depots) do
--         exports["qb-polyzone"]:AddBoxZone("depots", vector3(Depots[k].polyzone.x, Depots[k].polyzone.y, Depots[k].polyzone.z), Depots[k].polyzone1, Depots[k].polyzone2, {
--             name="depots",
--             heading=Depots[k].heading,
--             minZ = Depots[k].minZ,
--             maxZ = Depots[k].maxZ,
--             debugPoly=false
--         }) 
--     end
-- end)

CreateThread(function()
    
    exports["qb-polyzone"]:AddBoxZone("autobennys", vector3(-33.28638, -1055.024, 28.221361), 4.2, 8.2, {
        name="autobennys",
        heading=338,
        debugPoly=false
    })
    exports["qb-polyzone"]:AddBoxZone("autobennys", vector3(-1155.07, -2003.96, 13.18), 4.7, 9.8, {
        name="autobennys",
        heading=45,
        debugPoly=false
    })
    exports["qb-polyzone"]:AddBoxZone("autobennys", vector3(110.62, 6626.12, 31.79), 5.3, 7.4, {
        name="autobennys",
        heading=315,
        debugPoly=false
    })
    exports["qb-polyzone"]:AddBoxZone("pdbennys", vector3(-323.608, -369.9629, 20.033802), 5, 10, {
        name="pdbennys",
        heading=90,
        debugPoly=false
    })
    exports["qb-polyzone"]:AddBoxZone("paletopdbennys", vector3(1815.0581, 3679.5468, 33.974578), 5, 10, {
        name="paletopdbennys",
        heading=90,
        debugPoly=false
    })
    exports["qb-polyzone"]:AddBoxZone("lsbennys", vector3(-33.28638, -1055.024, 28.221361), 5, 10, {
        name="lsbennys",
        heading=90,
        debugPoly=false
    })
    exports["qb-polyzone"]:AddBoxZone("autobennys", vector3(1175.03, 2640.49, 37.77), 7.5, 5.6, {
        name="autobennys",
        heading=0,
        debugPoly=false
    })
end)

RegisterNetEvent('qb-polyzone:enter')
AddEventHandler('qb-polyzone:enter', function(name)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if name == "garages" then
        inGarage = true
    elseif name == "ganggarages" then
        inGarage = true
    elseif name == "autobennys" then
        InAutoBennys = true
    elseif name == "bennys" then
        InBennys = true
    elseif name == "pdbennys" then
        InPdbennys = true
    elseif name == "paletopdbennys" then
        InPaletoPDBennys = true
    elseif name == "jobgarages" then
        inGarage = true
    elseif name == "depots" then
        inDepots = true
    end
end)

RegisterNetEvent('qb-polyzone:exit')
AddEventHandler('qb-polyzone:exit', function(name)
    if name == "garages" then
        inGarage = false
    elseif name == "ganggarages" then
        inGarage = false
    elseif name == "autobennys" then
        InAutoBennys = false
    elseif name == "bennys" then
        InBennys = false
    elseif name == "pdbennys" then
        InPdbennys = false
    elseif name == "paletopdbennys" then
        InPaletoPDBennys = false
    elseif name == "jobgarages" then
        inGarage = false
    elseif name == "depots" then
        inDepots = false
    end
end)


function isCloseVeh()
    local ped = PlayerPedId()
    coordA = GetEntityCoords(ped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(ped, 0.0, 100.0, 0.0)
    vehicle = getVehicleInDirection(coordA, coordB)
    if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
        return true
    end
    return false
end

function GetPlayers()
    local players = {}
    
    for i = 0, 128 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local closestPed = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        for index,value in ipairs(players) do
            local target = GetPlayerPed(value)
            if(target ~= ply) then
                local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
                if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
                    closestPlayer = value
                    closestPed = target
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance, closestPed
    end
end


TrunkClasses = {
    [0]  = { allowed = true, x = 0.0, y = -1.5, z = 0.0 }, --Coupes  
    [1]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Sedans  
    [2]  = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --SUVs  
    [3]  = { allowed = true, x = 0.0, y = -1.5, z = 0.0 }, --Coupes  
    [4]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Muscle  
    [5]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Sports Classics  
    [6]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Sports  
    [7]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Super  
    [8]  = { allowed = false, x = 0.0, y = -1.0, z = 0.25 }, --Motorcycles  
    [9]  = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Off-road  
    [10] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Industrial  
    [11] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Utility  
    [12] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Vans  
    [13] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Cycles  
    [14] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Boats  
    [15] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Helicopters  
    [16] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Planes  
    [17] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Service  
    [18] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Emergency  
    [19] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Military  
    [20] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Commercial  
    [21] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Trains  
}

exports["qb-polyzone"]:AddBoxZone("bennys",vector3(-34.11174, -1053.55, 27.765237), 8.1, 6.2, { --vector3(-34.11174, -1053.55, 27.765237)
    name="bennys",
    heading=0,
    debugPoly=false
})