/*  PostInit.sqf

	Compile code strings in the Extended_PostInit_EventHandlers class and call
	them. This is done once per mission and after all the extended init event
	handler code is run. An addon maker can put run-once, late initialisation
	code in such a post-init "EH" rather than in a normal XEH init EH which
	 might be called several times.
*/
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

#ifdef DEBUG_MODE_FULL
diag_log text format["(%1) XEH BEG: PostInit", time];
#endif

// Warn if PostInit takes longer than 10 tickTime seconds
// Remove black-screen + loading-screen on timeOut
[] spawn
{
	private["_time2Wait"];
	_time2Wait = diag_ticktime + 10;
	waituntil {diag_ticktime > _time2Wait};
	if !(SLX_XEH_MACHINE select 8) then { XEH_LOG("WARNING: PostInit did not finish in a timely fashion"); if !(isDedicated) then { 4711 cutText ["","PLAIN", 0.01] }; endLoadingScreen };
};

GVAR(init_obj) = "HeliHEmpty" createVehicleLocal [0, 0, 0];
GVAR(init_obj) addEventHandler ["killed", {
	XEH_LOG("XEH: VehicleInit Started");
	{
		_sim = getText(configFile/"CfgVehicles"/(typeOf _x)/"simulation");
		_crew = crew _x;
		/*
		* If it's a vehicle then start event handlers for the crew.
		* (Vehicles have crew and are neither humanoids nor game logics)
		*/
		if ((count _crew>0)&&{ _sim == _x }count["soldier", "invisible"] == 0) then
		{
			{ [_x, "Extended_Init_Eventhandlers"] call SLX_XEH_init } forEach _crew;
		};
	} forEach vehicles;
	
	XEH_LOG("XEH: VehicleInit Finished, PostInit Started");
	deleteVehicle GVAR(init_obj);GVAR(init_obj) = nil
}];
GVAR(init_obj) setDamage 1;
waitUntil {isNil QUOTE(GVAR(init_obj))};


// On Server + Non JIP Client, we are now after all objects have inited
// and at the briefing, still time == 0
if (isNull player) then
{
	if (!isDedicated && !(SLX_XEH_MACHINE select 6)) then // only if MultiPlayer and not dedicated
	{
		#ifdef DEBUG_MODE_FULL
		diag_log text "JIP";
		#endif

		SLX_XEH_MACHINE set [1, true]; // set JIP
		// TEST for weird jip-is-server-issue :S
		if (!(SLX_XEH_MACHINE select 2) || SLX_XEH_MACHINE select 3 || SLX_XEH_MACHINE select 4) then {
			diag_log ["WARNING: JIP Client, yet wrong detection", SLX_XEH_MACHINE];
			SLX_XEH_MACHINE set [2, true]; // set Dedicated client
			SLX_XEH_MACHINE set [3, false]; // set server
			SLX_XEH_MACHINE set [4, false]; // set dedicatedserver
		};
		waitUntil { !(isNull player) };
		waitUntil { local player };
	};
};

if !(isNull player) then
{
	if (isNull (group player)) then
	{
		// DEBUG TEST: Crashing due to JIP, or when going from briefing
		//			 into game
		#ifdef DEBUG_MODE_FULL
		diag_log text "NULLGROUP";
		#endif		
		waitUntil { !(isNull (group player)) };
	};
};

SLX_XEH_MACHINE set [5, true]; // set player check = complete
// diag_log text format["(%2) SLX_XEH_MACHINE: %1", SLX_XEH_MACHINE, time];

// Loading screen minimal 1s
private["_time2Wait"];
if !(isDedicated) then { _time2Wait = diag_ticktime + 1 };

GVAR(init_obj) = "HeliHEmpty" createVehicleLocal [0, 0, 0];
GVAR(init_obj) addEventHandler ["killed", {
	// General InitPosts
	{	(_x/"Extended_PostInit_EventHandlers") call SLX_XEH_F_INIT } forEach [configFile, campaignConfigFile, missionConfigFile];

	// we set this BEFORE executing the inits, so that any unit created in another
	// thread still gets their InitPost ran
	SLX_XEH_MACHINE set [7, true];
	{ _x call SLX_XEH_init } forEach SLX_XEH_OBJECTS; // Run InitPosts
	deleteVehicle GVAR(init_obj);GVAR(init_obj) = nil
}];
GVAR(init_obj) setDamage 1;
waitUntil {isNil QUOTE(GVAR(init_obj))};

// XEH for non XEH supported addons
// Only works until someone uses removeAllEventhandlers on the object
// Only works if there is at least 1 XEH-enabled object on the Map - Place SLX_XEH_Logic to make sure XEH initializes.
// TODO: Perhaps do a config verification - if no custom eventhandlers detected in _all_ CfgVehicles classes, don't run this XEH handler - might be too much processing.

SLX_XEH_support_events = [XEH_EVENTS];
SLX_XEH_support_excludes = ["LaserTarget"]; // TODO: Anything else?? - Ammo crates for instance have no XEH by default due to crashes) - however, they don't appear in 'vehicles' list anyway.

SLX_XEH_support_fnc_loop = {
	SLX_XEH_support_processedObjects = SLX_XEH_support_processedObjects - [objNull]; // cleanup
	{ [_x] call SLX_XEH_support_fnc } forEach ((vehicles+allUnits) - SLX_XEH_support_processedObjects); // TODO: Does this need an isNull check?
};

// Add all (Init + "Other" XEH eventhandlers")
SLX_XEH_support_fnc_full = {
	TRACE_2("Adding XEH Full (cache hit)",_obj,_type);
	[_obj] call SLX_XEH_EH_Init;
	{ _obj addEventHandler [_x, compile format["_this call SLX_XEH_EH_%1", _x]] } forEach SLX_XEH_support_events;
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
	} forEach SLX_XEH_support_events;
};

// Process each new unit
SLX_XEH_support_fnc = {
	private ["_cfg", "_init", "_initAr", "_XEH", "_type", "_full", "_partial"];
	PARAMS_1(_obj);
	
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
		PUSH(_fullClasses,_type);
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

[] spawn {
	// Detect new units and check if XEH is enabled on them
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

if (!isDedicated && !isNull player) then { // isNull player check is for Main Menu situation.
	// Doing this before the spawn so we pull this into the PostInit, halted simulation state, for the initial player.
	_lastPlayer = player;
	_lastPlayer call SLX_XEH_F_ADDPLAYEREVENTS;
	_lastPlayer spawn {
		_lastPlayer = _this;
		// TODO: Perhaps this is possible in some event-style fashion, which would add the player events asap, synchronous.
		// (though perhaps not possible like teamswitch, besides, player == _unit is probably false at (preInit)?
		// TODO: Perhaps best run the statements in 'delayLess' FSM (or completely in delaylessLoop), synchronous, unscheduled?
		while {true} do {
			waitUntil {player != _lastPlayer};
			_lastPlayer call SLX_XEH_F_REMOVEPLAYEREVENTS;
			waitUntil {player == player};
			_lastPlayer = player;
			_lastPlayer call SLX_XEH_F_ADDPLAYEREVENTS;
		};
	};
};

// Remove black-screen + loading-screen
if !(isDedicated) then {
	#ifdef DEBUG_MODE_FULL
	diag_log ["Waiting...", _time2Wait, diag_tickTime];
	#endif
	waituntil {diag_ticktime > _time2Wait};
	4711 cutText ["", "PLAIN", 0.01];
};
endLoadingScreen;

SLX_XEH_MACHINE set [8, true];

XEH_LOG("XEH: PostInit Finished; " + str(SLX_XEH_MACHINE));

#ifdef DEBUG_MODE_FULL
diag_log text format["(%1) XEH END: PostInit", time];
#endif

nil;
