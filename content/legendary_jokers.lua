SMODS.Atlas {
	key = "legendaryjokers",
	path = "LegendaryJokers.png",
	px = 71,
	py = 95
}

function Nisedalatro.get_rarity_string(rarity)
	local rarity_string = 'common';

	if rarity == 2 then
		rarity_string = 'uncommon'
	elseif rarity == 3 then
		rarity_string = 'rare'
	elseif rarity == 4 then
		rarity_string = 'legendary'
	elseif type(rarity) == 'string' then
		rarity_string = rarity
	end

	return rarity_string;
end

SMODS.Joker {
	key = "red",
	blueprint_compat = true,
	atlas = "legendaryjokers",
	pos = {
		x = 2,
		y = 0,
	},
	soul_pos = {
		x = 3,
		y = 0
	},
	rarity = 4,
	cost = 26,
	unlocked = false,
	discovered = false,
	config = {
		immutable = {
			personally_consumed = {}
		},
		
		extra = {
			xmult = 1,

			-- Base Game
			xmult_common = 1,
			xmult_uncommon = 2.5,
			xmult_rare = 5,
			xmult_legendary = 15,

			-- Niseda rarities
			xmult_nest_epic = 7.5,
			xmult_nest_mythic = 20,
			xmult_nest_horrid = 7.5,

			-- Cryptid
			xmult_cry_epic = 10,
			xmult_cry_candy = 2,
			xmult_cry_cursed = -5,
			xmult_cry_exotic = 50,

			-- Default, incase the rarity isnt any of the above
			xmult_default = 2
		}
	},
	loc_vars = function(self, info_queue, card)
		local vars = {}
		if card.area and card.area == G.jokers then
			local my_pos = Nisedalatro.get_joker_index(card);
			local right_joker = G.jokers.cards[my_pos + 1]
			if right_joker then
				local rarity_string = Nisedalatro.get_rarity_string(right_joker.config.center.rarity);
				table.insert(vars, card.ability.extra["xmult_" .. rarity_string] or card.ability.extra.xmult_default)
			else
				table.insert(vars, 0)
			end
		else
			table.insert(vars, 0)
		end

		table.insert(vars, card.ability.extra.xmult)

		return {
			vars = vars,
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and not card.getting_sliced then
			local my_pos = Nisedalatro.get_joker_index(card);
			local to_consume = G.jokers.cards[my_pos + 1];

			if to_consume and not to_consume.getting_sliced and not SMODS.is_eternal(to_consume) then
				to_consume.getting_sliced = true
				G.GAME.joker_buffer = G.GAME.joker_buffer - 1
				local xmult_string = Nisedalatro.get_rarity_string(to_consume.config.center.rarity)
				local xmult = card.ability.extra["xmult_" .. xmult_string] or card.ability.extra.xmult_default
				card.ability.immutable.personally_consumed[to_consume.config.center_key] = true;

				-- TODO: set gros michel to extinct when its consumed by Red

				G.E_MANAGER:add_event(Event({
					func = function()
						G.GAME.joker_buffer = 0
						SMODS.scale_card(card, {
							ref_table = card.ability.extra,
							ref_value = "xmult",
							scalar_value = "xmult_" .. xmult_string,
							no_message = true
						})
						card:juice_up(0.8, 0.8)
						to_consume:start_dissolve({ HEX("821a1a"), G.C.BLACK }, nil, 1.6)
						return true
					end
				}))

				return {
					message = localize { type = 'variable', key = 'a_xmult', vars = { xmult } },
					colour = G.C.RED,
					text_colour = G.C.WHITE,
					no_juice = true
				}
			end
		elseif context.joker_main then
			return {
				xmult = card.ability.extra.xmult,
			}
		end
	end
}

-- Nebula
SMODS.Joker {
	key = "nebula",
	atlas = "legendaryjokers",
	pos = {
		x = 0,
		y = 0,
	},
	soul_pos = {
		x = 1,
		y = 0
	},
	rarity = 4,
	cost = 20,
	unlocked = false,
	discovered = false,
	config = {
		extra = {
			repetitions = 1
		},
		immutable = {
			max_repetitions = 5,
			levels = 3,
			recent_hand = ""
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				math.min(card.ability.extra.repetitions, card.ability.immutable.max_repetitions),
				card.ability.extra.repetitions ~= 1 and "s" or "",
				card.ability.immutable.levels
			}
		}
	end,
	calculate = function(self, card, context)
		if context.repetition and context.scoring_hand then
			local repeats = math.min(card.ability.extra.repetitions, card.ability.immutable.max_repetitions) *
				math.floor(G.GAME.hands[context.scoring_name].level / card.ability.immutable.levels);
			if to_number then
				repeats = to_number(repeats);
			end

			if repeats > 0 then
				return {
					repetitions = repeats
				}
			end
		end
	end
}

SMODS.Joker {
	key = "xavi",
	atlas = "legendaryjokers",
	pos = {
		x = 0,
		y = 0,
	},
	soul_pos = {
		x = 1,
		y = 0
	},
	rarity = 4,
	cost = 20,
	unlocked = false,
	discovered = false,
	config = {
		extra = {
			xmult = 1,
			xmult_mod = 0.5
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.xmult_mod,
				card.ability.extra.xmult
			}
		}
	end,
	calculate = function (self, card, context)
		if context.before and not context.blueprint_card then
			if next(context.poker_hands["Two Pair"]) then
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
				xmult = card.ability.extra.xmult
			}
		end
	end
}
