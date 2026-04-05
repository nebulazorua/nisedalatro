SMODS.Sound {
	key = "nest_goated_cookie",
	path = "cookie_hit.ogg" -- temporary
}


SMODS.Consumable {
    key = 'fortune_cookie',
    set = 'Tarot',
    pos = { x = 2, y = 0 },
    config = { extra = { odds = 25 , mult = 1.5} },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'nest_fortune_cookie')
        local mult = card.ability.extra.mult
        return { vars = { numerator, denominator, mult }}
    end,
    use = function(self, card, area, copier)
		if SMODS.pseudorandom_probability(card, "nest_fortune_cookie", 1, card.ability.extra.odds)then
			play_sound("nest_goated_cookie")
			local thingsToCheck = { jokers = G.jokers.cards, cons = G.consumeables.cards, shop = G.shop_jokers == nil and
			{} or G.shop_jokers.cards }
			for _, thing in next, thingsToCheck do
				for it = 1, #thing do
					local item = thing[it]
					for k,v in pairs(item.ability) do
						if type(v) == 'number' then
							if v ~= 0 and (v ~= 1 or (k ~= 'x_chips' and k ~= 'x_mult'))then
								v = v * card.ability.extra.mult
								item.ability[k] = v
							end
						elseif k == 'extra' then
							for k2,v2 in pairs(item.ability.extra) do
								if type(v2) == 'number' then
									v2 = v2 * card.ability.extra.mult
									item.ability.extra[k2] = v2
								end
							end
						end
					end
				end
			end
		else
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					attention_text({
						text = localize('k_nope_ex'),
						scale = 1.3,
						hold = 1.4,
						major = card,
						backdrop_colour = G.C.SECONDARY_SET.Tarot,
						align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
							'tm' or 'cm',
						offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
						silent = true
					})
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.06 * G.SETTINGS.GAMESPEED,
						blockable = false,
						blocking = false,
						func = function()
							play_sound('tarot2', 0.76, 0.4)
							return true
						end
					}))
					play_sound('tarot2', 1, 0.4)
					card:juice_up(0.3, 0.5)
					return true
				end
			}))
        end
    end,
    can_use = function(self, card)
        return true
    end
}