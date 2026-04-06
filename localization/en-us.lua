return {
	descriptions = {
		Joker = {
			j_nest_gargamel = {
				name = "Gargamel",
				text = {
					"When a played card with {C:clubs}Club{} suit is scored,",
					"this Joker gains {X:mult,C:white}X#1#{} Mult",
					"and destroys the scoring card.",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive})"
				}
			},
			j_nest_skibidi_toilet = {
				name = "Skibidi Toilet",
				text = {
					"If current hand contains a Flush, apply {X:mult,C:white}X#3#{} Mult per card played.",
					"{C:inactive}(Has a {C:green}#1# in #2#{C:inactive} chance to flush itself!){}",
					"{C:rainbow}skibidi toilet or creeper!{}"
				}
			},
			j_nest_creeper = {
				name = "Creeper",
				text = {
					"If current hand contains only Diamonds, apply {X:mult,C:white}X#3#{} Mult per card played.",
					"{C:inactive}(Has a {C:green}#1# in #2#{C:inactive} chance to explode the Diamond cards in your hand and itself!){}",
					"{C:rainbow}skibidi toilet or creeper!{}"
				}
			}
		},
		Tarot = {
			c_nest_fortune_cookie = {
				name = "Fortune Cookie",
				text = {
					"{C:green}#1# in #2#{} chance",
					"to increase the values of",
					"all owned {C:attention}Jokers{} by {X:mult,C:white}X#3#{}",
					"{C:inactive}(The odds of goatedness get lower with each success!){}"
				}
			}
		}
	},
	misc = {
		dictionary = {
			k_nest_gargamel = "Bid farewell!",
			k_nest_kaboom = "Kaboom!",
			k_nest_flushed = "Flushed!",
			k_nest_epic = "Epic",
		},
		labels = {
            nest_epic = "Epic",
        },
	}
	
}