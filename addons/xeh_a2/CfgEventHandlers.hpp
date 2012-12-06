// TODO: Sort out A2 from OA!

// Extended EH classes, where new events are defined.
class Extended_Init_EventHandlers
{
	// Vehicles.
	class StaticCannon /* : StaticWeapon */ {
		SLX_BIS = QUOTE(if(isNil 'BIS_Effects_Init') then { call COMPILE_FILE2(\ca\Data\ParticleEffects\SCRIPTS\init.sqf) });
	};

	class M252 /* : StaticMortar */ {
		SLX_BIS = QUOTE(if(isNil 'BIS_Effects_Init') then { call COMPILE_FILE2(\ca\Data\ParticleEffects\SCRIPTS\init.sqf) });
	};
	class 2b14_82mm /* : StaticMortar */ {
		SLX_BIS = QUOTE(if(isNil 'BIS_Effects_Init') then { call COMPILE_FILE2(\ca\Data\ParticleEffects\SCRIPTS\init.sqf) });
	};
	class FR_Miles /* : FR_Base */ {
		SLX_BIS = "(_this select 0) setidentity ""Miles""";
	};
	class FR_Cooper /* : FR_GL */ {
		SLX_BIS = "(_this select 0) setidentity ""Cooper""";
	};
	class FR_Sykes /* : FR_Marksman */ {
		SLX_BIS = "(_this select 0) setidentity ""Sykes""";
	};
	class FR_OHara /* : FR_Corpsman */ {
		SLX_BIS = "(_this select 0) setidentity ""Ohara""";
	};
	class FR_Rodriguez /* : FR_AR */ {
		SLX_BIS = "(_this select 0) setidentity ""Rodriguez""";
	};

	class Land_Fire_burning /* : Land_Fire */ {
		SLX_BIS = "(_this select 0) inflame true";
	};
	class Land_Campfire_burning /* : Land_Campfire */ {
		SLX_BIS = "(_this select 0) inflame true";
	};
	class Land_Fire_barrel_burning /* : Land_Fire_barrel */ {
		SLX_BIS = "(_this select 0) inflame true";
	};
	class FlagCarrierUSA /* : FlagCarrier */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""\ca\data\flag_usa_co.paa""";
	};
	class FlagCarrierCDF /* : FlagCarrierUSA */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""\ca\data\flag_Chernarus_co.paa""";
	};
	class FlagCarrierRU /* : FlagCarrierUSA */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""\ca\data\flag_rus_co.paa""";
	};
	class FlagCarrierINS /* : FlagCarrierUSA */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""\ca\data\flag_ChDKZ_co.paa""";
	};
	class FlagCarrierGUE /* : FlagCarrierUSA */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""\ca\data\flag_NAPA_co.paa""";
	};
	class FlagCarrierChecked /* : FlagCarrierCore */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""\ca\structures\misc\armory\checkered_flag\data\checker_flag_co.paa""";
	};
	class Barrack2 /* : Land_Barrack2 */ {
		SLX_BIS = "(_this select 0) setdir getdir (_this select 0)";
	};
	class Mass_grave /* : Grave */ {
		SLX_BIS = QUOTE(dummy = _this spawn COMPILE_FILE2(ca\characters2\OTHER\scripts\fly.sqf));
	};
	class AAV /* : Tracked_APC */ {
		SLX_BIS = QUOTE(if(isNil 'BIS_Effects_Init') then { call COMPILE_FILE2(\ca\Data\ParticleEffects\SCRIPTS\init.sqf) };_this spawn COMPILE_FILE2(\ca\tracked2\AAV\scripts\init.sqf));
	};
	class A10 /* : Plane */ {
		SLX_BIS = QUOTE(if(isNil 'BIS_Effects_Init') then { call COMPILE_FILE2(\ca\Data\ParticleEffects\SCRIPTS\init.sqf) });
	};
	class Su34 /* : Plane */ {
		SLX_BIS = QUOTE(if(isNil 'BIS_Effects_Init') then { call COMPILE_FILE2(\ca\Data\ParticleEffects\SCRIPTS\init.sqf) });
	};
};

class Extended_firedBis_Eventhandlers { // New fired EH, uses BIS notation
	class StaticCannon /* : StaticWeapon */ {
		SLX_BIS = "_this call BIS_Effects_EH_Fired";
	};
	class M252 /* : StaticMortar */ {
		SLX_BIS = "_this call BIS_Effects_EH_Fired";
	};
	class 2b14_82mm /* : StaticMortar */ {
		SLX_BIS = "_this call BIS_Effects_EH_Fired";
	};
	class A10 /* : Plane */ {
		SLX_BIS = "_this call BIS_Effects_EH_Fired";
	};
	class Su34 /* : Plane */ {
		SLX_BIS = "_this call BIS_Effects_EH_Fired";
	};
};

class Extended_firednear_Eventhandlers {
	class CAAnimalBase /* : Animal */ {
		SLX_BIS = "_this execFSM ""CA\animals2\Data\scripts\reactFire.fsm""";
	};
};
class Extended_hit_Eventhandlers {
	class TargetPopUpTarget /* : TargetBase */ {
		SLX_BIS = QUOTE([(_this select 0)] spawn COMPILE_FILE2(ca\misc\scripts\PopUpTarget.sqf));
	};
	class TargetEpopup /* : TargetBase */ {
		SLX_BIS = QUOTE([(_this select 0)] spawn COMPILE_FILE2(ca\misc\scripts\PopUpTarget.sqf));
	};
};
class Extended_killed_Eventhandlers {
	class A10 /* : Plane */ {
		SLX_BIS = "_this call BIS_Effects_EH_Killed";
	};
	class Su34 /* : Plane */ {
		SLX_BIS = "_this call BIS_Effects_EH_Killed";
	};
};

class DefaultEventHandlers;
