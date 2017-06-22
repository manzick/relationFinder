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
local json = require( "json" )
local scene = composer.newScene()



function scene:create(event)

	local sceneGroup = self.view

	--background--
	local background = display.newImageRect(sceneGroup, "images/bg_second.png", display.actualContentWidth, display.actualContentWidth*2 )
	background.x, background.y = display.contentCenterX, display.contentCenterY
	background.fill.effect = "filter.blurGaussian"
 
	background.fill.effect.horizontal.blurSize = 200
	background.fill.effect.horizontal.sigma = 200
	background.fill.effect.vertical.blurSize = 200
	background.fill.effect.vertical.sigma = 200

	--лого--
	local logo = display.newText(sceneGroup, "Relation \nFinder", display.contentCenterX, display.contentCenterY  - display.actualContentHeight/4 - 50, font, 80)
	

	local playButton = display.newRoundedRect(sceneGroup, display.contentCenterX - 150, display.contentCenterY, 200, 200, 10)
	playButton:setFillColor(unpack(BUTTON_COLOR))
	local  playButtonImages = display.newImageRect(sceneGroup, "images/play_button.png", 120, 120)
	playButtonImages.x, playButtonImages.y = display.contentCenterX - 150, display.contentCenterY

	local recordButton = display.newRoundedRect(sceneGroup, display.contentCenterX + 150, display.contentCenterY, 200, 200, 10)
	recordButton:setFillColor(unpack(BUTTON_COLOR))
	local  recordButtonImages = display.newImageRect(sceneGroup, "images/play_button.png", 120, 120)
	recordButtonImages.x, recordButtonImages.y = display.contentCenterX + 150, display.contentCenterY

	--Титры
	local logo = display.newText(sceneGroup, "By Manzick \nFor FNight", display.contentCenterX, display.contentCenterY + display.actualContentHeight/4 + 50, font, 80)



	print("jj")
	--print(display.actualContentHeight)
	local function onOrientationChange( event )
    	local currentOrientation = event.type
    	print( "Current orientation: " .. currentOrientation )
		print(display.actualContentHeight)

		background.x, background.y = display.contentCenterX, display.contentCenterY


	end
  
	Runtime:addEventListener( "orientation", onOrientationChange )
	

	--Затемнение
	--local glass = display.newImageRect(sceneGroup, "images/glass.png", display.actualContentWidth, display.actualContentWidth*2 )
	--glass.x, glass.y = display.contentCenterX, display.contentCenterY
	
	

	

	
	

	local function go_to_store()
		if (sound_on) then audio.play(click_sound) end 
		go_to_scene("scene.store","fromRight")
		
	end

	


		
	

	

end

function scene:destroy(event)
	local sceneGroup = self.view
	display.remove(sceneGroup)
	sceneGroup = nil
end

scene:addEventListener("create", scene)
scene:addEventListener("destroy", scene)

return scene
