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
			},
			j_nest_skibidi_toilet = {
				name = "Skibidi Toilet",
				text = {
					"If current hand contains a {C:attention}#4#{}",
					"apply {X:mult,C:white}X#3#{} Mult per card played.",
					"{C:inactive}(Has a {C:green}#1# in #2#{C:inactive} chance to flush itself){}",
					"{C:inactive}\"Skibidi Toilet, or Creeper?\"{}"
				}
			},
			j_nest_creeper = {
				name = "Creeper",
				text = {
					"If current hand contains only {C:diamonds}#4#{}",
					"apply {X:mult,C:white}X#3#{} Mult per card played.",
					"{C:inactive}(Has a {C:green}#1# in #2#{C:inactive} chance to explode",
					"{C:inactive}destroying itself and the played hand){}",
					"{C:inactive}\"Skibidi Toilet, or Creeper?\"{}"
				},
			j_nest_red = {
				name = "Red",
				text = {
					"When {C:attention}Blind{} is selected,",
					"{C:red}Consumes{} {C:attention}Joker{} to the right",
					"and permenantly add {X:mult,C:white}XMult{}",
					"based on it's rarity.",

					"{C:inactive}({C:red}Consumed{C:inactive} cards will not reappear!)",
					"{C:inactive}(Currently at {X:mult,C:white}X#2#{C:inactive}, will give {X:mult,C:white}X#1#{C:inactive})",
				}
			},
						j_nest_seven_chips = {
				name = "7chips",
				text = {
					"Gains #3# chips per 7 played.",
					"{C:inactive}(Has a {C:green}#1# in #2#{C:inactive} chance to gain {X:chips,C:white}X#3#{} Chips instead!",
					"{C:inactive}(Currently #4# chips){C:inactive}"
				}
			},
			j_nest_seveteen_chips = {
				name = "17chips",
				text = {
					"Gains #3# mult per Ace and 7 played,",
					"ONLY when a both are played and scoring.",
					"{C:inactive}(Has a {C:green}#1# in #2#{C:inactive} chance to gain {X:chips,C:white}X#3#{} Mult instead!",
					"{C:inactive}(Currently #4# mult){C:inactive}"
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
			k_nest_mythic = "Mythic",
			k_nest_bumper = 'Bumper',
			k_nest_sovl = 'Sovl!',
			k_nest_susovl = 'SuperSovl!',
			k_nest_horrid = 'Horrid'
		},
		},
		labels = {
			nest_epic = "Epic",
			nest_mythic = "Mythic",
			nest_bumper = "Bumper",
			nest_horrid = "Horrid"
		}
	}
}