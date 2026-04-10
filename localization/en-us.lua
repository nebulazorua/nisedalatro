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
			j_nest_chud = {
				name = "Nothing Ever Happens",
				text = {
					"Reduces all {C:attention}listed",
					"{C:green,E:1,S:1.1}probabilities{} to 0",
					"{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}0 in 3{C:inactive})",
				}
			},
			j_nest_goated = {
				name = "Goated Shirt",
				text = {
					"The {C:green,E:1,S:1.1}probability{} of",
					"{C:attention}The Fortune Cookie{} increases",
					"with each failure.",
					"{C:inactive}(Resets on successful use){}"
				},
				unlock = {
					"Successfully be deemed",
					"{C:attention}GOATED{}",
					"By The Fortune Cookie"
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
			j_nest_hot_dog = {
				name = "Ghost Wolf",
				text = {
					"This Joker gains",
					"{X:mult,C:white}X#1#{} Mult every time",
					"a {C:spectral}Spectral{} card is used",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}"
				}
			},

			j_nest_skibidi_toilet = {
				name = "Skibidi Toilet",
				text = {
					"If current hand contains a {C:attention}#4#{}",
					"each scored card gives {X:mult,C:white}X#3#{} Mult.",
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
					"Gains {C:chips}+#3#{} Chips per {C:attention}7{} scored.",
					"{C:inactive}(Has a {C:green}#1# in #2#{C:inactive} chance to gain {X:chips,C:white}X#3#{} {C:inactive}Chips instead!",
					"{C:inactive}(Currently #4# Chips){C:inactive}"
				}
			},
			j_nest_seventeen_mult = {
				name = "17mult",
				text = {
					"Gains {C:mult}+#3#{} Mult per {C:attention}Ace{} and {C:attention}7{} scored together,",
					"{C:inactive}(Has a {C:green}#1# in #2#{C:inactive} chance to gain {X:mult,C:white}X#5#{} {C:inactive}Mult instead!",
					"{C:inactive}(Currently #4# Mult){C:inactive}"
				}
			}
		},
		Tarot = {
			c_nest_fortune_cookie = {
				name = "The Fortune Cookie",
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
		labels = {
			nest_epic = "Epic",
			nest_mythic = "Mythic",
			nest_bumper = "Bumper",
			nest_horrid = "Horrid"
		}
	}
}