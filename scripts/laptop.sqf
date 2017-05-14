params ["_laptop"];

_laptop addAction["Take Laptop",{
	_laptop = _this select 0;
	_caller = _this select 1;

	_laptop attachTo[_caller, [0.1, 0.1, 0.15], "Pelvis"];
	_caller setVariable["hasLaptop",true,true];
	_caller addAction["Release Laptop",{
		_caller = _this select 1;
		_args 	= _this select 3;
		_laptop = _args select 0;
		detach _laptop;
		_caller setVariable["hasLaptop",false,true];
	},[_laptop],6];
},[],6];