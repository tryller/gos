local myHero = GetMyHero()
if GetObjectName(myHero) ~= "Teemo" then return end
local target = GetCurrentTarget()
require('Inspired')
local summonerNameOne = GetCastName(myHero,SUMMONER_1)
local summonerNameTwo = GetCastName(myHero,SUMMONER_2)
local Ignite = (summonerNameOne:lower():find("summonerdot") and SUMMONER_1 or (summonerNameTwo:lower():find("summonerdot") and SUMMONER_2 or nil))
local mainMenu = Menu("OK Teemo v1.0", "Teemo")
mainMenu:Menu("Combo", "Combo")
mainMenu.Combo:Boolean("useQ", "Use Q", true)
mainMenu.Combo:Boolean("useW", "Use W", true)
mainMenu.Combo:Key("Combo1", "Combo", string.byte(" "))
mainMenu:Menu("Credits","Credits")
mainMenu.Credits:Info("info", "Author: OnlyKatarina")
mainMenu.Credits:Info("info2", "Have Fun Teeemoooo")
mainMenu:Menu("Misc", "Misc")
mainMenu.Misc:Boolean("Autoignite", "Autoignite [SooN]", true)
mainMenu:Info("Gapcloser", "Gapcloser")

OnTick(function(myHero) 
if mainMenu.Combo.Combo1:Value() then
if mainMenu.Combo.useQ:Value() and CanUseSpell(myHero,_Q) == READY and ValidTarget(target, 680) then
CastTargetSpell(target, _Q)
IOW:ResetAA()
end
if mainMenu.Combo.useW:Value() and CanUseSpell(myHero,_W) == READY and ValidTarget(target, 680) then
CastSpell(_W)
end
end
	end)

PrintChat("OK Teemo v1.0.0 Loaded.")
PrintChat("by OnlyKatarina")
AddGapcloseEvent(_Q, 680, true, mainMenu)