return {
	descriptions = {
		Joker = {
			j_nest_gargamel = {
				name = "Gargamel",
				text = {
					"When a played card with {C:clubs}Club{} suit is scored",
					"this jokers gains {X:mult,C:white}X#1#{} Mult",
					"and destroys the card.",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive})"
				}
			}
		},
		Tarot = {
			c_nest_fortune_cookie = {
				name = "Fortune Cookie",
				text = {
					"{C:green}#1# in #2#{} chance to increase the values of",
					"all currently {C:attention}held cards{}",
					"and all {C:attention}items currently in shop{}",
					"by {X:mult,C:white}X#3#{}"
				}
			}
		}
	},
	misc = {
		dictionary = {
			k_nest_gargamel = "Bid farewell!"
		}
	}
}