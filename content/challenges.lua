SMODS.Challenge {
	key = "gargadeck",
	jokers = {
		{
			id = "j_nest_gargamel",
			eternal = true
		}
	},
	rules = {
		custom = {
			{
				id = "nest_all_clubs"
			}
		}
	},
	restrictions = {
		banned_cards = {
			{id = "c_sun"},
			{id = "c_moon"},
			{id = "c_world"},
			{id = "c_star"},
			{id = "c_sigil"},
			{id = "c_tower"},
			{id = "c_incantation"},
			{id = "m_stone"}
		},
		banned_other = {
			{ id = "bl_club", type = "blind" },
			{ id = "bl_head", type = "blind" },
			{ id = "bl_goad", type = "blind" },
			{ id = "bl_window", type = "blind" }
		}
	},
	deck = {
		type = "Challenge Deck",
		cards = (function ()
			local cards = {}
			for i, v in next, SMODS.Ranks do
				-- TODO: Instead of checking if its unmodded, instead check if it should be in the default deck
				if not v.original_mod then
					for i2 = 1, 4 do
						table.insert(cards, {r = v.card_key, s = "C"})
					end
				end
			end
			return cards;
		end)()
	},
	calculate = function (self, context)
		if context.modify_booster_card and context.booster.config.center.kind == 'Standard' then
			context.card:change_suit("Clubs")
		elseif context.modify_shop_card and (context.card.ability.set == 'Default' or context.card.ability.set == 'Enhanced')then
			context.card:change_suit("Clubs")
		end
	end
}