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
=======PONY QUIZ========
====COPYRIGHT FNIGHT====
========================
]]--

local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()




function scene:create(event)

	local sceneGroup = self.view
	local background = display.newImageRect(sceneGroup, "images/bg_second.png", display.actualContentWidth, display.actualContentWidth*2 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local level_hint = display.newText(sceneGroup, lang.level_hint.."("..baseTable.hints..")", display.contentCenterX, display.contentCenterY - display.contentCenterY*0.83, font, 70)
	level_hint:setFillColor(black)
	
	Hint_Activate = false
	Hint_Type = ""


	

	local Button_color = {}
	if (baseTable.hints > 0) then Button_color = {199/255, 171/255, 251/255} else Button_color = {109/255, 109/255, 109/255} end
	
	local function Show_50_func()
		if (baseTable.hints > 0) then
			Hint_Activate = true
			Hint_Type = "Show_50"
			if (sound_on) then audio.play(click_sound) end 
			go_to_scene("scene.level","fromLeft")
		end
	end
	local Show_50 = display.newRoundedRect(sceneGroup, display.contentCenterX, display.contentCenterY - 300, 650, 190, 10)
	Show_50:setFillColor(unpack(Button_color))
	Show_50_text = display.newText(sceneGroup, lang.hint_show_50, display.contentCenterX, display.contentCenterY - 300, font, 65)
	Show_50_text:setFillColor(black)
	Show_50:addEventListener("tap", Show_50_func)


	local function Show_random_letters_func()
		if (baseTable.hints > 0) then
			Hint_Activate = true
			Hint_Type = "Show_random_letters"
			if (sound_on) then audio.play(click_sound) end 
			go_to_scene("scene.level","fromLeft")
		end
	end
	local Show_random_letters = display.newRoundedRect(sceneGroup, display.contentCenterX, display.contentCenterY - 50, 650, 190, 10)
	Show_random_letters:setFillColor(unpack(Button_color))
	Show_random_letters_text = display.newText(sceneGroup, (math.round(table.maxn(cur_level.answer) / 2))..lang.hint_random_letters, display.contentCenterX, display.contentCenterY - 50, font, 65)
	Show_random_letters_text:setFillColor(black)
	Show_random_letters:addEventListener("tap", Show_random_letters_func)

	local function Delete_incorrect_func()
		if (baseTable.hints > 0) then
			Hint_Activate = true
			Hint_Type = "Delete_incorrect"
			if (sound_on) then audio.play(click_sound) end 
			go_to_scene("scene.level","fromLeft")
		end
	end
	local Delete_incorrect = display.newRoundedRect(sceneGroup, display.contentCenterX, display.contentCenterY + 200, 650, 190, 10)
	Delete_incorrect:setFillColor(unpack(Button_color))
	Delete_incorrect_text = display.newText(sceneGroup, lang.hint_delete_incorrect, display.contentCenterX, display.contentCenterY + 200, font, 65)
	Delete_incorrect_text:setFillColor(black)
	Delete_incorrect:addEventListener("tap", Delete_incorrect_func)

	
	--[[network_connection = false
	--Красивый пинг google--
	local socket = require("socket")
    local test = socket.tcp()
    test:settimeout(1000)  -- Set timeout to 1 second
    local netConn = test:connect("www.google.com", 80)
    if netConn == nil then
        network_connection = false
        print("false")
    else
    	network_connection = true
    	print("true")
    end
    test:close()
    

	if network_connection then Button_color = {126/255, 194/255, 255/255} print("true") else Button_color = {109/255, 109/255, 109/255} print("false") end

	local function Get_hints_func()
		if network_connection then
			--что-то сюда
		end
	end

	local Get_hints = display.newRoundedRect(sceneGroup, display.contentCenterX, display.contentCenterY + 450, 650, 190, 10)
	Get_hints:setFillColor(unpack(Button_color))
	Get_hints_text = display.newText(sceneGroup, lang.hint_get_hints, display.contentCenterX, display.contentCenterY + 450, font, 65)
	Get_hints_text:setFillColor(black)
	Get_hints:addEventListener("tap", Get_hints_func)]]

	

	local button_back = display.newImageRect(sceneGroup, "images/back.png", 50, 94)
	button_back.x = - (display.actualContentWidth - 720)/2 + 60
	button_back.y = button_back.height

	local go_start = function() if (sound_on) then audio.play(click_sound) end go_to_scene("scene.level","fromLeft") end
	button_back:addEventListener("tap", go_start)
	
end

function scene:destroy(event)
	local sceneGroup = self.view
	display.remove(sceneGroup)
	sceneGroup = nil
end

scene:addEventListener("create", scene)
scene:addEventListener("destroy", scene )

return scene
