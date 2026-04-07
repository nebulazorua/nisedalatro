SMODS.Atlas {
	key = "mythicjokers",
	path = "MythicJokers.png",
	px = 71,
	py = 95
}

SMODS.Joker {
	key = 'recursion',
	blueprint_compat = false,
	atlas = "mythicjokers",
	pos = {
		x = 0,
		y = 0,
	},
	rarity = 'nest_mythic',
	cost = 30,
	unlocked = false,
	discovered = false,
	config = {
		extra = {
			copies = 2
		}
	},
	loc_vars = function(self, info_queue, card)
		local ret = {vars = { card.ability.extra.copies, card.ability.extra.copies ~= 1 and "s" or "" }};
        if card.area and card.area == G.jokers then
			local my_pos = Nisedalatro.get_joker_index(card);

			local left_joker = G.jokers.cards[my_pos - 1];
			local right_joker = G.jokers.cards[my_pos + 1];

			local left_compatible = left_joker and left_joker ~= card and left_joker.config.center.blueprint_compat
			local right_compatible = right_joker and right_joker ~= card and right_joker.config.center.blueprint_compat

			local main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4, padding = 0.02 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = left_compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (left_compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        },
						{
							n = G.UIT.C,
							config = { ref_table = card, align = "m", colour = right_compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
							nodes = {
								{ n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (right_compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
							}
						}
                    }
                }
            }
			ret.main_end = main_end
        end

		return ret;
    end,

	calculate = function (self, card, context)
		if not context.blueprint_card then
			local my_pos = Nisedalatro.get_joker_index(card);

			local effects = {}

			for i = 1, card.ability.extra.copies do
				local left_ret = SMODS.blueprint_effect(card, G.jokers.cards[my_pos - 1], context)
				local right_ret = SMODS.blueprint_effect(card, G.jokers.cards[my_pos + 1], context)
				if left_ret then
					left_ret.colour = G.C.RED
				end
				table.insert(effects, left_ret)
				if right_ret then
					right_ret.colour = G.C.BLUE
				end
				table.insert(effects, right_ret)
			end

			return SMODS.merge_effects(effects);
		end
	end,

	check_for_unlock = function(self, args)
		if args.type == 'modify_jokers' then
			local has_blueprint = false;
			local has_brainstorm = false;
			for i = 1, #G.jokers.cards do
				local joker = G.jokers.cards[i];
				if joker.ability.name == 'Blueprint' then
					has_blueprint = true;
				end
				if  joker.ability.name == 'Brainstorm' then
					has_brainstorm = true;
				end
				if has_blueprint and has_brainstorm then return true end
			end
		end
		return false
	end
}

-- Recursion creation

local select_blind_ref = G.FUNCS.select_blind;
G.FUNCS.select_blind = function(e)
	if next(find_joker("Blueprint")) and next(find_joker("Brainstorm")) then
		-- Check if Blueprint is the leftmost joker and Brainstorm is to the right of Blueprint
		local leftmost = G.jokers.cards[1];
		local the_right = G.jokers.cards[2];

		if leftmost.ability.name == 'Blueprint' and the_right.ability.name == 'Brainstorm' and not leftmost.ability.eternal and not the_right.ability.eternal then -- Eternals can't be destroyed
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound('tarot2')

					leftmost.T.r = -0.2
					leftmost:juice_up(0.3, 0.4)
					leftmost.states.drag.is = true
					leftmost.children.center.pinch.x = true

					the_right.T.r = 0.2
					the_right:juice_up(0.3, 0.4)
					the_right.states.drag.is = true
					the_right.children.center.pinch.x = true

					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(leftmost);
							G.jokers:remove_card(the_right);
							leftmost:remove();
							the_right:remove();

							local card = SMODS.create_card {
								set = "Joker",
								key = 'j_nest_recursion'
							}
							card:set_edition({ negative = (#G.jokers.cards + 1) > G.jokers.config.card_limit }) -- Make it negative if Recursion would be above the card limit (pretty much only happens if the Blueprint and Brainstorm are both negatives)
							card:add_to_deck()
							G.jokers:emplace(card)
							return true;
						end
					}))

					return true
				end
			}))
		end
	end
	return select_blind_ref(e);
end
