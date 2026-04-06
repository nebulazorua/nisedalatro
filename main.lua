Nisedalatro = {}
Nisedalatro.mod = SMODS.current_mod;

SMODS.Rarity {
	key = 'mythic',
	badge_colour = HEX 'FFDD66',
	pools = { ["Joker"] = true },
	default_weight = 0
}


SMODS.load_file("misc/overrides.lua")()
SMODS.load_file("content/consumables.lua")()
SMODS.load_file("content/jokers.lua")() -- Load all the Nisedalatro jokers
SMODS.load_file("content/mythic_jokers.lua")()

SMODS.load_file("compat/jokerdisplay.lua")()