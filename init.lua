minetest.register_chatcommand('online', {
	description = 'Show online players',
	privs = {},
	params = "",
	func = function(name, param)
	
		local y = 0;
		local players_total = #minetest.get_connected_players()
		local p = {};

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

				y = y + 0.7;

				p[#p+1] = "image[0.3,"..y..";0.7,0.7;".. head .. "] image[4,"..(y+0.025)..";0.454,0.568;".. ping_texture .. "] box[0.3,"..y..";4.2,0.6;black] label[1.2,"..(0.05+y)..";"..minetest.colorize("white", name).."]"
			end

			local text = table.concat(p,"\n")
			local form = "size [5,9]  label[0.3,0.1;"..minetest.colorize("#dddddd", "Online Players: "..players_total.." / "..minetest.setting_get("max_users")).."]"

			form = form .. text

			minetest.show_formspec(name, "robot_msg", form);

	end,
})
				