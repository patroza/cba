// TODO: Sort out A2 from OA!
class CfgVehicles {
	class All {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Static: All { class EventHandlers {}; }; // Manually created
	class LandVehicle;
	class Car: LandVehicle {
		class Eventhandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Tank: LandVehicle {
		class Eventhandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Air;
	class Helicopter: Air {
		class Eventhandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Plane: Air {
		class Eventhandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class AllVehicles;
	class Ship: AllVehicles {
		class Eventhandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	/*
	class ParachuteBase: Helicopter {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	*/
	class StaticWeapon;
	class StaticCannon: StaticWeapon {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	/*
	class BIS_Steerable_Parachute: Plane {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	*/
	class Animal;
	class CAAnimalBase: Animal {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class StaticMortar;
	class M252: StaticMortar {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class 2b14_82mm: StaticMortar {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class SoldierWB;
	class FR_Base: SoldierWB { class EventHandlers; };
	class FR_Miles: FR_Base {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};
	class FR_GL: FR_Base { class EventHandlers; };
	class FR_Cooper: FR_GL {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};
	class FR_Marksman: FR_Base { class EventHandlers; };
	class FR_Sykes: FR_Marksman {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};
	class FR_Corpsman: FR_Base { class EventHandlers; };
	class FR_OHara: FR_Corpsman {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};
	class FR_AR: FR_Base { class EventHandlers; };
	class FR_Rodriguez: FR_AR {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};
	class Civilian;
	class SoldierEB;
	class SoldierGB;

	class HelicopterWreck;
	class AH1ZWreck: HelicopterWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class MH60Wreck: HelicopterWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class PlaneWreck;
	class AV8BWreck: PlaneWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Mi17Wreck: HelicopterWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Land_Fire;
	class Land_Fire_burning: Land_Fire {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Land_Campfire;
	class Land_Campfire_burning: Land_Campfire {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Land_Fire_barrel: Land_Fire {};
	class Land_Fire_barrel_burning: Land_Fire_barrel {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrier;
	class FlagCarrierUSA: FlagCarrier {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierCDF: FlagCarrierUSA {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierRU: FlagCarrierUSA {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierINS: FlagCarrierUSA {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierGUE: FlagCarrierUSA {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierCore;
	class FlagCarrierChecked: FlagCarrierCore {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TargetBase;
	class TargetPopUpTarget: TargetBase {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TargetEpopup: TargetBase {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Land_Barrack2;
	class Barrack2: Land_Barrack2 {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Grave;
	class Mass_grave: Grave {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Tracked_APC;
	class AAV: Tracked_APC {
		class EventHandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Pickup_PK_base: Car { class Eventhandlers; };
	class A10: Plane {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class A10Wreck: PlaneWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class SU25Wreck: PlaneWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Mi24Wreck: HelicopterWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class F35bWreck: PlaneWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class MQ9PredatorWreck: PlaneWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class MV22Wreck: PlaneWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class C130JWreck: PlaneWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Ka52Wreck: HelicopterWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class UH1YWreck: HelicopterWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Su34: Plane {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class MQ9PredatorB;
	class CruiseMissile2: MQ9PredatorB {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
};
