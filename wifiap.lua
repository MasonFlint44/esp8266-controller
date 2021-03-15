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

    return ap
end

function WifiAp:start(ssid)
    self.ssid = ssid
    wifi.setmode(wifi.SOFTAP)
    return wifi.ap.config({
        ssid = ssid
    })
end

function WifiAp:onClientConnected(handler)
    local connectedHandler = function(event)
        self.num_clients = self.num_clients + 1
        -- TODO: lookup ip in table with mac
        local timerHandler = function()
            local clients = wifi.ap.getclient()
            for mac, ip in pairs(clients) do
                print(mac, ip)
            end

            if handler ~= nil then
                handler(event)
            end
        end
        -- TODO: tweak timer value
        tmr.create():alarm(1000, tmr.ALARM_SINGLE, timerHandler)
    end
    wifi.eventmon.register(wifi.eventmon.AP_STACONNECTED, connectedHandler)
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
