local WifiAp = require("wifiap")
local WifiStation = require("wifistation")

local WifiManager = {}
WifiManager.__index = WifiManager

local function setStationHandlers(station, ssid)
    station.ssid = ssid
    station:onConnect(function()
        print("Connnected to "..ssid)
    end)
    station:onIpSet(function()
        print("IP address: "..station.ipAddress)
    end)
end

function WifiManager:new()
    local manager = {}
    setmetatable(manager, WifiManager)

    manager.ssid = "things.dev"
    manager.ap = WifiAp:new()
    manager.station = WifiStation:new()

    return manager
end

function WifiManager:start()
    if wifi.getmode() == wifi.STATION then
        local ssid = wifi.sta.getconfig(true).ssid
        print("Connecting to "..ssid.."...")
        setStationHandlers(self.station, ssid)
        return
    end
    self:startAp()
end

-- TODO: need way to reset station remotely
function WifiManager:resetStation()
    self:startAp()
end

function WifiManager:startAp(connectedHandler, disconnectedHandler)
    self.ap:onClientConnected(function(event)
        print("Client connected: "..event.ip)
        print("Total clients: "..self.ap.num_clients)
        -- self:getCredentials(event.ip)
        if connectedHandler ~= nil then
            connectedHandler(event)
        end
    end)
    self.ap:onClientDisconnected(function()
        print("Client disconnected")
        print("Total clients: "..self.ap.num_clients)
        if disconnectedHandler ~= nil then
            disconnectedHandler()
        end
    end)
    print("Starting wifi...")
    self.ap:start(self.ssid)
end

function WifiManager:getCredentials(ip)
    print("Requesting wifi credentials from "..ip)
    http.get("http://"..ip..":22983/GetWifiCredentials", nil,
        function(status_code, body, headers)
            if status_code == -1 then
                print("HTTP request failed")
                return
            end
            local data = sjson.decode(body)
            print("Received wifi credentials for "..data.ssid)
            self:startStation(data.ssid, data.password)
        end
    )
end

function WifiManager:startStation(ssid, password)
    setStationHandlers(self.station, ssid)
    print("Connecting to "..ssid.."...")
    self.station:connect(ssid, password)
end

return WifiManager
