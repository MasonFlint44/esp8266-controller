-- local WifiStation = require("wifistation")
local WifiAp = require("wifiap")

local ap = WifiAp:new()

ap:onClientConnected(function()
    print("Client connected - total: "..ap.num_clients)
end)

ap:onClientDisconnected(function()
    print("Client disconnected - total: "..ap.num_clients)
end)

print("Starting wifi...")
ap:start("makethings-io")

-- local station = WifiStation:new()

-- station:onConnect(function()
--     print("Connnected to "..station.ssid)
-- end)

-- station:onIpSet(function()
--     print("IP address: "..station.ipAddress)
-- end)

-- print("Connecting to "..ssid.."...")
-- station:connect("mason", "Flint1324-")

