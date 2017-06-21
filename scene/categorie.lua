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
local ponies = require("ponies")

cur_level = {}

function scene:create(event)

	local sceneGroup = self.view

	local background = display.newImageRect(sceneGroup, "images/bg_second.png", display.actualContentWidth, display.actualContentWidth*2 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local x = {display.contentCenterX - display.contentCenterX/1.5, display.contentCenterX, display.contentCenterX + display.contentCenterX/1.5}
	local y = display.contentCenterY - display.contentCenterY*0.5

	local head_shape = display.newRect(display.contentCenterX, 80, display.actualContentWidth, 180 )
	head_shape.alpha = 0

	local I_need_this_shit_for_kosyile = display.newText(sceneGroup, "", x[1], y)

	local function scrollActive()
		local xAbsPos, yAbsPos = I_need_this_shit_for_kosyile:localToContent(0,0)
		if (yAbsPos < I_need_this_shit_for_kosyile.y) then
			head_shape.alpha = math.abs((yAbsPos-I_need_this_shit_for_kosyile.y)/100)
		else 
			head_shape.alpha = 0
		end
	end

	local scrollView = widget.newScrollView
	{
		left = 0,
		top = 0,
		width = display.contentWidth,
		height = display.contentHeight,
		horizontalScrollDisabled = true,
		verticalScrollDisabled = false,
		hideBackground = true,
		hideScrollBar = true,
		listener = scrollActive,
	}

	scrollView:insert(I_need_this_shit_for_kosyile)

	local function go_level(event)
			if (baseTable.levels[tonumber(event.target[2].text)]) then
				if (sound_on) then audio.play(click_sound) end
					cur_level = ponies_list[tonumber(event.target[2].text)]
					go_to_scene("scene.level","fromRight")
			end
	end

	

	for i = 0, table.maxn(ponies_list) - 1 do
		local temp = display.newRoundedRect(sceneGroup, 0, 0, 228, 228, 10) 
		local temp_text = display.newText(sceneGroup, i + 1, 0, 0, font, 150)
		local temp_lock = display.newImageRect(sceneGroup, "images/locked.png", 150, 150)
		local temp_g = display.newGroup()
		temp_g:insert(temp)
		temp_g:insert(temp_text)
		temp_g:insert(temp_lock)
		temp.x, temp.y = x[i % 3 + 1], y + 240 * math.floor(i / 3)
		temp_lock.x, temp_lock.y = temp.x, temp.y
		temp_text.x, temp_text.y = temp.x, temp.y
		temp_text:setFillColor(0, 0, 0)
		if (baseTable.levels[i + 1] == 0) then
			temp:setFillColor(199/255, 171/255, 251/255)
			temp_lock:removeSelf()
		elseif (baseTable.levels[i + 1] == 1) then
			temp:setFillColor(255/255, 165/255, 0/255)
			temp_lock:removeSelf()
		else
			temp:setFillColor(150/255, 150/255, 150/255)
			temp_text:removeSelf()
		end
		scrollView:insert(temp_g)
		print(i.." "..x[i % 3 + 1].." "..y * (math.floor(i / 3) + 1))
		temp_g:addEventListener("tap", go_level)
	end
	
	sceneGroup:insert(scrollView)
	sceneGroup:insert(head_shape)

	

	--Заголовок--
	local categorie_name = display.newText(sceneGroup, lang.ponies, display.contentCenterX, display.contentCenterY - display.contentCenterY*0.83, font, 70)
	categorie_name:setFillColor(black)

	--Кнопка назад--
	local function go_categories() if (sound_on) then audio.play(click_sound) end go_to_scene("scene.start","fromLeft") end
	local button_back = display.newImageRect(sceneGroup, "images/back.png", 50, 94)
	button_back.x = - (display.actualContentWidth - 720)/2 + 60
	button_back.y = button_back.height
	button_back:addEventListener("tap", go_categories)
end

function scene:destroy(event)
	local sceneGroup = self.view
	display.remove(sceneGroup)
	sceneGroup = nil
end

scene:addEventListener("create", scene)
scene:addEventListener("destroy", scene )

return scene
