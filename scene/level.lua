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

	--Что это блять за пиздец?!
	 
	local sceneGroup = self.view

	try_game_lvl = try_game_lvl + 1

	local background = display.newImageRect(sceneGroup, "images/bg_second.png", display.actualContentWidth, display.actualContentWidth*2 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local level_name = display.newText(sceneGroup, lang.pony.." "..cur_level.number, display.contentCenterX, display.contentCenterY - display.contentCenterY*0.83, font, 70)
	level_name:setFillColor(black)

	local hint = display.newImageRect(sceneGroup, "images/hint.png", 69, 99)
	hint.x, hint.y = display.actualContentWidth + display.screenOriginX - 60, 100

	local hint_text = display.newText(sceneGroup, baseTable.hints, hint.x, hint.y - 10, font, 32)
	hint_text:setFillColor(black)

	local img_pony = display.newImageRect(sceneGroup, "ponies/"..cur_level.name..".gif", display.contentWidth - 20, (display.contentWidth - 20)/1.8 )
	img_pony.x = display.contentCenterX
	img_pony.y = level_name.y + 240
	img_pony.fill.effect = "filter.pixelate"
	img_pony.fill.effect.numPixels = 15

	local answerGroup = display.newGroup()
	sceneGroup:insert(answerGroup)
	local count_answer = table.maxn(cur_level.answer)
	local BiasByY = 0
	local Y_Position_of_Last_Row = 0
	while (count_answer >= 6) do
		count_answer = count_answer - 6
		for i,j in ipairs({ -3, -2, -1, 1, 2, 3 }) do
   			local temp = display.newImageRect(answerGroup, "images/word.png",100,100)
   			temp.x = i * (820 / 7) - 720 / 14
			temp.y = img_pony.y + img_pony.height / 2 + 70 + BiasByY
			Y_Position_of_Last_Row = temp.y 
			answerGroup:insert(temp)
		end
		BiasByY = BiasByY + 110
	end
	if Y_Position_of_Last_Row == 0 then 
		Y_Position_of_Last_Row = img_pony.y + img_pony.height / 2 - 40
	end
	for i = 0 , count_answer - 1 do
		local temp = display.newImageRect(answerGroup, "images/word.png",100,100)
		temp.x = display.contentCenterX - 58 * (count_answer - 1) + i * 117
		temp.y = Y_Position_of_Last_Row + 110
	end

	local word_down = display.newRect(sceneGroup, display.contentCenterX, answerGroup[answerGroup.numChildren].y + 200, display.actualContentWidth, 200+17*3)
	word_down:setFillColor(199/255, 171/255, 251/255)

	word_down_group = display.newGroup()
	sceneGroup:insert(word_down_group)

	local temp_first_g = display.newGroup()

	local temp_first = display.newImageRect(temp_first_g, "images/letter.png",100, 100)

	table.sort(cur_level.letters)
	local temp_first_l = display.newText(temp_first_g, cur_level.letters[1], 0, 0, font, 80)
	temp_first_l:setFillColor(black)

	temp_first_g.x = - (display.actualContentWidth - 720)/2 + 60 temp_first_g.y = word_down.y + 60
	word_down_group:insert(temp_first_g)

	for i = 2, table.maxn(cur_level.letters) do
		local temp_g = display.newGroup()
		local temp = display.newImageRect(temp_g, "images/letter.png",100, 100)
		if (word_down_group.numChildren % 2 == 1) then
			temp_g.x = word_down_group[word_down_group.numChildren].x
			temp_g.y = word_down.y - 60
		else
			temp_g.x = word_down_group[word_down_group.numChildren].x + 117
			temp_g.y = word_down.y + 60
		end

		local temp_l = display.newText(temp_g ,cur_level.letters[i], 0, 0, font, 80)
		temp_l:setFillColor(black)

		word_down_group:insert(temp_g)
	end

	word_down_group.x = - display.screenOriginX

	local scrollView = widget.newScrollView
	{
		left = - (display.actualContentWidth - 720)/2,
		width = display.actualContentWidth,
		height = display.contentHeight,
		horizontalScrollDisabled = false,
		verticalScrollDisabled = true,
		hideBackground = true,
	}

	scrollView:insert(word_down_group)
	sceneGroup:insert(scrollView)

	answerGroup_try = display.newGroup()
	sceneGroup:insert(answerGroup_try)

	--Убирает или добавлять буквы внизу--
	function fix_down_letters(target, on) 
		local FuckingBool = false
		local condition = true
		for i = 1, word_down_group.numChildren do
			if on then condition = (word_down_group[i].isVisible == false) else condition = (word_down_group[i].isVisible ~= false) end
			if ((word_down_group[i][2].text == target) and (FuckingBool == false) and condition) then
				if on then word_down_group[i].isVisible = true else word_down_group[i].isVisible = false end
				FuckingBool = true
			end
		end 
	end

	local last_cur_i = 1
	local NotLast_cur_i = 1
	local NotLast_Element_Use = false
	
	--Выставляем буквы перед стартом--
	local function Main_Write_Up_Button()
	if (baseTable[cur_level.name]) then
		local last_answer = baseTable[cur_level.name]
		for i = 1,#last_answer do
			local LA_i = last_answer:sub( i, i )
			Write_New_Up_Button(LA_i)
			fix_down_letters(LA_i,false)
			--[[local FuckingBool = false
			for j = 1, word_down_group.numChildren do
				if ((word_down_group[j][2].text == LA_i) and (FuckingBool == false) and (word_down_group[j].isVisible ~= false)) then
					word_down_group[j].isVisible = false
					FuckingBool = true
				end
			end]]
		end
	end
	end
	

	local function click_word_down(event)
		print(event.target.x.." "..event.target.y)
		if (last_cur_i <= answerGroup.numChildren or NotLast_Element_Use) then	
			if (NotLast_Element_Use == false) then
				local temp_g = display.newGroup()
				local temp = display.newImageRect(temp_g, "images/letter.png",100, 100)
				temp_g.x = answerGroup[last_cur_i].x
				temp_g.y = answerGroup[last_cur_i].y
				local temp_l = display.newText(temp_g ,event.target[2].text, 0, 0, font, 80)
				temp_l:setFillColor(black)
				answerGroup_try:insert(temp_g)
				answerGroup_try[last_cur_i]:addEventListener("tap", click_answerGroup)
				last_cur_i = last_cur_i + 1
			else
				NotLast_Element_Use = false
				answerGroup_try[NotLast_cur_i][2].text = event.target[2].text
				answerGroup_try[NotLast_cur_i].isVisible = true
				Find_Empty_Element()
			end
			event.target.isVisible = false
			save_letters_in_base()
			Fix_issues_for_go_to_new_fucking_level()
		end
	end

	function Fix_issues_for_go_to_new_fucking_level()
		print(t1)
			local t2 = ""
			for i = 1, #cur_level.answer do t2 = t2..cur_level.answer[i] end
			print(t2)
			if (t1 == t2) then
				baseTable[cur_level.name] = ""
				if (baseTable.levels[tonumber(cur_level.number)] == 0) then
					baseTable.levels[#baseTable.levels + 1] = 0
					baseTable.levels[tonumber(cur_level.number)] = 1
					baseTable.complete_levels = baseTable.complete_levels + 1
					if (baseTable.complete_levels % 3 == 0) then
						baseTable.hints = baseTable.hints + 1 --Выдаем халявные подсказки--
					end
				end
				saveBase()
				if (ponies_list[tonumber(cur_level.number) + 1]) then
					cur_level = ponies_list[tonumber(cur_level.number) + 1]
					go_to_scene("scene.level","fromLeft")
				else
					ads.hide()
					go_to_scene("scene.categorie", "fromLeft")
				end
			elseif (t1:len() == t2:len()) then
				--Это происходит при неверном ответе
				Find_Empty_Element()
				if (NotLast_Element_Use == false) then
					local function ShakeYouButt( obj )
    					transition.from(answerGroup_try, {time=150, x=-20, transition=easing.outBounce})
					end
					transition.from(answerGroup_try, {time=150, x=-50, transition=easing.outBounce, onComplete=ShakeYouButt })
				end
			end
		-- body
	end

	function click_answerGroup(event)
		for i = 1, word_down_group.numChildren do
			if (word_down_group[i].isVisible == false and word_down_group[i][2].text == event.target[2].text) then 
				if (event.target == answerGroup_try[last_cur_i - 1]) then
					answerGroup_try:remove(event.target)
					last_cur_i = last_cur_i - 1
				else
					NotLast_Element_Use = true
					event.target[2].text = " "
					event.target.isVisible = false
					Find_Empty_Element()
				end
				word_down_group[i].isVisible = true
				break
			end
		end	
		Find_Empty_Element()
	end

	function Write_New_Up_Button(letter)
		local temp_g = display.newGroup()
		local temp = display.newImageRect(temp_g, "images/letter.png",100, 100)
		temp_g.x = answerGroup[last_cur_i].x
		temp_g.y = answerGroup[last_cur_i].y
		local temp_l = display.newText(temp_g ,letter, 0, 0, font, 80)
		temp_l:setFillColor(black)
		answerGroup_try:insert(temp_g)
		answerGroup_try[last_cur_i]:addEventListener("tap", click_answerGroup)
		if (letter == " ") then answerGroup_try[last_cur_i].isVisible = false end
		last_cur_i = last_cur_i + 1
	end

	Main_Write_Up_Button()

	function Get_t1()
		t1 = ""
		for j = 1,answerGroup_try.numChildren do
			t1 = t1..answerGroup_try[j][2].text
		end 
		
	end

	function Find_Empty_Element()
		for j = 1,answerGroup_try.numChildren do 
			if answerGroup_try[j][2].text == " " then 
				NotLast_cur_i = j 
				NotLast_Element_Use = true
				break
			end
		end		
	end

	--ДОБАВИТЬ ОБРАБОТКУ КЛИКОВ--
	for i = 1, word_down_group.numChildren do
		word_down_group[i]:addEventListener("tap", click_word_down)
	end

	scrollView:setScrollWidth(word_down_group[word_down_group.numChildren].x + 180)

	--КНОПКА НАЗАД--
	local function go_categorie()
		if (sound_on) then audio.play(click_sound) end 

		print("вот сюда, код для сохранения")
		if (answerGroup_try[1]) then 
			save_letters_in_base()
			print(t1)
			print("база сохранена!")

		end
		
		ads.hide()
		go_to_scene("scene.categorie","fromLeft")
	end	

	local button_back = display.newImageRect(sceneGroup, "images/back.png", 50, 94)
	button_back.x = - (display.actualContentWidth - 720)/2 + 60
	button_back.y = button_back.height
	--local go_categorie = function() if (sound_on) then audio.play(click_sound) end ads.hide() go_to_scene("scene.categorie","fromLeft") end
	button_back:addEventListener("tap", go_categorie)

	--РЕКЛАМА--

	local function admobListener( event )
  		if (event.isError) then
   			print("Ошбика рекламы")
  		else
         --Тут ничего нет
     	end
 	end

 	local adY = display.actualContentHeight
 	if (system.getInfo("platformName") == "iPhone OS") then
  --iOS реклама--
  		appID = "ca-app-pub-9790813781374731~1095641603"
  		bannerAppID = "ca-app-pub-9790813781374731/2572374807"
  		interstitialAppID = "ca-app-pub-9790813781374731/4049108005"
 	else
  --Android реклама
    	appID = "ca-app-pub-9790813781374731~7002574400"  
     	bannerAppID = "ca-app-pub-9790813781374731/2432774009"
     	interstitialAppID = "ca-app-pub-9790813781374731/3909507206"
 	end
 	ads.init( "admob", appID, admobListener )
 	local adX, adY = display.screenOriginX, 100000

 	if (ads_on) then 
 		if(try_game_lvl % 7 == 0) then ads.show( "interstitial", { x=0, y=0, appId = interstitialAppID } )
 		else ads.show( "banner", { x=adX, y=adY, appId=bannerAppID } ) end
 	end

	--Сохраняет промежуточный ответ--
	function save_letters_in_base()
		Get_t1()
		if (cur_level.name ~= nil) then
			baseTable[cur_level.name] = t1
		end
		saveBase()
	end

	--Активация посказки--
	if Hint_Activate then
		print(Hint_Type)
		local Quantity_Empty_in_End = table.maxn(cur_level.answer) - (last_cur_i - 1)
		for j = 1,Quantity_Empty_in_End do
			Write_New_Up_Button(" ")
		end
		if (Hint_Type == "Show_50")	then
			local Size_Hint = math.round(table.maxn(cur_level.answer) / 2)
			for j = 1, #cur_level.answer do 
				if (j <= Size_Hint) then
					fix_down_letters(answerGroup_try[j][2].text,true)
					answerGroup_try[j][2].text = cur_level.answer[j]
					answerGroup_try[j].isVisible = true
					fix_down_letters(cur_level.answer[j],false)
				end
			end
		end
		if (Hint_Type == "Show_random_letters")	then
			local Size_Hint = math.round(table.maxn(cur_level.answer) / 2)
			Use_Number ={}
			for j = 1, #cur_level.answer do
				if (j <= Size_Hint) then
					local number = math.random(table.maxn(cur_level.answer))
					for i,j in ipairs(Use_Number) do
						while (j == number) do
							number = math.random(table.maxn(cur_level.answer)) 
						end
					end
					table.insert(Use_Number, 1, number)
					fix_down_letters(answerGroup_try[number][2].text,true)
					answerGroup_try[number][2].text = cur_level.answer[number]
					answerGroup_try[number].isVisible = true
					fix_down_letters(cur_level.answer[number],false)

				end
			end
		end
		if (Hint_Type == "Delete_incorrect") then
			for j = 1, #cur_level.answer do
				print(cur_level.answer[j])
				if (cur_level.answer[j] ~= answerGroup_try[j][2].text) then
					fix_down_letters(answerGroup_try[j][2].text,true)
					answerGroup_try[j][2].text = " "
					answerGroup_try[j].isVisible = false
				end
			end

		end
		Hint_Activate = false
		baseTable.hints = baseTable.hints - 1
		hint_text.text = baseTable.hints
		Get_t1()
		saveBase()

		Fix_issues_for_go_to_new_fucking_level()

	end 


	local function go_level_hint()
		ads.hide()
		save_letters_in_base()
		if (sound_on) then audio.play(click_sound) end 
		go_to_scene("scene.level_hint","fromRight")
	end

	local function rateMePlease()
		local function disagreeRate()
			local  function removing()  panelGroup:removeSelf() end
			baseTable.rate = true
			saveBase()
			transition.to(panelGroup, {time=1000, y=1000, transition=easing.outBounce, onComplete = removing})
		end

		local function agreeRate()
			local  function removing()  panelGroup:removeSelf() end
			baseTable.rate = true
			baseTable.hints = baseTable.hints + 1
			saveBase()
			--ПЕРЕХОД В МАГАЗИНЫ--
			if (system.getInfo("platformName") == "iPhone OS") then
				system.openURL("https://itunes.apple.com/us/app/pony-picture-quiz/id1175810537")
			else
				system.openURL("https://play.google.com/store/apps/details?id=ru.fnight.ponyquiz")
			end
			transition.to(panelGroup, {time=1000, y=1000, transition=easing.outBounce, onComplete = removing})
		end

		local function laterRate()
			local  function removing()  panelGroup:removeSelf() end
			transition.to(panelGroup, {time=1000, y=1000, transition=easing.outBounce, onComplete = removing})
		end

		panelGroup = display.newGroup()
		local panel = display.newRoundedRect( panelGroup, display.contentCenterX, display.contentCenterY, display.contentWidth - 100, display.contentHeight/3, 4)
		panel:setFillColor(199/255, 171/255, 251/255)
		local disagreeRate_text = display.newText(panelGroup, lang.no, panel.x - panel.width/3, panel.y + panel.height/3, font, 60 )
		disagreeRate_text:setFillColor( black )
		local agreeRate_text = display.newText(panelGroup, lang.yes, panel.x , panel.y + panel.height/3, font, 60 )
		agreeRate_text:setFillColor(black)
		local laterRate_text = display.newText(panelGroup, lang.later, panel.x + panel.width/3, panel.y + panel.height/3, font, 60 )
		laterRate_text:setFillColor(black)
		local star_pic = display.newImageRect(panelGroup, "images/rate.png", 100, 100)
		star_pic.x, star_pic.y = panel.x, panel.y - panel.height/3
		local rate_text_option = 
		{	
			parent = panelGroup,
			text = lang.rate_plz,
			x = panel.x,
			y = panel.y,
			width = panel.width - 40,
			font = font,
			fontSize = 50,
			align = "center"
		}
		local rate_text = display.newText(rate_text_option)
		rate_text:setFillColor( black )
		sceneGroup:insert(panelGroup)
		print(baseTable.rate)
		transition.from(panelGroup, {time=1000, y=-1000, transition=easing.outBounce})
		disagreeRate_text:addEventListener( "tap", disagreeRate )
		agreeRate_text:addEventListener( "tap", agreeRate )
		laterRate_text:addEventListener( "tap", laterRate )
	end

	if (((baseTable.complete_levels + 1) % 7 == 0) and (baseTable.rate == false)) then
		rateMePlease()
	end

	hint:addEventListener("tap", go_level_hint)
end

function scene:destroy(event)
	local sceneGroup = self.view
	display.remove(sceneGroup)
	sceneGroup = nil
end

scene:addEventListener("create", scene)
scene:addEventListener("destroy", scene )

return scene
