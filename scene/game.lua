local composer = require( "composer" )
local json = require( "json" )
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view
	local cardsGroup = display.newGroup()
	--Константы представленные CoronaSDK
	local ACH = display.actualContentHeight
	local ACW = display.actualContentWidth
	local CCX = display.contentCenterX
	local CCY = display.contentCenterY
	--Константы специально для relation finder
	local PORTRAITUP = CCY - ACH/4 - 125
	local PORTRAITDOWN = CCY + ACH/4 + 125
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

	--score--
	local score = display.newText(sceneGroup, "0", CCX, PORTRAITUP, font, 80)

	--cadrs--
	local zeroX = CCX - 15 - 76 - 30 - 76 - 30 - 76 + 38
	local zeroY = CCY - 15 - 76 - 30 - 76 - 30 - 76 + 38
	local y = 0
	for i = 0, 35 do
		local j = i % 6
		print(j)
		print(i / 36)
		local card = display.newRoundedRect(sceneGroup, zeroX + 106 * j, zeroY + 106 * y, 90, 90, 10)
		if j == 5 then y = y + 1 end
		cardsGroup:insert( card )
	end

	--pause button--
	local  pauseButtonImages = display.newImageRect(sceneGroup, "images/play_button.png", 120, 120)
	pauseButtonImages.x, pauseButtonImages.y = CCX, PORTRAITDOWN
	

	

	


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
			
			print( "боком" )
		end
		if currentOrientation == "portrait" or currentOrientation == "portraitUpsideDown" then
			
			print( "вертикально" )
		end
	end

	
  
	Runtime:addEventListener( "orientation", onOrientationChange )
	


		
	

end

function scene:destroy(event)
	local sceneGroup = self.view
	display.remove(sceneGroup)
	sceneGroup = nil
end

scene:addEventListener("create", scene)
scene:addEventListener("destroy", scene)

return scene
