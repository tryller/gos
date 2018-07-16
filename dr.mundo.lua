if GetObjectName(myHero) ~= "DrMundo" then return end
-- Keys
mainMenu = Menu("DrMundo", "DrMundo")
-- Combo menu
mainMenu:SubMenu("Combo", "Combo")
mainMenu.Combo:Boolean("Q", "Use Q", true)
mainMenu.Combo:Boolean("W", "Use W", true)
mainMenu.Combo:Boolean("E", "Use E", true)

-- Orbwalker's
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

OnTick(function(myHero)
	if Mode() == "Combo" then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1300) then

-- Dr.Mundo Q
	if mainMenu.Combo.Q:Value() then
        	CastSkillShot(_Q, unit.x, unit.y, unit.z)
	end


-- Dr.Mundo E
if mainMenu.Combo.E:Value() then
	CastSpell(_E)
end

end
end
end)
