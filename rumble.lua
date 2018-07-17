local ver = "0.03"

if GetObjectName(GetMyHero()) ~= "Rumble" then return end

require("OpenPredict")
require("DamageLib")

GetLevelPoints = function(unit) return GetLevel(unit) - (GetCastLevel(unit,0)+GetCastLevel(unit,1)+GetCastLevel(unit,2)+GetCastLevel(unit,3)) end
local SetDCP, SkinChanger = 0

local RumbleE = {delay = .5, range = 850, width = 90, speed = 2000}
local RumbleR = {delay = .5, range = 1700, width = 200, speed = 1600}

local RumbleMenu = Menu("Rumble", "Rumble")

RumbleMenu:SubMenu("Combo", "Combo")
RumbleMenu.Combo:Boolean("Q", "Use Q in combo", true)
RumbleMenu.Combo:Boolean("W", "Use W in combo", true)
RumbleMenu.Combo:Boolean("E", "Use E in combo", true)
RumbleMenu.Combo:Slider("Epred", "E Hit Chance", 3,0,10,1)
RumbleMenu.Combo:Boolean("R", "Use R in combo", true)
RumbleMenu.Combo:Slider("RX", "X Enemies to Cast R",3,1,5,1)
RumbleMenu.Combo:Slider("Rpred", "R Hit Chance", 3,0,10,1)


RumbleMenu:SubMenu("AutoMode", "AutoMode")
RumbleMenu.AutoMode:Boolean("Level", "Auto level spells", false)
RumbleMenu.AutoMode:Boolean("Ghost", "Auto Ghost", false)
RumbleMenu.AutoMode:Boolean("Q", "Auto Q", false)
RumbleMenu.AutoMode:Boolean("W", "Auto W", false)
RumbleMenu.AutoMode:Boolean("E", "Auto E", false)

RumbleMenu:SubMenu("LaneClear", "LaneClear")
RumbleMenu.LaneClear:Boolean("Q", "Use Q", true)
RumbleMenu.LaneClear:Boolean("E", "Use E", true)

RumbleMenu:SubMenu("Harass", "Harass")
RumbleMenu.Harass:Boolean("Q", "Use Q", true)
RumbleMenu.Harass:Boolean("E", "Use E", true)

RumbleMenu:SubMenu("KillSteal", "KillSteal")
RumbleMenu.KillSteal:Boolean("Q", "KS w Q", true)
RumbleMenu.KillSteal:Boolean("E", "KS w E", true)
RumbleMenu.KillSteal:Boolean("R", "KS w R", true)

RumbleMenu:SubMenu("AutoIgnite", "AutoIgnite")
RumbleMenu.AutoIgnite:Boolean("Ignite", "Ignite if killable", false)

RumbleMenu:SubMenu("Drawings", "Drawings")
RumbleMenu.Drawings:Boolean("DQ", "Draw Q Range", true)
RumbleMenu.Drawings:Boolean("DE", "Draw E Range", true)
RumbleMenu.Drawings:Boolean("DR", "Draw R Range", true)

RumbleMenu:SubMenu("SkinChanger", "SkinChanger")
RumbleMenu.SkinChanger:Boolean("Skin", "UseSkinChanger", true)
RumbleMenu.SkinChanger:Slider("SelectedSkin", "Select A Skin:", 1, 0, 4, 1, function(SetDCP) HeroSkinChanger(myHero, SetDCP)  end, true)

OnTick(function (myHero)
	local target = GetCurrentTarget()

	--AUTO LEVEL UP
	if RumbleMenu.AutoMode.Level:Value() then

			spellorder = {_Q, _E, _W, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _E, _E, _W, _W, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
			end
	end
        
        --Harass
                if IOW:Mode() == "Harass" then
            if RumbleMenu.Harass.Q:Value() and Ready(_Q) and ValidTarget(target, 600) then
				CastSkillShot(_Q, target)
                        end
            if RumbleMenu.Harass.E:Value() and Ready(_E) and ValidTarget(target, 850) then
				CastSkillShot(_E, target)
                        end
               end
	--COMBO
		if IOW:Mode() == "Combo" then
            if RumbleMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 600) then
				CastSkillShot(_Q, target)
                        end
            	    
	    if RumbleMenu.Combo.W:Value() and Ready(_W) then
				CastSpell(_W)
	                end

	    if RumbleMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, 850) then
                local EPred = GetPrediction(target,RumbleE)
                       if EPred.hitChance > (RumbleMenu.Combo.Epred:Value() * 0.1) and not EPred:mCollision(1) then
                                 CastSkillShot(_E,EPred.castPos)
                       end
                 end

            if RumbleMenu.Combo.R:Value() and Ready(_R) and EnemiesAround(myHeroPos(), 1700) >= 1 and (EnemiesAround(myHeroPos(), 1700) >= RumbleMenu.Combo.RX:Value()) then
                local RPred = GetPrediction(target,RumbleR)
                       if RPred.hitChance > (RumbleMenu.Combo.Rpred:Value() * 0.1) and not RPred:mCollision(1) then
                                 CastSkillShot(_R,RPred.castPos)
                       end
                end
            end

         --AUTO IGNITE
	for _, enemy in pairs(GetEnemyHeroes()) do
		
		if GetCastName(myHero, SUMMONER_1) == 'SummonerDot' then
			 Ignite = SUMMONER_1
			if ValidTarget(enemy, 600) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end

		elseif GetCastName(myHero, SUMMONER_2) == 'SummonerDot' then
			 Ignite = SUMMONER_2
			if ValidTarget(enemy, 600) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end
		end

	end

        for _, enemy in pairs(GetEnemyHeroes()) do
                
                if IsReady(_Q) and ValidTarget(enemy, 600) and RumbleMenu.KillSteal.Q:Value() and GetHP(enemy) < getdmg("Q",enemy) then
		         CastSkillShot(_Q, enemy)
		
                end 

                if IsReady(_E) and ValidTarget(enemy, 850) and RumbleMenu.KillSteal.E:Value() and GetHP(enemy) < getdmg("E",enemy) then
		         CastSkillShot(_E, enemy)
  
                end
    
                if IsReady(_R) and ValidTarget(enemy, 1700) and RumbleMenu.KillSteal.R:Value() and GetHP(enemy) < getdmg("R",enemy) then
		         CastSkillShot(_R, target.pos)
                end
      end

      if IOW:Mode() == "LaneClear" then
      	  for _,closeminion in pairs(minionManager.objects) do
	        if RumbleMenu.LaneClear.Q:Value() and Ready(_Q) and ValidTarget(closeminion, 600) then
	        	CastSkillShot(_Q, closeminion)
	        end
                if RumbleMenu.LaneClear.E:Value() and Ready(_E) and ValidTarget(closeminion, 850) then
	        	CastSkillShot(_E, closeminion)
	        end
      	  end
      end
        --AutoMode
        if RumbleMenu.AutoMode.Q:Value() then        
          if Ready(_Q) and ValidTarget(target, 600) then
						CastSkillShot(_Q, target)
          end
        end 
        if RumbleMenu.AutoMode.W:Value() then        
          if Ready(_W) then
	  	      CastSpell(_W)
          end
        end
        if RumbleMenu.AutoMode.E:Value() then        
	        if Ready(_E) and ValidTarget(target, 850) then
						CastSkillShot(_E, target)
	        end
        end
                
	--AUTO GHOST
	if RumbleMenu.AutoMode.Ghost:Value() then
		if GetCastName(myHero, SUMMONER_1) == "SummonerHaste" and Ready(SUMMONER_1) then
			CastSpell(SUMMONER_1)
		elseif GetCastName(myHero, SUMMONER_2) == "SummonerHaste" and Ready(SUMMONER_2) then
			CastSpell(Summoner_2)
		end
	end
end)

OnDraw(function (myHero)
        
         if RumbleMenu.Drawings.DQ:Value() then
		DrawCircle(GetOrigin(myHero), 600, 0, 200, GoS.Red)
	end

	if RumbleMenu.Drawings.DE:Value() then
		DrawCircle(GetOrigin(myHero), 850, 0, 200, GoS.Blue)
	end

	if RumbleMenu.Drawings.DR:Value() then
		DrawCircle(GetOrigin(myHero), 1750, 0, 200, GoS.Green)
	end

end)

local function SkinChanger()
	if RumbleMenu.SkinChanger.UseSkinChanger:Value() then
		if SetDCP >= 0  and SetDCP ~= GlobalSkin then
			HeroSkinChanger(myHero, SetDCP)
			GlobalSkin = SetDCP
		end
        end
end


print('<font color = "#01DF01"><b>Rumble</b> <font color = "#01DF01">by <font color = "#01DF01"><b>Allwillburn</b> <font color = "#01DF01">Loaded!')

