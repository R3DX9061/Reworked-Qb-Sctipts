local QBCore = exports['qb-core']:GetCoreObject() 
local Ads = {}
local Cooldown = false
local useDebug = Config.Debug

-- for debug
local function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end

-- functions
local function shallowCopy(original)
	local copy = {}
	for key, value in pairs(original) do
		copy[key] = value
	end
	return copy
end

local function hasItem(item)
    if Config.Inventory == 'qb' then
        return QBCore.Functions.HasItem(item)
    elseif Config.Inventory == 'ox' then
        local fromItem = exports.ox_inventory:Search('count', item)
        return fromItem > 0
    end
end

local function hasCrypto(price)
    if Config.Phone == 'qb' then
        local Player = QBCore.Functions.GetPlayerData()
        return Player.money['crypto'] >= price
    elseif Config.Phone == 're' then
        return exports['sundown-utils']:hasEnoughCrypto(Config.CryptoType, price)
    end
end

local function setCWLaptopOpen(bool) 
    if useDebug then
       print('Laptop was opened')
    end
    SetNuiFocus(bool, bool)
    if bool then
        TriggerEvent('animations:client:EmoteCommandStart', {"tablet2"})
    else
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end
    SendNUIMessage({
        action = "cwLaptop",
        toggle = bool
    })
end

local function openCWLaptop()
    TriggerEvent('animations:client:EmoteCommandStart', {"tablet2"})
    QBCore.Functions.Progressbar("open_cw_laptop", "Свързване със защитена VPN услуга", Config.Settings.VPNConnectionTime, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        setCWLaptopOpen(true)
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Canceled", "error")
    end)
end

local function generateAds()
    if Cooldown then
        if useDebug then
           print('cooldown is active')
        end
        return Ads
    else
        if useDebug then
           print('generating new ads')
        end
        Cooldown = true
        Ads = {}
        local amount = math.random(Config.Settings.TokensAmount.min, Config.Settings.TokensAmount.max)
        local cooldownTime = math.random(Config.Settings.Cooldown.min, Config.Settings.Cooldown.max)

        Citizen.SetTimeout(cooldownTime, function()
            Cooldown = false
        end)
        if useDebug then
           print('Amount of ads: ',amount)
           print('Cooldown lenght: ', cooldownTime)
        end

        for i = 1, amount, 1 do
            if useDebug then
               print('adding ad')
            end
            local randomNumber = math.random(1, #Config.TokenAds)
            local ad = shallowCopy(Config.TokenAds[randomNumber])
            
            ad.price = math.floor((math.random()*(ad.price.max-ad.price.min) + ad.price.min)*10)/10
            if not ad.body then
                if Config.UseBuyTokens then
                    ad.body = Config.Settings.GenericTexts.BuyTokens
                else
                    ad.body = Config.Settings.GenericTexts.Tokens
                end
            end 
    
            table.insert(Ads, ad)
        end
        return Ads
    end
end

local function removeAd(adName)
    if useDebug then
       print('removing ad', adName)
    end
    for i, ad in ipairs (Ads) do 
        if (ad.name == adName) then
            if useDebug then
               print('found: ', ad.name)
            end
            table.remove(Ads, i)
            return;
        end
    end
end

RegisterNUICallback('confirmPurchase', function(product, cb)
    local Player = QBCore.Functions.GetPlayerData()
    if hasCrypto(product.price) then
        if hasItem('cw_token_empty') then
            if product.type == 'token' then
                if Config.UseBuyTokens then
                    local productName = product.name
                    QBCore.Functions.TriggerCallback('cw-tokens:server:PlayerHasBuyToken', function(result)
                        if useDebug then
                           print('result', dump(result))
                        end
                        if result then
                            TriggerEvent('cw-tokens:client:attemtDigitalTradeFromToken', product.name, product.price)
                            cb(true)
                        else
                            QBCore.Functions.Notify("Не разполагате с необходимия елемент", "error")       
                            cb(false)
                        end
                    end, productName)
                else
                    TriggerEvent('cw-tokens:client:attemtDigitalTrade', product.name, product.price)
                    cb(true)
                end
            else
                print('type not implemented')
            end
        else
            cb(false)
            QBCore.Functions.Notify("Не разполагате с необходимия елемент", "error")       
        end
    else
        cb(false)
        QBCore.Functions.Notify("Не разполагате с достатъчно криптовалути", "error")
    end
end)

RegisterNUICallback('removeAd', function(data, cb)
    removeAd(data)
    cb(true)
end)

RegisterNUICallback('generateAds', function(data, cb)
    generateAds()
    cb(Ads)
end)

RegisterNUICallback('exitCWLaptop', function(_, cb)
    setCWLaptopOpen(false)
    cb('ok')
end)

RegisterNetEvent("cw-darkweb:client:openInteraction", function()
    openCWLaptop()
end)

RegisterNUICallback('checkIfPlayerHasCWLaptop', function(data, cb)
    local retval = false
    if QBCore.Functions.HasItem(Config.LaptopItem) then
        cb(true)
    else
        cb(false)
    end
end)

RegisterCommand('openDarkWeb', function(source)
    openCWLaptop()
end)

RegisterCommand('closeDarkWeb', function(source)
    setCWLaptopOpen(false)
end)

RegisterNetEvent('cw-tokens:client:toggleDebug', function(debug)
   print('Setting debug to',debug)
   useDebug = debug
end)