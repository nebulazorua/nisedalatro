if not JokerDisplay then return end

JokerDisplay.Definitions.j_nest_gargamel = { -- Gargamel
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" },
			}
		}
	},
	reminder_text = {
		{ text = "(" },
		{ ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.SUITS.Clubs },
		{ text = ")" },
	},
	calc_function = function(card)
		card.joker_display_values.localized_text = localize("Clubs", 'suits_plural')
	end
}

JokerDisplay.Definitions.j_nest_nebula = { -- Nebula
	retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
		local scoring_name, _, _ = JokerDisplay.evaluate_hand()
		if G.GAME.hands[scoring_name] then

			local repeats = math.min(joker_card.ability.extra.repetitions, joker_card.ability.immutable.max_repetitions) *
				math.floor(G.GAME.hands[scoring_name].level / joker_card.ability.immutable.levels);
			if to_numberr then
				repeats = to_number(repeats);
			end
			return repeats;
		end
		return 0;
	end
	
}

JokerDisplay.Definitions.j_nest_red = { -- Red
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
			}
		}
	},
	reminder_text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "next_gain", retrigger_type = "exp" }
			}
		}
	},
	reminder_text_config = { colour = G.C.WHITE },
	calc_function = function(card)
		local mult = 0;

		local my_pos = Nisedalatro.get_joker_index(card);
		local right_joker = G.jokers.cards[my_pos + 1]
		if right_joker then
			local rarity_string = Nisedalatro.get_rarity_string(right_joker.config.center.rarity);
			mult = card.ability.extra["xmult_" .. rarity_string] or card.ability.extra.xmult_default;
		end
		card.joker_display_values.next_gain = mult;
	end
}

-- Ghost Wolf
JokerDisplay.Definitions.j_nest_hot_dog = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
			}
		}
	}
}


JokerDisplay.Definitions.j_nest_skibidi_toilet = { -- Skibidi Toilet
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "exp" }
			}
		}
	},
	reminder_text = {
		{ text = "(" },
		{ ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE },
		{ text = ")" },
	},
	calc_function = function(card)
		local mult = 1
		local _, poker_hands, hand = JokerDisplay.evaluate_hand()
		local count = 0;

		if poker_hands.Flush and next(poker_hands.Flush) then
			for _, card in next, hand do
				count = count + JokerDisplay.calculate_card_triggers(card, hand);
			end
			mult = card.ability.extra.xmult ^ count
		end

		card.joker_display_values.mult = mult;
		card.joker_display_values.localized_text = localize("Flush", 'poker_hands')
	end
}

-- or

JokerDisplay.Definitions.j_nest_creeper = { -- Creeper
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "exp" }
			}
		}
	},
	reminder_text = {
		{ text = "(" },
		{ ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.SUITS.Diamonds },
		{ text = ")" },
	},
	calc_function = function(card)
		local mult = 1;
		local _, poker_hands, hand = JokerDisplay.evaluate_hand()
		local count = 0;
		
		for _, card in next, hand do
			if not card:is_suit("Diamonds", true)then
				count = 0;
				break;
			end
			count = count + JokerDisplay.calculate_card_triggers(card, hand);
		end
		mult = card.ability.extra.xmult ^ count
		card.joker_display_values.mult = mult;
		card.joker_display_values.localized_text = localize("Diamonds", 'suits_plural')
	end
}
