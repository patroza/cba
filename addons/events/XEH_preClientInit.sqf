//#define DEBUG_MODE_FULL
#include "script_component.hpp"
/*
	Custom events
*/
LOG(MSG_INIT);

["CBA_loadGame", { [] spawn FUNC(attach_handler) }] call CBA_fnc_addEventHandler;
["CBA_playerSpawn", { LOG("Player spawn detected!") }] call CBA_fnc_addEventHandler;

[] spawn
{
	private ["_lastPlayer", "_newPlayer"];
	waitUntil {player == player};
	_lastPlayer = objNull;
	while {true} do
	{
		waitUntil {player != _lastPlayer};
		waitUntil {!(isNull player)};
		_newPlayer = player; // Cumbersome but ensures refering to the same object
		["CBA_playerSpawn", [_newPlayer, _lastPlayer]] call CBA_fnc_localEvent;
		_lastPlayer = _newPlayer;
	};
};


// Display Eventhandlers - Abstraction layer
PREP(displayHandler);

GVAR(attaching) = false;

FUNC(handle_retach) = 
{
	private ["_id", "_ar"];
	// _key and _value
	TRACE_2("",_key,_value);
	
	// Only remove handler if it exists (has an id)
	_id = _value select 0;
	if !(isNil "_id")
	{
		TRACE_2("Removing",_key,_id);
		(findDisplay 46) displayRemoveEventHandler [_key, _id];
	};

	// Only add handler back if there are actually handlers
	// TODO: Account for 'empty' arrays? Could use a counter to keep count of active, non active.
	_ar = _value select 1;
	if (count _ar > 0) then
	{
		TRACE_1("Adding",_key);
		_value set [0, (findDisplay 46) displayAddEventHandler [_key, format["[_this, '%1'] call " + QUOTE(FUNC(displayHandler)), _key]]];
	};
};

// TODO: Stack/multiplex into single events per type ?
FUNC(attach_handler) =
{
	if (GVAR(attaching)) exitWith {}; // Already busy
	GVAR(attaching) = true;
	TRACE_3("ReAttaching",GVAR(attaching),GVAR(keypressed),time);

	waitUntil { !(isNull (findDisplay 46)) };
	TRACE_1("Display found!",time);
	_handle = { [GVAR(handler_hash), {call FUNC(handle_retach)}] call CBA_fnc_hashEachPair } execFSM CBA_common_delayLess;
	waitUntil {completedFSM _handle};
	GVAR(attaching) = false;
};


// Display Eventhandlers - Higher level API specially for keyDown/Up and Action events
// Workaround , in macros
#define UP [_this, 'keyup']
#define DOWN [_this, 'keydown']

PREP(keyHandler);

[] spawn
{
	waitUntil { !(isNull (findDisplay 46)) };
	// Workaround for Single Player, mission editor, or mission, preview/continue, whatever, adding double handlers
	if !(isMultiplayer) then { { (findDisplay 46) displayRemoveAllEventHandlers _x } forEach ["KeyUp", "KeyDown"] };

	["KeyUp", QUOTE(UP call FUNC(keyHandler))] call CBA_fnc_addDisplayHandler;
	["KeyDown", QUOTE(DOWN call FUNC(keyHandler))] call CBA_fnc_addDisplayHandler;

	// ["KeyDown", QUOTE(_this call FUNC(actionHandler))] call CBA_fnc_addDisplayHandler;

	// Workaround for displayEventhandlers falling off at gameLoad after gameRestart
	// Once the last registered keypress is longer than 10 seconds ago, re-attach the handler.
	GVAR(keypressed) = time;
	while {true} do
	{
		waitUntil {(time - GVAR(keypressed)) > 10};
		TRACE_1("Longer than 10 seconds ago",_this);
		call FUNC(attach_handler);
		GVAR(keypressed) = time;
	};
};
