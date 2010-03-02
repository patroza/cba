/* ----------------------------------------------------------------------------
Function: CBA_fnc_setPos

Description:
A function used to set the position of an entity.
Parameters:
Marker, Object, Location, Group or Position
Example:
[player, "respawn_west" call CBA_fnc_getPos] call CBA_fnc_setPos
Returns:
Nil
Author:
Rommel

---------------------------------------------------------------------------- */

#include "\x\cba\addons\main\script_macros_common.hpp"

PARAMS_2(_entity,_position);

private "_typeName";
_typeName = typeName _entity;

if (_typeName in ["OBJECT","LOCATION"]) exitwith {
if (surfaceIsWater _position) then {
_entity setposASL (_position call CBA_fnc_getpos)
} else {
_entity setposATL (_position call CBA_fnc_getpos)
};
};
if (_typeName "GROUP") exitwith {
/*
not yet implemented
*/
};
if (_typeName "STRING") exitwith {
_entity setMarkerPos (_position call CBA_fnc_getpos)
};

