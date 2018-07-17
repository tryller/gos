
--============================================================--
--|| | \ | |                  / ____|         (_)           ||--
--|| |  \| | _____   ____ _  | (___   ___ _ __ _  ___  ___  ||--
--|| | . ` |/ _ \ \ / / _` |  \___ \ / _ \ '__| |/ _ \/ __| ||--
--|| | |\  | (_) \ V / (_| |  ____) |  __/ |  | |  __/\__ \ ||--
--|| |_| \_|\___/ \_/ \__,_| |_____/ \___|_|  |_|\___||___/ ||--
--============================================================--
-- [[Champion: Singed, Author: Nova, Created: 4/4/16]]
--
-- Fatures:
--     - Invisible poison exploit
--     - Auto ignite
--
-- To come:
--     - Auto void toss
--     - Auto sludge
--     - Fling KS

if GetObjectName(myHero) ~= "Singed" then return end

local WRange, ERange =  myHero:GetSpellData(_W).range, myHero:GetSpellData(_E).range
local xIgnite, IRDY = 0, 0
local summonerNameOne = GetCastName(myHero,SUMMONER_1)
local summonerNameTwo = GetCastName(myHero,SUMMONER_2)
local Ignite = (summonerNameOne:lower():find("summonerdot") and SUMMONER_1 or (summonerNameTwo:lower():find("summonerdot") and SUMMONER_2 or nil))
local n = {}

local Singed = Menu("Singed", "Singed")
Singed:Key("Q", "Q Exploit", string.byte(""))
Singed:Menu("KS","Kill Functions")
Singed.KS:Boolean("Ignite","Auto-Ignite",true)


Singed:Boolean("AutoLevel", "Enable Auto Lvl Up", false)

local function CheckItemCD()
    IRDY = Ignite and CanUseSpell(myHero, Ignite) == 0 and 1 or 0
end

local function DamageFunc()
    xIgnite = (50 + GetLevel(myHero) * 20) * IRDY
end

local function SpellSequence()
	if #n > 0 then
		for  i = 1, #n do
    	  	local armor = GetArmor(n[i])
    	  	local hp = GetCurrentHP(n[i])
    	  	local hpreg = GetHPRegen(n[i])
    		local shield = GetDmgShield(n[i])
		 	local health = hp * ((100 + ((armor - GetArmorPenFlat(myHero)) * GetArmorPenPercent(myHero))) * .01) + hpreg * 6 + shield
    		if IRDY == 1 and health < xIgnite and GetDistance(n[i]) <= 600 then
                if Singed.KS.Ignite:Value() then
    			    CastTargetSpell(n[i], Ignite)
                end
    		end
		end
	end
end

local function LevelUp()
    if Singed.AutoLevel:Value() then 
        leveltable = {_Q, _E, _Q, _E, _Q , _R, _Q , _W, _Q , _E, _R, _E, _E, _W, _W, _R, _W, _W} -- Full Q then full E
    end
    LevelSpell(leveltable[GetLevel(myHero)])
end

OnTick(function(myHero)
	n = GetEnemyHeroes()

	if not IsDead(myHero) then
		CheckItemCD()
		DamageFunc()
        SpellSequence()
    end

    local mousePos = GetMousePos()

    if Singed.Q:Value() then
        CastSpell(_Q)
        MoveToXYZ(mousePos.x, mousePos.y, mousePos.z)
    end
    
    if Singed.AutoLevel:Value() then
        LevelUp()
    end
    
end)

PrintChat("<font color=\'#fc1212\'><b>[Nova]: <font color=\'#ffffff\'>Singed Loaded!</b></font>")
