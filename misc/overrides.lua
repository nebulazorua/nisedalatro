
local CardShatter = Card.shatter;
function Card:shatter()
	check_for_unlock({ type = 'card_destroyed', card = self })
	return CardShatter(self);
end

local CardDissolve = Card.start_dissolve;

function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
	check_for_unlock({ type = 'card_destroyed', card = self })
	return CardDissolve(self, dissolve_colours, silent, dissolve_time_fac, no_juice);
end
