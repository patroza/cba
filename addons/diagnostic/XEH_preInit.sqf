#include "script_component.hpp"
LOG(MSG_INIT);

[QGVAR(debug), { _this call CBA_fnc_debug }] call CBA_fnc_addEventHandler;

if (SLX_XEH_MACHINE select 3) then
{
	FUNC(handle_peak) =
	{
		PARAMS_1(_variable);
		if (isNil _variable) then
		{
			[QGVAR(receive_peak), [_variable, nil]] call CBA_fnc_globalEvent;
		} else {
			[QGVAR(receive_peak), [_variable, call compile _variable]] call CBA_fnc_globalEvent;
		};

	};
	[QGVAR(peek), { _this call CBA_fnc_handle_peak }] call CBA_fnc_addEventHandler;
};

PREP(perf_loop);

