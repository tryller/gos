if GetObjectName(myHero) ~= "Ekko" then return end

require('OpenPredict')

--Combo
mainMenu = Menu("Ekko", "Ekko")
mainMenu:Menu("Combo", "Combo")
mainMenu.Combo:Boolean("CQ", "Use Q", true)
mainMenu.Combo:Slider("CQH", "HitChance", 20, 0, 100, 1)
mainMenu.Combo:Slider("CQM", "Q Mana", 50, 0, 100, 1)
mainMenu.Combo:Boolean("CW", "Use W Enemy", true)
mainMenu.Combo:Slider("CWH", "HitChance", 20, 0, 100, 1)
mainMenu.Combo:Slider("CWM", "W Mana", 50, 0, 100, 1)
mainMenu.Combo:Slider("CWE", "W Enemy Hit", 1, 0, 5, 1)
mainMenu.Combo:Boolean("CE", "Use E", true)
mainMenu.Combo:Slider("CEM", "E Mana", 50, 0, 100, 1)
--Misc
mainMenu:Menu("Misc", "Misc")
mainMenu.Misc:Boolean("UR", "Auto R Low Hp", true)
mainMenu.Misc:Slider("URH", "Hp To Ult", 10, 0, 100, 1)
mainMenu.Misc:Boolean("HER", "Auto R If enemies", true)
mainMenu.Misc:Slider("HERX", "Enemies To Hit ", 1, 0, 5, 1)
--Killsteal
mainMenu:Menu("Killsteal", "Killsteal")
mainMenu.Killsteal:Boolean("KR", "Killsteal R", true)
--mainMenu.Killsteal:Slider("KRE", "Enemies Hit", 1, 0, 5, 1)


--R
OnObjectLoad(function(Object) 

  if GetObjectBaseName(Object) == "Ekko" then
  twin = Object
  end

end)


OnCreateObj(function(Object) 

  if GetObjectBaseName(Object) == "Ekko" then
  twin = Object
  end
  
end)

OnDeleteObj(function(Object) 
  if GetObjectBaseName(Object) == "Ekko_Base_R_TrailEnd.troy" then
  twin = nil
  end
end)

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
     local t = GetCurrentTarget()
     local myHeroPos = GetOrigin(myHero)
     local mousePos = GetMousePos()
     local q = { delay = 0.25, speed = 1000, width = 60, range = 950 }
     local pI = GetPrediction(t, q)


        if mainMenu.Combo.CQ:Value() and GetPercentMP(myHero) >= mainMenu.Combo.CQM:Value() and ValidTarget(t, 550) then      
            if CanUseSpell(myHero,_Q) == READY and pI and pI.hitChance >= (mainMenu.Combo.CQH:Value()/100) then
             CastSkillShot(_Q, pI.castPos)
            end
        end
         local w = { delay = 3.750, speed = 1000, width = 250, range = 1600 }
         local pI = GetPrediction(t, w)
        if mainMenu.Combo.CW:Value() and GetPercentMP(myHero) >= mainMenu.Combo.CWM:Value() and ValidTarget(t, 1500) then
            if CanUseSpell(myHero,_W) == READY and pI and pI.hitChance >= (mainMenu.Combo.CWH:Value()/100) then
             CastSkillShot(_W, pI.castPos)
            end
        end

         local e = { delay = 0.25, speed = 1050, width = 60, range = 950 }
         local pI = GetPrediction(t, e)
        if mainMenu.Combo.CE:Value() and GetPercentMP(myHero) >= mainMenu.Combo.CEM:Value() and ValidTarget(t, 900) then
            if CanUseSpell(myHero,_E) == READY then
            CastSkillShot(_E, mousePos.x, mousePos.y, mousePos.z)
            end
        end       
    end
local t = GetCurrentTarget()    
    --Misc
    if CanUseSpell(myHero,_R) == READY and mainMenu.Misc.UR:Value() and GetPercentHP(myHero) <= mainMenu.Misc.URH:Value() then
     CastSpell(_R)
    end
    if twin and IsReady(_R) and mainMenu.Misc.HER:Value() then
        if EnemiesAround(GetOrigin(twin), 300) >= mainMenu.Misc.HERX:Value() and IsObjectAlive(t) then
         CastSpell(_R)
        end
    end
    --Killsteal
    for i,e in pairs(GetEnemyHeroes()) do
    	if CanUseSpell(myHero,_R) == READY and IsObjectAlive(e) and EnemiesAround(GetOrigin(twin), 300) >= 1 and mainMenu.Killsteal.KR:Value() and GetCurrentHP(e) < CalcDamage(myHero, e, 0, (150*GetCastLevel(myHero,_R)+150+(1.3*(GetBonusAP(myHero))))) then
         CastSpell(_R)
        end
   end
end)       
