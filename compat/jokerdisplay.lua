if not JokerDisplay then return end

JokerDisplay.Definitions.j_nest_gargamel = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" },
			}
		}
	}
}
