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
				},
				unlock = {
					"Destroy {E:1,C:attention}#1#",
					"cards with {E:!,C:attention}#2#",
					"suit in one run."
				}
			},
			j_nest_recursion = {
				name = "Recursion",
				text = {
					"Copies {C:attention}Jokers{}",
					"to the left and right",
					"{C:attention}#1#{} time#2#."
				},
				unlock = {
					"Have both a {C:attention}Blueprint{}",
					"and a {C:attention}Brainstorm{}",
					"at the same time"
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
			k_nest_mythic = "Mythic"
		},
		labels = {
			nest_mythic = "Mythic"
		}
	}
}