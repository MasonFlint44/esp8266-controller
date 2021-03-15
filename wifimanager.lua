local WifiAp = require("wifiap")
local WifiStation = require("wifistation")

local WifiManager = {}
WifiManager.__index = WifiManager

local function setupAccessPoint(ap, ssid)
    ap:onClientConnected(function()
        print("Client connected - total: "..ap.num_clients)
    end)
    ap:onClientDisconnected(function()
        print("Client disconnected - total: "..ap.num_clients)
    end)
    print("Starting wifi...")
    ap:start(ssid)
end

function WifiManager:new()
    local manager = {}
    setmetatable(manager, WifiManager)

    manager.ap = WifiAp:new()
    manager.station = WifiStation:new()

    setupAccessPoint(manager.ap, "makethings-io")

    return manager
end


return WifiManager
