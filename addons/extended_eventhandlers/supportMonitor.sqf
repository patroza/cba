#include "script_component.hpp"
// XEH for non XEH supported addons
// Only works until someone uses removeAllEventhandlers on the object
// Only works if there is at least 1 XEH-enabled object on the Map - Place SLX_XEH_Logic to make sure XEH initializes.
// TODO: Perhaps do a config verification - if no custom eventhandlers detected in _all_ CfgVehicles classes, don't run this XEH handler - might be too much processing.

private ["_events", "_fnc", "_processedObjects"];
_events = [XEH_EVENTS];
_excludes = ["LaserTarget"]; // TODO: Anything else?? - Ammo crates for instance have no XEH by default due to crashes) - however, they don't appear in 'vehicles' list anyway.

// Add all (Init + "Other" XEH eventhandlers")
SLX_XEH_support_fnc_full = {
	TRACE_2("Adding XEH Full (cache hit)",_obj,_type);
	[_obj] call SLX_XEH_EH_Init;
	{ _obj addEventHandler [_x, compile format["_this call SLX_XEH_EH_%1", _x]] } forEach _events;
};

// Check existing "Other" XEH eventhandlers, add those which are missing
SLX_XEH_support_fnc_partial = {
	{
		_event = (_cfg >> _x);
		_XEH = false;

		if (isText _event) then {
			_eventAr = toArray(getText(_event));
			if (count _eventAr > 13) then {
				_ar = [];
				for "_i" from 0 to 13 do {
					PUSH(_ar,_eventAr select _i);
				};
				if (toString(_ar) == "_this call SLX") then { _full = false; _XEH = true };
			};
		};
		if !(_XEH) then { _partial = true; TRACE_3("Adding missing EH",_obj,_type,_x); _obj addEventHandler [_x, compile format["_this call SLX_XEH_EH_%1", _x]] };
	} forEach _events;
};

// Process each new unit
SLX_XEH_support_fnc_loop = {
	private ["_obj", "_cfg", "_init", "_initAr", "_XEH", "_type", "_full", "_partial"];
	_obj = _this select 0;
	
	_type = typeOf _obj;

	PUSH(SLX_XEH_support_processedObjects,_obj);

	// Already has Full XEH EH entries - Needs nothing!
	if (_type in SLX_XEH_support_xehClasses) exitWith { TRACE_2("Already XEH (cache hit)",_obj,_type) };

	// No XEH EH entries at all - Needs full XEH
	if (_type in SLX_XEH_support_fullClasses) exitWith { call SLX_XEH_support_fnc_full };
	
	if (_type in SLX_XEH_support_exclClasses) exitWith { TRACE_2("Exclusion, abort (cache hit)",_obj,_type) };

	_cfg = (configFile >> "CfgVehicles" >> _type >> "EventHandlers");
	// No EH class - Needs full XEH
	if !(isClass _cfg) exitWith {
		call SLX_XEH_support_fnc_full;
		TRACE_2("Caching (full)",_obj,_type);
		PUSH(SLX_XEH_support_fullClasses,_type);
	};
	
	_excl = false;
	{ if (_obj isKindOf _x) exitWith { _excl = true } } forEach SLX_XEH_support_excludes;
	if (_excl) exitWith {
		TRACE_2("Exclusion, abort and caching",_obj,_type);
		PUSH(SLX_XEH_support_exclClasses,_type);
	};

	// Check 1 - a XEH object variable
	// Cannot use anymore because we want to do deeper verifications
	//_XEH = _obj getVariable "Extended_FiredEH";
	//if !(isNil "_XEH") exitWith { TRACE_2("Has XEH (1)",_obj,_type) };

	// Check 2 - XEH init EH detected
	_init = _cfg >> "init";

	_XEH = false;
	if (isText _init) then {
		_initAr = toArray(getText(_init));
		if (count _initAr > 11) then {
			_ar = [];
			for "_i" from 0 to 11 do {
				PUSH(_ar,_initAr select _i);
			};
			if (toString(_ar) == "if(isnil'SLX") then { _XEH = true };
		};
	};
	
	_full = false; // Used for caching objects that need ALL eventhandlers assigned, incl init.
	if (_XEH) then {
		TRACE_2("Has XEH init",_obj,_type)
	} else {
		TRACE_2("Adding XEH init",_obj,_type);
		[_obj] call SLX_XEH_EH_Init;
		_full = true;
	};
	
	// Add script-eventhandlers for those events that are not setup properly.
	_partial = false;
	call SLX_XEH_support_fnc_partial;

	if !(_partial) then { TRACE_2("Caching",_obj,_type); PUSH(SLX_XEH_support_xehClasses,_type); };
	if (_full) then { TRACE_2("Caching (full)",_obj,_type); PUSH(SLX_XEH_support_fullClasses,_type); };
};

SLX_XEH_support_processedObjects = []; // Used to maintain the list of processed objects
SLX_XEH_support_xehClasses = []; // Used to cache classes that have full XEH setup
SLX_XEH_support_fullClasses = []; // Used to cache classes that NEED full XEH setup
SLX_XEH_support_exclClasses = []; // Used for exclusion classes

// Detect new units and check if XEH is enabled on them
[] spawn {
	if (isNil "cba_common_fnc_directCall") then {
		while {true} do {
			call SLX_XEH_support_fnc_loop;
			sleep 2;
		};
	} else {
		while {true} do {
			_obj = [[], {call SLX_XEH_support_fnc_loop}] call CBA_common_fnc_directCall;
			waitUntil {isNull _obj};
			sleep 2;
		};
	};
};
