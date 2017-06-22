--[[
========================
=====OOOOOO=O=====O=====
=====O======OO====O=====
=====O======O=O===O=====
=====OOO====O=====O=====
=====O======O===O=O=====
=====O======O====OO=====
=====O======O=====O=====
========================
=====OOOOOOOOOOOOOO=====
========================
========PONY QUIZ=======
====COPYRIGHT FNIGHT====
========================
]]--

local composer = require("composer")
local json = require("json")
local scene = composer.newScene()
local locale = require("locale")
local ponies = require("ponies")
ads = require("ads")

baseTable = {}

filePath = system.pathForFile("base.json", system.DocumentsDirectory)

try_game_lvl = 0

BUTTON_COLOR = {93/255, 93/255, 93/255}


function loadBase()
	local file = io.open(filePath, "r")

	if file then
		local contents = file:read("*a")
		io.close(file)
		baseTable = json.decode(contents)
	end

	if (not(baseTable.levels)) then
		baseTable = {
		["levels"] = {0,0,0,0,0}, 
		["sound"] = true,
		["sound2"] = true, --ads_on
		["music"] = true,
		["complete_levels"] = 0,
		["hints"] = 3,
		["rate"] = false,
		}
	end
end

function saveBase()
	for i = #baseTable, 11, -1 do
        table.remove( baseTable, i )
    end

    local file = io.open( filePath, "w" )

    if file then
        file:write( json.encode( baseTable ) )
        io.close( file )
    end
end

loadBase()

--sound_on = baseTable.sound
--music_on = baseTable.music
--ads_on = baseTable.sound2
--click_sound = audio.loadSound("sound/click_sound.mp3") --Необходимо доработать систему звуков
--background_music = audio.loadStream("sound/background_music.mp3")
--backgroundMusicChannel = audio.play(background_music, {channel = 3, loops = -1})
--[[if (music_on) then
	audio.resume(backgroundMusicChannel) 
else 
	audio.pause(backgroundMusicChannel) 
end
audio.setVolume(0.2)]]

font = "Avenir_Next.ttc"

if (system.getPreference( "locale", "language" ) == "ru") then
	lang = rus
else
	lang = eng
end

--[[function change_music()
	if (music_on) then
		music_on = false
		if (sound_on) then audio.play(click_sound) end
		music:setFrame(4)
		audio.pause(backgroundMusicChannel)
	else
		music_on = true
		if (sound_on) then audio.play(click_sound) end
		music:setFrame(3)
		audio.resume(backgroundMusicChannel)
	end
	baseTable.music = music_on
	saveBase()
end

function change_sound()
	if (sound_on) then
		sound_on = false
		sound:setFrame(1)
	else
		sound_on = true
		sound:setFrame(2)
		audio.play(click_sound)
	end
	baseTable.sound = sound_on
	saveBase()
end]]

function go_to_scene(set_scene,set_effect)
	composer.removeScene(set_scene)
	composer.gotoScene(set_scene, {time = 300, effect=set_effect})
end

go_exit = function() if (sound_on) then audio.play(click_sound) end  native.requestExit() end

function change_lang()
	if (sound_on) then 
			local audioChanell = audio.play(click_sound) 
		end 
	if (lang == rus) then
		lang = eng
		go_to_scene("scene.start","fromBottom")
	else
		lang = rus
		go_to_scene("scene.start","fromBottom")
	end
end

function goGame()
	display.remove(splash)
	composer.gotoScene("scene.start", { time=300, effect="fromBottom" } )
end

local function onKeyEvent(event)
		if(event.phase == "up" and event.keyName == "back") then
			local cur_scene = composer.getSceneName( "current" )
			if (cur_scene == "scene.categorie"  or  cur_scene == "scene.store") then go_to_scene("scene.start","fromLeft")
			elseif (cur_scene == "scene.garage") then go_to_scene("scene.categories_garage","fromLeft")
			elseif (cur_scene == "scene.level_hint") then go_to_scene("scene.level","fromLeft")
			elseif (cur_scene == "scene.level") then if (answerGroup_try[1]) then save_letters_in_base() end ads.hide() go_to_scene("scene.categorie","fromLeft")
			else print("Это не работает") 
			end
			return true
		else 
			return false
		end
		
	end

Runtime:addEventListener("key", onKeyEvent)

splash = display.newImageRect("images/splash.gif", display.contentWidth, display.contentHeight)
splash.x, splash.y = display.contentCenterX, display.contentCenterY
splash.alpha = 0
--transition.to(splash,{time = 0, alpha = 1,onComplete = go_game})
if (system.getInfo( "environment" ) == "simulator") then
	transition.to(splash,{time = 0, alpha = 1, onComplete = goGame})
else 
	transition.to(splash,{time = 2500, alpha = 1, onComplete = goGame})
end
