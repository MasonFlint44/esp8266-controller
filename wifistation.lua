local WifiStation = {}
WifiStation.__index = WifiStation

function WifiStation:new()
    local station = {}
    setmetatable(station, WifiStation)

    -- Register default event handlers
    station:onConnect()
    station:onDisconnect()
    station:onAuthModeChange()
    station:onIpSet()

    return station
end

-- function WifiStation:smartConnect()
--     local internalHandler = function(ssid, password)
--         self.ssid = ssid
--     end
--     wifi.startsmart(0, internalHandler)
-- end

function WifiStation:connect(ssid, password)
    self.ssid = ssid
    wifi.setmode(wifi.STATION)
    return wifi.sta.config({
        ssid = ssid,
        pwd = password
    })
end

function WifiStation:onConnect(handler)
    local internalHandler = function(event)
        self.isConnected = true
        if handler ~= nil then
            handler(event)
        end
    end
    wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, internalHandler)
end

function WifiStation:onDisconnect(handler)
    local internalHandler = function(event)
        self.isConnected = false
        if handler ~= nil then
            handler(event)
        end
    end
    wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, internalHandler)
end

function WifiStation:onAuthModeChange(handler)
    local internalHandler = function (event)
        self.authMode = event.new_auth_mode
        if handler ~= nil then
            handler(event)
        end
    end
    wifi.eventmon.register(wifi.eventmon.STA_AUTHMODE_CHANGE, internalHandler)
end

function WifiStation:onIpSet(handler)
    local internalHandler = function (event)
        self.ipAddress = event.IP
        self.netmask = event.netmask
        self.gateway = event.gateway
        if handler ~= nil then
            handler(event)
        end
    end
    wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, internalHandler)
end

return WifiStation
