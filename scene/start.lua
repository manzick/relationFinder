local composer = require( "composer" )
local json = require( "json" )
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view
	--Всякие переменные
	local score = false
	local currentOrientation = "portrait"
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
	local background = display.newImageRect( sceneGroup, "images/bg.png", ACH, ACH )
	background.x, background.y = CCX, CCY
	background.fill.effect = "filter.blurGaussian"
	background.fill.effect.horizontal.blurSize = 200
	background.fill.effect.horizontal.sigma = 200
	background.fill.effect.vertical.blurSize = 200
	background.fill.effect.vertical.sigma = 200

	--лого--
	local logo = display.newText(sceneGroup, "Relation \nFinder", CCX, PORTRAITUP, font, 80)
	
	--Кнопка плей
	--local playButton = display.newRoundedRect(sceneGroup, CCX - 150, CCY, 200, 200, 10)
	--playButton:setFillColor(unpack(BUTTON_COLOR))
	local  playButtonImages = display.newImageRect(sceneGroup, "images/play_button.png", 120, 120)
	playButtonImages.x, playButtonImages.y = CCX - 150, CCY

	--Кнопка рекордов--
	--local recordButton = display.newRoundedRect(sceneGroup, CCX + 150, CCY, 200, 200, 10)
	--recordButton:setFillColor(unpack(BUTTON_COLOR))
	local  recordButtonImages = display.newImageRect(sceneGroup, "images/best_button.png", 120, 120)
	recordButtonImages.x, recordButtonImages.y = CCX + 150, CCY

	--Титры
	local title = display.newText(sceneGroup, "By Manzick \nFor FNight", CCX, PORTRAITDOWN, font, 80)

	local function getDarkGlass()
		score = true
		display.save( sceneGroup, "temp.png", system.DocumentsDirectory )
		local glass = display.newImage(sceneGroup, "temp.png", system.DocumentsDirectory )
		glass.height, glass.weight = ACH, ACW
		glass.x, glass.y = CCX, CCY
		glass.fill.effect = "filter.blurGaussian"
		glass.fill.effect.horizontal.blurSize = 200
		glass.fill.effect.horizontal.sigma = 200
		glass.fill.effect.vertical.blurSize = 200
		glass.fill.effect.vertical.sigma = 200

		local closeButton = display.newImageRect(sceneGroup, "images/close.png", 100, 100)
		if currentOrientation == "landscapeLeft" or currentOrientation == "landscapeRight" then
			closeButton.x, closeButton.y = CCX, CCY + 250
		end
		if currentOrientation == "portrait" or currentOrientation == "portraitUpsideDown" then
			closeButton.x, closeButton.y = CCX, CCY + 450
		end 
		
		
		local titleScore = display.newText(sceneGroup, lang.titleScore, CCX, PORTRAITUP, font, 80)
		local scoreNote = display.newText(sceneGroup, baseTable.record, CCX, CCY, font, 80)

		local function breakGlass() 
			glass:removeSelf()
			closeButton:removeSelf()
			titleScore:removeSelf()
			scoreNote:removeSelf()
			score = false
		end
		local function rotateGlass()
			if glass.height then
				glass:removeSelf()
				closeButton:removeSelf()
				titleScore:removeSelf()
				scoreNote:removeSelf()
			end
			

		end
		glass:addEventListener("tap", breakGlass)
		closeButton:addEventListener("tap", breakGlass)
		Runtime:addEventListener( "orientation", rotateGlass )

	end
	
	local function onOrientationChange( event )
		--Локальные константы, которые еще и изменяются, чоооо?)
    	currentOrientation = event.type
    	CCX, CCY = display.contentCenterX, display.contentCenterY
    	ACH, ACW = display.actualContentHeight, display.actualContentWidth
    	PORTRAITUP = CCY - ACH/4 - 50
		PORTRAITDOWN = CCY + ACH/4 + 50
		LANDSCAPEUP = CCX - ACW/4 - 50
		LANDSCAPEDOWN = CCX + ACW/4 + 50

		background.x, background.y = CCX, CCY
		if currentOrientation == "landscapeLeft" or currentOrientation == "landscapeRight" then
			--playButton.x, playButton.y = CCX, CCY - 150
			playButtonImages.x, playButtonImages.y = CCX, CCY - 150
			--recordButton.x, recordButton.y = CCX, CCY + 150
			recordButtonImages.x, recordButtonImages.y = CCX, CCY + 150
			print( "боком" )
		end
		if currentOrientation == "landscapeRight" then
			logo.x, logo.y = LANDSCAPEUP, CCY
			title.x, title.y = LANDSCAPEDOWN, CCY
		end
		if currentOrientation == "landscapeLeft" then
			logo.x, logo.y = LANDSCAPEDOWN, CCY
			title.x, title.y = LANDSCAPEUP, CCY
		end
		if currentOrientation == "portrait" or currentOrientation == "portraitUpsideDown" then
			--playButton.x, playButton.y = CCX - 150, CCY
			playButtonImages.x, playButtonImages.y = CCX - 150, CCY
			--recordButton.x, recordButton.y = CCX + 150, CCY
			recordButtonImages.x, recordButtonImages.y = CCX + 150, CCY
			logo.x, logo.y = CCX, PORTRAITUP
			title.x, title.y = CCX, PORTRAITDOWN
			print( "вертикально" )
		end
		score = false
	end

	local function goToGame()
		go_to_scene("scene.game","fromRight")
	end


  
	Runtime:addEventListener( "orientation", onOrientationChange )
	--playButton:addEventListener("tap", goToGame)
	playButtonImages:addEventListener("tap", goToGame)
	--recordButton:addEventListener("tap", getDarkGlass)
	recordButtonImages:addEventListener("tap", getDarkGlass)
		
	--Затемнение
	--local glass = display.newImageRect(sceneGroup, "images/glass.png", ACW, ACW*2 )
	--glass.x, glass.y = CCX, CCY

	

end

function scene:destroy(event)
	local sceneGroup = self.view
	display.remove(sceneGroup)
	sceneGroup = nil
end

scene:addEventListener("create", scene)
scene:addEventListener("destroy", scene)

return scene
