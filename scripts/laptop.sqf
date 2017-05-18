params ["_laptop"];

_laptop addAction["Take Laptop", {
	_laptop = _this select 0;
	_caller = _this select 1;

    {_laptop hideObjectGlobal true;} remoteExec ["bis_fnc_call", 2];

	_laptop attachTo[_caller, [0.1, 0.1, 0.15], "Pelvis"];
	_caller setVariable["hasLaptop", true, true];

	_caller addAction["Release Laptop",{
		_caller = _this select 1;
        _actID  = _this select 2;
		_args 	= _this select 3;
		_laptop = _args select 0;

		detach _laptop;
		_caller setVariable["hasLaptop", false, true];
        _caller removeAction _actID;

        {_laptop hideObjectGlobal false;} remoteExec ["bis_fnc_call", 2];

	}, [_laptop], 5, false];

}, [], 6, true, true, "", "", 3];