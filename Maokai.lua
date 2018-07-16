
--============================================================--
--|| | \ | |                  / ____|         (_)           ||--
--|| |  \| | _____   ____ _  | (___   ___ _ __ _  ___  ___  ||--
--|| | . ` |/ _ \ \ / / _` |  \___ \ / _ \ '__| |/ _ \/ __| ||--
--|| | |\  | (_) \ V / (_| |  ____) |  __/ |  | |  __/\__ \ ||--
--|| |_| \_|\___/ \_/ \__,_| |_____/ \___|_|  |_|\___||___/ ||--
--============================================================--
-- [[Champion: Maokai, Author: Nova, Created: 5/4/16]]
-- Fatures:
--     - Auto Q, W, E
require('Inspired')
require('OpenPredict')

if GetObjectName(myHero) ~= "Maokai" then return end

local RANGE_Q, RANGE_W, RANGE_E, RANGE_R =  myHero:GetSpellData(_Q).range, myHero:GetSpellData(_W).range,  myHero:GetSpellData(_E).range, myHero:GetSpellData(_R).range


local mainMenu = Menu("mainMenu", "Maokai")
mainMenu:Menu("Combo","Combo")
mainMenu.Combo:Boolean("Q","Use Q",true)
mainMenu.Combo:Boolean("W","Use W",true)
mainMenu.Combo:Boolean("E","Use E",true)

function Mode()
	if _G.IOW_Loaded and IOW:Mode() then
		return IOW:Mode()
	elseif _G.PW_Loaded and PW:Mode() then
		return PW:Mode()
	elseif _G.DAC_Loaded and DAC:Mode() then
		return DAC:Mode()
	elseif _G.AutoCarry_Loaded and DACR:Mode() then
		return DACR:Mode()
	elseif _G.SLW_Loaded and SLW:Mode() then
		return SLW:Mode()
	end
end

function Combo()
	local target = GetCurrentTarget()
	local QReady = Ready(_Q)
	local WReady = Ready(_W)
	local EReady = Ready(_E)
	local RReady = Ready(_R)

	--E
	if mainMenu.Combo.E:Value() and EReady and ValidTarget(target, RANGE_E) then
       	CastSkillShot(_E, target.x, target.y, target.z)
	end
	
	--W
	if mainMenu.Combo.W:Value() and WReady and ValidTarget(target, RANGE_W) then
		CastTargetSpell(target, _W)
	end
	
	--Q
	if mainMenu.Combo.Q:Value() and QReady and ValidTarget(target, RANGE_Q) then
        	CastSkillShot(_Q, target.x, target.y, target.z)
	end
end

OnTick(function(myHero)
	if Mode() == "Combo" then
		Combo()
	end
end)
