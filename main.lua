local composer = require("composer")
local json = require("json")
local scene = composer.newScene()
local locale = require("locale")
local color = require("color")
ads = require("ads")

baseTable = {}

filePath = system.pathForFile("base.json", system.DocumentsDirectory)

BUTTON_COLOR = {93/255, 93/255, 93/255}


function loadBase()
	local file = io.open(filePath, "r")

	if file then
		local contents = file:read("*a")
		io.close(file)
		baseTable = json.decode(contents)
	end

	if (not(baseTable.record)) then
		baseTable = { 
		["record"] = "0",
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



font = "Avenir_Next.ttc"

if (system.getPreference( "locale", "language" ) == "ru") then
	lang = rus
else
	lang = eng
end


function go_to_scene(set_scene,set_effect)
	composer.removeScene(set_scene)
	composer.gotoScene(set_scene, {time = 300, effect=set_effect})
end

function change_lang()
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

--Кнопки назад для андроида
--[[local function onKeyEvent(event)
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
Runtime:addEventListener("key", onKeyEvent)]]

splash = display.newImageRect("images/splash.gif", display.contentWidth, display.contentHeight)
splash.x, splash.y = display.contentCenterX, display.contentCenterY
splash.alpha = 0
transition.to(splash,{time = 0, alpha = 1,onComplete = goGame})
--splash если бы он был нужен
--[[if (system.getInfo( "environment" ) == "simulator") then
	transition.to(splash,{time = 0, alpha = 1, onComplete = goGame})
else 
	transition.to(splash,{time = 2500, alpha = 1, onComplete = goGame})
end]]
