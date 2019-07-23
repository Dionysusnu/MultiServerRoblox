local PlayersService = game:GetService("Players");
local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local Url = "your.domain.here/bot";

local function UpdateStatus()
	local Data = {};
	Data.type = "heartbeat"
	Data.jobId = game.JobId;
	local PlayersTable = {};
	local Players = PlayersService:GetPlayers();
	for i = 1, #Players do
		PlayersTable[tostring(Players[i].UserId)] = Players[i].Name;
	end;
	Data.table = {
		placeId = game.PlaceId;
		playerCount = #PlayersTable;
		players = PlayersTable;
	};
	local Encoded = HttpService:JSONEncode(Data);
	HttpService:PostAsync(Url, Encoded);
end;

local Count = 0;
local function OnHeartbeat(Delta)
	Count = Count + Delta;
	if Count > 5 then
		Count = Count - 5;
		UpdateStatus();
	end;
end;

RunService.Heartbeat:Connect(OnHeartbeat)