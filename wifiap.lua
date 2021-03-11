local WifiAp = {}
WifiAp.__index = WifiAp

function WifiAp:new()
    local ap = {}
    setmetatable(ap, WifiAp)

    -- Register default event handlers
    ap:onClientConnected()
    ap:onClientDisconnected()
    ap:onProbe()
    ap.num_clients = 0

    wifi.setmode(wifi.SOFTAP)

    return ap
end

function WifiAp:start(ssid)
    self.ssid = ssid

    return wifi.ap.config({
        ssid = ssid
    })
end

function WifiAp:onClientConnected(handler)
    local internalHandler = function(event)
        self.num_clients = self.num_clients + 1
        if handler ~= nil then
            handler(event)
        end
    end
    wifi.eventmon.register(wifi.eventmon.AP_STACONNECTED, internalHandler)
end

function WifiAp:onClientDisconnected(handler)
    local internalHandler = function(event)
        self.num_clients = self.num_clients - 1
        if handler ~= nil then
            handler(event)
        end
    end
    wifi.eventmon.register(wifi.eventmon.AP_STADISCONNECTED, internalHandler)
end

function WifiAp:onProbe(handler)
    local internalHandler = function(event)
        if handler ~= nil then
            handler(event)
        end
    end
    wifi.eventmon.register(wifi.eventmon.AP_PROBEREQRECVED, internalHandler)
end

return WifiAp
