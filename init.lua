minetest.register_chatcommand('online', {
	description = 'Show online players',
	privs = {interact = true},
	params = "",
	func = function(name, param)
	

		local players_total = #minetest.get_connected_players()

		--12 23 34
		
			local f_size = 5
			
			if players_total >= 12 and players_total <= 22 then
				f_size = 10
			elseif players_total >= 23 and players_total <= 33 then
				f_size = 15
			elseif players_total >= 34 then
				f_size = 20
			end

			local fs = "size ["..f_size..",9] bgcolor[#080808BB;true] background[0,0;8,8;gui_formbg.png;true] label[0.3,0.1;"..minetest.colorize("#dddddd", "Online Players: "..players_total.." / "..minetest.setting_get("max_users")).."]"
			local count = 0
			local fsx = 0
			local fsy = 0.7

			for k,v in pairs(minetest.get_connected_players()) do 

				local name = v:get_player_name()

				local head = "[combine:8x8:-8,-8=character.png"	
				local ping_texture = "[combine:10x8:0,-32=ping_pics.png"
				local ping = math.floor((minetest.get_player_information(name).avg_rtt / 2) * 1000)

				if minetest.get_modpath("simple_skins") then
					head = "[combine:8x8:-8,-8="..skins.skins[name]..".png"
				end
				
				if ping >= 0 and ping <= 100 then
					ping_texture = "[combine:10x8:0,0=ping_pics.png"
				elseif ping >= 100 and ping <= 300 then
					ping_texture = "[combine:10x8:0,-8=ping_pics.png"
				elseif ping >= 300 and ping <= 600 then
					ping_texture = "[combine:10x8:0,-16=ping_pics.png"
				elseif ping >= 600 and ping <= 1000 then
					ping_texture = "[combine:10x8:0,-24=ping_pics.png"
				elseif ping >= 1000 then
					ping_texture = "[combine:10x8:0,-32=ping_pics.png"
				end

				count = count + 1																
				
				fs = fs .. "image["..(fsx+0.3)..","..fsy..";0.7,0.7;".. head .. "] image["..(fsx+4)..","..(fsy+0.025)..";0.454,0.568;".. ping_texture .. "] box["..(fsx+0.3)..","..fsy..";4.2,0.6;black] label["..(fsx+1.2)..","..(0.05+fsy)..";"..minetest.colorize("white", name).."]"
				
				fsy = fsy + 0.75

				if count == 11 or count == 22 or count == 33 then
					-- start next row
					fsx = fsx + 5
					fsy = 0.7
				end
				
			end

			minetest.show_formspec(name, "robot_msg", fs);

	end,
})