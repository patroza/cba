#include "\x\cba\addons\ui\script_component.hpp"
#include "\ca\editor\Data\Scripts\dikCodes.h"
#include "data\common.hpp"

#define _minObjectInteractionDistance 5 // arbitrary distance. Might not work with very long/large vehicles. TODO: Find a very fast way to determine vehicle size.

private["_handled", "_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt", 
	"_target", "_menuSource", "_active", "_potentialTarget", "_isTypeTarget", "_potentialKeyMatch", "_potentialMenuSource", "_vehicleTarget"];
_ctrl = _this select 0;
_dikCode = _this select 1;
_shift = _this select 2;
_ctrlKey = _this select 3;
_alt = _this select 4;

_handled = false;
//player sideChat format [__FILE__+": %1", [_this /* , GVAR(typeMenuSources) */]];

// scan typeMenuSources key list (optimise overhead)
_potentialKeyMatch = false;
{
	if (_dikCode in (_x select 1)) exitWith
	{
		_potentialKeyMatch = true;
	};
} forEach GVAR(typeMenuSources);

// interaction key used
if (_potentialKeyMatch || (_dikCode in _flexiMenu_interactKeys)) then
{
	if (!GVAR(optionSelected) && time-GVAR(lastAccessTime) > 0.4) then
	{
		GVAR(lastAccessTime) = time;
		// check if menu already open
		_active = (!isNil {uiNamespace getVariable QUOTE(GVAR(display))});
		if (_active) then
		{
			_active = (!isNull (uiNamespace getVariable QUOTE(GVAR(display))));
		};
		if (!_active) then
		{
			// examine cursor object for relevant menu def variable
			_target = objNull;
			// if dedicated interact key is used
			if (_dikCode in _flexiMenu_interactKeys) then {_target = cursorTarget};
			if (!isNull _target && _target distance player > _minObjectInteractionDistance) then {_target = objNull};

			_isTypeTarget = false;

			// check for [cursorTarget or "player" or "vehicle"] types in typeMenuSources list
			_potentialTarget = cursorTarget;
			if (!isNull _potentialTarget && _potentialTarget distance player > _minObjectInteractionDistance) then {_potentialTarget = objNull};
			_vehicleTarget = vehicle player;
			if (_vehicleTarget == player) then {_vehicleTarget = objNull};

			{ // forEach
				if (_dikCode in (_x select 1)) then
				{
					if ((_x select 0 == typeOf _potentialTarget) || 
						(/*(_vehicleTarget != player) &&*/ (_x select 0 == typeOf _vehicleTarget)) ||
						(_x select 0 == "player")) exitWith
					{
						_isTypeTarget = true;
						_target = if ((_vehicleTarget != player) && (_x select 0 == typeOf _vehicleTarget)) then {_vehicleTarget} else {_potentialTarget};
						if (_x select 0 == "player") then
						{
							_target = player;
						};
						_potentialMenuSource = _x select 2;
					};
				};
			} forEach GVAR(typeMenuSources);

			if (!isNull _target) then
			{
				private ["_menuSource"]; // sometimes nil
				_menuSource = _target getVariable QUOTE(GVAR(flexiMenu_source));
				if (isNil "_menuSource") then {_menuSource = []};

				if (count _menuSource == 0 && _isTypeTarget) then // Note: object specific menu overrides type menu
				{
					_menuSource = _potentialMenuSource;
				};

				if (isNil "_menuSource") then {_menuSource = []};
				if (count _menuSource > 0) then
				{
					// show menu dialog and load menu data
// TODO: Probably pass in _target too. High priority.
					//nul = [_target, _menuSource] call FUNC(menu);
					nul = _menuSource call FUNC(menu);
					_handled = true;
				};
			}
			else
			{
				//player sideChat format [__FILE__+": no cursor target", _this];
			};
		}
		else
		{
			//player sideChat format [__FILE__+": _active", _this];
		};
	};
};

_handled // result