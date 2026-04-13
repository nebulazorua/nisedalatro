
local CardShatter = Card.shatter;
function Card:shatter()
	check_for_unlock({ type = 'card_destroyed', card = self })
	return CardShatter(self);
end

local CardDissolve = Card.start_dissolve;

function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
	check_for_unlock({ type = 'card_destroyed', card = self })
	return CardDissolve(self, dissolve_colours, silent, dissolve_time_fac, no_juice);
end


local AddToPool = SMODS.add_to_pool;

function SMODS.add_to_pool(prototype_obj, args)
	local reds = SMODS.find_card("j_nest_red");
	if #reds > 0 then
		for _, red in next, reds do
			if (red.ability.immutable.personally_consumed[prototype_obj.key]) then
				return false;
			end
		end
	end
	if G.GAME.modifiers.nest_all_clubs and prototype_obj.key == "m_stone" then
		return false;
	end

	return AddToPool(prototype_obj, args)
end

local CreatePlayingCard = create_playing_card;

function create_playing_card(card_init, area, skip_materialize, silent, colours, skip_emplace)
	local card = CreatePlayingCard(card_init, area, skip_materialize, silent, colours, skip_emplace)
	if G.GAME.modifiers.nest_all_clubs then
		card:change_suit("Clubs")
	end
	return card;
end