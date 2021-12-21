wifimanager = require("wifimanager"):new()
mqttclient = require("mqttclient"):new()
mqttclient:onConnect(
    function (event)
        print("Connected to mqtt broker")
    end
)
mqttclient:onDisconnect(
    function(event, reason)
       print("Error connecting to mqtt broker "..reason) 
    end
)
wifimanager:startAp(
    function(event)
        mqttclient:connect(event.ip)
    end
)