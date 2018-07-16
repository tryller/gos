if GetObjectName(GetMyHero()) ~= "Lulu" then return end

require("Inspired")

LuluMenu = Menu("Lulu", "Lulu")
LuluMenu:SubMenu("Combo", "Combo")
LuluMenu.Combo:Boolean("Q", "Use Q", true)
LuluMenu.Combo:Boolean("W", "Use W", true)
LuluMenu.Combo:Boolean("EE", "Use Enemy E", false)
LuluMenu.Combo:Boolean("AE", "Use Ally E", true)
LuluMenu.Combo:Boolean("ME", "Use Me E", true)
LuluMenu.Combo:Boolean("AR", "Use Allies R", true)
LuluMenu.Combo:Boolean("MR", "Use Me R", true)


LuluMenu:SubMenu("DMG", "Draw DMG")
LuluMenu.DMG:Boolean("Q", "Draw Q Dmg", true)
LuluMenu.DMG:Boolean("E", "Draw E Dmg", false)

 
 
 
OnTick(function(myHero)
 
        if IOW:Mode() == "Combo" then
                       
                        local target = GetCurrentTarget()
                      local QPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),1450,250,925,80,false,false)


                       
					   
                        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, 1300) and LuluMenu.Combo.Q:Value() then
                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
						end
                        if CanUseSpell(myHero, _W) == READY and ValidTarget(target, 700) and LuluMenu.Combo.W:Value() then
                        CastTargetSpell(target, _W)
                        end
			if CanUseSpell(myHero, _E) == READY and ValidTarget(target, 1000) and LuluMenu.Combo.EE:Value() then
                        CastTargetSpell(target, _E)
                        end
                        for _, ally in pairs(GetAllyHeroes()) do
                        if CanUseSpell(myHero, _E) == READY and ValidTarget(target, 1000) and (GetCurrentHP(ally)/GetMaxHP(ally))<0.3 and LuluMenu.Combo.AE:Value() then
                        CastTargetSpell(ally, _E)
                        end
                    end
                        if CanUseSpell(myHero, _E) == READY and ValidTarget(target, 1000) and (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.15 and LuluMenu.Combo.ME:Value() then
                        CastTargetSpell(myHero, _E)   
						end
                        for _, ally in pairs(GetAllyHeroes()) do
                        if LuluMenu.Combo.AR:Value() and ValidTarget(target, 1000) and (GetCurrentHP(ally)/GetMaxHP(ally))<0.3 and CanUseSpell(myHero, _R) == READY then
                        CastTargetSpell(ally, _R)
                        end
                    end
                        if LuluMenu.Combo.MR:Value() and ValidTarget(target, 1000) and (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.3 and CanUseSpell(myHero, _R) == READY then
                        CastTargetSpell(myHero, _R)
                        end

        end


for i,enemy in pairs(GetEnemyHeroes()) do

if CanUseSpell(myHero,_Q) == READY and ValidTarget(enemy, 2000) and LuluMenu.DMG.Q:Value() then
local trueDMG = CalcDamage(myHero, enemy, 0, (45*GetCastLevel(myHero,_Q) + 35 + 0.5*(GetBonusAP(myHero))))
    DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),trueDMG,0,0xffff0000)
end
if CanUseSpell(myHero,_E) == READY and ValidTarget(enemy, 2000) and LuluMenu.DMG.E:Value() then 
local trueDMG = CalcDamage(myHero, enemy, 0, (30*GetCastLevel(myHero,_E) + 50 + 0.4*(GetBonusAP(myHero))))
    DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),trueDMG,0,0xffff0000)
  end
    
end


     
 

 


end)

PrintChat("Toxic Lulu by: POPTART Loaded, Have Fun")
