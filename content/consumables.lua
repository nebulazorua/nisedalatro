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

        local thingsToCheck = {jokers = G.jokers.cards, cons = G.consumeables.cards, shop = G.shop_jokers.cards}
        for i in 1, #thingsToCheck do
            local thing = thingsToCheck[i]
            for it = 1, #thing do
                local item = thing[it]
                for k,v in pairs(item.ability) do
                    if k == 'extra' then
                        for k2,v2 in pairs(item.ability.extra) do
                            if type(v2) == 'number' then
                                v2 = v2 * card.ability.extra.mult
                                item.ability.extra[k2] = v2
                            end
                        end
                    end
                    if type(v) == 'number' then
                        v = v * card.ability.extra.mult
                        item.ability[k] = v
                    end
                end
            end
        end
    end,
    can_use = function(self, card)
        return true
    end
}