local ver = "0.03"

if GetObjectName(GetMyHero()) ~= "Hecarim" then return end

require("DamageLib")

GetLevelPoints = function(unit) return GetLevel(unit) - (GetCastLevel(unit,0)+GetCastLevel(unit,1)+GetCastLevel(unit,2)+GetCastLevel(unit,3)) end

local HecarimMenu = Menu("Hecarim", "Hecarim")

HecarimMenu:SubMenu("Combo", "Combo")

HecarimMenu.Combo:Boolean("Q", "Use Q in combo", true)
HecarimMenu.Combo:Boolean("W", "Use W in combo", true)
HecarimMenu.Combo:Boolean("E", "Use E in combo", true)
HecarimMenu.Combo:Boolean("R", "Use R in combo", true)
HecarimMenu.Combo:Slider("RX", "X Enemies to Cast R",3,1,5,1)
HecarimMenu.Combo:Boolean("Tiamat", "Use Tiamat", true)
HecarimMenu.Combo:Boolean("RHydra", "Use RHydra", true)
HecarimMenu.Combo:Boolean("YGB", "Use GhostBlade", true)
HecarimMenu.Combo:Boolean("Gunblade", "Use Gunblade", true)

HecarimMenu:SubMenu("AutoMode", "AutoMode")
HecarimMenu.AutoMode:Boolean("Level", "Auto level spells", true)
HecarimMenu.AutoMode:Boolean("Ghost", "Auto Ghost", false)
HecarimMenu.AutoMode:Boolean("Q", "Auto Q", false)
HecarimMenu.AutoMode:Boolean("W", "Auto W", false)
HecarimMenu.AutoMode:Boolean("E", "Auto E", false)
HecarimMenu.AutoMode:Boolean("R", "Auto R", false)
HecarimMenu.AutoMode:Slider("RX", "X Enemies to Cast R",3,1,5,1)

HecarimMenu:SubMenu("LaneClear", "LaneClear")
HecarimMenu.LaneClear:Boolean("Q", "Use Q", true)
HecarimMenu.LaneClear:Boolean("W", "Use W", true)
HecarimMenu.LaneClear:Boolean("E", "Use E", false)
HecarimMenu.LaneClear:Boolean("RHydra", "Use RHydra", true)
HecarimMenu.LaneClear:Boolean("Tiamat", "Use Tiamat", true)

HecarimMenu:SubMenu("Harass", "Harass")
HecarimMenu.Harass:Boolean("Q", "Use Q", true)
HecarimMenu.Harass:Boolean("W", "Use W", true)

HecarimMenu:SubMenu("KillSteal", "KillSteal")
HecarimMenu.KillSteal:Boolean("Q", "KS w Q", true)
HecarimMenu.KillSteal:Boolean("E", "KS w E", true)

HecarimMenu:SubMenu("AutoIgnite", "AutoIgnite")
HecarimMenu.AutoIgnite:Boolean("Ignite", "Ignite if killable", true)

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

OnTick(function (myHero)
	local target = GetCurrentTarget()
	local YGB = GetItemSlot(myHero, 3142)
	local RHydra = GetItemSlot(myHero, 3074)
	local Tiamat = GetItemSlot(myHero, 3077)
	local Gunblade = GetItemSlot(myHero, 3146)

	--AUTO LEVEL UP
	if HecarimMenu.AutoMode.Level:Value() then
			spellorder = {_Q, _W, _E, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
			end
	end
        
        --Harass
	if Mode() == "Harass" then
            if HecarimMenu.Harass.Q:Value() and Ready(_Q) and ValidTarget(target, 350) then
				if target ~= nil then 
                                      CastSpell(_Q)
                                end
            end
            if HecarimMenu.Harass.W:Value() and Ready(_W) and ValidTarget(target, 525) then
				CastSpell(_W)
                       end     
            end

	--COMBO
		if Mode() == "Combo" then
            if HecarimMenu.Combo.YGB:Value() and YGB > 0 and Ready(YGB) and ValidTarget(target, 700) then
			CastSpell(YGB)
            end

            if HecarimMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 350) then
				if target ~= nil then 
                                      CastSpell(_Q)
                                end
            end
            if HecarimMenu.Combo.Tiamat:Value() and Tiamat > 0 and Ready(Tiamat) and ValidTarget(target, 350) then
			CastSpell(Tiamat)
            end
            if HecarimMenu.Combo.Gunblade:Value() and Gunblade > 0 and Ready(Gunblade) and ValidTarget(target, 700) then
			CastTargetSpell(target, Gunblade)
            end
            if HecarimMenu.Combo.RHydra:Value() and RHydra > 0 and Ready(RHydra) and ValidTarget(target, 400) then
			CastSpell(RHydra)
            end

	    if HecarimMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, 525) then
				CastSpell(_W)
	                end
	    if HecarimMenu.Combo.E:Value() and Ready(_E) then
				CastSpell(_E)
			end
	    
            if HecarimMenu.Combo.R:Value() and Ready(_R) and EnemiesAround(myHeroPos(), 1000) >= 1 and (EnemiesAround(myHeroPos(), 1000) >= HecarimMenu.Combo.RX:Value()) then
				CastTargetSpell(target, _R)
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
                
                if IsReady(_Q) and ValidTarget(enemy, 350) and HecarimMenu.KillSteal.Q:Value() and GetHP(enemy) < getdmg("Q",enemy) then
		         if target ~= nil then 
                                      CastSpell(_Q)
		         end
                end 

                if IsReady(_E) and ValidTarget(enemy, 187) and HecarimMenu.KillSteal.E:Value() and GetHP(enemy) < getdmg("E",enemy) then
		                      CastSpell(_E)
  
                end
      end

      if Mode() == "LaneClear" then
      	  for _,closeminion in pairs(minionManager.objects) do
	        if HecarimMenu.LaneClear.Q:Value() and Ready(_Q) and ValidTarget(closeminion, 350) then
	        	CastSpell(_Q)
                end
                if HecarimMenu.LaneClear.W:Value() and Ready(_W) and ValidTarget(closeminion, 525) then
	        	CastSpell(_W)
                end
                if HecarimMenu.LaneClear.E:Value() and Ready(_E) and ValidTarget(closeminion, 325) then
	        	CastSpell(_E)
	        end                
                if HecarimMenu.LaneClear.Tiamat:Value() and ValidTarget(closeminion, 350) then
			CastSpell(Tiamat)
		end
	
		if HecarimMenu.LaneClear.RHydra:Value() and ValidTarget(closeminion, 400) then
                        CastSpell(RHydra)
      	        end
          end
      end
        --AutoMode
        if HecarimMenu.AutoMode.Q:Value() then        
          if Ready(_Q) and ValidTarget(target, 350) then
		      CastTargetSpell(target, _Q)
          end
        end 
        if HecarimMenu.AutoMode.W:Value() then        
          if Ready(_W) and ValidTarget(target, 525) then
	  	      CastSpell(_W)
          end
        end
        if HecarimMenu.AutoMode.E:Value() then        
	  if Ready(_E) and ValidTarget then
		      CastSpell(_E)
	  end
        end
        if HecarimMenu.AutoMode.R:Value() then        
	  if Ready(_R) and EnemiesAround(myHeroPos(), 1000) >= 1 and (EnemiesAround(myHeroPos(), 1000) >= HecarimMenu.AutoMode.RX:Value()) then 
		      CastTargetSpell(target, _R)
	  end
        end
                
	--AUTO GHOST
	if HecarimMenu.AutoMode.Ghost:Value() then
		if GetCastName(myHero, SUMMONER_1) == "SummonerHaste" and Ready(SUMMONER_1) then
			CastSpell(SUMMONER_1)
		elseif GetCastName(myHero, SUMMONER_2) == "SummonerHaste" and Ready(SUMMONER_2) then
			CastSpell(Summoner_2)
		end
	end
end)
