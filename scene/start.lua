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

	local sheetOption = 
	{
		width = 160,
		height = 160,
		numFrames = 4,
		sheetContentWidth = 320,
		sheetContentHeight = 320
	}

	local iconSheet = graphics.newImageSheet( "images/pic_sheet.png", sheetOption)
	local sequenceData = {
		name = "icons",
		start = 1,
		count = 4,
	}

	--background--
	local background = display.newImageRect(sceneGroup, "images/bg_second.png", display.actualContentWidth, display.actualContentWidth*2 )
	background.x, background.y = display.contentCenterX, display.contentCenterY
	background.fill.effect = "filter.blurGaussian"
 
	background.fill.effect.horizontal.blurSize = 20
	background.fill.effect.horizontal.sigma = 200
	background.fill.effect.vertical.blurSize = 20
	background.fill.effect.vertical.sigma = 140

	--лого--
	local  logo = display.newImageRect(sceneGroup, "images/logo.png", 510, 300)
	logo.x, logo.y = display.contentCenterX, display.contentCenterY - display.contentCenterY*0.7

	local color =  {
    	highlight = { r=1, g=1, b=1 },
    	shadow = { r=0.3, g=0.3, b=0.3 }
	}
	

	local playButton = display.newRoundedRect(sceneGroup, display.contentCenterX, display.contentCenterY, 200, 200, 10)
	playButton:setFillColor(unpack(BUTTON_COLOR))

	local Button_color =  {199/255, 171/255, 251/255} 
	playButton:setStrokeColor( unpack(Button_color) )
	--playButton:setEmbossColor( color )
	
	

	

	
	

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
