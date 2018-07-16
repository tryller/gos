

Version = "1.05"  
LVersion = " 6.2"
Scriptname = "Krystra Mid Series"
Author = "Krystra"
list = "Leblanc , Lissandra , Viktor, Akali, Diana"
 link = "http://gamingonsteroids.com/topic/10502-beta-stage-krystra-mid-series-leblanc-viktor-lissandra-diana-akali-multi-prediction-orbwalk-support-expert-drawings-and-much-more/"
 date = "09.02.2016"

AutoUpdate("/Lonsemaria/Gos/master/Common/KLib.lua","/Lonsemaria/Gos/master/Version/Klib.version",COMMON_PATH.."KLib.lua",0.02)

---//==================================================\\---
--|| > English Translation details               ||--
---\\==================================================//---
loc_eng = {
--General Menu(Combo) // 8 // 1
"Combo Settings", "Use Q in Combo", "Use W in Combo", "Use E in Combo", "Use R in Combo" ,
"Use Ignite if target killable","Combo logic","Mana Manager %",
--General Menu(Harass) // 5 // 9
"Harass Settings","Harass With Q","Harass With W","Harass With E","Harass With R",
--General Menu(Clear) // 16 // 14
"Farm Settings","LaneClear Settings","Use Q on Laneclear","Use W on Laneclear","Use E on Laneclear","Use R on Laneclear",
"JungleClear Settings","Use Q on jungleclear","Use W on jungleclear","Use E on jungleclear","Use R on jungleclear",
"Lasthit Settings","Use Q on Lasthit","Use W on Lasthit","Use E on Lasthit","Use R on Lasthit",
--General Menu(Escape) // 5 // 30
"Escape Settings","Use Q While Escape","Use W While Escape","Use E While Escape","Use R While Escape",
--General Menu(Killsteal) // 7 // 35
"KillSteal Settings","Killsteal On/Off","Steal With Q","Steal With W","Steal With E","Steal With R","Steal With Ignite",
--General Menu(İtem Settings) // 5 // 42
"Item Settings","Auto Zhonya", "Zhonya if Health under -> %", "Use Hextech Gunblade", "Use Bilgewater Cutlass",
--General Menu(Vıp Settings) // 19 // 47
"VIP Settings","Use Packet Casting","To use vip settings, Packet Casting should be open.", "Auto Level Settings","Use Auto Level",
"Select Skill Order","Skin Hack Settings","Use Skin Hack","Make sure that using packet casting is ON.",
"To use vip settings, You need to be a VIP user on   community.","Select Skin",
"Focus Q>W>E", "Focus Q>E>W","Focus W>Q>E","Focus W>E>Q","Focus E>W>Q", "Focus E>Q>W", "Smart" ,
--General Menu(Draw Settings) // 12 // 65
"Draw Settings","Skill Drawing Settings","Q Skill Drawings","W Skill Drawings","E Skill Drawings","R Skill Drawings","Auto Attack Range",
"Draw Combo Mode","Draw Permabox","Draw Permabox ( Needs 2x F9 )","Draw circle for target selected","Target calculation",
--General Menu(Target Selectors) // 2 // 77
"Targetselectors","Left Click For Target Selection",
--General Menu(Key Settings) // 13 // 79
"Keys Settings", "    [Combo Key Settings]","Combo Key","    [Harass Key Settings]", 
"Smart Harass Key","      [Clear Key Settings]","LaneClear Key","JungleClear Key", 
"      [Other Key Settings]","Escape Key", " Keys are Same As Here","OrwWalkerKey Settings",
"Auto Harass Q",
--General Menu(Misc Settings) // 7 // 92
"Misc Settings", "[" .. myHero.charName.. "] - Auto-Interrupt","Interrupt with Q Skill","Interrupt with W Skill","Interrupt with E Skill",
"Interrupt with R Skill","       [Supported Skills]",
-- General Menu(Skill Logic) // 6 // 99
"Skill Logics","Q Skill Logic","W Skill Logic","E Skill Logic","R Skill Logic","Health Manager %",
-- General Menu(Hitchance Settings) // 5 // 105
"Hitchance","Q Hitchance","W Hitchance","E Hitchance","R Hitchance",
-- General Menu(Orbwalk Settings) // 5  // 110
"OrbWalkerKey Settings",
"                 Script Version:  "..Version.. "         ","            Script was made by  "..Author.. "         ",
"       Leauge Of Legends Version:  "..LVersion.. "         ","Current Orbwalker:                      Sidas Auto Carry",
"Current Orbwalker:                             SxOrbWalk", 
-- Leblanc Menu // 13 // 116
"Q>E>W>R", "Q>R>E>W", "E>Q>W>R", "E>W>Q>R" ,"Random Skill Order","W Skill turn back settings"," Q>E>W>R mode ",
" Q>R>E>W mode "," E>Q>W>R mode "," E>W>Q>R mode ",
" Random Skill Order mode ","Steal With QW","Only use E Skill (Only Stun)"," Select Combomode Key",
-- Akali Menu // 9
"2 enemy", "3 enemy" , "4 enemy","5 enemy","Use R if Q is on target", "Rush Skills","Use Stealth if enemy >","Use Stealth if healt %","Use Stealth (W)",
-- Diana Menu // 4
"Smart Combo", "Use R if target marked" , "Spam everything fast","Use E only if enemy distance > 280",
-- Lissandraa Menu // 17
"E Logic for combo mode","E Logic for harass mode","Engage with second E", "Do not use Second E ( Recomended)" ,
"Do not use Second E ( Recomended)", "Engage with second E" ,"Smart", "save for yourself", "Use for enemy" ,"Auto R for yourself",
"AutoR if Health under -> %", "Engage with second E option is still on Beta..", "R Logic for combo mode", "For using Smart R logic, AutoR should be open..",
"Use W for Anti GapClose","This Function is on beta..",
-- Viktor Menu // 5
"Ulti Logic","Use Ulti If Target Is Killable","Use Ulti Directly" ,"E HitChance (Default value = 1.6)","E HitChance (Default value = 2)","Smart Auto Harass",
-- language menu// 5
"Language(Needs 2xF9)","English", "Turkish","German","Korean",
-- Extrass// 
"Start Engage With Your Ulti ",
-- rework// 171
"Auto W back if health >","Always","Depends on local Settings","Never","Enemy Number","Auto W back if enemy >","   [Local Back Settings]","W>R>Q>E mode ",
" W>Q>R>E mode ","Minimum minion to Q >","Minimum minion to W >","Minimum minion to E >","Minimum minion to R >","           [Mana Manager]",
"Q Skill Mana Manager  %","W Skill Mana Manager  %","E Skill Mana Manager  %","R Skill Mana Manager  %","Use Auto Lasthit","Only if cannot AA","Lasthit Logic","Auto Potion","Use Auto Potion",
"Auto Potion if Health under -> %","Anti-AFK Settings","Use Anti Afk","E -Target draw","Color Settings","Q Color","W Color","E Color","R Color","E -Target Color","Auto Attack Color",
"Selected Target Color","Draw Width Settings","E -Target Width","Selected Target Width","Auto Attack Width","Q Skill Width","W Skill Width","E Skill Width","R Skill Width","Draw Damage Indicator",
"Lasthit Key","Click For Instructions","Use if needed","Clear Key Settings","[" .. myHero.charName.. "] - Anti Gap-Close","Gap-Close With W Skill","Humanizer for Anti Gap Close",
"Auto W Settings","Use Auto W ","Auto W if enemy >","R -Target draw","R -Target Color","R -Target Width"
}

---//==================================================\\---
--|| > Turkish Translation details               ||--
---\\==================================================//---
loc_tr = {
--General Menu(Combo) // 8
"Kombo Ayarlari", "Komboda Q kullan", "Komboda W kullan", "Komboda E kullan", "Komboda R kullan" ,
"Hedef olucekse tutustur kullan","Kombonu sec ","Mana Menajeri %",
--General Menu(Harass) // 5
"Durtme Ayarlari","Rakibi Q ile durt","Rakibi W ile durt","Rakibi E ile durt","Rakibi R ile durt",
--General Menu(Clear) // 16
"Farm Ayarlari","Koridor Temizleme Ayarlari","Q skilini Kullan","W skilini Kullan","E skilini Kullan","R skilini Kullan",
"Orman Temizleme Ayarlari","Q skilini Kullan","W skilini Kullan","E skilini Kullan","R skilini Kullan",
"Son Vurus Ayarlari","Q skilini Kullan","W skilini Kullan","E skilini Kullan","R skilini Kullan",
--General Menu(Escape) // 5
"Kacis Ayarlari","Kacarken Q kullan","Kacarken W kullan","Kacarken E kullan","Kacarken R kullan",
--General Menu(Killsteal) // 7
"Kill Calma Ayarlari","Kill Calma Kapali / Acik","Q skilini Kullan","W skilini Kullan","E skilini Kullan","R skilini Kullan","Tutustur Kullan",
--General Menu(İtem Settings) // 5
"Item Ayarlari","Otomatik Zhonya", "Zhonya Eger can -> %", "Hextech Gunblade kullan", "Bilgewater Cutlass kullan",
--General Menu(Vıp Settings) // 19
"VIP Ayarlari","Packet Casting Kullan","Vip ayarlarini kullanmak icin packet casting acik olmalidir.", "Otomatik Seviye Ayarlari","Otomatik Seviye",
"Yetenek Duzeninin Secin","Kostum Hack Ayarlari","Kostum Hack Kullan","Packet Casting acik oldugundan emin olunuz",
"Vip ayarlarini kullanmak icin   Vip uyesi olmaniz gerekmektedir.","Kostum sec",
"Q>W>E ", "Q>E>W","W>Q>E","W>E>Q","E>W>Q", "E>Q>W", "Akilli" ,
--General Menu(Draw Settings) // 11
"Cizim Ayarlari","Yetenek Cizim Ayarlari","Q Yetenek menzilini ciz","W Yetenek menzilini ciz","E Yetenek menzilini ciz","R Yetenek menzilini ciz","Otomatik Saldiri Menzili",
"Kombo Modunu Ciz","Permabox Ciz","Permabox Ciz ( 2x F9 Gerekir )","Secili hedefi daire icine al","Hedef hasar hesapla",
--General Menu(Target Selectors) // 2
"Hedef Secici","Sol tik ile hedef sec",
--General Menu(Key Settings) // 13
"Tus Ayarlari", "<------------------Kombo Tus Ayarlari------------------>","Kombo Tusu","<------------------Durtme Tus Ayari------------------>", 
"Durtme Tusu","<------------------Temizleme Tus Ayarlari-------------------->","Koridor Temizleme Tusu","Orman Temizleme Tusu", 
"<------------------Diger Tus Ayarlari-------------------->","Kacis Tusu", "Orbwalker Tuslariniz Burayla Ayni Olmalidir.","OrwWalkerKey Ayarlari",
"Otomatik Q Durtme",
--General Menu(Misc Settings) // 7
"Ekstra Ayarlar", "[" .. myHero.charName.. "] - Otomatik Durdurma","Q Yetenegi ile durdur","W Yetenegi ile durdur","E Yetenegi ile durdur",
"R Yetenegi ile durdur","                  [Desteklenen Yetenekler]",
-- General Menu(Skill Logic) // 6
"Yetenek Ayarlari","Q Yetenegi Ayarlari","W Yetenegi Ayarlari","E Yetenegi Ayarlari","R Yetenegi Ayarlari","Health Menajeri %",
-- General Menu(Hitchance Settings) // 5
"Tutturma Orani","Q Tutturma Orani","W Tutturma Orani","E Tutturma Orani","R Tutturma Orani",
-- General Menu(Orbwalk Settings) // 5
"OrbWalker Tus Ayarlari",
"                 Script Versiyonu:  "..Version.. "         ","            Script "..Author.. " tarafindan yapilmistir.        ",
"       Leauge Of Legends Versiyonu:  "..LVersion.. "         ","Kullanilan Orbwalker:                      Sidas Auto Carry",
"Kullanilan Orbwalker:                             SxOrbWalk", 
-- Leblanc Menu // 13
"Q>E>W>R", "Q>R>E>W", "E>Q>W>R", "E>W>Q>R" ,"Rastgele Yetenek Duzeni","W yetenegi geri donme ayarlari"," Q>E>W>R modunda W yerine geri don ",
"Q>R>E>W modunda W yerine geri don ","E>Q>W>R modunda W yerine geri don","E>W>Q>R modunda W yerine geri don ",
"Rastgele Yetenek modunda W yerine geri dön ","QW ile cal","Sadece E Kullan (Sadece Sersemlet)"," Kombo Modu Tusu",
-- Akali Menu // 9
"2 dusman", "3 dusman" , "4 dusman","5 dusman","Q Hedefteyse R Kullan", "Yetenekleri Direk Kullan","Görunmezlik(W) kullan hedef >","Görunmezlik(W) kullan Can %",
"Görunmezlik(W) kullan",
-- Diana Menu // 4
"Akilli Kombo", "Hedef isaretli ise R kullan" , "Butun yetenekleri hizlica kullan","E yetenegini mesafe > 280 kullan",
-- Lissandraa Menu // 17
"Kombo modu icin E ayarlari","Durtme modu icin E ayarlari","2. E ile basla", "2. E'yi kullanma ( önerilen)" ,
"2. E'yi kullanma (onerilen)", "2. E ile basla" ,"Akilli", "Kendini koru", "Dusman icin kullan" ,"Kendine otomatik R",
"Otomatik R can altindaysa -> %", "2. E ile basla ayari test asamasindadir..", "Kombo modu icin R ayarlari", "Akilli R ayarlari için kendine otomatik R acik olmalidir.",
"W kullanarak dusmani uzak tut","Bu ozellik hala test asamasindadir..",
-- Viktor Menu // 5
"Ulti Ayarlari","Hedef olucek ise Ulti Kullan","Ultiyi Direk Kullan" ,"E Tutturma Orani (Normali = 1.6)","E Tutturma Orani (Normali = 2)","Otomatik durtme",
-- language menu// 5
"Dil Secimi(2xF9 Gerekmektedir.)","Ingilizce", "Turkce","Almanca","Korece",
-- Extrass// 
"Komboyu ulti ile baslat ",
-- rework// 171
"Otomatik w eger can >","Her zaman","Local Ayarlara Bagli","Asla","Dusman Sayisi","Otomatik W Eger Dusman >","                        [Local Ayarlar]","W>R>Q>E modunda W yerine geri don",
"W>Q>R>E modunda W yerine geri don ","Q icin minimum minion  >","W icin minimum minion  >","E icin minimum minion  >","R icin minimum minion >","                        [Mana Menajeri]",
"Q Yetenegi Mana Menajeri  %","W Yetenegi Mana Menajeri  %","E Yetenegi Mana Menajeri  %","R Yetenegi Mana Menajeri  %","Otomatik Son Vurus","Eger otomatik Saldiri Yapamiyorsa","Son Vurus Ayarlari","Otomatik Pot","Otomatik Pot Kullan",
"Auto Potion if Health under -> %","Anti-AFK Ayarlari","Anti Afk Kullan","E -Hedef Cizimi","Renk Ayarlari","Q Rengi","W Rengi","E Rengi","R Rengi","E -Hedef Rengi","Otomatik Saldiri Rengi",
"Secili Karakter Rengi","Kalinlik Ayarlari","E -Hedef Kalinlik","Secili Karakter Kalinlik","Otomatik Saldiri Kalinlik","Q Yetenegi kalinlik","W Yetenegi kalinlik","E Yetenegi kalinlik",
"R Yetenegi kalinlik","Hasar cizimi goster",
"Son vurus tusu","Talimatlar icin tiklayiniz","Gerekli ise kullan","Farm Tus Ayarlari","[" .. myHero.charName.. "] - Anti Gap-Close","W Yetenegi ile Anti Gap-Close","Anti Gap-Close icin insanlastirma",
"Otomatik W Ayarlari","Otomatik W Kullan ","Otomatik W Eger Dusman >","R -Hedef Cizim","R -Hedef Rengi","R -Hedef Kalinlik"
}
---//==================================================\\---
--|| > German Translation details               ||--
---\\==================================================//---
loc_gr = {
--General Menu(Combo) // 8 // 1
"Combo Einstellungen", "Benutze Q im Combo Modus", "Benutze W im Combo Modus", "Benutze E im Combo Modus", "Benutze R im Combo Modus" ,
"Benutze Ignite wenn das Ziel dadurch stirbt","Combo Logik","Mana Manager %",
--General Menu(Harass) // 5 // 9
"Harass Einstellungen","Harass mit Q","Harass mit W","Harass mit E","Harass mit R",
--General Menu(Clear) // 16 // 14
"Farm Einstellungen","LaneClear Einstellungen","Benutze Q im Laneclear Modus","Benutze W im Laneclear Modus","Benutze E im Laneclear Modus","Benutze im Laneclear Modus",
"JungleClear Einstellungen","Benutze Q im jungleclear Modus","Benutze W im jungleclear Modus","Benutze E im jungleclear Modus","Benutze R im jungleclear Modus",
"Lasthit Einstellungen","Benutze Q im Lasthit Modus","Benutze W im Lasthit Modus","Benutze E im Lasthit Modus","Benutze R im Lasthit Modus",
--General Menu(Escape) // 5 // 30
"Escape Einstellungen","Benutze Q beim Fliehen","Benutze W beim Fliehen","Benutze E beim Fliehen","Benutze R beim Fliehen",
--General Menu(Killsteal) // 7 // 35
"KillSteal Einstellungen","Killsteal Ein/Aus","Stiehl mit Q","Stiehl mit W","Stiehl mit E","Stiehl mit R","Stiehl mit Ignite",
--General Menu(item) // 5 // 42
"Item Einstellungen","Auto Zhonya", "Benutzte Zhonya wenn Leben unter -> %", "Benutze Hextech Gunblade", "Benutze Bilgewater Cutlass",
--General Menu(vip Einstellungen) // 19 // 47
"VIP Einstellungen","Benutze Packet Casting","Um VIP Einstellungen, zu benutzten muss Package Casting moglich sein", "Auto Level Einstellungen","Benutze Auto Level",
"Select Skill Order","Skin Hack Einstellungen","Benutze Skin Hack","Stelle sicher, dass Packet Casting activiert ist",
"Um VIP Einstellungen zu benutzten, musst du VIP sein","Wahle einen Skin",
"Focus Q>W>E", "Focus Q>E>W","Focus W>Q>E","Focus W>E>Q","Focus E>W>Q", "Focus E>Q>W", "Smart" ,
--General Menu(Graphik Einstellungen) // 12 // 65
"Graphik Einstellungen","Skill Anzeige Einstellungen","Q Anzeigen","W  Anzeigen","E Anzeigen","R Anzeigen","Standart Attacken Reichweite",
"Zeige Combo Modus","Zeige Permabox","Zeige Permabox ( Benotigt 2x F9 )","Zeichne Zirkel um dein gewahltes Ziel","Ziel berechnung",
--General Menu(Target Selectors) // 2 // 77
"Ziel Sortierung","Linksclick fur manuelles Auswahlen von Zielen",
--General Menu(Key Einstellungen) // 13 // 79
"Key Einstellungen", "<------------------Combo Key Einstellungen------------------>","Combo Key","<------------------Harass Key Einstellungen------------------>", 
"Smart Harass Key","<------------------Clear Key Einstellungen-------------------->","LaneClear Key","JungleClear Key", 
"<------------------Andere Key Einstellungen-------------------->","Escape Key", "Stelle sicher, dass deine Orbwalker Keys die gleichen wie hier sind.","OrwWalkerKey Einstellungen",
"Auto Harass Q",
--General Menu(Misc Einstellungen) // 7 // 92
"Andere Einstellungen", "[" .. myHero.charName.. "] - Auto-Abrechen","Abruch mit Q","Abruch mit W","Abruch mit E",
"Abruch mit R","                  [Supported Skills]",
-- General Menu(Skill Logic) // 6 // 99
"Skill Logik","Q Logik","W Logik","E Logik","R Logik","Health Manager %",
-- General Menu(Hitchance Einstellungen) // 5 // 105
"Trefferchance","Q Trefferchance","W Trefferchance","E Trefferchance","R Trefferchance",
-- General Menu(Orbwalk Einstellungen) // 5  // 110
"OrbWalkerKey Einstellungen",
"                 Script Version:  "..Version.. "         ","            Script wurde gemacht von  "..Author.. "         ",
"       Leauge Of Legends Version:  "..LVersion.. "         ","Aktueller Orbwalker:                      Sidas Auto Carry",
"Aktueller Orbwalker:                             SxOrbWalk", 
-- Leblanc Menu // 13 // 116
"Q>E>W>R", "Q>R>E>W", "E>Q>W>R", "E>W>Q>R" ,"Zufällige Benutzung","W Skill zuruckkomm Einstellungen","Gehe zuruck zum W Spot im Q>E>W>R modus ",
"Gehe zuruck zum W Spot im Q>R>E>W modus ","Gehe zuruck zum W Spot im E>Q>W>R modus ","Gehe zuruck zum W Spot im E>W>Q>R modus",
"Gehe zuruck zum W Spot im Zufälligen Modus ","Stiehl mit QW","Benutze nur E (Nur Stunnen)"," Wähle Combomodus Key",
-- Akali Menu // 9
"2 Gegner", "3 Gegner" , "4 Gegner","5 Gegner","Benutze R wenn Q das Ziel getroffen hat", "Rush Skills","Benutze Verbergen wenn gegner >","Benutze Verbergen wenn Leben %","Benutze Verbergen (W)",
-- Diana Menu // 4
"Smart Combo", "Benutze R wenn Ziel markiert" , "Benutzte alles schnell hintereinander","Benutze E nur wenn die Distanz zum gegner > 280",
-- Lissandraa Menu // 17
"E Logik fur combo modus","E Logic fur harass modus","Engage mit Zweiten E", "Benutze nicht den Zweiten E ( Empfohlen)" ,
"Benutze nicht den Zweiten E ( Empfohlen)", "Engage mit Zweiten E" ,"Smart", "Rette dich selbst", "Benutze gegen Gegner" ,"Auto R fur dichselbst",
"AutoR wenn Leben unter -> %", "Die 'Engage mit Zweiten E' Option ist im Beta Stadium", "R Logik fur den combo modus", "Um Smart R Logik zu benutzten, sollte AutoR aktiviert sein",
"Benutze W fur Anti-GapClose","Diese Function befindet sich in der Beta Phase",
-- Viktor Menu // 5
"Ulti Logik","Benutze Ultimate wenn das Ziel dadurch stribt","Benutze die Ultimate direkt" ,"E Trefferwarscheinlichkeit (Standart Wert = 1.6)","E Trefferwarscheinlichkeit (Standart Wert = 2)","Smart Auto Harass",
-- language menu// 5
"Sprachen(2xF9)","English", "Turkish","Deutsch","Korean",
-- Extrass// 
"Starte Engange's mit deiner Ultimate",
-- rework// 171
"Auto W back if health >","Always","Depends on local Settings","Never","Enemy Number","Auto W back if enemy >","                        [Local Settings]","Turn back to W spot on W>R>Q>E mode ",
"Turn back to W spot on W>Q>R>E mode ","Minimum minion to Q >","Minimum minion to W >","Minimum minion to E >","Minimum minion to R >","                        [Mana Manager]",
"Q Skill Mana Manager  %","W Skill Mana Manager  %","E Skill Mana Manager  %","R Skill Mana Manager  %","Use Auto Lasthit","Only if cannot AA","Lasthit Logic","Auto Potion","Use Auto Potion",
"Auto Potion if Health under -> %","Anti-AFK Settings","Use Anti Afk","E -Target draw","Color Settings","Q Color","W Color","E Color","R Color","E -Target Color","Auto Attack Color",
"Selected Target Color","Draw Width Settings","E -Target Width","Selected Target Width","Auto Attack Width","Q Skill Width","W Skill Width","E Skill Width","R Skill Width","Draw Damage Indicator",
"Lasthit Key","Click For Instructions","Use if needed","Clear Key Settings","[" .. myHero.charName.. "] - Anti Gap-Close","Gap-Close With W Skill","Humanizer for Anti Gap Close",
"Auto W Settings","Use Auto W ","Auto W if enemy >","R -Target draw","R -Target Color","R -Target Width"
}
lbspot = {
{x = 3078.2177734375 , y = 95.748046875, z = 4303.9643554688},
{x = 2153.0966796875 , y = 95.748046875, z = 4493.1884765625},
{x = 4395.9223632813 , y = 95.748168945313, z = 3125.4541015625},
{x = 4524.7241210938 , y = 95.748168945313, z = 2084.6958007813},
{x = 5380.0322265625 , y = 51.261352539063, z = 2490.5747070313},
{x = 6214.2373046875 , y = 50.011840820313, z = 3461.103515625},
{x = 6281.7963867188 , y = 48.528076171875, z = 5089.8540039063},
{x = 7254.994140625 , y = 52.451171875, z = 5991.65625},
{x = 8116.4321289063 , y = 52.890258789063, z = 5751.265625},
{x = 8965.8251953125 , y = 52.623413085938, z = 4474.44921875},
{x = 9034.9921875 , y = 53.795166015625, z = 3890.2607421875},
{x = 9287.0341796875 , y = 58.37451171875, z = 3511.9157714844},
{x = 9867.59765625 , y = 57.9990234375, z = 3118.6665039063},
{x = 8189.5307617188 , y = 51.60595703125, z = 3209.5812988281},
{x = 3359.3425292969 , y = 52.47412109375, z = 6241.1318359375},
{x = 3771.423828125 , y = 51.000732421875, z = 7254.4926757813},
{x = 4495.3837890625 , y = 49.123657226563, z = 8071.3657226563},
{x = 5118.5659179688 , y = 51.157348632813, z = 7832.5595703125},
{x = 5629.3662109375 , y = 51.654296875, z = 7679.3193359375},
{x = 8539.6025390625 , y = 51.1298828125, z = 2087.4418945313},
{x = 10205.384765625 , y = 49.22314453125, z = 2187.3041992188},
{x = 7604.810546875 , y = 51.273681640625, z = 2096.0678710938},
{x = 7557.9194335938 , y = 48.730102539063, z = 4686.337890625},
{x = 2212.1691894531 , y = 50.411865234375, z = 7797.4438476563},
{x = 1652.8302001953 , y = 52.838134765625, z = 8647.6708984375},
{x = 2160.7019042969 , y = 53.1201171875, z = 10001.190429688},
{x = 2514.5668945313 , y = 51.77490234375, z = 9193.083984375},
{x = 3071.609375 , y = 52.812622070313, z = 9864.0703125},
{x = 2831.2150878906 , y = 54.32568359375, z = 10353.356445313},
{x = 8954.75390625 , y = 51.528076171875, z = 4903.7778320313},
{x = 8418.10546875 , y = 53.97119140625, z = 3763.158203125},
-- -------------------------------------mavi taraf bitti
{x = 10224.888671875 , y = 91.430053710938, z = 12704.100585938},
{x = 10429.840820313 , y = 91.429809570313, z = 11703.564453125},
{x = 11582.235351563 , y = 91.429809570313, z = 10554.192382813},
{x = 12668.779296875 , y = 91.430053710938, z = 10328.741210938},
{x = 11852.047851563 , y = 50.3076171875, z = 8894.05859375},
{x = 12117.778320313 , y = 52.48046875, z = 8043.8427734375},
{x = 11148.4140625 , y = 52.204711914063, z = 7751.361328125},
{x = 10362.048828125 , y = 61.070068359375, z = 8575.6318359375},
{x = 10950.1953125 , y = 52.203979492188, z = 7506.3989257813},
{x = 10353.25390625 , y = 51.999267578125, z = 6711.8408203125},
{x = 10437.215820313 , y = 53.444458007813, z = 9096.6904296875},
{x = 12971.645507813 , y = 51.981201171875, z = 6886.2333984375},
{x = 13101.166015625 , y = 53.143432617188, z = 5653.0639648438},
{x = 12408.293945313 , y = 51.729370117188, z = 5222.7763671875},
{x = 12139.694335938 , y = 51.7294921875, z = 4567.697265625},
{x = 11617.538085938 , y = 51.679321289063, z = 5176.0625},
{x = 9070.85546875 , y = 53.036010742188, z = 7165.3149414063},
{x = 7072.7900390625 , y = 52.87255859375, z = 8811.623046875},
{x = 7598.4057617188 , y = 52.872436523438, z = 8878.0712890625},
{x = 8826.94140625 , y = 52.596069335938, z = 9295.0693359375},
{x = 8573.7900390625 , y = 51.770141601563, z = 11260.03515625},
{x = 9409.0888671875 , y = 52.306396484375, z = 12289.697265625},
{x = 6559.1030273438 , y = 53.944580078125, z = 11621.458007813},
{x = 5281.6518554688 , y = 56.848266601563, z = 11749.409179688},
{x = 6328.6049804688 , y = 54.5703125, z = 12774.705078125},
{x = 7206.1005859375 , y = 56.4765625, z = 12770.250976563},
{x = 4976.4399414063 , y = 56.671020507813, z = 11446.337890625},
{x = 5699.2983398438 , y = 56.692016601563, z = 10907.643554688},
{x = 5812.009765625 , y = 54.16015625, z = 10189.111328125},
{x = 7286.1147460938 , y = 51.417358398438, z = 10186.866210938}
}

lbspotend = {
{x = 3360.7543945313 , y = 54.14990234375, z = 4812.75},
{x = 2190.0805664063 , y = 52.7880859375, z = 5119.3852539063},
{x = 4987.3720703125 , y = 50.947265625, z = 3204.5400390625},
{x = 5115.9340820313 , y = 51.991333007813, z = 2112.9604492188},
{x = 6006.2861328125 , y = 52.13916015625, z = 2439.6027832031},
{x = 6717.298828125 , y = 48.523559570313, z = 3892.9299316406},
{x = 6118.3544921875 , y = 51.7763671875, z = 5708.7084960938},
{x = 7109.2329101563 , y = 53.19287109375, z = 5437.3901367188},
{x = 8229.4609375 , y = -71.240600585938, z = 6389.2055664063},
{x = 9430.9189453125 , y = -71.240600585938, z = 4516.9462890625},
{x = 9438.8330078125 , y = -70.579711914063, z = 4275.380859375},
{x = 9656.0322265625 , y = -70.806518554688, z = 4005.1967773438},
{x = 9739.7646484375 , y = 49.222900390625, z = 2702.9108886719},
{x = 8254.1640625 , y = 51.130126953125, z = 2679.1723632813},
{x = 2864.1623535156 , y = 57.044799804688, z = 5993.6665039063},
{x = 3698.5791015625 , y = 52.7587890625, z = 7761.037109375},
{x = 4003.1398925781 , y = 51.234252929688, z = 7891.3862304688},
{x = 5114.298828125 , y = -40.389038085938, z = 8537.78515625},
{x = 5995.3530273438 , y = -68.9873046875, z = 8241.912109375},
{x = 8574.029296875 , y = 49.453735351563, z = 1673.580078125},
{x = 10102.54296875 , y = 50.260009765625, z = 1717.2194824219},
{x = 7392.90625 , y = 49.446655273438, z = 1641.5682373047},
{x = 7658.3383789063 , y = 53.982421875, z = 4227.2319335938},
{x = 2337.2009277344 , y = 51.789916992188, z = 8228.5986328125},
{x = 2047.6506347656 , y = 51.777587890625, z = 8631.96875},
{x = 1683.5931396484 , y = 52.83837890625, z = 10189.442382813},
{x = 2872.6669921875 , y = 50.676025390625, z = 9213.484375},
{x = 3521.923828125 , y = -66.380126953125, z = 10094.618164063},
{x = 3020.0129394531 , y = -70.343872070313, z = 10846.442382813},
{x = 9041.140625 , y = -71.240600585938, z = 5496.4653320313},
{x = 8034.2280273438 , y = 53.720825195313, z = 3940.2602539063},
-- ---------------------------------------mavi taraf bitti
{x = 9689.9365234375 , y = 52.322875976563, z = 12663.056640625},
{x = 9955.4375 , y = 52.30615234375, z = 11460.467773438},
{x = 11371.384765625 , y = 52.306274414063, z = 10065.577148438},
{x = 12632.4765625 , y = 52.306274414063, z = 9777.009765625},
{x = 11431.650390625 , y = 59.111206054688, z = 8522.919921875},
{x = 11585.361328125 , y = 52.824584960938, z = 8031.7602539063},
{x = 10906.69921875 , y = 62.66259765625, z = 8239.5224609375},
{x = 10791.670898438 , y = 63.077880859375, z = 8360.7275390625},
{x = 10998.96875 , y = 51.723510742188, z = 7037.748046875},
{x = 10872.008789063 , y = 51.72265625, z = 6888.4609375},
{x = 10173.395507813 , y = 52.117553710938, z = 9537.7919921875},
{x = 12673.555664063 , y = 51.702758789063, z = 6491.19921875},
{x = 12617.803710938 , y = 52.173828125, z = 5782.1801757813},
{x = 11973.099609375 , y = 53.644165039063, z = 5227.3408203125},
{x = 11925.876953125 , y = -68.921142578125, z = 4045.8798828125},
{x = 11377.123046875 , y = -71.240600585938, z = 4801.3989257813},
{x = 8648.61328125 , y = -71.240600585938, z = 6735.1474609375},
{x = 6728.6801757813 , y = -71.240600585938, z = 8495.57421875},
{x = 7703.7436523438 , y = 52.408813476563, z = 9384.001953125},
{x = 8699.5771484375 , y = 50.383911132813, z = 9775.046875},
{x = 8129.8115234375 , y = 50.467163085938, z = 10956.14453125},
{x = 8863.501953125 , y = 56.47705078125, z = 12406.870117188},
{x = 6391.2529296875 , y = 56.47705078125, z = 12191.615234375},
{x = 5376.2807617188 , y = 56.460815429688, z = 12158.2109375},
{x = 6293.357421875 , y = 52.837890625, z = 13276.076171875},
{x = 7261.732421875 , y = 52.838134765625, z = 13321.002929688},
{x = 4941.2719726563 , y = -71.240478515625, z = 10840.948242188},
{x = 5309.9711914063 , y = -71.240600585938, z = 10677.38671875},
{x = 5346.1616210938 , y = -71.240600585938, z = 10363.08984375},
{x = 7158.8759765625 , y = 56.380126953125, z = 10707.299804688}
}

yasuospot = {
{x = 3633.6062011719 , y = 51.888549804688, z = 7397.85546875},-- +
{x = 1684.1527099609 , y = 52.838134765625, z = 8451.1015625}, --+
{x = 3545.6989746094 , y = 50.916137695313, z = 6976.63671875},
{x = 7281.1123046875 , y = 52.48046875, z = 5892.6801757813},
{x = 8154.3564453125 , y = 51.550659179688, z = 3142.1145019531},

{x = 13148.944335938 , y = 54.646240234375, z = 6437.7163085938},
{x = 11132.174804688 , y = 52.203369140625, z = 7848.6010742188},
{x = 10995.295898438 , y = 52.20361328125, z = 7482.541015625},

}

yasuospotend = {
{x = 3589.552734375 , y = 52.169189453125, z = 7707.8466796875},-- +
{x = 1992.1899414063 , y = 51.777709960938, z = 8496.0576171875}, --+
{x = 3648.572265625 , y = 52.458862304688, z = 6701.93359375},
{x = 7104.0532226563 , y = 58.594970703125, z = 5623.9267578125},
{x = 8275.32421875 , y = 51.1298828125, z = 2851.9223632813},

{x = 12853.529296875 , y = 51.646118164063, z = 6436.1352539063},
{x = 11079.994140625 , y = 62.517578125, z = 8093.0014648438},
{x = 11150.340820313 , y = 51.724975585938, z = 7232.6801757813},


}
function pointOnLine(myHero, unit, minion, extra)
    local tominion = {x = minion.x - unit.x, z = minion.z - unit.z}
    local tomyHero = {x = myHero.x - unit.x, z = myHero.z - unit.z}

    local magitudeTomyHero = tomyHero.x ^ 2 + tomyHero.z ^ 2
    local dotP = tominion.x * tomyHero.x + tominion.z * tomyHero.z

    local distance = dotP / magitudeTomyHero

    return unit.x + tomyHero.x * (distance + extra), unit.z + tomyHero.z * (distance + extra)
end
function DrawLineHPBar(damage, text, unit, enemyTeam)
    if unit.dead or not unit.visible then return end
    local p = WorldToScreen(1 , Vector(unit.x, unit.y, unit.z))
    if not OnScreen(p.x, p.y) then return end
    local thedmg = 0
    local line = 1.4
    local linePosA  = {x = 0, y = 0 }
    local linePosB  = {x = 0, y = 0 }
    local TextPos   = {x = 0, y = 0 }
    
    
    if damage >= unit.maxHealth then
        thedmg = unit.maxHealth - 1
    else
        thedmg = damage
    end
    
    thedmg = math.round(thedmg)
    
    local StartPos = GetHPBarPos(unit)
    local  EndPos = GetHPBarPos(unit)
    local Real_X = StartPos.x + 150
    local Offs_X = (Real_X + ((unit.health - thedmg) / unit.maxHealth) * (EndPos.x - StartPos.x - 2))
    if Offs_X < Real_X then Offs_X = Real_X end 
    local mytrans = 350 - math.round(255*((unit.health-thedmg)/unit.maxHealth))
    if mytrans >= 255 then mytrans=254 end
    local my_bluepart = math.round(400*((unit.health-thedmg)/unit.maxHealth))
    if my_bluepart >= 255 then my_bluepart=254 end

    
    if enemyTeam then
        linePosA.x = Offs_X-150
        linePosA.y = (StartPos.y-(30+(line*15)))    
        linePosB.x = Offs_X-150
        linePosB.y = (StartPos.y-5)
        TextPos.x = Offs_X-148
        TextPos.y = (StartPos.y-(30+(line*15)))
    else
        linePosA.x = Offs_X-125
        linePosA.y = (StartPos.y-(30+(line*15)))    
        linePosB.x = Offs_X-125
        linePosB.y = (StartPos.y-15)
    
        TextPos.x = Offs_X-122
        TextPos.y = (StartPos.y-(30+(line*15)))
    end

    DrawLine(linePosA.x, linePosA.y, linePosB.x, linePosB.y , 2, ARGB(mytrans, 255, my_bluepart, 0))
    DrawText(tostring(thedmg).." "..tostring(text), 15, TextPos.x, TextPos.y , ARGB(mytrans, 255, my_bluepart, 0))
end

function mPos3D(cx,cz,x,z,r)
	if (math.pow(cx-x,2)+math.pow(cz-z,2)<math.pow(r,2)) then
		return true
	else
		return false
	end
end
function CurrentTimeInMillis()
  return (os.clock() * 1000);
end
    function CircleIntersection(v1, v2, c, radius)
    assert(VectorType(v1) and VectorType(v2) and VectorType(c) and type(radius) == "number", "CircleIntersection: wrong argument types (<Vector>, <Vector>, <Vector>, integer expected)")
    
    local x1, y1, x2, y2, x3, y3 = v1.x, v1.z or v1.y, v2.x, v2.z or v2.y, c.x, c.z or c.y
    local r = radius
    local xp, yp, xm, ym = nil, nil, nil, nil
    local IsOnSegment = nil
    
    if x1 == x2 then
    
      local B = math.sqrt(r^2-(x1-x3)^2)
      
      xp, yp, xm, ym = x1, y3+B, x1, y3-B
    else
    
      local m = (y2-y1)/(x2-x1)
      local n = y1-m*x1
      local A = x3-m*(n-y3)
      local B = math.sqrt(A^2-(1+m^2)*(x3^2-r^2+(n-y3)^2))
      
      xp, xm = (A+B)/(1+m^2), (A-B)/(1+m^2)
      yp, ym = m*xp+n, m*xm+n
    end
    
    if x1 <= x2 then
      IsOnSegment = x1 <= xp and xp <= x2
    else
      IsOnSegment = x2 <= xp and xp <= x1        
    end
      if IsOnSegment then
      return Vector(xp, 0, yp)
    else
      return Vector(xm, 0, ym)
    end
    
  end
isAGapcloserUnit = {
  ['Ahri']        = {true, spell = _R,          range = 450,   projSpeed = 2200, },
  ['Aatrox']      = {true, spell = _Q,                  range = 1000,  projSpeed = 1200, },
  ['Akali']       = {true, spell = _R,                  range = 800,   projSpeed = 2200, },
  ['Alistar']     = {true, spell = _W,                  range = 650,   projSpeed = 2000, },
  ['Amumu']       = {true, spell = _Q,                  range = 1100,  projSpeed = 1800, },
  ['Corki']       = {true, spell = _W,                  range = 800,   projSpeed = 650,  },
  ['Diana']       = {true, spell = _R,                  range = 825,   projSpeed = 2000, },
  ['Darius']      = {true, spell = _R,                  range = 460,   projSpeed = math.huge, },
  ['Fiora']       = {true, spell = _Q,                  range = 600,   projSpeed = 2000, },
  ['Fizz']        = {true, spell = _Q,                  range = 550,   projSpeed = 2000, },
  ['Gragas']      = {true, spell = _E,                  range = 600,   projSpeed = 2000, },
  ['Graves']      = {true, spell = _E,                  range = 425,   projSpeed = 2000, exeption = true },
  ['Hecarim']     = {true, spell = _R,                  range = 1000,  projSpeed = 1200, },
  ['Irelia']      = {true, spell = _Q,                  range = 650,   projSpeed = 2200, },
  ['JarvanIV']    = {true, spell = _Q,                  range = 770,   projSpeed = 2000, },
  ['Jax']         = {true, spell = _Q,                  range = 700,   projSpeed = 2000, },
  ['Jayce']       = {true, spell = 'JayceToTheSkies',   range = 600,   projSpeed = 2000, },
  ['Khazix']      = {true, spell = _E,                  range = 900,   projSpeed = 2000, },
  ['Leblanc']     = {true, spell = _W,                  range = 600,   projSpeed = 2000, },
  --['LeeSin']      = {true, spell = 'blindmonkqtwo',     range = 1300,  projSpeed = 1800, },
  ['Leona']       = {true, spell = _E,                  range = 900,   projSpeed = 2000, },
  ['Lucian']      = {true, spell = _E,                  range = 425,   projSpeed = 2000, },
  ['Malphite']    = {true, spell = _R,                  range = 1000,  projSpeed = 1500, },
  ['Maokai']      = {true, spell = _W,                  range = 525,   projSpeed = 2000, },
  ['MonkeyKing']  = {true, spell = _E,                  range = 650,   projSpeed = 2200, },
  ['Pantheon']    = {true, spell = _W,                  range = 600,   projSpeed = 2000, },
  ['Poppy']       = {true, spell = _E,                  range = 525,   projSpeed = 2000, },
  ['Riven']       = {true, spell = _E,                  range = 150,   projSpeed = 2000, },
  ['Renekton']    = {true, spell = _E,                  range = 450,   projSpeed = 2000, },
  ['Sejuani']     = {true, spell = _Q,                  range = 650,   projSpeed = 2000, },
  ['Shen']        = {true, spell = _E,                  range = 575,   projSpeed = 2000, },
  ['Shyvana']     = {true, spell = _R,                  range = 1000,  projSpeed = 2000, },
  ['Tristana']    = {true, spell = _W,                  range = 900,   projSpeed = 2000, },
  ['Tryndamere']  = {true, spell = 'Slash',             range = 650,   projSpeed = 1450, },
  ['XinZhao']     = {true, spell = _E,                  range = 650,   projSpeed = 2000, },
  ['Yasuo']       = {true, spell = _E,                  range = 475,   projSpeed = 1000, },
  ['Vayne']       = {true, spell = _Q,                  range = 300,   projSpeed = 1000, },
}
  Interrupt = {
    ["Katarina"] = {charName = "Katarina", stop = {["KatarinaR"] = {name = "Death lotus(R)", spellName = "KatarinaR", ult = true }}},
    ["Nunu"] = {charName = "Nunu", stop = {["AbsoluteZero"] = {name = "Absolute Zero(R)", spellName = "AbsoluteZero", ult = true }}},
    ["Malzahar"] = {charName = "Malzahar", stop = {["AlZaharNetherGrasp"] = {name = "Nether Grasp(R)", spellName = "AlZaharNetherGrasp", ult = true}}},
    ["Caitlyn"] = {charName = "Caitlyn", stop = {["CaitlynAceintheHole"] = {name = "Ace in the hole(R)", spellName = "CaitlynAceintheHole", ult = true, projectileName = "caitlyn_ult_mis.troy"}}},
    ["FiddleSticks"] = {charName = "FiddleSticks", stop = {["Crowstorm"] = {name = "Crowstorm(R)", spellName = "Crowstorm", ult = true}}},
    ["Galio"] = {charName = "Galio", stop = {["GalioIdolOfDurand"] = {name = "Idole of Durand(R)", spellName = "GalioIdolOfDurand", ult = true}}},
    ["Janna"] = {charName = "Janna", stop = {["ReapTheWhirlwind"] = {name = "Monsoon(R)", spellName = "ReapTheWhirlwind", ult = true}}},
    ["MissFortune"] = {charName = "MissFortune", stop = {["MissFortune"] = {name = "Bullet time(R)", spellName = "MissFortuneBulletTime", ult = true}}},
    ["MasterYi"] = {charName = "MasterYi", stop = {["MasterYi"] = {name = "Meditate(W)", spellName = "Meditate", ult = false}}},
    ["Pantheon"] = {charName = "Pantheon", stop = {["PantheonRJump"] = {name = "Skyfall(R)", spellName = "PantheonRJump", ult = true}}},
    ["Shen"] = {charName = "Shen", stop = {["ShenStandUnited"] = {name = "Stand united(R)", spellName = "ShenStandUnited", ult = true}}},
    ["Urgot"] = {charName = "Urgot", stop = {["UrgotSwap2"] = {name = "Position Reverser(R)", spellName = "UrgotSwap2", ult = true}}},
    ["Varus"] = {charName = "Varus", stop = {["VarusQ"] = {name = "Piercing Arrow(Q)", spellName = "Varus", ult = false}}},
    ["Warwick"] = {charName = "Warwick", stop = {["InfiniteDuress"] = {name = "Infinite Duress(R)", spellName = "InfiniteDuress", ult = true}}},
}
Champions = {
    ["Aatrox"] = {charName = "Aatrox", skillshots = {
        ["AatroxE"] = {spellKey = _E, name = "Blade of Torment (E)", spellName = "AatroxE", spellDelay = 250, projectileName = "AatroxBladeofTorment_mis.troy", projectileSpeed = 1200, range = 1075, radius = 100, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["AatroxW"] = {spellKey = _W, spellName = "Aatrox (W)", checkName = true, name = "AatroxW", isAutoBuff = true, range = 125, isSelfCast = true, noAnimation = true},
        ["AatroxQ"] = {name = "AatroxQ", spellName = "Aatrox (Q)", spellDelay = 250, projectileName = "AatroxQ.troy", projectileSpeed = 450, range = 650, radius = 145, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1},
        ["AatroxR"] = { spellKey = _R, isSelfCast = true, isAutoBuff = true, spellName = "AatroxR", name = "AatroxR", range = 125},
    }},
    ["Ahri"] = {charName = "Ahri", skillshots = {
        ["AhriOrbofDeception"] = {spellKey = _Q, name = "Orb of Deception (Q)", spellName = "AhriOrbofDeception", spellDelay = 250, projectileName = "Ahri_Orb_mis.troy", projectileSpeed = 1750, range = 800, radius = 100, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Orb of Deception Back"] = {name = "Orb of Deception Back(QB)", spellName = "AhriOrbofDeception!", spellDelay = 750, projectileName = "Ahri_Orb_mis_02.troy", projectileSpeed = 915, range = 800, radius = 100, type = "LINE"},
        ["AhriSeduce"] = {spellKey = _E, isTrueRange = true, isCollision = true, name = "Charm (E)", spellName = "AhriSeduce", spellDelay = 250, projectileName = "Ahri_Charm_mis.troy", projectileSpeed = 1600, range = 1075, radius = 60, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["AhriFoxFire"] = { spellKey = _W, isSelfCast = true, spellName = "AhriFoxFire", name = "AhriFoxFire", range = 750, projectileSpeed = 1400},
    }},
    ["Alistar"] = {charName = "Alistar", skillshots = {
    --unfinished
        ["Headbutt"] = {spellKey = _W, isTargeted = true, name = "Headbutt", spellName = "Headbutt", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 650, type = "LINE"},
        ["Pulverize"] = {spellKey = _Q, isSelfCast = true, name = "Pulverize", spellName = "Pulverize", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 250, type = "CIRCULAR"},
    }},
    ["Amumu"] = {charName = "Amumu", skillshots = {
        ["BandageToss"] = {spellKey = _Q, isCollision = true, name = "Bandage Toss (Q)", spellName = "BandageToss", spellDelay = 250, projectileName = "Bandage_beam.troy", projectileSpeed = 2000, range = 1100, radius = 80, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Tantrum"] = {spellKey = _E, isSelfCast = true, name = "Tantrum", spellName = "Tantrum", spellDelay = 250, range = 200, type = "CIRCULAR"},
        ["AuraofDespair"] = { spellKey = _W, isSelfCast = true, heroHasNoBuff = "AuraofDespair", spellName = "AuraofDespair", name = "AuraofDespair", range = 300, },
    }},
    ["Anivia"] = {charName = "Anivia", skillshots = {
        ["FlashFrostSpell"] = {spellKey = _Q, name = "Flash Frost (Q)", spellName = "FlashFrostSpell", spellDelay = 250, projectileName = "cryo_FlashFrost_mis.troy", projectileSpeed = 850, range = 1100, radius = 110, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Frostbite"] = {spellKey = _E, isTargeted = true, targetHasBuff = "chilled", name = "Frostbite (E)", spellName = "Frostbite", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 700, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Glacial Storm"] = {spellKey = _R, name = "Glacial Storm", spellName = "GlacialStorm", spellDelay = 250, projectileName = "Ahri_Orb_mis.troy", range = 615, radius = 400, type = "CIRCULAR"},
    }},
    ["Akali"] = {charName = "Akali", skillshots = {
    --unfinished
        ["AkaliQ"] = {spellKey = _Q, isTargeted = true, name = "Akali(Q)", spellName = "AkaliQ", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 600, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Crescent Slash"] = {spellKey = _E, isSelfCast = true, name = "Crescent Slash", spellName = "CrescentSlash", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 325, type = "CIRCULAR"},
        ["Shadow Dance"] = {spellKey = _R, isTargeted = true, name = "Shadow Dance", spellName = "Shadow Dance", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 800, type = "LINE"},
    }},
    ["Ashe"] = {charName = "Ashe", skillshots = {
        ["EnchantedCrystalArrow"] = { name = "Enchanted Arrow", spellName = "EnchantedCrystalArrow", spellDelay = 250, projectileName = "EnchantedCrystalArrow_mis.troy", projectileSpeed = 1600, range = 25000, radius = 130, type = "LINE", fuckedup = false, blockable = true, danger = 1},
        ["Volley"] = {spellKey = _W, isTrueRange = true, name = "Volley", spellName = "Volley", spellDelay = 250, range = 1200, radius = 200, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["FrostShot"] = { spellKey = _Q, isSelfCast = true, isAutoBuff = true, heroHasNoBuff = "FrostShot", noAnimation = true, spellName = "FrostShot", name = "FrostShot", range = 600, projectileName = "IceArrow_mis.troy",},
    }},
    ["Annie"] = {charName = "Annie", skillshots = {
    --unfinished
        ["Disintegrate"] = {spellKey = _Q, isTargeted = true, name = "Disintegrate", spellName = "Disintegrate", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 625, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["MoltenShield"] = { spellKey = _E, isSelfCast = true, spellName = "MoltenShield", name = "MoltenShield", range = math.huge, },
        ["Incinerate"] = {spellKey = _W, isTrueRange = true, name = "Incinerate", spellName = "Incinerate", spellDelay = 500, projectileName = "Thresh_Q_whip_beam.troy", range = 625, radius = 200, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["InfernalGuardian"] = { spellKey = _R, type = "CIRCULAR", checkName = true, spellName = "InfernalGuardian", name = "InfernalGuardian", range = 600, radius = 290},
    }},
    ["Blitzcrank"] = {charName = "Blitzcrank", skillshots = {
        ["RocketGrabMissile"] = {spellKey = _Q, isCollision = true, isTrueRange = true, name = "Rocket Grab", spellName = "RocketGrabMissile", spellDelay = 250, projectileName = "FistGrab_mis.troy", projectileSpeed = 1800, range = 1050, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Power Fist"] = {spellKey = _E, isSelfCast = true, targetHasBuff = "rocketgrab2", name = "Power Fist", spellName = "PowerFist", spellDelay = 250, range = math.huge,},
        ["Static Field"] = {spellKey = _R, isSelfCast = true, name = "Static Field", spellName = "StaticField", spellDelay = 250, range = 550, type = "CIRCULAR"},
    }},
    ["Brand"] = {charName = "Brand", skillshots = {
        ["BrandBlaze"] = {spellKey = _Q, isCollision = true, name = "BrandBlaze", spellName = "BrandBlaze", spellDelay = 250, projectileName = "BrandBlaze_mis.troy", projectileSpeed = 1600, range = 900, radius = 80, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Pillar of Flame"] = {spellKey = _W, name = "Pillar of Flame", spellName = "BrandFissure", spellDelay = 875, projectileName = "BrandPOF_tar_green.troy", range = 900, radius = 240, type = "CIRCULAR"},
        ["BrandWildfire"] = {name = "BrandWildfire", spellName = "BrandWildfire", castDelay = 250, projectileName = "BrandWildfire_mis.troy", projectileSpeed = 1000, range = 1100, radius = 250, type = "circular", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Caitlyn"] = {charName = "Caitlyn", skillshots = {
        ["CaitlynPiltoverPeacemaker"] = {spellKey = _Q, name = "Piltover Peacemaker", spellName = "CaitlynPiltoverPeacemaker", spellDelay = 625, projectileName = "caitlyn_Q_mis.troy", projectileSpeed = 2200, range = 1300, radius = 90, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Caitlyn Entrapment"] = {name = "Caitlyn Entrapment", spellName = "CaitlynEntrapment", spellDelay = 150, projectileName = "caitlyn_entrapment_mis.troy", projectileSpeed = 2000, range = 950, radius = 80, type = "LINE"},
        ["CaitlynHeadshotMissile"] = {name = "Ace in the Hole", spellName = "CaitlynHeadshotMissile", range = 3000, fuckedup = false, blockable = true, danger = 1, projectileName = "caitlyn_ult_mis.troy"},
    }},
    ["Cassiopeia"] = {charName = "Cassiopeia", skillshots = {
        ["Noxious Blast"] = {spellKey = _Q, name = "Noxious Blast", spellName = "Noxious Blast", spellDelay = 600, range = 850, radius = 75, type = "CIRCULAR"},
        ["CassiopeiaTwinFang"] = {spellKey = _E, isTargeted = true, targetHasBuff = "poison", name = "Twin Fang", spellName = "CassiopeiaTwinFang", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", projectileSpeed = 1800,  range = 700, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Chogath"] = {charName = "Chogath", skillshots = {
        ["Rupture"] = {spellKey = _Q, name = "Rupture", spellName = "Rupture", spellDelay = 875, projectileName = "rupture_cas_01_red_team.troy", range = 950, radius = 125, type = "CIRCULAR"},
        ["Feast"] = { spellKey = _R, isTargeted = true, isExecute = true, spellName = "Feast", name = "Feast", range = 150, },
--["Rupture"] = { spellKey = _Q, castType = 0, spellName = "Rupture", name = "Rupture", range = 950, projectileName = "AnnieBasicAttack_mis.troy",},
--["VorpalSpikes"] = { spellKey = _E, castType = 0, spellName = "VorpalSpikes", name = "VorpalSpikes", range = 40, projectileName = "TristanaBasicAttack_mis.troy", radius = 170,},
        ["FeralScream"] = { spellKey = _W, type = "LINE", spellName = "FeralScream", name = "FeralScream", range = 700, radius = 200 },

    }},
    ["Corki"] = {charName = "Corki", skillshots = {
        ["PhosphorusBomb"] = {spellKey = _Q, name = "Phosphorus Bomb", spellName = "PhosphorusBomb", spellDelay = 750, spellAnimationDelay = 250, projectileName = "LayWaste_point.troy", range = 825, radius = 250, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1},
        ["GGun"] = { spellKey = _E, type = "LINE", spellName = "GGun", name = "GGun", range = 600, radius = 200, noAnimation = true,},
        ["Missile Barrage"] = {spellKey = _R, isCollision = true, heroHasBuff = "corkimissilebarragenc", isTrueRange = true, name = "Missile Barrage", spellName = "MissileBarrage", spellDelay = 250, projectileName = "corki_MissleBarrage_mis.troy", projectileSpeed = 2000, range = 1300, radius = 40, type = "LINE"},
        ["MissileBarrageBig"] = {spellKey = _R, isCollision = true, name = "Missile Barrage big", heroHasBuff = "mbcheck2", spellName = "MissileBarrageBig", spellDelay = 250, projectileName = "Corki_MissleBarrage_DD_mis.troy", projectileSpeed = 2000, range = 1600, radius = 60, type = "LINE", fuckedUp = false, blockable = true, danger = 1}
    }},
    ["Darius"] = {charName = "Darius", skillshots = {
    --unfinished
        ["Noxian Guillotine"] = {spellKey = _R, isTargeted = true, isExecute = true, name = "Noxian Guillotine", spellName = "NoxianGuillotine", spellDelay = 250, range = 460, type = "LINE"},
        ["Crippling Strike"] = {spellKey = _W, isSelfCast = true, isAutoReset = true, name = "Crippling Strike", spellName = "Crippling Strike", spellDelay = 250, range = 125, type = "CIRCULAR"},
        ["DariusAxeGrabCone"] = {spellKey = _E, isTrueRange = true, name = "Apprehend", spellName = "DariusAxeGrabCone", spellDelay = 320, range = 570, radius = 200, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["DariusCleave"] = {spellKey = _Q, isSelfCast = true, name = "Decimate", spellName = "DariusCleave", spellDelay = 230, range = 425, type = "CIRCULAR"},
    }},
    ["Diana"] = {charName = "Diana", skillshots = {
        --["Diana Arc"] = {spellKey = _Q, name = "DianaArc", spellName = "DianaArc", spellDelay = 250, projectileName = "Diana_Q_trail.troy", projectileSpeed = 1600, range = 830, radius = 100, type = "CIRCULAR"},
        ["DianaArc"] = {spellKey = _Q, name = "DianaArc", spellName = "DianaArc", spellDelay = 250, projectileName = "Diana_Q_trail.troy", range = 830, radius = 200, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1},
        ["Pale Cascade"] = {spellKey = _W, isSelfCast = true, isShield = true, name = "Pale Cascade", spellName = "PaleCascade", spellDelay = 230, range = 200, type = "CIRCULAR", noAnimation = true,
            damage = function () return 25 + myHero.ap * .3 + 15 * myHero:GetSpellData(_W).level end},
        ["Lunar Rush"] = {spellKey = _R, isTargeted = true, name = "Lunar Rush", spellName = "LunarRush", spellDelay = 250, range = 825, type = "LINE"},
    }},
    ["Draven"] = {charName = "Draven", skillshots = {
        ["DravenFury"] = { spellKey = _W, isSelfCast = true, isAutoBuff = true, noAnimation = true, spellName = "DravenFury", name = "DravenFury", range = 550, },
        ["DravenSpinning"] = { spellKey = _Q, isSelfCast = true, isAutoBuff = true, noAnimation = true, spellName = "DravenSpinning", name = "DravenSpinning", range = 550, },
        ["DravenDoubleShot"] = {spellKey = _E, name = "Stand Aside", spellName = "DravenDoubleShot", spellDelay = 250, projectileName = "Draven_E_mis.troy", projectileSpeed = 1400, range = 1100, radius = 130, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["DravenRCast"] = {spellKey = _R, isExecute = true, name = "DravenR", spellName = "DravenRCast", spellDelay = 500, projectileName = "Draven_R_mis!.troy", projectileSpeed = 2000, range = 25000, radius = 160, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Elise"] = {charName = "Elise", skillshots = {
        ["EliseHumanE"] = {spellKey = _E, isCollision = true, name = "Cocoon", checkName = true, spellName = "EliseHumanE", spellDelay = 250, projectileName = "Elise_human_E_mis.troy", projectileSpeed = 1450, range = 1100, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["EliseHumanQ"] = {spellKey = _Q, isTargeted = true, checkName = true, name = "Neurotoxin", spellName = "EliseHumanQ", spellDelay = 250, range = 625, type = "LINE", fuckedUp = false, blockable = true, danger = 1, fuckedUp = false, blockable = true, danger = 1},
        ["Venomous Bite"] = {spellKey = _Q, isTargeted = true, checkName = true, name = "Venomous Bite", spellName = "EliseSpiderQCast", spellDelay = 250, range = 475, type = "LINE"},
        ["Skittering Frenzy"] = {spellKey = _W, isSelfCast = true, checkName = true, name = "Skittering Frenzy", spellName = "EliseSpiderW", spellDelay = 250, range = 300, type = "CIRCULAR"},
        ["EliseHumanW"] = {spellKey = _W, isCollision = true, name = "Volatile Spiderling", checkName = true, spellName = "EliseHumanW", spellDelay = 250, projectileName = "Elise_human_E_mis.troy", projectileSpeed = 1450, range = 950, radius = 100, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        
    }},
    ["Ezreal"] = {charName = "Ezreal", skillshots = {
        ["EzrealMysticShot"]             = {spellKey = _Q, isCollision = true, name = "Mystic Shot",      spellName = "EzrealMysticShot", spellDelay = 250, projectileName = "Ezreal_mysticshot_mis.troy",  projectileSpeed = 2000, range = 1100, radius = 80, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["EzrealEssenceFlux"]            = {spellKey = _W, name = "Essence Flux",     spellName = "EzrealEssenceFlux",     spellDelay = 250, projectileName = "Ezreal_essenceflux_mis.troy", projectileSpeed = 1500, range = 900,  radius = 80,  type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["EzrealMysticShotPulse"] = {name = "Mystic ShotPulse(E)",      spellName = "EzrealMysticShotPulse", spellDelay = 250, projectileName = "Ezreal_mysticshot_mis.troy",  projectileSpeed = 2000, range = 1200,  radius = 80,  type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["EzrealTrueshotBarrage"]        = {spellKey = _R, isExecute = true, name = "Trueshot Barrage", spellName = "EzrealTrueshotBarrage", spellDelay = 1000, projectileName = "Ezreal_TrueShot_mis.troy", projectileSpeed = 2000, range = 20000, radius = 160, type = "LINE", fuckedup = false, blockable = true, danger = 1},
    }},
    ["Evelynn"] = {charName = "Evelynn", skillshots = {
    --unfinished
        ["Ravage"] = {spellKey = _E, isTargeted = true, name = "Ravage", spellName = "Ravage", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 225, type = "LINE"},
        ["Dark Frenzy"] = {spellKey = _W, isSelfCast = true, name = "Dark Frenzy", spellName = "DarkFrenzy", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 125, type = "LINE"},
        ["Hate Spike"] = {spellKey = _Q, isSelfCast = true, name = "Hate Spike", spellName = "HateSpike", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 500, type = "LINE"},
    }},
    
    ["Heimerdinger"] = {charName = "Heimerdinger", skillshots = {
        ["HextechMicroRockets"]   = {spellKey = _W, isCollision = true, name = "Hextech Micro-Rockets",      spellName = "HextechMicroRockets", spellDelay = 250, projectileName = "Ezreal_mysticshot_mis.troy",  projectileSpeed = 1200, range = 1100, radius = 80, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["CH-2ElectronStormGrenade"]    = {spellKey = _E, name = "CH-2 Electron Storm Grenade",     spellName = "CH-2ElectronStormGrenade",     spellDelay = 250, projectileName = "Ezreal_essenceflux_mis.troy", projectileSpeed = 1750, range = 925,  radius = 80,  type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["FiddleSticks"] = {charName = "FiddleSticks", skillshots = {
        ["DarkWind"] = {spellKey = _E, isTargeted = true, name = "Dark Wind", spellName = "DarkWind", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 750, projectileSpeed = 1500, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Fiora"] = {charName = "Fiora", skillshots = {
        ["FioraQ"] = { spellKey = _Q, isTargeted = true, spellName = "FioraQ", name = "FioraQ", range = 600,},
        ["FioraFlurry"] = { spellKey = _E, isSelfCast = true, isAutoBuff = true, noAnimation = true, spellName = "FioraFlurry", name = "FioraFlurry", range = 500, projectileSpeed = 0, projectileName = "AnnieBasicAttack_mis.troy",},
        ["FioraDance"] = { spellKey = _R, isTargeted = true, isExecute = true, spellName = "FioraDance", name = "FioraDance", range = 400, },
        --["FioraRiposte"] = { spellKey = _W, castType = 0, spellName = "FioraRiposte", name = "FioraRiposte", range = 20, projectileSpeed = 0, projectileName = "AnnieBasicAttack_mis.troy",},
    }},
    ["Fizz"] = {charName = "Fizz", skillshots = {
        ["Leap Strike"] = {spellKey = _Q, isTargeted = true, name = "Leap Strike", spellName = "LeapStrike", spellDelay = 250, range = 700,},
        ["Seastone Trident"] = {spellKey = _W, isSelfCast = true, isAutoBuff = true, noAnimation = true, name = "Seastone Trident", spellName = "SeastoneTrident", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 600, type = "CIRCULAR"},
        --["Fizz Ultimate"] = {name = "Fizz ULT", spellName = "FizzMarinerDoom", spellDelay = 250, projectileName = "Fizz_UltimateMissile.troy", projectileSpeed = 1350, range = 1275, radius = 80, type = "LINE"},
        ["FizzMarinerDoom"] = {name = "Fizz ULT", spellName = "FizzMarinerDoom", castDelay = 250, projectileName = "Fizz_UltimateMissile.troy", projectileSpeed = 1350, range = 1275, radius = 80, type = "line", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Galio"] = {charName = "Galio", skillshots = {
        ["GalioResoluteSmite"] =  { spellKey = _Q, name = "GalioResoluteSmite", spellName = "GalioResoluteSmite", spellDelay = 250, projectileName = "galio_concussiveBlast_mis.troy", projectileSpeed = 850, range = 2000, radius = 200, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["GalioRighteousGust"] = { spellKey = _E, type = "LINE", spellName = "GalioRighteousGust", name = "GalioRighteousGust", range = 1180, projectileSpeed = 1200, radius = 120,},
        ["GalioBulwark"] = { spellKey = _W, isTargeted = true, isShield = true, spellName = "GalioBulwark", name = "GalioBulwark", range = 800, },
        ["GalioIdolOfDurand"] = { spellKey = _R, isSelfCast = true, channelDuration = 2000, spellName = "GalioIdolOfDurand", name = "GalioIdolOfDurand", range = 600, },
    }},
    ["Gangplank"] = {charName = "Gangplank", skillshots = {
        ["RaiseMorale"] = { spellKey = _E, isSelfCast = true, isAutoBuff = true, spellName = "RaiseMorale", name = "RaiseMorale", range = 125, projectileName = "pirate_raiseMorale_mis.troy",},
        --["CannonBarrage"] = { spellKey = _R, castType = 0, spellName = "CannonBarrage", name = "CannonBarrage", range = 20000, projectileName = "missing_instant.troy",},
        ["Parley"] = { spellKey = _Q, isTargeted = true, spellName = "Parley", name = "Parley", range = 625, projectileName = "pirate_parley_mis.troy",},
        --["RemoveScurvy"] = { spellKey = _W, castType = 0, spellName = "RemoveScurvy", name = "RemoveScurvy", range = 20,},
    }},
    ["Gragas"] = {charName = "Gragas", skillshots = {
        ["GragasBarrelRoll"] = {spellKey = _Q, name = "Barrel Roll", spellName = "GragasBarrelRoll", spellDelay = 250, projectileName = "gragas_barrelroll_mis.troy", projectileSpeed = 1000, range = 950, radius = 100, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Barrel Roll Missile"] = {name = "Barrel Roll Missile", spellName = "GragasBarrelRollMissile", spellDelay = 0, projectileName = "gragas_barrelroll_mis.troy", projectileSpeed = 1000, range = 1115, radius = 180, type = "CIRCULAR"},
    }},
    --edit
    ["Graves"] = {charName = "Graves", skillshots = {
        ["GravesClusterShot"] = {spellKey = _Q, name = "Buckshot", spellName = "GravesClusterShot", spellDelay = 250, projectileName = "Graves_ClusterShot_mis.troy", projectileSpeed = 1750, range = 900, radius = 60, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["SmokeScreen"] = {spellKey = _W, name = "Smoke Screen", spellName = "SmokeScreen", spellDelay = 250, projectileName = "Graves_SmokeGrenade_mis.troy", projectileSpeed = 1500, range = 950, radius = 300, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["GravesChargeShot"] = {spellKey = _R, isExecute = true, name = "Collateral Damage", spellName = "GravesChargeShot", spellDelay = 250, projectileName = "Graves_ChargedShot_mis.troy", projectileSpeed = 1500, range = 1000, radius = 100, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Irelia"] = {charName = "Irelia", skillshots = {
        ["IreliaGatotsu"] = { spellKey = _Q, isTargeted = true, spellName = "IreliaGatotsu", name = "IreliaGatotsu", range = 650,},
        ["IreliaEquilibriumStrike"] = { spellKey = _E, isTargeted = true, spellName = "IreliaEquilibriumStrike", name = "IreliaEquilibriumStrike", range = 425,
            castReq = function (target) return myHero.health < target.health end},
        ["IreliaTranscendentBlades"] = { spellKey = _R, type = "LINE", spellName = "IreliaTranscendentBlades", name = "IreliaTranscendentBlades", range = 1200, projectileSpeed = 1600, projectileName = "Irelia_ult_dagger_mis.troy", radius = 120, fuckedUp = false, blockable = true, danger = 1},
        ["IreliaHitenStyle"] = { spellKey = _W, isSelfCast = true, noAnimation = true, spellName = "IreliaHitenStyle", name = "IreliaHitenStyle", range = math.huge,},
    }},
    ["Janna"] = {charName = "Janna", skillshots = {
        ["HowlingGale"] = { spellKey = _Q, type = "LINE", spellName = "HowlingGale", name = "HowlingGale", range = 1100, projectileName = "HowlingGale_mis.troy", radius = 150, fuckedUp = false, blockable = true, danger = 1},
        ["Zephyr"] = {spellKey = _W, isTargeted = true, name = "Zephyr", spellName = "Zephyr", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 600, projectileSpeed = 1500, type = "LINE"},
        ["Eye Of The Storm"] = {spellKey = _E, isTargeted = true, isShield = true, name = "Eye Of The Storm", spellName = "EyeOfTheStorm", spellDelay = 250, range = 800, type = "CIRCULAR",
            damage = function () return 40 + 40 * myHero:GetSpellData(_E).level + myHero.ap * .7 end
            },
    }},
    ["Jax"] = {charName = "Jax", skillshots = {
    --unfinished
        ["Leap Strike"] = {spellKey = _Q, isTargeted = true, name = "Leap Strike", spellName = "LeapStrike", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 700, type = "CIRCULAR"},
        ["Empower"] = {spellKey = _W, isSelfCast = true, isAutoReset = true, name = "Empower", spellName = "Empower", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 125, type = "CIRCULAR"},
    }},
    ["Jayce"] = {charName = "Jayce", skillshots = {
        ["JayceToTheSkies"] = {spellKey = _Q, isTargeted = true, checkName = true, name = "JayceQ", spellName = "JayceToTheSkies", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 600, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Thundering Blow"] = {spellKey = _E, isTargeted = true, checkName = true, name = "Thundering Blow", spellName = "JayceThunderingBlow", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 240, type = "LINE"},
        ["Hyper Charge"] = {spellKey = _W, isSelfCast = true, checkName = true, isAutoReset = true, name = "Hyper Charge", spellName = "jaycehypercharge", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 500, type = "CIRCULAR"},
        ["JayceStaticField"] = {spellKey = _W, isSelfCast = true, checkName = true, name = "Lightning Field", spellName = "JayceStaticField", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 285, type = "CIRCULAR"},
        ["jayceshockblast"] = {spellKey = _Q, isCollision = true, checkName = true, name = "JayceShockBlast", spellName = "jayceshockblast", spellDelay = 250, projectileName = "JayceOrbLightning.troy", projectileSpeed = 1450, range = 1050, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["JayceShockBlastCharged"] = {name = "JayceShockBlastCharged", spellName = "JayceShockBlast", spellDelay = 250, projectileName = "JayceOrbLightningCharged.troy", projectileSpeed = 2350, range = 1600, radius = 70, type = "LINE"},
    }},
    ["Jinx"] = {charName = "Jinx", skillshots = {
        ["JinxWMissile"] =  {spellKey = _W, isCollision = true, name = "Zap", spellName = "JinxWMissile", spellDelay = 600, projectileName = "Jinx_W_mis.troy", projectileSpeed = 3300, range = 1450, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["JinxRWrapper"] =  {name = "Super Mega Death Rocket", spellName = "JinxRWrapper", spellDelay = 600, projectileName = "Jinx_R_Mis.troy", projectileSpeed = 2200, range = 20000, radius = 120, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }}, 
    ["Karthus"] = {charName = "Karthus", skillshots = {
        ["Lay Waste"] = {spellKey = _Q, name = "Lay Waste", spellName = "LayWaste", spellDelay = 750, spellAnimationDelay = 250, projectileName = "LayWaste_point.troy", range = 875, radius = 50, type = "CIRCULAR"},
    }},
    ["Karma"] = {charName = "Karma", skillshots = {
    --unfinished
        ["Focused Resolve"] = {spellKey = _W, isTargeted = true, name = "Focused Resolve", spellName = "FocusedResolve", spellDelay = 250, range = 650, projectileName = "swain_shadowGrasp_transform.troy", type = "LINE"},
        ["Mantra"] = {spellKey = _R, isSelfCast = true, name = "Mantra", spellName = "Mantra", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 950, type = "CIRCULAR"},
        ["KarmaQ"] = {spellKey = _Q, isCollision = true, name = "KarmaQ", spellName = "KarmaQ", spellDelay = 250, projectileName = "TEMP_KarmaQMis.troy", projectileSpeed = 1700, range = 950, radius = 90, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["KarmaSolKimShield"] = { spellKey = _E, isTargeted = true, isShield = true, spellName = "KarmaSolKimShield", name = "KarmaSolKimShield", range = 800, noAnimation = true,
            damage = function () return 40 + myHero.ap * .5 + 40 * myHero:GetSpellData(_E).level end},
    }},
    ["Kassadin"] = {charName = "Kassadin", skillshots = {
    --unfinished
        ["NullSphere"] = {spellKey = _Q, isTargeted = true, name = "Null Sphere", spellName = "NullSphere", spellDelay = 250, range = 650, projectileName = "swain_shadowGrasp_transform.troy", type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Nether Blade"] = {spellKey = _W, isSelfCast = true, isAutoReset = true, isAutoBuff = true, noAnimation = true, name = "Nether Blade", spellName = "NetherBlade", spellDelay = 250, range = 250, type = "CIRCULAR"},
        ["Force Pulse"] = {spellKey = _E, isTrueRange = true, name = "Force Pulse", spellName = "ForcePulse", spellDelay = 250, range = 700, radius = 200, type = "LINE"},
    }},
    
    ["Katarina"] = {charName = "Katarina", skillshots = {
        ["KatarinaE"] = { spellKey = _E, isTargeted = true, spellName = "KatarinaE", name = "KatarinaE", range = 700, projectileSpeed = 0, projectileName = "AnnieBasicAttack_mis.troy",},
        ["KatarinaW"] = { spellKey = _W, isSelfCast = true, spellName = "KatarinaW", name = "KatarinaW", range = 375, projectileSpeed = 1400, projectileName = "Disintegrate_mis.troy",},
        ["KatarinaR"] = { spellKey = _R, isSelfCast = true, channelDuration = 2500, spellName = "KatarinaR", name = "KatarinaR", range = 550, projectileName = "katarina_deathLotus_mis.troy", fuckedup = false, blockable = true, danger = 1},
        ["KatarinaQ"] = { spellKey = _Q, isTargeted = true, spellName = "KatarinaQ", name = "KatarinaQ", range = 675, projectileSpeed = 1100, projectileName = "katarina_bouncingBlades_mis.troy", fuckedUp = false, blockable = true, danger = 1},
    }}, 
    ["Kayle"] = {charName = "Kayle", skillshots = {
    --unfinished
        ["Reckoning"] = {spellKey = _Q, isTargeted = true, name = "Reckoning", spellName = "Reckoning", spellDelay = 250, range = 650, fuckedUp = false, blockable = true, danger = 1},
        ["DivineBlessing"] = {spellKey = _W, isTargeted = true, isHeal = true, name = "Divine Blessing", spellName = "DivineBlessing", spellDelay = 250, range = 900, type = "LINE"},
        ["Righteous Fury"] = {spellKey = _E, isSelfCast = true, noAnimation = true, name = "Righteous Fury", spellName = "RighteousFury", spellDelay = 250, range = 650},
        ["JudicatorIntervention"] = { spellKey = _R, isTargeted = true, isShield = true, isUntargetable = true, spellName = "JudicatorIntervention", name = "JudicatorIntervention", range = 900,},
    }},
    ["Kennen"] = {charName = "Kennen", skillshots = {
        ["KennenShurikenHurlMissile1"] = {spellKey = _Q, isCollision = true, name = "Thundering Shuriken", spellName = "KennenShurikenHurlMissile1", spellDelay = 180, projectileName = "kennen_ts_mis.troy", projectileSpeed = 1700, range = 1050, radius = 50, type = "LINE", fuckedUp = false, blockable = true, danger = 1}
    }},
    ["Khazix"] = {charName = "Khazix", skillshots = {
        ["KhazixQ"] = {spellKey = _Q, isTargeted = true, name = "KhazixQ", spellName = "KhazixQ", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 375, type = "LINE"},
        ["KhazixW"] = {spellKey = _W, isCollision = true, name = "KhazixW", spellName = "KhazixW", spellDelay = 250, projectileName = "Khazix_W_mis_enhanced.troy", projectileSpeed = 1700, range = 1000, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["khazixwlong"] = {name = "khazixwlong", spellName = "khazixwlong", spellDelay = 250, projectileName = "Khazix_W_mis_enhanced.troy", projectileSpeed = 1700, range = 1025, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["KogMaw"] = {charName = "KogMaw", skillshots = {
        ["CausticSpittle"] = {spellKey = _Q, isTargeted = true, name = "Caustic Spittle", spellName = "CausticSpittle", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 625, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Bio-Arcane Barrage"] = {spellKey = _W, isSelfCast = true, isAutoBuff = true, name = "Bio-Arcane Barrage", spellName = "BioArcaneBarrage", spellDelay = 250, range = 600, type = "CIRCULAR"},
        ["KogMawVoidOozeMissile"] = {spellKey = _E, name = "Void Ooze", spellName = "KogMawVoidOozeMissile", spellDelay = 250, projectileName = "KogMawVoidOoze_mis.troy", projectileSpeed = 1450, range = 1200, radius = 100, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Living Artillery"] = {spellKey = _R, name = "Living Artillery", spellName = "KogMawLivingArtillery", spellDelay = 850, projectileName = "KogMawLivingArtillery_mis.troy", range = 2200, radius = 100, type = "CIRCULAR"}
    }},
    ["Leblanc"] = {charName = "Leblanc", skillshots = {
        --unfinished
        ["SigilQ"] = {spellKey = _Q, isTargeted = true, name = "Sigil of Silence", spellName = "SigilQ", spellDelay = 250, projectileName = "non.troy", range = 700, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["LeblancChaosOrbM"] = {spellKey = _R, isTargeted = true, checkName = true, name = "Sigil of Silence R", spellName = "LeblancChaosOrbM", spellDelay = 250, projectileName = "non.troy", range = 700, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["LeblancSoulShackle"] = {spellKey = _E, isCollision = true, name = "Ethereal Chains", spellName = "LeblancSoulShackle", spellDelay = 250, projectileName = "leBlanc_shackle_mis.troy", projectileSpeed = 1600, range = 960, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["LeblancSoulShackleM"] = {name = "Ethereal Chains R", spellName = "LeblancSoulShackleM", spellDelay = 250, projectileName = "leBlanc_shackle_mis_ult.troy", projectileSpeed = 1600, range = 960, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["LeeSin"] = {charName = "LeeSin", skillshots = {
        ["BlindMonkQOne"] = {spellKey = _Q, isCollision = true, checkName = true, name = "Sonic Wave", spellName = "BlindMonkQOne", spellDelay = 250, projectileName = "blindMonk_Q_mis_01.troy", projectileSpeed = 1800, range = 975, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["blindmonkqtwo"] = {spellKey = _Q, checkName = true, isSelfCast = true, name = "Sonic Wave2", spellName = "blindmonkqtwo", spellDelay = 250, range = 975, radius = 70, type = "LINE"},
        ["BlindMonkEOne"] = { spellKey = _E, isSelfCast = true, spellName = "BlindMonkEOne", name = "BlindMonkEOne", range = 350, },        
        ["BlindMonkRKick"] = { spellKey = _R, isTargeted = true, isExecute = true, spellName = "BlindMonkRKick", name = "BlindMonkRKick", range = 375, projectileSpeed = 1500,},
    }},
    ["Leona"] = {charName = "Leona", skillshots = {
        ["LeonaShieldOfDaybreakAttack"] = {spellKey = _Q, isTargeted = true, isAutoReset = true, name = "Shield of Daybreak", spellName = "LeonaShieldOfDaybreakAttack", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 125, type = "CIRCULAR"},
        ["LeonaSolarBarrier"] = { spellKey = _W, isSelfCast = true, spellName = "LeonaSolarBarrier", name = "LeonaSolarBarrier", range = 275, },
        ["Zenith Blade"] = {spellKey = _E, name = "Zenith Blade", spellName = "LeonaZenithBlade", spellDelay = 250, projectileName = "Leona_ZenithBlade_mis.troy", projectileSpeed = 2000, range = 900, radius = 80, type = "LINE"},
        ["Leona Solar Flare"] = {spellKey = _R, name = "Leona Solar Flare", spellName = "LeonaSolarFlare", spellDelay = 250, projectileName = "Leona_SolarFlare_cas.troy", projectileSpeed = 2000, range = 1200, radius = 300, type = "CIRCULAR"}
    }},
    ["Lissandra"] = {charName = "Lissandra", skillshots = {
        ["LissandraW"] = { spellKey = _W, isSelfCast = true, isRoot = true, spellName = "LissandraW", name = "LissandraW", range = 450, },
        ["LissandraR"] = { spellKey = _R, isTargeted = true, isStun = true, spellName = "LissandraR", name = "LissandraR", range = 550, },
        --find projectile speed
        ["LissandraQ"] = { spellKey = _Q, type = "LINE", spellName = "LissandraQ", name = "LissandraQ", projectileName = "Lissandra_Q_Shards.troy", projectileSpeed = 1400, range = 725, radius = 75, fuckedUp = false, blockable = true, danger = 1},
        --["LissandraE"] = { spellKey = _E, castType = 0, spellName = "LissandraE", name = "LissandraE", range = 25000, projectileSpeed = 850, projectileName = "Lissandra_E_Missile.troy", radius = 110,},
        ["LissandraE"] = {name = "LissandraE", spellName = "LissandraE", castDelay = 250, projectileName = "Lissandra_E_Missle.troy", projectileSpeed = 850, range = 1500, radius = 140, fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Lucian"] = {charName = "Lucian", skillshots = {
        ["LucianQ"] =  {spellKey = _Q, name = "LucianQ", isTargeted = true, spellName = "LucianQ", spellDelay = 350, projectileName = "Lucian_Q_laser.troy", range = 570, radius = 65, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["LucianW"] =  {spellKey = _W, name = "LucianW", spellName = "LucianW", spellDelay = 300, projectileName = "Lucian_W_mis.troy", projectileSpeed = 1600, range = 1000, radius = 80, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Lulu"] = {charName = "Lulu", skillshots = {
        ["LuluQ"] = {spellKey = _Q, name = "Lulu (Q)", spellName = "LuluQ", spellDelay = 250, projectileName = "Lulu_Q_Mis.troy", projectileSpeed = 1450, range = 1000, radius = 50, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["LuluW"] = { spellKey = _W, isTargeted = true, isStun = true, spellName = "LuluW", name = "LuluW", range = 650, },
        ["LuluE"] = { spellKey = _E, isTargeted = true, isShield = true, spellName = "LuluE", name = "LuluE", range = 650,
            damage = function () return 40 + 40 * myHero:GetSpellData(_E).level + myHero.ap * .6 end,},
        ["LuluR"] = { spellKey = _R, isTargeted = true, isShield = true, spellName = "LuluR", name = "LuluR", range = 900,
            damage = function () return 150 + 150 * myHero:GetSpellData(_W).level + myHero.ap * .5 end,},
    }},
    ["Lux"] = {charName = "Lux", skillshots = {
        ["LuxLightBinding"] =  {spellKey = _Q, isCollision = true, name = "Light Binding (Q)", spellName = "LuxLightBinding", spellDelay = 250, projectileName = "LuxLightBinding_mis.troy", projectileSpeed = 1200, range = 1175, radius = 80, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["LuxLightStrikeKugel"] = {spellKey = _W, name = "LuxLightStrikeKugel", spellName = "LuxLightStrikeKugel", spellDelay = 250, projectileName = "LuxLightstrike_mis.troy", projectileSpeed = 1400, range = 1100, radius = 275, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["LuxMaliceCannon"] =  {spellKey = _R, isExecute = true, name = "Lux Malice Cannon", spellName = "LuxMaliceCannon", spellDelay = 950, projectileName = "Enrageweapon_buf_02.troy", range = 3500, radius = 190, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        --["LuxPrismaticWave"] = { spellKey = _W, castType = 0, spellName = "LuxPrismaticWave", name = "LuxPrismaticWave", range = 10000, radius = 150,},
    }},
    ["MasterYi"] = {charName = "Master Yi", skillshots = {
    --unfinished
        ["Alpha Strike"] = {spellKey = _Q, isTargeted = true, isUntargetable = true, name = "Alpha Strike", spellName = "AlphaStrike", spellDelay = 250, range = 600,},
        ["Wuju Style"] = {spellKey = _E, isSelfCast = true, isAutoBuff = true, noAnimation = true, name = "Wuju Style", spellName = "WujuStyle", },
        ["Meditate"] = { spellKey = _W, isSelfCast = true, isAutoReset = true, spellName = "Meditate", name = "Meditate", range = 200, },
    }},
    ["Malzahar"] = {charName = "Malzahar", skillshots = {
        ["Null Zone"] = {spellKey = _W, name = "Null Zone", spellName = "NullZone", spellDelay = 600, range = 800, radius = 250, type = "CIRCULAR"},
        ["Malefic Visions"] = {spellKey = _E, isTargeted = true, name = "Malefic Visions", spellName = "MaleficVisions", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 650, type = "LINE"},
        ["Nether Grasp"] = {spellKey = _R, isTargeted = true, channelDuration = 2500, name = "Nether Grasp", spellName = "NetherGrasp", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 700, type = "LINE"},
    }},
    ["Malphite"] = {charName = "Malphite", skillshots = {
        ["SeismicShard"] = {spellKey = _Q, isTargeted = true, name = "Seismic Shard", spellName = "SeismicShard", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 625, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Ground Slam"] = {spellKey = _E, isSelfCast = true, name = "Ground Slam", spellName = "GroundSlam", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 200, type = "CIRCULAR"},
        ["Brutal Strikes"] = {spellKey = _W, isSelfCast = true, noAnimation = true, isAutoBuff = true, name = "Brutal Strikes", spellName = "BrutalStrikes", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 200, type = "CIRCULAR"},
        ["UFSlash"] = {name = "UFSlash", spellName = "UFSlash", spellDelay = 250, projectileName = "TEST", projectileSpeed = 1800, range = 1000, radius = 160, type = "LINE"},    
    }},
    ["Maokai"] = {charName = "Maokai", skillshots = {
        ["MaokaiUnstableGrowth"] = { spellKey = _W, isTargeted = true, spellName = "MaokaiUnstableGrowth", name = "MaokaiUnstableGrowth", range = 650, },
        ["MaokaiTrunkLine"] = { spellKey = _Q, type = "LINE", spellName = "MaokaiTrunkLine", name = "MaokaiTrunkLine", range = 600, projectileSpeed = 1200, radius = 110, fuckedUp = false, blockable = true, danger = 1},
        ["MaokaiDrain3"] = { spellKey = _R, type = "CIRCULAR", spellName = "MaokaiDrain3", name = "MaokaiDrain3", range = 625, radius = 575,},
        ["MaokaiSapling2"] = { spellKey = _E, type = "LINE", spellName = "MaokaiSapling2", name = "MaokaiSapling2", range = 1100, projectileSpeed = 1750, projectileName = "Maokai_sapling_mis.troy", radius = 175},
    }},
    ["Mordekaiser"] = {charName = "Mordekaiser", skillshots = {
        ["MordekaiserMaceOfSpades"] = { spellKey = _Q, isAutoReset = true, spellName = "MordekaiserMaceOfSpades", name = "MordekaiserMaceOfSpades", range = 125,},
        ["MordekaiserCreepingDeathCast"] = { spellKey = _W, isTargeted = true, isShield = true, spellName = "MordekaiserCreepingDeathCast", name = "MordekaiserCreepingDeathCast", range = 750, projectileName = "mordekaiser_creepingDeath_mis.troy", radius = 200,},
        ["MordekaiserChildrenOfTheGrave"] = { spellKey = _R, isTargeted = true, isExecute = true, spellName = "MordekaiserChildrenOfTheGrave", name = "MordekaiserChildrenOfTheGrave", range = 850,},
        ["MordekaiserSyphonOfDestruction"] = { spellKey = _E, type = "LINE", spellName = "MordekaiserSyphonOfDestruction", name = "MordekaiserSyphonOfDestruction", range = 700, radius = 200},
    }},
    ["Morgana"] = {charName = "Morgana", skillshots = {
         ["DarkBindingMissile"] = {spellKey = _Q, isCollision = true, name = "Dark Binding", spellName = "DarkBindingMissile", spellDelay = 250, projectileName = "DarkBinding_mis.troy", projectileSpeed = 1200, range = 1300, radius = 80, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["TormentedSoil"] = { spellKey = _W, spellName = "TormentedSoil", name = "TormentedSoil", range = 900, radius = 175, type = "CIRCULAR"},
        --["SoulShackles"] = { spellKey = _R, castType = 0, spellName = "SoulShackles", name = "SoulShackles", range = 625, projectileName = "AnnieBasicAttack_mis.troy",},
        --["BlackShield"] = { spellKey = _E, castType = 0, spellName = "BlackShield", name = "BlackShield", range = 750, projectileName = "AnnieBasicAttack_mis.troy",},

    }},
    ["DrMundo"] = {charName = "DrMundo", skillshots = {
        ["InfectedCleaverMissile"] = {spellKey = _Q, isCollision = true, name = "Infected Cleaver", spellName = "InfectedCleaverMissile", spellDelay = 250, projectileName = "dr_mundo_infected_cleaver_mis.troy", projectileSpeed = 2000, range = 1000, radius = 75, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        --["BurningAgony"] = { spellKey = _W, isSelfCast = true, spellName = "BurningAgony", name = "BurningAgony", range = 325, projectileName = "AnnieBasicAttack_mis.troy",},
        ["Sadism"] = { spellKey = _R, isSelfCast = true, isHeal = true, spellName = "Sadism", name = "Sadism", range = math.huge, projectileName = "dr_mundo_sadism_cas_02.troy",},
        ["Masochism"] = { spellKey = _E, isSelfCast = true, isAutoBuff = true, spellName = "Masochism", name = "Masochism", range = 300, },
    }},
    ["Nami"] = {charName = "Nami", skillshots = {
        ["NamiQ"] = {spellKey = _Q, name = "NamiQ", spellName = "NamiQ", spellDelay = 850, projectileName = "Nami_Q_mis.troy", range = 875, radius = 100, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1},
        ["Ebb and Flow"] = {spellKey = _W, isTargeted = true, name = "Ebb and Flow", spellName = "EbbAndFlow", spellDelay = 250, range = 725,},
        ["TidecallersBlessing"] = {spellKey = _E, isSelfCast = true, name = "TidecallersBlessing", spellName = "TidecallersBlessing", spellDelay = 250, range = 800, type = "CIRCULAR"},
    }},
    ["Nasus"] = {charName = "Nasus", skillshots = {
    --unfinished
        ["NasusW"] = {spellKey = _W, isTargeted = true, name = "Wither", spellName = "NasusW", spellDelay = 250, range = 600, type = "LINE"},
        ["NasusE"] = {spellKey = _E, spellName = "NasusE", name = "NasusE", range = 650, radius = 400, type = "CIRCULAR" },
        ["NasusQ"] = {spellKey = _Q, isSelfCast = true, isAutoReset = true, name = "Siphoning Strike", spellName = "NasusQ", spellDelay = 250, range = 125, type = "CIRCULAR"},
    }},
    ["Nautilus"] = {charName = "Nautilus", skillshots = {
        ["NautilusAnchorDrag"] = {spellKey = _Q, isCollision = true, name = "Dredge Line", spellName = "NautilusAnchorDrag", spellDelay = 250, projectileName = "Nautilus_Q_mis.troy", projectileSpeed = 2000, range = 1080, radius = 80, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["NautilusPiercingGaze"] = { spellKey = _W, isSelfCast = true, isShield = true, spellName = "NautilusPiercingGaze", name = "NautilusPiercingGaze", range = math.huge, },
        ["NautilusSplashZone"] = { spellKey = _E, isSelfCast = true, spellName = "NautilusSplashZone", name = "NautilusSplashZone", range = 600, },
        ["NautilusGrandLine"] = { spellKey = _R, isTargeted = true, spellName = "NautilusGrandLine", name = "NautilusGrandLine", range = 825, projectileSpeed = 1400, },
    }},
    ["Nidalee"] = {charName = "Nidalee", skillshots = {
        ["JavelinToss"] = {spellKey = _Q, isCollision = true, name = "Javelin Toss", spellName = "JavelinToss", spellDelay = 125, projectileName = "nidalee_javelinToss_mis.troy", projectileSpeed = 1300, range = 1500, radius = 60, type = "LINE", checkName = true, fuckedUp = false, blockable = true, danger = 1},
        ["PrimalSurge"] = { spellKey = _E, isTargeted = true, isHeal = true, spellName = "PrimalSurge", name = "PrimalSurge", range = 600, checkName = true, },
        ["Bushwhack"] = { spellKey = _W, type = "CIRCULAR", spellName = "Bushwhack", name = "Bushwhack", range = 900, radius = 70, checkName = true, },
        
        ["Swipe"] = { spellKey = _E, type = "LINE", spellName = "Swipe", name = "Swipe", range = 400, radius = 200, checkName = true, },
        ["Pounce"] = { spellKey = _W, isSelfCast = true, spellName = "Pounce", name = "Pounce", range = 375, checkName = true, },
        ["Takedown"] = { spellKey = _Q, isSelfCast = true, isAutoReset = true, spellName = "Takedown", name = "Takedown", range = 500, checkName = true, },
        
        --["AspectOfTheCougar"] = { spellKey = _R, castType = 0, spellName = "AspectOfTheCougar", name = "AspectOfTheCougar", range = 20, projectileName = "TeemoBasicAttack_mis.troy",},
    }},
    ["Nocturne"] = {charName = "Nocturne", skillshots = {
        ["NocturneDuskbringer"] =  {spellKey = _Q, name = "NocturneDuskbringer", spellName = "NocturneDuskbringer", spellDelay = 250, projectileName = "NocturneDuskbringer_mis.troy", projectileSpeed = 1400, range = 1200, radius = 60, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Unspeakable Horror"] = {spellKey = _E, isTargeted = true, name = "UnspeakableHorror", spellName = "UnspeakableHorror", spellDelay = 250, range = 425, type = "LINE"},
    }},
    ["Olaf"] = {charName = "Olaf", skillshots = {
        ["OlafAxeThrow"] = {spellKey = _Q, name = "Undertow", spellName = "OlafAxeThrow", spellDelay = 250, projectileName = "olaf_axe_mis.troy", projectileSpeed = 1600, range = 1000, radius = 90, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Reckless Swing"] = {spellKey = _E, isTargeted = true, name = "Reckless Swing", spellName = "RecklessSwing", spellDelay = 250, range = 325, type = "LINE"},
        ["Vicious Strikes"] = {spellKey = _W, isSelfCast = true, isAutoBuff = true, noAnimation = true, name = "Vicious Strikes", spellName = "ViciousStrikes", range = 200},
    }},
    ["Orianna"] = {charName = "Orianna", skillshots = {
        --["OrianaReturn"] = { spellKey = ExtraSpell5, castType = 1, spellName = "OrianaReturn", name = "OrianaReturn", range = 10000, projectileSpeed = 2250, projectileName = "Oriana_Ghost_mis_return.troy", radius = 200,},
        --["OrianaRedact"] = { spellKey = ExtraSpell3, castType = 3, spellName = "OrianaRedact", name = "OrianaRedact", range = 1500, projectileSpeed = 2250, projectileName = "Oriana_Ghost_mis_protect.troy", radius = 80,},
        --["OrianaIzuna"] = { spellKey = ExtraSpell1, castType = 3, spellName = "OrianaIzuna", name = "OrianaIzuna", range = 2000, projectileSpeed = 1350, projectileName = "Oriana_Ghost_mis.troy", radius = 80,},
        --["OrianaDetonateCommand"] = { spellKey = _R, castType = 0, spellName = "OrianaDetonateCommand", name = "OrianaDetonateCommand", range = 410, projectileSpeed = 1200, radius = 80,},
        ["OrianaIzunaCommand"] = { spellKey = _Q, type = "LINE", spellName = "OrianaIzunaCommand", name = "OrianaIzunaCommand", range = 825, projectileSpeed = 1200, radius = 80,},
        
        ["OrianaRedactCommand"] = { spellKey = _E, isTargeted = true, isShield = true, spellName = "OrianaRedactCommand", name = "OrianaRedactCommand", range = 1120, projectileSpeed = 1200, radius = 80,},
        ["OrianaDissonanceCommand"] = { spellKey = _W, isSelfCast = true, spellName = "OrianaDissonanceCommand", name = "OrianaDissonanceCommand", range = math.huge, radius = 80,},
    }},
    ["Pantheon"] = {charName = "Pantheon", skillshots = {
    --unfinished
        ["SpearShot"] = {spellKey = _Q, isTargeted = true, name = "Spear Shot", spellName = "SpearShot", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 600, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1},
        ["Aegis of Zeonia"] = {spellKey = _W, isTargeted = true, name = "Aegis of Zeonia", spellName = "PantheonW", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 600, type = "LINE"},
        ["Pantheon_Heartseeker"] = {spellKey = _E, channelDuration = 750, name = "Heartseeker Strike", spellName = "Pantheon_Heartseeker", spellDelay = 250, projectileName = "Thresh_Q_whip_beam.troy", projectileSpeed = 2000, range = 600, radius = 200, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Poppy"] = {charName = "Poppy", skillshots = {
    --unfinished
        ["Devastating Blow"] = {spellKey = _Q, isTargeted = true, name = "Devastating Blow", spellName = "DevastatingBlow", spellDelay = 250, range = 125, projectileName = "swain_shadowGrasp_transform.troy", type = "LINE"},
        ["Heroic Charge"] = {spellKey = _E, isTargeted = true, name = "Heroic Charge", spellName = "HeroicCharge", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 525, type = "LINE"},
        ["Paragon of Demacia"] = {spellKey = _W, isSelfCast = true, isAutoBuff = true, noAnimation = true, name = "Paragon of Demacia", spellName = "PoppyW", spellDelay = 250, range = 300,},
    }},
    ["Quinn"] = {charName = "Quinn", skillshots = {
        ["QuinnQ"] = {spellKey = _Q, isCollision = true, name = "QuinnQ", spellName = "QuinnQ", spellDelay = 250, projectileName = "Quinn_Q_missile.troy", projectileSpeed = 1550, range = 1050, radius = 80, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["QuinnE"] = { spellKey = _E, isTargeted = true, spellName = "QuinnE", name = "QuinnE", range = 750, },
    }},
    ["Rumble"] = {charName = "Rumble", skillshots = {
        ["RumbleGrenade"] =  {spellKey = _E, name = "RumbleGrenade", spellName = "RumbleGrenade", spellDelay = 250, projectileName = "rumble_taze_mis.troy", projectileSpeed = 2000, range = 800, radius = 90, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Flamespitter"] =  {spellKey = _Q, name = "Flamespitter", spellName = "Flamespitter", spellDelay = 250, range = 650, radius = 90, type = "CIRCULAR"},
        ["RumbleShield"] = { spellKey = _W, isSelfCast = true, isShield = true, spellName = "RumbleShield", name = "RumbleShield", range = math.huge, 
            damage = function () return 20 + 30 * myHero:GetSpellData(_W).level + myHero.ap * .4 end,},
    }},
    ["Rengar"] = {charName = "Rengar", skillshots = {
    --unfinished
        ["RengarE"] = {spellKey = _E, isTargeted = true, name = "Bola Strike", spellName = "RengarE", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 575, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Savagery"] = {spellKey = _Q, isSelfCast = true, isAutoReset = true, name = "Savagery", spellName = "Savagery", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 125, type = "CIRCULAR"},
        --["Empowered Savagery"] = {spellKey = _Q, isSelfCast = true, isAutoReset = true, hasBuff="" ,name = "Empowered Savagery", spellName = "EmpoweredSavagery", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 125, type = "CIRCULAR"},
        ["Battle Roar"] = {spellKey = _W, isSelfCast = true, noAnimation = true, name = "Battle Roar", spellName = "RengarQ", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 500, type = "CIRCULAR"},
    }},
    ["Renekton"] = {charName = "Renekton", skillshots = {
    --unfinished
        ["Ruthless Predator"] = {spellKey = _W, isTargeted = true, isAutoReset = true, name = "Ruthless Predator", spellName = "RuthlessPredator", spellDelay = 250, range = 125, projectileName = "swain_shadowGrasp_transform.troy", type = "LINE"},
        ["Cull the Meek"] = {spellKey = _Q, isSelfCast = true, isTrueRange = true, name = "Cull the Meek", spellName = "RenektonQ", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 225, type = "CIRCULAR"},
        ["Slice And Dice"] = {spellKey = _E, name = "Slice", spellName = "Slice", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 450, radius = 200, type = "LINE"},
    }},
    ["Riven"] = {charName = "Riven", skillshots = {
    --unfinished
        ["Ki Burst"] = {spellKey = _W, isSelfCast = true, name = "Ki Burst", spellName = "RivenW", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 125, type = "CIRCULAR"},
        ["Broken Wings"] = {spellKey = _Q, name = "Broken Wings", spellName = "RivenTriCleave", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 260, radius = 200, type = "LINE"},
        ["Valor"] = {spellKey = _E, name = "Valor", spellName = "Valor", spellDelay = 250, projectileName = "Thresh_Q_whip_beam.troy", range = 325, radius = 200, type = "LINE"},
        ["RivenR"] = {spellKey = _R, name = "Blade of the Exile", spellName = "RivenR", spellDelay = 250, projectileName = "Thresh_Q_whip_beam.troy", range = 900, radius = 200, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Ryze"] = {charName = "Ryze", skillshots = {
    --unfinished
        ["Overload"] = {spellKey = _Q, isTargeted = true, name = "Overload", spellName = "Overload", spellDelay = 250, range = 600, projectileName = "Overload_mis.troy", type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Rune Prison"] = {spellKey = _W, isTargeted = true, name = "Rune Prison", spellName = "RunePrison", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 600, type = "LINE"},
        ["SpellFlux"] = {spellKey = _E, isTargeted = true, name = "Spell Flux", spellName = "SpellFlux", spellDelay = 250, projectileName = "SpellFlux_mis.troy", range = 600, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Desperate Power"] = {spellKey = _R, isSelfCast = true, name = "Desperate Power", spellName = "Desperate Power", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 600, type = "CIRCULAR"},
    }},
    ["Sejuani"] = {charName = "Sejuani", skillshots = {
        ["SejuaniR"] = {name = "SejuaniR", spellName = "SejuaniGlacialPrisonCast", spellDelay = 250, projectileName = "Sejuani_R_mis.troy", projectileSpeed = 1600, range = 1200, radius = 110, type = "LINE"},    
    }},
    ["Shaco"] = {charName = "Shaco", skillshots = {
        ["TwoShivPoison"] = { spellKey = _E, isTargeted = true, spellName = "TwoShivPoison", name = "TwoShivPoison", range = 625, projectileName = "JesterDagger.troy", fuckedUp = false, blockable = true, danger = 1},
        --["HallucinateFull"] = { spellKey = _R, castType = 0, spellName = "HallucinateFull", name = "HallucinateFull", range = 500, projectileName = "AnnieBasicAttack_mis.troy",},
        --["Deceive"] = { spellKey = _Q, castType = 0, spellName = "Deceive", name = "Deceive", range = 25000, projectileName = "AnnieBasicAttack_mis.troy",},
        --["JackInTheBox"] = { spellKey = _W, type = "CIRCULAR", spellName = "JackInTheBox", name = "JackInTheBox", range = 425, projectileName = "TristannaBasicAttack4_mis.troy",},
    }},
    ["Shen"] = {charName = "Shen", skillshots = {
        ["ShadowDash"] = {name = "ShadowDash", spellName = "ShenShadowDash", spellDelay = 0, projectileName = "shen_shadowDash_mis.troy", projectileSpeed = 3000, range = 575, radius = 50, type = "LINE"},
        ["ShenVorpalStar"] = { spellKey = _Q, isTargeted = true, spellName = "ShenVorpalStar", name = "ShenVorpalStar", range = 475, projectileSpeed = 1500, projectileName = "shen_vorpalStar_mis.troy"},
        ["ShenFeint"] = { spellKey = _W, isShield = true, isSelfCast = true, spellName = "ShenFeint", name = "ShenFeint", range = math.huge, 
            damage = function () return 20 + 40 * myHero:GetSpellData(_W).level + myHero.ap * .6 end,},
        --["ShenStandUnited"] = { spellKey = _R, castType = 0, spellName = "ShenStandUnited", name = "ShenStandUnited", range = 25000, projectileName = "AnnieBasicAttack_mis.troy",},
    }},
    ["Shyvana"] = {charName = "Shyvana", skillshots = { 
        ["ShyvanaDoubleAttack"] = { spellKey = _Q, isSelfCast = true, isAutoReset = true, spellName = "ShyvanaDoubleAttack", name = "ShyvanaDoubleAttack", range = 125, },
        ["ShyvanaFireball"] = { spellKey = _E, spellName = "ShyvanaFireball", name = "ShyvanaFireball", range = 925, projectileSpeed = 1200, projectileName = "shyvana_flameBreath_mis.troy", radius = 60, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["ShyvanaImmolationAura"] = { spellKey = _W, isSelfCast = true, noAnimation = true, spellName = "ShyvanaImmolationAura", name = "ShyvanaImmolationAura", range = 150, },
    }}, 
    ["Skarner"] = {charName = "Skarner", skillshots = {
    --unfinished        
        ["Crystal Slash"] = {spellKey = _Q, isSelfCast = true, name = "Crystal Slash", spellName = "CrystalSlash", spellDelay = 250, range = 300, type = "CIRCULAR"},
        ["Fracture"] = {spellKey = _E, name = "Fracture", spellName = "Fracture", spellDelay = 250, projectileName = "TEMP_KarmaQMis.troy", projectileSpeed = 1700, range = 900, radius = 45, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["SkarnerExoskeleton"] = { spellKey = _W, isSelfCast = true, isShield = true, spellName = "SkarnerExoskeleton", name = "SkarnerExoskeleton", range = math.huge, 
            damage = function () return 25 + 55 * myHero:GetSpellData(_W).level + myHero.ap * .8 end,}
    }},
    ["Sion"] = {charName = "Sion", skillshots = {
        ["CrypticGaze"] = { spellKey = _Q, isTargeted = true, isStun = true, spellName = "CrypticGaze", name = "CrypticGaze", range = 550, projectileName = "CrypticGaze_mis.troy",},
        --["DeathsCaressFull"] = { spellKey = _W, castType = 0, spellName = "DeathsCaressFull", name = "DeathsCaressFull", range = 1, projectileName = "AnnieBasicAttack_mis.troy",},
        --["Cannibalism"] = { spellKey = _R, castType = 0, spellName = "Cannibalism", name = "Cannibalism", range = 1,},
        --["Enrage"] = { spellKey = _E, castType = 0, spellName = "Enrage", name = "Enrage", range = 1, projectileName = "FuryoftheAncient_mis.troy",},
    }},
    ["Sivir"] = {charName = "Sivir", skillshots = { --hard to measure speed
        --unfinished
        ["SivirQ"] = {spellKey = _Q, name = "Boomerang Blade", spellName = "SivirQ", spellDelay = 250, projectileName = "Sivir_Base_Q_mis.troy", projectileSpeed = 1350, range = 1075, radius = 101, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Ricochet"] = {spellKey = _W, isSelfCast = true, isAutoReset = true, name = "Ricochet", spellName = "Ricochet", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 550, type = "LINE"},
    }},
    ["Sona"] = {charName = "Sona", skillshots = {
        ["HymnofValor"] = {spellKey = _Q, isSelfCast = true, name = "Hymn of Valor", spellName = "HymnofValor", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 700, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["SonaAriaofPerseverance"] = { spellKey = _W, isSelfCast = true, isHeal = true, spellName = "SonaAriaofPerseverance", name = "SonaAriaofPerseverance", range = 1000,},
        ["SonaCrescendo"] = {name = "Crescendo", spellName = "SonaCrescendo", spellDelay = 250, projectileName = "SonaCrescendo_mis.troy", projectileSpeed = 2400, range = 1000, radius = 150, type = "LINE", fuckedUp = false, blockable = true, danger = 1},      
    }},
    ["Soraka"] = {charName = "Soraka", skillshots = {
        ["Infuse"] = {spellKey = _E, isTargeted = true, name = "Infuse", spellName = "Infuse", spellDelay = 250, range = 725, type = "LINE"},
        ["Starcall"] = {spellKey = _Q, isSelfCast = true, isTrueRange = true, name = "Starcall", spellName = "Starcall", spellDelay = 250, range = 675, type = "CIRCULAR"},        
        ["AstralBlessing"] = {spellKey = _W, isTargeted = true, isHeal = true, spellName = "AstralBlessing", name = "AstralBlessing", range = 750},
        ["Wish"] = { spellKey = _R, isTargeted = true, isHeal = true, spellName = "Wish", name = "Wish", range = math.huge},
    }},
    ["Swain"] = {charName = "Swain", skillshots = {
    --unfinished
        ["Decrepify"] = {spellKey = _Q, isTargeted = true, name = "Decrepify", spellName = "Decrepify", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 625, radius = 125, type = "LINE", fuckedUp = false, blockable = true, danger = 1, fuckedUp = false, blockable = true, danger = 1},
        ["Nevermove"] = {spellKey = _W, name = "Nevermove", spellName = "SwainShadowGrasp", spellDelay = 875, projectileName = "swain_shadowGrasp_transform.troy", range = 900, radius = 125, type = "CIRCULAR"},
        ["Torment"] = {spellKey = _E, isTargeted = true, name = "Torment", spellName = "Torment", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", projectileSpeed = 1000, range = 625, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Syndra"] = {charName = "Syndra", skillshots = {
        ["SyndraQ"] = {name = "SyndraQ", spellName = "SyndraQ", spellDelay = 200, projectileName = "Syndra_Q_cas.troy", projectileSpeed = 300, range = 800, radius = 180, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1}
    }},
    ["Talon"] = {charName = "Talon", skillshots = {
    --unfinished
        ["Noxian Diplomacy"] = {spellKey = _Q, isSelfCast = true, isAutoReset = true, name = "Noxian Diplomacy", spellName = "TalonQ", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 125, type = "CIRCULAR"},
        ["Cutthroat"] = {spellKey = _E, isTargeted = true, name = "Cutthroat", spellName = "Cutthroat", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 700, type = "CIRCULAR"},
        ["Rake"] = {spellKey = _W, name = "Rake", spellName = "Rake", spellDelay = 250, projectileName = "Thresh_Q_whip_beam.troy", projectileSpeed = 2000, range = 600, radius = 200, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["ShadowAssault"] = {spellKey = _R, isSelfCast = true, name = "Shadow Assault", spellName = "ShadowAssault", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 500, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Taric"] = {charName = "Taric", skillshots = {
        ["Imbue"] = { spellKey = _Q, isTargeted = true, isHeal = true, spellName = "Imbue", name = "Imbue", range = 750, },
        ["Dazzle"] = {spellKey = _E, isTargeted = true, name = "Dazzle", spellName = "Dazzle", spellDelay = 250, range = 625, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Shatter"] = {spellKey = _W, isSelfCast = true, name = "Shatter", spellName = "Shatter", spellDelay = 250, range = 200, type = "CIRCULAR"},
        ["Radiance"] = {spellKey = _R, isSelfCast = true, name = "Radiance", spellName = "Radiance", spellDelay = 250, range = 200, type = "CIRCULAR"},
    }},
    ["Teemo"] = {charName = "Teemo", skillshots = {
    --insert projectile speed
        ["BlindingDart"] = {spellKey = _Q, isTargeted = true, name = "BlindingDart", spellName = "BlindingDart", spellDelay = 250, projectileName = "BlindShot_mis.troy", projectileSpeed = 1900, range = 680, fuckedUp = false, blockable = true, danger = 1}
    }},
    ["Thresh"] = {charName = "Thresh", skillshots = {
        ["ThreshQ"] = {spellKey = _Q, isCollision = true, name = "ThreshQ", spellName = "ThreshQ", spellDelay = 500, projectileName = "Thresh_Q_whip_beam.troy", projectileSpeed = 1900, range = 1075, radius = 65, type = "LINE", fuckedUp = false, blockable = true, danger = 1}
    }},
    ["Tristana"] = {charName = "Tristana", skillshots = {
    --unfinished
        ["Explosive Shot"] = {spellKey = _E, isTargeted = true, isAutoReset = true, name = "Explosive Shot", spellName = "ExplosiveShot", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 700, type = "LINE"},
        ["Rapid Fire"] = {spellKey = _Q, isSelfCast = true, name = "Rapid Fire", spellName = "RapidFire", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 700, type = "CIRCULAR"},
        ["BusterShot"] = {spellKey = _R, isTargeted = true, isExecute = true, name = "Buster Shot", spellName = "BusterShot", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 645, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Trundle"] = {charName = "Trundle", skillshots = {
        ["TrundlePain"] = { spellKey = _R, isTargeted = true, spellName = "TrundlePain", name = "TrundlePain", range = 700,},
        ["trundledesecrate"] = { spellKey = _W, spellName = "trundledesecrate", name = "trundledesecrate", range = 900, radius = 1000, type = "CIRCULAR"},
        ["TrundleTrollSmash"] = { spellKey = _Q, isSelfCast = true, isAutoReset = true, spellName = "TrundleTrollSmash", name = "TrundleTrollSmash", range = 125,},
        ["TrundleCircle"] = { spellKey = _E, spellName = "TrundleCircle", name = "TrundleCircle", range = 1000, radius = 62, type = "CIRCULAR"},
    }},
    ["Tryndamere"] = {charName = "Tryndamere", skillshots = {
        ["UndyingRage"] = { spellKey = _R, isSelfCast = true, isShield = true, spellName = "UndyingRage", name = "UndyingRage", range = math.huge,},
    }},
    ["TwistedFate"] = {charName = "TwistedFate", skillshots = {
        ["WildCards"] = {spellKey = _Q, name = "Loaded Dice", spellName = "WildCards", spellDelay = 250, projectileName = "Roulette_mis.troy", projectileSpeed = 1000, range = 1450, radius = 40, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Pick A Card"] = {spellKey = _W, isSelfCast = true, checkName = true, name = "Pick A Card", spellName = "PickACard", spellDelay = 250, projectileName = "Thresh_Q_whip_beam.troy", projectileSpeed = 1500, range = 700, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Gold Card"] = {spellKey = _W, isSelfCast = true, checkName = true, name = "Gold Card", spellName = "goldcardlock", spellDelay = 250, projectileName = "TwistedFate_Base_W_GoldCard.troy", projectileSpeed = 1500, range = math.huge, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Blue Card"] = {spellKey = _W, isSelfCast = true, checkName = true, name = "Blue Card", spellName = "bluecardlock", spellDelay = 250, projectileName = "TwistedFate_Base_W_BlueCard.troy", projectileSpeed = 1500, range = math.huge, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Red Card"] = {spellKey = _W, isSelfCast = true, checkName = true, name = "Red Card", spellName = "redcardlock", spellDelay = 250, projectileName = "TwistedFate_Base_W_RedCard.troy", projectileSpeed = 1500, range = math.huge, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Twitch"] = {charName = "Twitch", skillshots = {
        ["TwitchVenomCask"] = { spellKey = _W, type = "LINE", spellName = "TwitchVenomCask", name = "TwitchVenomCask", projectileName = "Twitch_Venom_Splash.troy", projectileSpeed = 1400, range = 900, radius = 200, fuckedUp = false, blockable = true, danger = 1},
        ["HideInShadows"] = { spellKey = _Q, isSelfCast = true, isAutoBuff = true, noAnimation = ture, spellName = "HideInShadows", name = "HideInShadows", range = 550, },
        ["Expunge"] = { spellKey = _E, isSelfCast = true, spellName = "Expunge", name = "Expunge", range = 1200, fuckedUp = false, blockable = true, danger = 1},
        --["FullAutomatic"] = { spellKey = _R, castType = 0, spellName = "FullAutomatic", name = "FullAutomatic", range = 1200,},
    }},
    ["Udyr"] = {charName = "Udyr", skillshots = {       
        ["UdyrPhoenixStance"] = { spellKey = _R, isSelfCast = true, noAnimation = true, isAutoBuff = true, spellName = "UdyrPhoenixStance", name = "UdyrPhoenixStance", range = math.huge,},
        ["UdyrTurtleStance"] = { spellKey = _W, isSelfCast = true, noAnimation = true, isShield = true, spellName = "UdyrTurtleStance", name = "UdyrTurtleStance", range = math.huge,},
        ["UdyrBearStance"] = { spellKey = _E, isSelfCast = true, noAnimation = true, spellName = "UdyrBearStance", name = "UdyrBearStance", range = math.huge,},
        ["UdyrTigerStance"] = { spellKey = _Q, isSelfCast = true, noAnimation = true, isAutoBuff = true, spellName = "UdyrTigerStance", name = "UdyrTigerStance", range = math.huge,},

    }},
    
    ["Urgot"] = {charName = "Urgot", skillshots = {
        ["UrgotHeatseekingLineMissile"] = {name = "Acid Hunter", spellName = "UrgotHeatseekingLineMissile", spellDelay = 175, projectileName = "UrgotLineMissile_mis.troy", projectileSpeed = 1600, range = 1000, radius = 60, type = "LINE", fuckedUp = false, blockable = true, danger = 1, fuckedUp = false, blockable = true, danger = 1},
        ["UrgotPlasmaGrenade"] = {name = "Plasma Grenade", spellName = "UrgotPlasmaGrenade", spellDelay = 250, projectileName = "UrgotPlasmaGrenade_mis.troy", projectileSpeed = 1750, range = 900, radius = 250, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["MonkeyKing"] = {charName = "MonkeyKing", skillshots = {
    --unfinished
        ["MonkeyKingNimbus"] = {spellKey = _E, isTargeted = true, name = "Nimbus Strike", spellName = "MonkeyKingNimbus", spellDelay = 250, range = 625, type = "LINE"},
        ["MonkeyKingQAttack"] = {spellKey = _Q, isSelfCast = true, isAutoReset = true, isTrueRange = true, name = "Crushing Blow", spellName = "MonkeyKingQAttack", spellDelay = 250, range = 325, type = "CIRCULAR"},
    }},
    ["Vladimir"] = {charName = "Vladimir", skillshots = {
        --["VladimirSanguinePool"] = { spellKey = _W, castType = 0, spellName = "VladimirSanguinePool", name = "VladimirSanguinePool", range = 1050, projectileName = "DarkWind_mis.troy", radius = 120,},
        ["VladimirHemoplague"] = { spellKey = _R, type = "CIRCULAR", spellName = "VladimirHemoplague", name = "VladimirHemoplague", range = 700, projectileSpeed = 1200, projectileName = "VladHemoPlague_cas.troy", radius = 175,},
        ["VladimirTidesofBlood"] = { spellKey = _E, isSelfCast = true, spellName = "VladimirTidesofBlood", name = "VladimirTidesofBlood", range = 610, projectileSpeed = 1100, projectileName = "VladTidesofBlood_mis.troy", radius = 120,},
        ["VladimirTransfusion"] = { spellKey = _Q, isTargeted = true, spellName = "VladimirTransfusion", name = "VladimirTransfusion", range = 600,},
    }},
    ["Volibear"] = {charName = "Volibear", skillshots = {
        ["VolibearQ"] = { spellKey = _Q, isAutoReset = true, spellName = "VolibearQ", name = "VolibearQ", range = 125, },
        ["VolibearR"] = { spellKey = _R, isAutoBuff = true, spellName = "VolibearR", name = "VolibearR", range = 125, },
        ["VolibearE"] = { spellKey = _E, isSelfCast = true, spellName = "VolibearE", name = "VolibearE", range = 425, projectileName = "FerosciousHowl_cas3.troy",},
        ["VolibearW"] = { spellKey = _W, isTargeted = true, isExecute = true, spellName = "VolibearW", name = "VolibearW", range = 400, },
    }},
    ["Warwick"] = {charName = "Warwick", skillshots = {
    --unfinished
        ["Hungering Strike"] = {spellKey = _Q, isTargeted = true, name = "Hungering Strike", spellName = "HungeringStrike", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 400, type = "LINE"},
        ["Hunters Call"] = {spellKey = _W, isSelfCast = true, isAutoBuff = true, noAnimation = true, name = "Hunters Call", spellName = "HuntersCall", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 300, type = "CIRCULAR"},
    }},
    ["Varus"] = {charName = "Varus", skillshots = {
        ["VarusQ!"] = {spellKey = _Q, name = "Varus Q Missile", spellName = "VarusQ!", spellDelay = 0, projectileName = "VarusQ_mis.troy", projectileSpeed = 1900, range = 1600, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["VarusE"] = {spellKey = _E, name = "Varus E", spellName = "VarusE", spellDelay = 250, projectileName = "VarusEMissileLong.troy", projectileSpeed = 1500, range = 925, radius = 275, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1},
        ["VarusR"] = {name = "VarusR", spellName = "VarusR", spellDelay = 250, projectileName = "VarusRMissile.troy", projectileSpeed = 1950, range = 1250, radius = 100, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    
    ["Vayne"] = {charName = "Vayne", skillshots = {
        --["VayneInquisition"] = { spellKey = _R, castType = 0, spellName = "VayneInquisition", name = "VayneInquisition", range = 1, projectileName = "AnnieBasicAttack_mis.troy",},
        --["VayneCondemn"] = { spellKey = _E, castType = 0, spellName = "VayneCondemn", name = "VayneCondemn", range = 550, projectileSpeed = 1200, projectileName = "vayne_E_mis.troy",},
        --["VayneSilveredBolts"] = { spellKey = _W, castType = 0, spellName = "VayneSilveredBolts", name = "VayneSilveredBolts", range = 10000, radius = 50,},
        ["VayneTumble"] = { isAutoReset = true, isDash = true, spellName = "VayneTumble", name = "VayneTumble", range = 300, },
        ["VayneCondemn"] = {name = "VayneCondemn", spellName = "VayneCondemn", castDelay = 250, projectileName = "vayne_E_mis.troy", projectileSpeed = 1200, range = 550, radius = 450, fuckedUp = false, blockable = true, danger = 1}
    }}, 
    ["Veigar"] = {charName = "Veigar", skillshots = {
        ["BalefulStrike"] = {spellKey = _Q, isTargeted = true, name = "Baleful Strike", spellName = "BalefulStrike", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 650, projectileSpeed = 1500, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Dark Matter"] = {spellKey = _W, name = "VeigarDarkMatter", targetHasBuff = "Stun", spellName = "VeigarDarkMatter", spellDelay = 1250, projectileName = "!", range = 900, radius = 112, type = "CIRCULAR"},
        ["Primordial Burst"] = {spellKey = _R, isTargeted = true, isExecute = true, name = "Primordial Burst", spellName = "PrimordialBurst", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 650, projectileSpeed = 1500, type = "LINE"},
    }},
    ["Vi"] = {charName = "Vi", skillshots = {
    --unfinished
        ["Excessive Force"] = {spellKey = _E, isSelfCast = true, isAutoReset = true, name = "Excessive Force", spellName = "ExcessiveForce", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 125, type = "CIRCULAR"},
    }},
    ["XinZhao"] = {charName = "XinZhao", skillshots = {
        ["Talon Strike"] = {spellKey = _Q, isSelfCast = true, isAutoReset = true, name = "Talon Strike", spellName = "TalonStrike", spellDelay = 250, range = 175, type = "LINE"},
        ["Battle Cry"] = {spellKey = _W, isSelfCast = true, isAutoBuff = true, noAnimation = true, name = "Battle Cry", spellName = "BattleCry", spellDelay = 250, range = 300,},
        ["Crescent Sweep"] = {spellKey = _R, isSelfCast = true, name = "Crescent Sweep", spellName = "CrescentSweep", spellDelay = 250, range = 300, type = "CIRCULAR"},
        ["Audacious Charge"] = { spellKey = _E, isTargeted = true, spellName = "XinZhaoCharge", name = "Audacious Charge", range = 600, },
    }},
    ["Xerath"] = {charName = "Xerath", skillshots = {
        ["XerathMageSpear"] = { spellKey = _E, type = "LINE", isCollision = true, isStun = true, spellName = "XerathMageSpear", name = "XerathMageSpear", projectileName = "Xerath_Base_E_mis.troy", range = 1050, projectileSpeed = 1600, radius = 70, fuckedUp = false, blockable = true, danger = 1},
        ["XerathArcanopulseChargeUp"] = { spellKey = _Q, type = "LINE", spellName = "XerathArcanopulseChargeUp", heroHasNoBuff = "XerathArcanopulseChargeUp", name = "XerathArcanopulseChargeUp", range = 1000, radius = 100, },
        ["XerathArcanopulseChargeUp2"] = { spellKey = _Q, type = "LINE", spellName = "XerathArcanopulseChargeUp2", heroHasBuff = "XerathArcanopulseChargeUp", name = "XerathArcanopulseChargeUp2", range = 750, radius = 100, fuckedUp = false, blockable = true, danger = 1},
        --range function
        ["XerathArcaneBarrage2"] = { spellKey = _W, type = "CIRCULAR", spellName = "XerathArcaneBarrage2", name = "XerathArcaneBarrage2", range = 1100, spellDelay = 750, radius = 200, fuckedUp = false, blockable = true, danger = 1},
        ["XerathLocusOfPower2"] = { spellKey = _R, type = "CIRCULAR", spellName = "XerathLocusOfPower2", name = "XerathLocusOfPower2", projectileName = "Xerath_Base_R_mis.troy", range = 5600, radius = 100, spellDelay = 750, fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Yasuo"] = {charName = "Yasuo", skillshots = {
        ["Steel Tempest"] = {spellKey = _Q, name = "Steel Tempest", isTrueRange = true, spellName = "SteelTempest", spellDelay = 250, projectileName = "Yasuo_Q_WindStrike.troy", range = 475, radius = 50, type = "LINE"},
        ["yasuoq3w"] = {spellKey = _Q, name = "Steel Tempest3", checkName = true, spellName = "yasuoq3w", spellDelay = 250, projectileName = "Yasuo_Q_wind_mis.troy", projectileSpeed = 1500, range = 900, radius = 100, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Yorick"] = {charName = "Yorick", skillshots = {       
        ["YorickDecayed"] = { spellKey = _W, spellName = "YorickDecayed", name = "YorickDecayed", range = 600, radius = 100, type = "CIRCULAR"},
        --["YorickReviveAlly"] = { spellKey = _R, castType = 0, spellName = "YorickReviveAlly", name = "YorickReviveAlly", range = 850, projectileSpeed = 1500,},
        ["YorickSpectral"] = { spellKey = _Q, isSelfCast = true, isAutoReset = true, noAnimation = true, spellName = "YorickSpectral", name = "YorickSpectral", range = 125,},
        ["YorickRavenous"] = { spellKey = _E, isTargeted = true, spellName = "YorickRavenous", name = "YorickRavenous", range = 550, },
    }},
    ["Zed"] = {charName = "Zed", skillshots = {
        ["ZedShuriken"] = {spellKey = _Q, name = "ZedShuriken", spellName = "ZedShuriken", spellDelay = 250, projectileName = "Zed_Q_Mis.troy", projectileSpeed = 1700, range = 925, radius = 50, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["ZedShadowSlash"] = { spellKey = _E, isSelfCast = true, spellName = "ZedShadowSlash", name = "ZedShadowSlash", range = 290,},
    }},
    ["Ziggs"] = {charName = "Ziggs", skillshots = {
        ["ZiggsQ"] =  {spellKey = _Q, isCollision = true, name = "ZiggsQ", spellName = "ZiggsQ", spellDelay = 250, projectileName = "ZiggsQ.troy", projectileSpeed = 1700, range = 1400, radius = 155, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["ZiggsW"] =  {spellKey = _W, name = "ZiggsW", spellName = "ZiggsW", spellDelay = 250, projectileName = "ZiggsW_mis.troy", projectileSpeed = 1700, range = 1000, radius = 325, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["ZiggsE"] =  {spellKey = _E, name = "ZiggsE", spellName = "ZiggsE", spellDelay = 250, projectileName = "ZiggsE_Mis_Large.troy", projectileSpeed = 1700, range = 900, radius = 250, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["ZiggsR"] = { spellKey = _R, isExecute = true, type = "LINE", spellName = "ZiggsR", name = "ZiggsR", range = 5000, projectileSpeed = 1750, projectileName = "ZiggsR_Mis_Nuke.troy", radius = 550, fuckedup = false, blockable = true, danger = 1},
    }},
    ["Zilean"] = {charName = "Zilean", skillshots = {
    --unfinished
        ["TimeBomb"] = {spellKey = _Q, isTargeted = true, name = "Time Bomb", spellName = "TimeBomb", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 700, radius = 330, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1},
        ["Rewind"] = {spellKey = _W, isSelfCast = true, name = "Rewind", spellName = "Rewind", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 700, type = "CIRCULAR"},
        ["ChronoShift"] = { spellKey = _R, isTargeted = true, isShield = true, spellName = "ChronoShift", name = "ChronoShift", range = 900, },
    }},
    ["Zyra"] = {charName = "Zyra", skillshots = {
        ["Deadly Bloom"]   = {spellKey = _Q, name = "Deadly Bloom", spellName = "ZyraQFissure", spellDelay = 625, projectileName = "zyra_Q_cas.troy", range = 800, radius = 220, type = "CIRCULAR"},
        ["Rampant Growth"]   = {spellKey = _W, name = "Rampant Growth", spellName = "Rampant Growth", spellDelay = 625, projectileName = "zyra_Q_cas.troy", range = 850, radius = 220, type = "CIRCULAR"},
        ["ZyraGraspingRoots"] = {spellKey = _E, name = "Grasping Roots", spellName = "ZyraGraspingRoots", spellDelay = 250, projectileName = "Zyra_E_sequence_impact.troy", projectileSpeed = 1150, range = 1150, radius = 70,  type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["ZyraBrambleZone"] = { spellKey = _R, type = "CIRCULAR", spellName = "ZyraBrambleZone", name = "ZyraBrambleZone", range = 700, spellDelay = 250, radius = 400},
        ["zyrapassivedeathmanager"] = { spellKey = _Q, checkName = true, name = "Zyra Passive", spellName = "zyrapassivedeathmanager", spellDelay = 500, projectileName = "zyra_passive_plant_mis.troy", projectileSpeed = 2000, range = 1474, radius = 60,  type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
}
---//==================================================\\---
--|| > Skin Hack Table --Credits to Divine                 ||--
---\\==================================================//---
skinMeta = {

  -- A
["Aatrox"]       = {"Classic", "Justicar", "Mecha", "Sea Hunter"},
["Ahri"]         = {"Classic", "Dynasty", "Midnight", "Foxfire", "Popstar", "Challenger", "Academy"},
["Akali"]        = {"Classic", "Stinger", "Crimson", "All-star", "Nurse", "Blood Moon", "Silverfang", "Headhunter"},
["Alistar"]      = {"Classic", "Black", "Golden", "Matador", "Longhorn", "Unchained", "Infernal", "Sweeper", "Marauder"},
["Amumu"]        = {"Classic", "Pharaoh", "Vancouver", "Emumu", "Re-Gifted", "Almost-Prom King", "Little Knight", "Sad Robot", "Surprise Party"},
["Anivia"]       = {"Classic", "Team Spirit", "Bird of Prey", "Noxus Hunter", "Hextech", "Blackfrost", "Prehistoric"},
["Annie"]        = {"Classic", "Goth", "Red Riding", "Annie in Wonderland", "Prom Queen", "Frostfire", "Reverse", "FrankenTibbers", "Panda", "Sweetheart"},
["Ashe"]         = {"Classic", "Freljord", "Sherwood Forest", "Woad", "Queen", "Amethyst", "Heartseeker", "Marauder"},
["Azir"]         = {"Classic", "Galactic", "Gravelord"},
  -- B  
["Bard"]         = {"Classic", "Elderwood", "Chroma Pack: Marigold", "Chroma Pack: Ivy", "Chroma Pack: Sage"},
["Blitzcrank"]   = {"Classic", "Rusty", "Goalkeeper", "Boom Boom", "Piltover Customs", "Definitely Not", "iBlitzcrank", "Riot", "Chroma Pack: Molten", "Chroma Pack: Cobalt", "Chroma Pack: Gunmetal", "Battle Boss"},
["Brand"]        = {"Classic", "Apocalyptic", "Vandal", "Cryocore", "Zombie", "Spirit Fire"},
["Braum"]        = {"Classic", "Dragonslayer", "El Tigre", "Lionheart"},
  -- C  
["Caitlyn"]      = {"Classic", "Resistance", "Sheriff", "Safari", "Arctic Warfare", "Officer", "Headhunter", "Chroma Pack: Pink", "Chroma Pack: Green", "Chroma Pack: Blue"},
["Cassiopeia"]   = {"Classic", "Desperada", "Siren", "Mythic", "Jade Fang", "Chroma Pack: Day", "Chroma Pack: Dusk", "Chroma Pack: Night"},
["Chogath"]      = {"Classic", "Nightmare", "Gentleman", "Loch Ness", "Jurassic", "Battlecast Prime", "Prehistoric"},
["Corki"]        = {"Classic", "UFO", "Ice Toboggan", "Red Baron", "Hot Rod", "Urfrider", "Dragonwing", "Fnatic"},
  -- D
["Darius"]       = {"Classic", "Lord", "Bioforge", "Woad King", "Dunkmaster", "Chroma Pack: Black Iron", "Chroma Pack: Bronze", "Chroma Pack: Copper", "Academy"},
["Diana"]        = {"Classic", "Dark Valkyrie", "Lunar Goddess"},
["DrMundo"]      = {"Classic", "Toxic", "Mr. Mundoverse", "Corporate Mundo", "Mundo Mundo", "Executioner Mundo", "Rageborn Mundo", "TPA Mundo", "Pool Party"},
["Draven"]       = {"Classic", "Soul Reaver", "Gladiator", "Primetime", "Pool Party"},
  -- E 
["Ekko"]         = {"Classic", "Sandstorm", "Academy"},
["Elise"]        = {"Classic", "Death Blossom", "Victorious", "Blood Moon"},
["Evelynn"]      = {"Classic", "Shadow", "Masquerade", "Tango", "Safecracker"},
["Ezreal"]       = {"Classic", "Nottingham", "Striker", "Frosted", "Explorer", "Pulsefire", "TPA", "Debonair", "Ace of Spades"},
  -- F 
["FiddleSticks"] = {"Classic", "Spectral", "Union Jack", "Bandito", "Pumpkinhead", "Fiddle Me Timbers", "Surprise Party", "Dark Candy", "Risen"},
["Fiora"]        = {"Classic", "Royal Guard", "Nightraven", "Headmistress", "PROJECT"},
["Fizz"]         = {"Classic", "Atlantean", "Tundra", "Fisherman", "Void", "Chroma Pack: Orange", "Chroma Pack: Black", "Chroma Pack: Red", "Cottontail"},
  -- G  
["Galio"]        = {"Classic", "Enchanted", "Hextech", "Commando", "Gatekeeper", "Debonair"},
["Gangplank"]    = {"Classic", "Spooky", "Minuteman", "Sailor", "Toy Soldier", "Special Forces", "Sultan", "Captain"},
["Garen"]        = {"Classic", "Sanguine", "Desert Trooper", "Commando", "Dreadknight", "Rugged", "Steel Legion", "Chroma Pack: Garnet", "Chroma Pack: Plum", "Chroma Pack: Ivory", "Rogue Admiral"},
["Gnar"]         = {"Classic", "Dino", "Gentleman"},
["Gragas"]       = {"Classic", "Scuba", "Hillbilly", "Santa", "Gragas, Esq.", "Vandal", "Oktoberfest", "Superfan", "Fnatic", "Caskbreaker"},
["Graves"]       = {"Classic", "Hired Gun", "Jailbreak", "Mafia", "Riot", "Pool Party", "Cutthroat"},
  -- H 
["Hecarim"]      = {"Classic", "Blood Knight", "Reaper", "Headless", "Arcade", "Elderwood"},
["Heimerdinger"] = {"Classic", "Alien Invader", "Blast Zone", "Piltover Customs", "Snowmerdinger", "Hazmat"},
  -- I 
["Illaoi"]       = {"Classic", "Void Bringer"},
["Irelia"]       = {"Classic", "Nightblade", "Aviator", "Infiltrator", "Frostblade", "Order of the Lotus"},
  -- J 
["Janna"]        = {"Classic", "Tempest", "Hextech", "Frost Queen", "Victorious", "Forecast", "Fnatic"},
["JarvanIV"]     = {"Classic", "Commando", "Dragonslayer", "Darkforge", "Victorious", "Warring Kingdoms", "Fnatic"},
["Jax"]          = {"Classic", "The Mighty", "Vandal", "Angler", "PAX", "Jaximus", "Temple", "Nemesis", "SKT T1", "Chroma Pack: Cream", "Chroma Pack: Amber", "Chroma Pack: Brick", "Warden"},
["Jayce"]        = {"Classic", "Full Metal", "Debonair", "Forsaken"},
["Jinx"]         = {"Classic", "Mafia", "Firecracker", "Slayer"},
  -- K 
["Kalista"]      = {"Classic", "Blood Moon", "Championship"},
["Karma"]        = {"Classic", "Sun Goddess", "Sakura", "Traditional", "Order of the Lotus", "Warden"},
["Karthus"]      = {"Classic", "Phantom", "Statue of", "Grim Reaper", "Pentakill", "Fnatic", "Chroma Pack: Burn", "Chroma Pack: Blight", "Chroma Pack: Frostbite"},
["Kassadin"]     = {"Classic", "Festival", "Deep One", "Pre-Void", "Harbinger", "Cosmic Reaver"},
["Katarina"]     = {"Classic", "Mercenary", "Red Card", "Bilgewater", "Kitty Cat", "High Command", "Sandstorm", "Slay Belle", "Warring Kingdoms"},
["Kayle"]        = {"Classic", "Silver", "Viridian", "Unmasked", "Battleborn", "Judgment", "Aether Wing", "Riot"},
["Kennen"]       = {"Classic", "Deadly", "Swamp Master", "Karate", "Kennen M.D.", "Arctic Ops"},
["Khazix"]       = {"Classic", "Mecha", "Guardian of the Sands"},
["Kindred"]      = {"Classic", "Shadowfire"},
["KogMaw"]       = {"Classic", "Caterpillar", "Sonoran", "Monarch", "Reindeer", "Lion Dance", "Deep Sea", "Jurassic", "Battlecast"},
  -- L 
["Leblanc"]      = {"Classic", "Wicked", "Prestigious", "Mistletoe", "Ravenborn"},
["LeeSin"]       = {"Classic", "Traditional", "Acolyte", "Dragon Fist", "Muay Thai", "Pool Party", "SKT T1", "Chroma Pack: Black", "Chroma Pack: Blue", "Chroma Pack: Yellow", "Knockout"},
["Leona"]        = {"Classic", "Valkyrie", "Defender", "Iron Solari", "Pool Party", "Chroma Pack: Pink", "Chroma Pack: Azure", "Chroma Pack: Lemon", "PROJECT"},
["Lissandra"]    = {"Classic", "Bloodstone", "Blade Queen"},
["Lucian"]       = {"Classic", "Hired Gun", "Striker", "Chroma Pack: Yellow", "Chroma Pack: Red", "Chroma Pack: Blue", "PROJECT"},
["Lulu"]         = {"Classic", "Bittersweet", "Wicked", "Dragon Trainer", "Winter Wonder", "Pool Party"},
["Lux"]          = {"Classic", "Sorceress", "Spellthief", "Commando", "Imperial", "Steel Legion", "Star Guardian"},
  -- M 
["Malphite"]     = {"Classic", "Shamrock", "Coral Reef", "Marble", "Obsidian", "Glacial", "Mecha", "Ironside"},
["Malzahar"]     = {"Classic", "Vizier", "Shadow Prince", "Djinn", "Overlord", "Snow Day"},
["Maokai"]       = {"Classic", "Charred", "Totemic", "Festive", "Haunted", "Goalkeeper"},
["MasterYi"]     = {"Classic", "Assassin", "Chosen", "Ionia", "Samurai Yi", "Headhunter", "Chroma Pack: Gold", "Chroma Pack: Aqua", "Chroma Pack: Crimson", "PROJECT"},
["MissFortune"]  = {"Classic", "Cowgirl", "Waterloo", "Secret Agent", "Candy Cane", "Road Warrior", "Mafia", "Arcade", "Captain"},
["Mordekaiser"]  = {"Classic", "Dragon Knight", "Infernal", "Pentakill", "Lord", "King of Clubs"},
["Morgana"]      = {"Classic", "Exiled", "Sinful Succulence", "Blade Mistress", "Blackthorn", "Ghost Bride", "Victorious", "Chroma Pack: Toxic", "Chroma Pack: Pale", "Chroma Pack: Ebony"},
  -- N 
["Nami"]         = {"Classic", "Koi", "River Spirit", "Urf", "Chroma Pack: Sunbeam", "Chroma Pack: Smoke", "Chroma Pack: Twilight"},
["Nasus"]        = {"Classic", "Galactic", "Pharaoh", "Dreadknight", "Riot K-9", "Infernal", "Archduke", "Chroma Pack: Burn", "Chroma Pack: Blight", "Chroma Pack: Frostbite",},
["Nautilus"]     = {"Classic", "Abyssal", "Subterranean", "AstroNautilus", "Warden"},
["Nidalee"]      = {"Classic", "Snow Bunny", "Leopard", "French Maid", "Pharaoh", "Bewitching", "Headhunter", "Warring Kingdoms"},
["Nocturne"]     = {"Classic", "Frozen Terror", "Void", "Ravager", "Haunting", "Eternum"},
["Nunu"]         = {"Classic", "Sasquatch", "Workshop", "Grungy", "Nunu Bot", "Demolisher", "TPA", "Zombie"},
  -- O 
["Olaf"]         = {"Classic", "Forsaken", "Glacial", "Brolaf", "Pentakill", "Marauder"},
["Orianna"]      = {"Classic", "Gothic", "Sewn Chaos", "Bladecraft", "TPA", "Winter Wonder"},
  -- P 
["Pantheon"]     = {"Classic", "Myrmidon", "Ruthless", "Perseus", "Full Metal", "Glaive Warrior", "Dragonslayer", "Slayer"},
["Poppy"]        = {"Classic", "Noxus", "Lollipoppy", "Blacksmith", "Ragdoll", "Battle Regalia", "Scarlet Hammer"},
  -- Q 
["Quinn"]        = {"Classic", "Phoenix", "Woad Scout", "Corsair"},
  -- R 
["Rammus"]       = {"Classic", "King", "Chrome", "Molten", "Freljord", "Ninja", "Full Metal", "Guardian of the Sands"},
["Reksai"]       = {"Classic", "Eternum", "Pool Party"},
["Renekton"]     = {"Classic", "Galactic", "Outback", "Bloodfury", "Rune Wars", "Scorched Earth", "Pool Party", "Scorched Earth", "Prehistoric"},
["Rengar"]       = {"Classic", "Headhunter", "Night Hunter", "SSW"},
["Riven"]        = {"Classic", "Redeemed", "Crimson Elite", "Battle Bunny", "Championship", "Dragonblade", "Arcade"},
["Rumble"]       = {"Classic", "Rumble in the Jungle", "Bilgerat", "Super Galaxy"},
["Ryze"]         = {"Classic", "Human", "Tribal", "Uncle", "Triumphant", "Professor", "Zombie", "Dark Crystal", "Pirate", "Whitebeard"},
  -- S 
["Sejuani"]      = {"Classic", "Sabretusk", "Darkrider", "Traditional", "Bear Cavalry", "Poro Rider"},
["Shaco"]        = {"Classic", "Mad Hatter", "Royal", "Nutcracko", "Workshop", "Asylum", "Masked", "Wild Card"},
["Shen"]         = {"Classic", "Frozen", "Yellow Jacket", "Surgeon", "Blood Moon", "Warlord", "TPA"},
["Shyvana"]      = {"Classic", "Ironscale", "Boneclaw", "Darkflame", "Ice Drake", "Championship"},
["Singed"]       = {"Classic", "Riot Squad", "Hextech", "Surfer", "Mad Scientist", "Augmented", "Snow Day", "SSW"},
["Sion"]         = {"Classic", "Hextech", "Barbarian", "Lumberjack", "Warmonger"},
["Sivir"]        = {"Classic", "Warrior Princess", "Spectacular", "Huntress", "Bandit", "PAX", "Snowstorm", "Warden", "Victorious"},
["Skarner"]      = {"Classic", "Sandscourge", "Earthrune", "Battlecast Alpha", "Guardian of the Sands"},
["Sona"]         = {"Classic", "Muse", "Pentakill", "Silent Night", "Guqin", "Arcade", "DJ"},
["Soraka"]       = {"Classic", "Dryad", "Divine", "Celestine", "Reaper", "Order of the Banana"},
["Swain"]        = {"Classic", "Northern Front", "Bilgewater", "Tyrant"},
["Syndra"]       = {"Classic", "Justicar", "Atlantean", "Queen of Diamonds"},
  -- T 
["TahmKench"]    = {"Classic", "Master Chef"},
["Talon"]        = {"Classic", "Renegade", "Crimson Elite", "Dragonblade", "SSW"},
["Taric"]        = {"Classic", "Emerald", "Armor of the Fifth Age", "Bloodstone"},
["Teemo"]        = {"Classic", "Happy Elf", "Recon", "Badger", "Astronaut", "Cottontail", "Super", "Panda", "Omega Squad"},
["Thresh"]       = {"Classic", "Deep Terror", "Championship", "Blood Moon", "SSW"},
["Tristana"]     = {"Classic", "Riot Girl", "Earnest Elf", "Firefighter", "Guerilla", "Buccaneer", "Rocket Girl", "Chroma Pack: Navy", "Chroma Pack: Purple", "Chroma Pack: Orange", "Dragon Trainer"},
["Trundle"]      = {"Classic", "Lil' Slugger", "Junkyard", "Traditional", "Constable"},
["Tryndamere"]   = {"Classic", "Highland", "King", "Viking", "Demonblade", "Sultan", "Warring Kingdoms", "Nightmare"},
["TwistedFate"]  = {"Classic", "PAX", "Jack of Hearts", "The Magnificent", "Tango", "High Noon", "Musketeer", "Underworld", "Red Card", "Cutpurse"},
["Twitch"]       = {"Classic", "Kingpin", "Whistler Village", "Medieval", "Gangster", "Vandal", "Pickpocket", "SSW"},
  -- U 
["Udyr"]         = {"Classic", "Black Belt", "Primal", "Spirit Guard", "Definitely Not"},
["Urgot"]        = {"Classic", "Giant Enemy Crabgot", "Butcher", "Battlecast"},
  -- V 
["Varus"]        = {"Classic", "Blight Crystal", "Arclight", "Arctic Ops", "Heartseeker", "Swift t"},
["Vayne"]        = {"Classic", "Vindicator", "Aristocrat", "Dragonslayer", "Heartseeker", "SKT T1", "Arclight", "Chroma Pack: Green", "Chroma Pack: Red", "Chroma Pack: Silver"},
["Veigar"]       = {"Classic", "White Mage", "Curling", "Veigar Greybeard", "Leprechaun", "Baron Von", "Superb Villain", "Bad Santa", "Final Boss"},
["Velkoz"]       = {"Classic", "Battlecast", "Arclight"},
["Vi"]           = {"Classic", "Neon Strike", "Officer", "Debonair", "Demon"},
["Viktor"]       = {"Classic", "Full Machine", "Prototype", "Creator"},
["Vladimir"]     = {"Classic", "Count", "Marquis", "Nosferatu", "Vandal", "Blood Lord", "Soulstealer", "Academy"},
["Volibear"]     = {"Classic", "Thunder Lord", "Northern Storm", "Runeguard", "Captain"},
  -- W 
["Warwick"]      = {"Classic", "Grey", "Urf the Manatee", "Big Bad", "Tundra Hunter", "Feral", "Firefang", "Hyena", "Marauder"},
["MonkeyKing"]   = {"Classic", "Volcanic", "General", "Jade Dragon", "Underworld"},
  -- X 
["Xerath"]       = {"Classic", "Runeborn", "Battlecast", "Scorched Earth", "Guardian of the Sands"},
["XinZhao"]      = {"Classic", "Commando", "Imperial", "Viscero", "Winged Hussar", "Warring Kingdoms", "Secret Agent"},
  -- Y 
["Yasuo"]        = {"Classic", "High Noon", "PROJECT"},
["Yorick"]       = {"Classic", "Undertaker", "Pentakill"},
  -- Z 
["Zac"]          = {"Classic", "Special Weapon", "Pool Party", "Chroma Pack: Orange", "Chroma Pack: Bubblegum", "Chroma Pack: Honey"},
["Zed"]          = {"Classic", "Shockblade", "SKT T1", "PROJECT"},
["Ziggs"]        = {"Classic", "Mad Scientist", "Major", "Pool Party", "Snow Day", "Master Arcanist"},
["Zilean"]       = {"Classic", "Old Saint", "Groovy", "Shurima Desert", "Time Machine", "Blood Moon"},
["Zyra"]         = {"Classic", "Wildfire", "Haunted", "SKT T1"},

}
