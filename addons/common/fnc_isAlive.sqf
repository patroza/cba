/* ----------------------------------------------------------------------------
Function: CBA_fnc_isAlive

Description:
	A function used to find out if the group or object is alive.
Parameters:
	Array, Group or Unit
Example:
	_alive = (Units player) call CBA_fnc_getAlive
Returns:
	Boolean
Author:
	Rommel

---------------------------------------------------------------------------- */

switch (typename _this) do {
	case "ARRAY" : {
		{
			if (_x call CBA_fnc_isalive) exitwith {true};
			false;
		} foreach _this;
	};
	case "OBJECT" : {
		alive _this;
	};
	case "GROUP" : {
		if (isnull (leader _this)) then {
			false;
		} else {
			(units _this) call CBA_fnc_isalive;
		};
	};
	default {alive _this};
};