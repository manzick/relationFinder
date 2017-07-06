local composer = require( "composer" )
local json = require( "json" )
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view
	local cardsGroup = display.newGroup()
	local cardsGreyGroup = display.newGroup()
	local color = {}
	local colorBegin = { 
 		0, 0, 0, 0, 0, 0, 
  		0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 
	}
	--Игровые переменные
	local score = 0
	local heart = "00:00"
	--Константы представленные CoronaSDK
	local ACH = display.actualContentHeight
	local ACW = display.actualContentWidth
	local CCX = display.contentCenterX
	local CCY = display.contentCenterY
	--Константы специально для relation finder
	local PORTRAITUP = CCY - ACH/4 - 100
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
	local timerText = display.newText(sceneGroup, heart, CCX, PORTRAITUP - 100, font, 50)
	local scoreText = display.newText(sceneGroup, score, CCX, PORTRAITUP, font, 100)

	print("Today")
	print(math.abs(31 - 63))
	--Create color array--
	for i = 1, 18 do
		local one = math.random(1, 255)
		local two = math.random(1, 255)
		local tree = math.random(1, 255)
		--local tempSTR = "color1:  " .. one .. " " .. two .. " " .. tree
		--print(tempSTR)
		--local notDone = true
		
		
		for j = 1, #color do
			print("beliver: "..j)
			--if notDone then 
			local tempSTR = "colorPro:  " .. math.abs(color[j][1] - one) .. " " .. math.abs(color[j][2] - two) .. " " .. math.abs(color[j][3] - tree)
			--print(tempSTR)
			if 	(math.abs(color[j][1] - one) < 50 and math.abs(color[j][2] - two) < 50) then 		
					one = math.random(1, 255)
					two = math.random(1, 255)
			end	
			if 	(math.abs(color[j][3] - tree) < 50 and math.abs(color[j][2] - two) < 50) then 		
					two = math.random(1, 255)
					tree = math.random(1, 255)
			end	
			if 	(math.abs(color[j][1] - one) < 50 and math.abs(color[j][3] - tree) < 50) then 		
					one = math.random(1, 255)
					tree = math.random(1, 255)
			end	
			if 	math.abs(color[j][1] - one) < 50 and math.abs(color[j][2] - two) < 50 and math.abs(color[j][3] - tree) < 50 then 		
					one = math.random(1, 255)
					two = math.random(1, 255)
					tree = math.random(1, 255)
			end	
			
		end
		
		
		local tempSTR = "color2:  " .. one .. " " .. two .. " " .. tree
		print(tempSTR)

		local tempColor = { one, two, tree }
		--local tempColor = { math.random(1, 255)/255, math.random(1, 255)/255, math.random(1, 255)/255 }
		color[#color + 1] = tempColor
	end


	--cards--
	local zeroX = CCX - 15 - 76 - 30 - 76 - 30 - 76 + 38
	local zeroY = CCY - 15 - 76 - 30 - 76 - 30 - 76 + 38
	local y = 0
	for i = 0, 35 do
		local j = i % 6
		local card = display.newRoundedRect(zeroX + 106 * j, zeroY + 106 * y, 90, 90, 10)

		local randomNumber = math.random(1, 18)
		while colorBegin[randomNumber] == 2 do
			randomNumber = math.random(1, 18)
		end
		colorBegin[randomNumber] = colorBegin[randomNumber] + 1
		card:setFillColor( color[randomNumber][1]/255, color[randomNumber][2]/255, color[randomNumber][3]/255 )
		if j == 5 then y = y + 1 end
		cardsGroup:insert( card )
	end
	sceneGroup:insert( cardsGroup )

	--greyCards--
	local y = 0
	for i = 0, 35 do
		local j = i % 6
		local grayCard = display.newRoundedRect(zeroX + 106 * j, zeroY + 106 * y, 300, 300, 10)
		grayCard:setFillColor(unpack(BUTTON_COLOR))
		grayCard.isVisible = false
		--transition.to( grayCard, { time=500, method=resize, width = 90, height = 90 } )
		if j == 5 then y = y + 1 end
		cardsGreyGroup:insert( grayCard )
		
	end
	sceneGroup:insert( cardsGreyGroup )




	local function getGrayCard()
			--cardsGreyGroup[1].isVisible = true

		for i = 1, 36 do
			cardsGreyGroup[i].isVisible = true
			transition.to( cardsGreyGroup[i], { time=500, method=resize, width = 90, height = 90 } )
		end 
		
	end


	timer.performWithDelay( 2000, getGrayCard )
		--sceneGroup:insert( cardsGreyGroup )


	--pause button--
	local  pauseButtonImages = display.newImageRect(sceneGroup, "images/pause_button.png", 120, 120)
	pauseButtonImages.x, pauseButtonImages.y = CCX, PORTRAITDOWN
	

	




	local function getPauseGlass()
		score = true
		sceneGroup:insert( cardsGreyGroup )

		display.save( sceneGroup , "temp.png", system.DocumentsDirectory )
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
		y = 0
		for i = 1, 36 do
			local j = (i - 1) % 6
			cardsGreyGroup[i].x = zeroX + 106 * j
			cardsGreyGroup[i].y = zeroY + 106 * y
			if j == 5 then y = y + 1 end
		end
		if currentOrientation == "landscapeRight" then
			scoreText.x, scoreText.y = LANDSCAPEUP, CCY
			timerText.x, timerText.y  =  LANDSCAPEUP, CCY - 100
			pauseButtonImages.x, pauseButtonImages.y = LANDSCAPEDOWN, CCY

			
			print( "боком" )
		end
		if currentOrientation == "landscapeLeft" then
			scoreText.x, scoreText.y = LANDSCAPEDOWN, CCY
			timerText.x, timerText.y  =  LANDSCAPEDOWN, CCY - 100
			pauseButtonImages.x, pauseButtonImages.y = LANDSCAPEUP, CCY

			
			print( "боком" )
		end
		if currentOrientation == "portrait" or currentOrientation == "portraitUpsideDown" then
			scoreText.x, scoreText.y = CCX, PORTRAITUP
			timerText.x, timerText.y  =  CCX, PORTRAITUP - 100
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
	--display.remove(cardsGroup)
	--display.remove(cardsGreyGroup)
	sceneGroup = nil
end

scene:addEventListener("create", scene)
scene:addEventListener("destroy", scene)

return scene
