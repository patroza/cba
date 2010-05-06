/* ----------------------------------------------------------------------------
Internal Function: CBA_events_fnc_displayHandler

Description:
	Executes the display's handler

Author: 
	Sickboy
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(displayHandler);

private ["_code", "_handled", "_result", "_handlers"];
#ifdef DEBUG_MODE_FULL
	private ["_ar"];
	_ar = [];
#endif

PARAMS_2(_data,_type);
_type = toLower _type;

_handlers = [GVAR(keyhandler_hash), _type] call CBA_fnc_hashGet;

GVAR(keypressed) = time; // Fine too, any displayhandler should trigger it as save-exit-start-loadgame will remove all handlers

_handled = false; // If true, suppress the default handling of the key.
_result = false;

{
	if (true) then
	{
		if (count _x == 0) exitWith {}; // Skip: TODO, this is kinda lame as it is at every event evaluated for nothing..
		_code = _x select 0;
		#ifdef DEBUG_MODE_FULL
			PUSH(_ar,_code);
		#endif
		_result = _data call _code;
		if (isNil "_result") then
		{
			WARNING("Nil result from handler.");
			_result = false;
		}
		else{if ((typeName _result) != "BOOL") then
		{
			TRACE_1("WARNING: Non-boolean result from handler.",_result);
			_result = false;
		}; };
	};
	
	// If any handler says that it has completely _handled_ the keypress,
	// then don't allow other handlers to be tried at all.
	if (_result) exitWith { _handled = true };
	
} forEach _handlers;

TRACE_1("displayHandler",_ar);

_handled;
