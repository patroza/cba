/* ----------------------------------------------------------------------------
Function: CBA_fnc_addDisplayHandler

Description:
	Adds an action to a displayHandler
	
Parameters:
	_type - Displayhandler type to attach to [String].
	_code - Code to execute upon event [String].

Returns:
	the id of the attached handler

Examples:
	(begin example)
		_id = ["KeyDown", "_this call myKeyDownEH"] call CBA_fnc_addDisplayHandler;
	(end)

Author:
	Sickboy
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addDisplayHandler);

if (isDedicated) exitWith { WARNING("Function called on dedicated. Should only run on clients") };

private ["_ar", "_id", "_idx"];
PARAMS_2(_type,_code);

_type = toLower _type;
// TODO: Verify if the eventhandler type exists?
_ar = [GVAR(handler_hash), _type] call CBA_fnc_hashGet;
if (count _ar > 0) then
{
	_id = _ar select 0;
} else { 
	if (isNull (findDisplay 46)) then
	{
		_id = nil;
	} else {
		_id = (findDisplay 46) displayAddEventhandler [_type, format["[_this, '%1'] call " + QUOTE(FUNC(displayHandler)), _type]];
	};
	_ar set [0, if (isNil "_id") then { nil } else { _id }];
	_ar set [1, []];
	[GVAR(handler_hash), _type, _ar] call CBA_fnc_hashSet;
};
_handlers = _ar select 1;
PUSH(_handlers,[_code]);
_idx = count _handlers;

if (isNil "_id") then
{
	[] spawn FUNC(attach_handler)
};

_idx;
