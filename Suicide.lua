local version = "0.07"
function AutoUpdate(data)
    if tonumber(data) > tonumber(version) then
        PrintChat("New Suicide Bot Version Found " .. data)
        PrintChat("Downloading update, please wait...")
        DownloadFileAsync("https://raw.githubusercontent.com/mvpgos/-MvP-GoS/master/MvPChampions/Suicide.lua", SCRIPT_PATH .. "SuicideBot.lua", function() PrintChat(string.format("<font color=\"#FC5743\"><b>Script Downloaded succesfully. please 2x f6</b></font>")) return end)
    end
end
GetWebResultAsync("https://raw.githubusercontent.com/mvpgos/-MvP-GoS/master/MvPChampions/Suicide.version", AutoUpdate) 
LoadGOSScript(Base64Decode("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"))
local azul
local rojo
local botaBasica = 0
local botaRapidaQueFlipas = 0

menu = MenuConfig("ThatBot", "|MvP|SuicideBot")
menu:Menu("Input", "Block Input")
menu.Input:Boolean("BlIn", "Block Input", false)
menu:Menu("S", "Info and more")
menu.S:Info("Ver", "Current Version: "..version.."")
menu.S:Info("s", "Have Fun using this bot")

OnTick(function(myHero)
	if menu.Input.BlIn:Value() then
		BlockInput(true)
	else BlockInput(false)
	end

	if not myHero.dead then
		--[[
		if GetDistance(Vector(396, 182.132507, 462), myHero) < 350 then
			azul = 1
		end ]]
		if GetTeam(myHero) == 100 then
			azul = 1
		elseif GetTeam(myHero) == 200 then
			rojo = 1
		end
		if azul == 1 then
			MoveToXYZ(14340, 171.977722, 14390)
		end
		--[[
		if GetDistance(Vector(14340, 171.977722, 14390), myHero) < 350 then
			rojo = 1
		end ]]
		if rojo == 1 then
			MoveToXYZ(396, 182.132507, 462)
		end
	end
	if botaBasica == 0 then
		if GetCurrentGold(myHero) <= 500 then
			BuyItem(1001)
			botaBasica = 1
		end
	end
	if botaRapidaQueFlipas == 0 then
		if GetCurrentGold(myHero) >= 1000 then
			BuyItem(3117)
			botaRapidaQueFlipas = 1
		end
	end
end)
OnDraw(function(myHero)
	DrawCircle(myHero.pos, 350, 1,32,GoS.Red)
end)
--[[
OnWndMsg(function(msg, wParam)
	if msg == 516 and wParam == 0 then
		BlockOrder()
	end
end)
]]
id = 11
scriptname = "SuicideBot"
GoSTracker(scriptname,id)
PrintChat(string.format("<font color=\"#85EDD7\"><b>Thanks for using |MvP|SuicideBot, have fun reaching your dead record. </b></font>"))
PrintChat("Lock your screen (Y) for a better experience")
