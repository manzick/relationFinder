local composer = require( "composer" )
local json = require( "json" )
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view
	--Константы представленные CoronaSDK
	local ACH = display.actualContentHeight
	local ACW = display.actualContentWidth
	local CCX = display.contentCenterX
	local CCY = display.contentCenterY
	--Константы специально для relation finder
	local PORTRAITUP = CCY - ACH/4 - 50
	local PORTRAITDOWN = CCY + ACH/4 + 50
	local LANDSCAPEUP = CCX - ACW/4 - 50
	local LANDSCAPEDOWN = CCX + ACW/4 + 50

	--background--
	local background = display.newImageRect(sceneGroup, "images/bg.png", ACH, ACH )
	background.x, background.y = CCX, CCY
	
	background.fill.effect = "filter.blurGaussian"
	background.fill.effect.horizontal.blurSize = 200
	background.fill.effect.horizontal.sigma = 200
	background.fill.effect.vertical.blurSize = 200
	background.fill.effect.vertical.sigma = 200

	--лого--
	local logo = display.newText(sceneGroup, "Relation \nFinder", CCX, PORTRAITUP, font, 80)
	
	--Кнопка плей
	local playButton = display.newRoundedRect(sceneGroup, CCX - 150, CCY, 200, 200, 10)
	playButton:setFillColor(unpack(BUTTON_COLOR))
	local  playButtonImages = display.newImageRect(sceneGroup, "images/play_button.png", 120, 120)
	playButtonImages.x, playButtonImages.y = CCX - 150, CCY

	--Кнопка рекордов--
	local recordButton = display.newRoundedRect(sceneGroup, CCX + 150, CCY, 200, 200, 10)
	recordButton:setFillColor(unpack(BUTTON_COLOR))
	local  recordButtonImages = display.newImageRect(sceneGroup, "images/play_button.png", 120, 120)
	recordButtonImages.x, recordButtonImages.y = CCX + 150, CCY

	--Титры
	local title = display.newText(sceneGroup, "By Manzick \nFor FNight", CCX, PORTRAITDOWN, font, 80)


	local function onOrientationChange( event )
		--Локальные константы, которые еще и изменяются, чоооо?)
    	local currentOrientation = event.type
    	CCX, CCY = display.contentCenterX, display.contentCenterY
    	ACH, ACW = display.actualContentHeight, display.actualContentWidth
    	PORTRAITUP = CCY - ACH/4 - 50
		PORTRAITDOWN = CCY + ACH/4 + 50
		LANDSCAPEUP = CCX - ACW/4 - 50
		LANDSCAPEDOWN = CCX + ACW/4 + 50

		background.x, background.y = CCX, CCY
		if currentOrientation == "landscapeLeft" or currentOrientation == "landscapeRight" then
			playButton.x, playButton.y = CCX, CCY - 150
			playButtonImages.x, playButtonImages.y = CCX, CCY - 150
			recordButton.x, recordButton.y = CCX, CCY + 150
			recordButtonImages.x, recordButtonImages.y = CCX, CCY + 150
			logo.x, logo.y = LANDSCAPEUP, CCY
			title.x, title.y = LANDSCAPEDOWN, CCY
			print("боком")
		end
		if currentOrientation == "portrait" or currentOrientation == "portraitUpsideDown" then
			playButton.x, playButton.y = CCX - 150, CCY
			playButtonImages.x, playButtonImages.y = CCX - 150, CCY
			recordButton.x, recordButton.y = CCX + 150, CCY
			recordButtonImages.x, recordButtonImages.y = CCX + 150, CCY
			logo.x, logo.y = CCX, PORTRAITUP
			title.x, title.y = CCX, PORTRAITDOWN
			print("вертикально")
		end

	end
  
	Runtime:addEventListener( "orientation", onOrientationChange )
	
	local function go_to_store()
		if (sound_on) then audio.play(click_sound) end 
		go_to_scene("scene.store","fromRight")
		
	end

		
	--Затемнение
	--local glass = display.newImageRect(sceneGroup, "images/glass.png", display.actualContentWidth, display.actualContentWidth*2 )
	--glass.x, glass.y = display.contentCenterX, display.contentCenterY

	

end

function scene:destroy(event)
	local sceneGroup = self.view
	display.remove(sceneGroup)
	sceneGroup = nil
end

scene:addEventListener("create", scene)
scene:addEventListener("destroy", scene)

return scene
