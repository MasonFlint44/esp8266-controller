-- local WifiStation = require("wifistation")
local WifiAp = require("wifiap")
-- local HttpController = require("httpcontroller")

-- local station = WifiStation:new()
-- local controller = HttpController:new()

-- station:onConnect(function()
--     print("Connnected to "..station.ssid)
-- end)

-- station:onIpSet(function()
--     print("IP address: "..station.ipAddress)
-- end)

-- print("Connecting to wifi...")
-- station:connect("mason", "Flint1324-")

local ap = WifiAp:new()

ap:onClientConnected(function()
    print("Client connected - total: "..ap.num_clients)
end)

ap:onClientDisconnected(function()
    print("Client disconnected - total: "..ap.num_clients)
end)

print("Starting wifi...")
ap:start("makethings-io")

-- local http = HttpController:new()