SMODS.Atlas {
	key = "jokers",
	path = "Jokers.png",
	px = 71,
	py = 95
}

-- Gargamel

SMODS.Sound {
	key = "nest_gargamel_trigger",
	path = "gargamel_trigger.ogg"
}

SMODS.Sound {
	key = "nest_gargamel_obtain",
	path = "gargamel_buy.ogg"
}

SMODS.Sound {
	key = "nest_gargamel_die1",
	path = "gargasell1.ogg"
}

SMODS.Sound {
	key = "nest_gargamel_die2",
	path = "gargasell2.ogg"
}
	
SMODS.Sound {
	key = "nest_gargamel_die3",
	path = "gargasell3.ogg"
}

SMODS.Joker {
	key = 'gargamel',
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
	unlocked = false,
	discovered = false,
	config = {
		extra = {
			xmult = 1,
			xmult_mod = 0.2,
			played_clubs_this_hand = 0 -- for displaying funny message
		}
	},
	locked_loc_vars = function(self, info_queue, card)
		return { vars = { 10, localize("Clubs", "suits_singular") } }
	end,

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
		if context.destroying_card and context.destroy_card:is_suit("Clubs") and not context.retrigger_joker then
			return {
				remove = true
			}
		elseif context.individual and not context.blueprint_card and context.cardarea == G.play then
			if context.other_card:is_suit("Clubs") then
				if (not context.other_card.ability.garga_got_this_one) then
					context.other_card.ability.garga_got_this_one = true;
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
			local retrigger = context.retrigger_joker or context.blueprint_card
			return {
				xmult = card.ability.extra.xmult,
				delay = 0.4,
				func = card.ability.extra.played_clubs_this_hand > 0 and function()
					card.ability.extra.played_clubs_this_hand = 0;
					if not retrigger then
						card_eval_status_text(card, 'extra', nil, nil, nil,
							{ message = localize("k_nest_gargamel"), sound = "nest_gargamel_trigger" })
					end
				end or nil
			}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then 
			play_sound("nest_gargamel_obtain")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		-- dont add from_debuff check its funnier like this
		play_sound("nest_gargamel_die" .. pseudorandom("nest_gargasell", 1, 3))
	end,
	check_for_unlock = function(self, args)
		if args.type == 'card_destroyed' then
			if args.card:is_suit("Clubs") then
				G.GAME.DESTROYED_CLUBS = (G.GAME.DESTROYED_CLUBS or 0) + 1;
				return G.GAME.DESTROYED_CLUBS >= 10
			end
		end
		return false;
	end
}

-- Skibidi Toilet and Creeper

SMODS.Joker { -- Skibidi Toilet, cannot be bought alongside Creeper [skibidi toilet or creepare!!!]
	key ='skibidi_toilet',
	blueprint_compat = true,
	atlas = "jokers",
	pos = {
		x = 3,
		y = 0,
	},
	config = {
		extra = {
			xmult = 2,
			odds = 30,
			triggered = false,
		}
	},
	rarity = 'nest_epic',
	cost = 10,
	unlocked = true,
	discovered = false,
	loc_vars = function (self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'nest_skibidi_toilet')
		return { vars = {numerator, denominator,  card.ability.extra.xmult, localize("Flush", "poker_hands") } }
	end,
	calculate = function (self, card, context)
		if context.after and not context.blueprint_card and card.ability.extra.triggered then
			card.ability.extra.triggered = false;
			if SMODS.pseudorandom_probability(card, 'nest_skibidi_toilet', 1, card.ability.extra.odds) then
				SMODS.destroy_cards(card, nil, nil, true)
				return {
					message = localize('k_nest_flushed')
				}
			else
				return {
					message = localize("k_safe_ex")
				}
			end
		-- Add the mult in main scoring context
		elseif context.individual and context.cardarea == G.play and next(context.poker_hands['Flush']) then
			card.ability.extra.triggered = true;
			return {
				xmult = card.ability.extra.xmult
			}
		end
		
	end,
	add_to_deck = function (self, card, from_debuff)
		--- @type SMODS.Joker
		local creeper = SMODS.find_card("j_nest_creeper", true)[1]; 
		if creeper then
			SMODS.destroy_cards(creeper);
			SMODS.destroy_cards(card);
			G.GAME.SKIBIDI_GREED = true
		end
	end,
	in_pool = function (self, args)
		return not G.GAME.SKIBIDI_GREED
	end
}

--- @param context CalcContext
--- @return table
--- Returns a table of all diamonds in the scoring hand based on context

local function get_all_diamonds(context)
	local diamonds = {}
	for _, playing_card in ipairs(context.scoring_hand) do
		if playing_card:is_suit("Diamonds", true) then
			table.insert(diamonds, playing_card)
		end
	end

	return diamonds;
end


SMODS.Joker { -- Creeper, cannot be bought alongside Skibidi Toilet [skibidi toilet or creepare!!!]
	key ='creeper',
	blueprint_compat = true,
	atlas = "jokers",
	pos = {
		x = 4,
		y = 0,
	},
	rarity = 'nest_epic',
	cost = 10,
	unlocked = true,
	discovered = false,
	config = {
		extra = {
			xmult = 2.5,
			triggered = false,
			odds = 20
		}
	},
	loc_vars = function (self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'nest_creeper')
		return { vars = { numerator, denominator, card.ability.extra.xmult, localize("Diamonds", "suits_plural") } }
	end,
	calculate = function (self, card, context)
		if context.after and not context.blueprint_card and card.ability.extra.triggered then
			card.ability.extra.triggered = false;
			if SMODS.pseudorandom_probability(card, 'nest_creeper', 1, card.ability.extra.odds) then
				SMODS.destroy_cards(card, nil, nil, true)
				SMODS.destroy_cards(get_all_diamonds(context), nil, nil, true)
				return {
					message = localize('k_nest_kaboom')
				}
			else
				return {
					message = localize("k_safe_ex")
				}
			end
		-- Add the mult in main scoring context
		elseif context.individual and context.cardarea == G.play and #get_all_diamonds(context) == #G.play.cards then
			card.ability.extra.triggered = true;
			return {
				xmult = card.ability.extra.xmult
			}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		--- @type SMODS.Joker
		local toilet = SMODS.find_card("j_nest_skibidi_toilet", true)[1];
		if toilet then
			SMODS.destroy_cards(toilet);
			SMODS.destroy_cards(card);
			G.GAME.SKIBIDI_GREED = true
		end
	end,
	in_pool = function(self, args)
		return not G.GAME.SKIBIDI_GREED
	end
}

SMODS.Joker {
	key ='seven_chips',
	blueprint_compat = true,
	atlas = "jokers",
	pos = {
		x = 5,
		y = 0,
	},
	rarity = 'nest_horrid',
	cost = 10,
	unlocked = true,
	discovered = true,
	config = {
		extra = {
			chips = 7,
			odds = 14,
			cur_chips = 0
		}
	},
	loc_vars = function (self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'nest_seven_chips')
		return { vars = { numerator, denominator, card.ability.extra.chips, card.ability.extra.cur_chips} }
	end,
	calculate = function (self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 and not context.blueprint_card then

			if SMODS.pseudorandom_probability(card, 'nest_seven_chips', 1, card.ability.extra.odds) then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "cur_chips",
					scalar_value = "chips",
					no_message = true,
					operation = 'X'
				})
				return {
					message = localize("k_nest_susovl"),
					message_card = card,
					colour = G.C.CHIPS
				}
			else
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "cur_chips",
					scalar_value = "chips",
					no_message = true
				})
				return {
					message = localize("k_nest_sovl"),
					message_card = card,
					colour = G.C.CHIPS
				}
			end
		elseif context.joker_main then
			return {
				chips = card.ability.extra.cur_chips
			}
		end
	end
}

SMODS.Joker {
	key ='seventeen_mult',
	blueprint_compat = true,
	atlas = "jokers",
	pos = {
		x = 6,
		y = 0,
	},
	rarity = 'nest_horrid',
	cost = 10,
	unlocked = true,
	discovered = true,
	config = {
		extra = {
			mult = 17,
			odds = 28,
			cur_mult = 0,
			xmult = 7,
			
			sevens = 0,
			aces = 0,
		}
	},
	loc_vars = function (self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'nest_seventeen_mult')
		return { vars = { numerator, denominator, card.ability.extra.mult, card.ability.extra.cur_mult, card.ability.extra.xmult } }
	end,
	calculate = function (self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint_card then
			if context.other_card:get_id() == 14 then
				card.ability.extra.sevens = card.ability.extra.sevens + 1;
			elseif context.other_card:get_id() == 7 then
				card.ability.extra.aces = card.ability.extra.aces + 1;
			end
			if card.ability.extra.sevens > 0 and card.ability.extra.aces > 0 then
				card.ability.extra.sevens = card.ability.extra.sevens - 1;
				card.ability.extra.aces = card.ability.extra.aces - 1;

				if SMODS.pseudorandom_probability(card, 'nest_seventeen_mult', 1, card.ability.extra.odds) then
					SMODS.scale_card(card, {
						ref_table = card.ability.extra,
						ref_value = "cur_mult",
						scalar_value = "xmult",
						no_message = true,
						operation = 'X'
					})
					return {
						message = localize("k_nest_susovl"),
						message_card = card,
						colour = G.C.MULT
					}
				else
					SMODS.scale_card(card, {
						ref_table = card.ability.extra,
						ref_value = "cur_mult",
						scalar_value = "mult",
						no_message = true
					})
					return {
						message = localize("k_nest_sovl"),
						message_card = card,
						colour = G.C.MULT
					}
				end
			end
		elseif context.joker_main then
			card.ability.extra.aces = 0;
			card.ability.extra.sevens = 0;
			return {
				mult = card.ability.extra.cur_mult
			}
		end
	end
}