/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeDisplayHandler

Description:
	Removes an action to a displayHandler
	
Parameters:
	_type - Displayhandler type to attach to [String].
	_id - Displayhandler ID to remove [Code].

Returns:

Examples:
	(begin example)
		["KeyDown", _id] call CBA_fnc_removeDisplayHandler;
	(end)

Author:
	Sickboy
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(removeDisplayHandler);

private ["_ar", "_entry"];
PARAMS_2(_type,_index);

_type = toLower _type;
_ar = [GVAR(handler_hash), _type] call CBA_fnc_hashGet;
if (count _ar > 0) then
{
	_id = _ar select 0;
	_handlers = _ar select 1;
	if (count _handlers <= _index) exitWith { WARNING("Tried to remove inexistend handler") }; // Doesn't exist
	_handlers set [_index, []];
	// TODO: If no handlers left, remove eventhandler
	// if !(isNull(findDisplay 46)) then { (findDisplay 46) displayRemoveEventhandler [_type, _id] };
	// _ar set [0, nil];
};
