SMODS.Atlas {
	key = "jokers",
	path = "Jokers.png",
	px = 71,
	py = 95
}-- Gargamel

SMODS.Sound {
	key = "nest_gargamel_trigger",
	path = "gargamel_trigger.ogg"
}

SMODS.Sound {
	key = "nest_gargamel_obtain",
	path = "gargamel_buy.ogg"
}

SMODS.Sound {
	key = "nest_gargamel_die",
	path = "gargasell.ogg"
}

SMODS.Joker {
	key ='gargamel',
	blueprint_compat = true,
	atlas = "jokers",
	pos = {
		x = 0,
		y = 0,
	},
	soul_pos = {
		x = 1,
		y = 0
	},
	rarity = 3,
	cost = 6,
	unlocked = true,
	discovered = true,
	config = {
		extra = {
			xmult = 1,
			xmult_mod = 0.2,
			played_clubs_this_hand = 0 -- for displaying funny message
		}
	},
	loc_vars = function (self, info_queue, card)
		return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
	end,
	calculate = function (self, card, context)
		if context.destroying_card and context.destroy_card:is_suit("Clubs") then
			return {
				remove = true
			}
		elseif context.individual and not context.blueprint_card and context.cardarea == G.play then
			if context.other_card:is_suit("Clubs") then
				if context.other_card.ability.extra == nil then
					context.other_card.ability.extra = {}
				end
				if(not context.other_card.ability.extra.garga_got_this_one)then
					context.other_card.ability.extra.garga_got_this_one = true;
					card.ability.extra.played_clubs_this_hand = card.ability.extra.played_clubs_this_hand + 1;
				end

				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "xmult",
					scalar_value = "xmult_mod",
					no_message = true
				})

				return {
					message = localize("k_upgrade_ex"),
					message_card = card,
					colour = G.C.MULT
				}
			end
		elseif context.joker_main then
			return {
				xmult = card.ability.extra.xmult,
				delay = 0.4,
				func = card.ability.extra.played_clubs_this_hand > 0 and function ()
					card.ability.extra.played_clubs_this_hand = 0;
					card_eval_status_text(card, 'extra', nil, nil, nil,
					{ message = localize("k_nest_gargamel"), sound = "nest_gargamel_trigger" })
				end or nil
			}
		end
	end,
	add_to_deck = function (self, card, from_debuff)
		play_sound("nest_gargamel_obtain")
	end,
	remove_from_deck =function (self, card, from_debuff)
		play_sound("nest_gargamel_die")
	end
}

