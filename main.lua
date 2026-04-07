Nisedalatro = {}
Nisedalatro.mod = SMODS.current_mod;

SMODS.Rarity {
	key = "epic",
	badge_colour = HEX('FF00FF'),
	default_weight = 0.005,
	get_weight = function(self, weight, object_type)
		return weight
	end,
	pools = { ["Joker"] = true }
}

SMODS.Rarity {
	key = 'mythic',
	badge_colour = HEX 'FFDD66',
	pools = { ["Joker"] = true },
	default_weight = 0
}


--- @param card SMODS.Joker
--- @return number
--- Returns the index that the joker is at. Returns -1 if the Joker isn't in the Joker area.
function Nisedalatro.get_joker_index(card)
	local my_pos = -1
	for i = 1, #G.jokers.cards do
		if G.jokers.cards[i] == card then
			my_pos = i
			break
		end
	end
	return my_pos;
end

--- @param card Card
--- @return number
--- Returns the index that the card is at. Returns -1 if the Joker isn't in an area. 
--- Shouldn't be used in Joker calculation.
--- @see Nisedalatro.get_joker_index
function Nisedalatro.get_card_index(card)
	local my_pos = -1
	for i = 1, #card.area.cards do
		if card.area.cards[i] == card then
			my_pos = i
			break
		end
	end
	return my_pos;
end

local function load_file(file)
	local f, err = SMODS.load_file(file);
	if err then
		error(err, 2);
	else
		return f();
	end
end


-- TODO: Make bumper cards & brap radio bumper for horrids to appear from
-- ALSO: figure out a new name for brap radio since its stupid and we dont want that in a public release
SMODS.Rarity {
	key = 'horrid',
	badge_colour = HEX '000000',
	pools = { ["Joker"] = true },
	default_weight = 0.005
}


load_file("misc/overrides.lua")
load_file("content/consumables.lua")
load_file("content/jokers.lua") 
load_file("content/legendary_jokers.lua")
load_file("content/mythic_jokers.lua")

load_file("compat/jokerdisplay.lua")