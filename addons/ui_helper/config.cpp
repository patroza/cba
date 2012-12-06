class CfgPatches
{
	class cba_ui_helper
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"CAUI"};
	};
};
class RscStandardDisplay;
//class RscDisplayMultiplayer: RscStandardDisplay
class RscDisplayMultiplayerSetup: RscStandardDisplay
{
	onLoad = "call compile preprocessFileLineNumbers 'x\cba\addons\ui_helper\onLoad.sqf';";
};