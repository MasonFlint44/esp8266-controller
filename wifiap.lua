local WifiAp = {}
WifiAp.__index = WifiAp

function WifiAp:new()
    local ap = {}
    setmetatable(ap, WifiAp)

    ap.num_clients = 0
    ap.get_ip_delay = 100

    -- Register default event handlers
    ap:onClientConnected()
    ap:onClientDisconnected()
    ap:onProbe()

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
        local timer = tmr.create()
        local timerHandler = function()
            local clients = wifi.ap.getclient()
            local ip = clients[event.MAC]
            if ip == nil then
                return
            end
            timer:unregister()
            if handler ~= nil then
                handler({mac=event.MAC, ip=ip})
            end
        end
        timer:alarm(self.get_ip_delay, tmr.ALARM_AUTO, timerHandler)
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
