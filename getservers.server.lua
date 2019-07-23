local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Url = "your.domain.here/bot"

local function GetServers()
	local Data = {
		["type"] = "getservers"
	}
	local Encoded = HttpService:JSONEncode(Data)
	local Response = HttpService:PostAsync(Url, Encoded)
	return HttpService:JSONDecode(Response)
end

local Count = 0
local Servers = GetServers()
local function onHeartbeat(Delta)
	Count = Count + Delta
	if Count > 5 then
		Count = Count - 5
		Servers = GetServers()
	end
end

local function RetreiveServers()
	return Servers;
end

game:GetService("ReplicatedStorage").GetServersRemote.OnServerInvoke = 	RetreiveServers