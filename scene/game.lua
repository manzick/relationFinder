local composer = require( "composer" )
local json = require( "json" )
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view
	local cardsGroup = display.newGroup()
	local cardsGreyGroup = display.newGroup()
	--Константы представленные CoronaSDK
	local ACH = display.actualContentHeight
	local ACW = display.actualContentWidth
	local CCX = display.contentCenterX
	local CCY = display.contentCenterY
	--Константы специально для relation finder
	local PORTRAITUP = CCY - ACH/4 - 150
	local PORTRAITDOWN = CCY + ACH/4 + 150
	local LANDSCAPEUP = CCX - ACW/4 - 150
	local LANDSCAPEDOWN = CCX + ACW/4 + 150

	--background--
	local background = display.newImageRect( sceneGroup, "images/bg.png", ACH, ACH )
	background.x, background.y = CCX, CCY
	
	background.fill.effect = "filter.blurGaussian"
	background.fill.effect.horizontal.blurSize = 200
	background.fill.effect.horizontal.sigma = 200
	background.fill.effect.vertical.blurSize = 200
	background.fill.effect.vertical.sigma = 200

	--score--
	local score = display.newText(sceneGroup, "0", CCX, PORTRAITUP, font, 80)

	--cards--
	local zeroX = CCX - 15 - 76 - 30 - 76 - 30 - 76 + 38
	local zeroY = CCY - 15 - 76 - 30 - 76 - 30 - 76 + 38
	local y = 0
	for i = 0, 35 do
		local j = i % 6
		print(j)
		print(i / 36)
		local card = display.newRoundedRect(cardsGroup, zeroX + 106 * j, zeroY + 106 * y, 90, 90, 10)
		--card:setFillColor(unpack(BUTTON_COLOR))
		
		if j == 5 then y = y + 1 end
		cardsGroup:insert( card )
	end
	sceneGroup:insert( cardsGroup )




	function getGrayCard() 
		local y = 0
		for i = 0, 35 do
			local j = i % 6
			print(j)
			print(i / 36)
			local card = display.newRoundedRect(cardsGreyGroup, zeroX + 106 * j, zeroY + 106 * y, 300, 300, 10)
			card:setFillColor(unpack(BUTTON_COLOR))
			transition.to( card, { time=500, method=resize, width = 90, height = 90 } )
			if j == 5 then y = y + 1 end
			--cardsGreyGroup:insert( card )
			--sceneGroup:insert( card )
		end
		sceneGroup:insert( cardsGreyGroup )
	end


	timer.performWithDelay( 2000, getGrayCard )

	--pause button--
	local  pauseButtonImages = display.newImageRect(sceneGroup, "images/pause_button.png", 120, 120)
	pauseButtonImages.x, pauseButtonImages.y = CCX, PORTRAITDOWN
	

	




	local function getPauseGlass()
		score = true
		display.save( sceneGroup, "temp.png", system.DocumentsDirectory )
		local glass = display.newImage(sceneGroup, "temp.png", system.DocumentsDirectory )
		glass.height, glass.weight = ACH, ACW
		glass.x, glass.y = CCX, CCY
		glass.fill.effect = "filter.blurGaussian"
		glass.fill.effect.horizontal.blurSize = 512
		glass.fill.effect.horizontal.sigma = 512
		glass.fill.effect.vertical.blurSize = 512
		glass.fill.effect.vertical.sigma = 512


		--[[local closeButton = display.newImageRect(sceneGroup, "images/close.png", 100, 100)
		if currentOrientation == "landscapeLeft" or currentOrientation == "landscapeRight" then
			closeButton.x, closeButton.y = CCX, CCY + 250
		end
		if currentOrientation == "portrait" or currentOrientation == "portraitUpsideDown" then
			closeButton.x, closeButton.y = CCX, CCY + 450
		end ]]
		
		
		--local titleScore = display.newText(sceneGroup, lang.titleScore, CCX, PORTRAITUP, font, 80)
		--local textPauseNoteBG = display.newRoundedRect(sceneGroup, CCX, CCY, 670, 220, 10)
		--textPauseNoteBG:setFillColor(unpack(BUTTON_COLOR))
		local textPauseNote = display.newText(sceneGroup, lang.textPause, CCX, CCY, font, 40)

		local function breakGlass() 
			glass:removeSelf()
			closeButton:removeSelf()
			titleScore:removeSelf()
			textPauseNote:removeSelf()
			score = false
		end
		local function rotateGlass()
			if glass.height then
				glass:removeSelf()
				closeButton:removeSelf()
				titleScore:removeSelf()
				textPauseNote:removeSelf()
			end
			

		end
		glass:addEventListener("tap", breakGlass)
		--closeButton:addEventListener("tap", breakGlass)
		Runtime:addEventListener( "orientation", rotateGlass )

	end	


	local function onOrientationChange( event )
		--Локальные константы, которые еще и изменяются, чоооо?)
    	local currentOrientation = event.type
    	CCX, CCY = display.contentCenterX, display.contentCenterY
    	ACH, ACW = display.actualContentHeight, display.actualContentWidth
    	PORTRAITUP = CCY - ACH/4 - 150
		PORTRAITDOWN = CCY + ACH/4 + 150
		LANDSCAPEUP = CCX - ACW/4 - 150
		LANDSCAPEDOWN = CCX + ACW/4 + 150
		zeroX = CCX - 15 - 76 - 30 - 76 - 30 - 76 + 38
		zeroY = CCY - 15 - 76 - 30 - 76 - 30 - 76 + 38
		local y = 0

		background.x, background.y = CCX, CCY
		for i = 1, 36 do
			local j = (i - 1) % 6
			cardsGroup[i].x = zeroX + 106 * j
			cardsGroup[i].y = zeroY + 106 * y
			if j == 5 then y = y + 1 end
		end
		if currentOrientation == "landscapeRight" then
			score.x, score.y = LANDSCAPEUP, CCY
			pauseButtonImages.x, pauseButtonImages.y = LANDSCAPEDOWN, CCY

			
			print( "боком" )
		end
		if currentOrientation == "landscapeLeft" then
			score.x, score.y = LANDSCAPEDOWN, CCY
			pauseButtonImages.x, pauseButtonImages.y = LANDSCAPEUP, CCY

			
			print( "боком" )
		end
		if currentOrientation == "portrait" or currentOrientation == "portraitUpsideDown" then
			score.x, score.y = CCX, PORTRAITUP
			pauseButtonImages.x, pauseButtonImages.y = CCX, PORTRAITDOWN

			
			print( "вертикально" )
		end
	end

	
  
	Runtime:addEventListener( "orientation", onOrientationChange )
	pauseButtonImages:addEventListener("tap", getPauseGlass)
	


		
	

end

function scene:destroy(event)
	local sceneGroup = self.view
	display.remove(sceneGroup)
	display.remove(cardsGroup)
	display.remove(cardsGreyGroup)
	sceneGroup = nil
end

scene:addEventListener("create", scene)
scene:addEventListener("destroy", scene)

return scene
