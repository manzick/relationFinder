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
local json = require( "json" )


if (system.getInfo("platformName") == "iPhone OS") then
	store = require("store")
else
	store = require("plugin.google.iap.v3")
end


function scene:create(event)

	local sceneGroup = self.view
	local background = display.newImageRect(sceneGroup, "images/bg_second.png", display.actualContentWidth, display.actualContentWidth*2 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local store_TL = display.newText(sceneGroup, lang.store_title, display.contentCenterX, display.contentCenterY - display.contentCenterY*0.83, font, 80)
	store_TL:setFillColor(black)
	ButtonClick = false
	

	local function transactionListener( event )
    --Новая красивая глава
    	local FirstGoFunc = false
		if (event.transaction.productIdentifier == "hide_ads" and event.transaction.state == "purchased" and FirstGoFunc == false) then
			local alert1 = native.showAlert( lang.alert_hide_ads_purchase_title, lang.alert_hide_ads_purchase_sub, { "OK"} )
			FirstGoFunc = true
			ads_on = false
			baseTable.sound2 = ads_on 
			saveBase()
		end

		if (event.transaction.productIdentifier == "hide_ads" and event.transaction.state == "restored" and FirstGoFunc == false) then
			local alert1 = native.showAlert( lang.alert_hide_ads_restore_title, lang.alert_hide_ads_restore_sub, { "OK"} )
			FirstGoFunc = true
			ads_on = false
			baseTable.sound2 = ads_on 
			saveBase()
		end

		if (event.transaction.productIdentifier == "five_hints" and event.transaction.state == "purchased" and FirstGoFunc == false) then
			local alert1 = native.showAlert( lang.alert_five_hints_purchase_title, lang.alert_five_hints_purchase_sub, { "OK"} )
			FirstGoFunc = true
			baseTable.hints = baseTable.hints + 5
			saveBase()
			if (system.getInfo("platformName") == "Andriod") then
				store.consumePurchase("five_hints")
			end
		end

		if (FirstGoFunc == false and ButtonClick == true) then 
			ButtonClick = false
			local description_alert = native.showAlert( lang.alert_error_title, lang.alert_error_body , { "OK"} )
		end 
		
		
		--$--local alert1 = native.showAlert( "Привет", "Мы в листнере транзакций", { "OK"} )
		--[[if event.transaction.state == "purchased" then
			if (event.transaction.productIdentifier == "hide_ads") then
				--$--local alert1 = native.showAlert( "Привет", "Отключение рекламы совершено", { "OK"} )
				local alert1 = native.showAlert( "Отключение рекламы", "Покупка совершена успешно", { "OK"} )
				ads_on = false
				baseTable.sound2 = ads_on 
				saveBase()
			end
			if (event.transaction.productIdentifier == "five_hints") then
				--$--local alert1 = native.showAlert( "Привет", "Держи 5 подсказок", { "OK"} )
				baseTable.hints = baseTable.hints + 5
				saveBase()
				if (system.getInfo("platformName") == "Andriod") then
					store.consumePurchase("five_hints")
				end
			end

		elseif  event.transaction.state == "restored" then
			if (event.transaction.productIdentifier == "hide_ads") then
				--$--local alert1 = native.showAlert( "Привет", "Твои покупки восстановлены", { "OK"} )
				ads_on = false
				baseTable.sound2 = ads_on 
				saveBase()
			else 
				local description_alert = native.showAlert( lang.alert_no_ads_title, lang.alert_no_ads_body , { "OK"} )
			end
		else
			--$--local alert1 = native.showAlert( "Привет", "Да вообще нихуя не работает", { "OK"} )
		end

    	if ( event.transaction.state == "failed" ) then 
	      	--$--local alert1 = native.showAlert( "Привет", "Твой говнокод не работает))", { "OK"} )
	    end]]
	    store.finishTransaction( event.transaction )
	    
	end

	store.init( transactionListener )
	





	if ads_on then Ads_button_color = {199/255, 171/255, 251/255} else Ads_button_color = {109/255, 109/255, 109/255} end
	local function No_ads_func()
		ButtonClick = true
		if (sound_on) then audio.play(click_sound) end
		if ads_on then
			store.purchase("hide_ads")
		end
	end
	local No_ads = display.newRoundedRect(sceneGroup, display.contentCenterX, display.contentCenterY - 300, 650, 190, 10)
	No_ads:setFillColor(unpack(Ads_button_color))
	No_ads_text = display.newText(sceneGroup, lang.store_no_ads, display.contentCenterX, display.contentCenterY - 300, font, 65)
	No_ads_text:setFillColor(black)
	No_ads:addEventListener("tap", No_ads_func)


	Other_button_color = {199/255, 171/255, 251/255}
	local function Five_Hints_func()
		ButtonClick = true
		if (sound_on) then audio.play(click_sound) end
		if (system.getInfo("platformName") == "iPhone OS") then
			store.purchase("five_hints")
			--$--local alert1 = native.showAlert( "Привет", "Твой говнокод на яблоке работает))", { "OK"} )
		else
			store.purchase("five_hints")
			--$--local alert1 = native.showAlert( "Привет", "Твой говнокод на андроиде работает))", { "OK"} )
		end
	end
	local Five_Hints = display.newRoundedRect(sceneGroup, display.contentCenterX, display.contentCenterY - 50, 650, 190, 10)
	Five_Hints:setFillColor(unpack(Other_button_color))
	Five_Hints_text = display.newText(sceneGroup, lang.store_five_hints, display.contentCenterX, display.contentCenterY - 50, font, 65)
	Five_Hints_text:setFillColor(black)
	Five_Hints:addEventListener("tap", Five_Hints_func)



	local function Restore_purchased_func()
		ButtonClick = true
		if (sound_on) then audio.play(click_sound) end
		if ads_on then 
			store.restore()
		end
	end
	local Restore_purchased = display.newRoundedRect(sceneGroup, display.contentCenterX, display.contentCenterY + 200, 650, 190, 10)
	Restore_purchased:setFillColor(unpack(Ads_button_color))
	Restore_purchased_text = display.newText(sceneGroup, lang.store_restore_purchased, display.contentCenterX, display.contentCenterY + 200, font, 65)
	Restore_purchased_text:setFillColor(black)
	Restore_purchased:addEventListener("tap", Restore_purchased_func)


	
	


	
	

	local button_back = display.newImageRect(sceneGroup, "images/back.png", 46, 86)
	button_back.x = - (display.actualContentWidth - 720)/2 + 60
	button_back.y = 100
	local go_start = function() if (sound_on) then audio.play(click_sound) end go_to_scene("scene.start","fromLeft") end
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
