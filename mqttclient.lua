local MqttClient = {}
MqttClient.__index = MqttClient

function MqttClient:new()
    local m = {}
    setmetatable(m, MqttClient)

    m.clientid = "nodemcu"
    m.keepalive = 60
    m.username = nil
    m.password = nil
    m.port = 1883
    m.secure = false
    m.client = mqtt.Client(m.clientid, m.keepalive, m.username, m.password)

    -- Register default event handlers
    m:onConnect()
    m:onDisconnect()

    return m
end

function MqttClient:connect(host)
    print("Connnecting to MQTT broker at "..host..":"..self.port.."...")
    self.client:connect(host, self.port, self.secure, self.onConnectCallback, self.onDisconnectCallback)
end

function MqttClient:onConnect(handler)
    local internalHandler = function(event)
        self.isConnected = true
        if handler ~= nil then
            handler(event)
        end
    end
    self.onConnectCallback = internalHandler
end

function MqttClient:onDisconnect(handler)
    local internalHandler = function(event, reason)
        self.isConnected = false
        if handler ~= nil then
            handler(event, reason)
        end
    end
    self.onDisconnectCallback = internalHandler
end

return MqttClient
