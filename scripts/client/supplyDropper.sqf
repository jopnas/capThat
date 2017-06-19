_supplyDropper = {
	params["_dropper","_supply"];
	_class = format [
		"%1_parachute_02_F", 
		toString [(toArray faction player) select 0]
	];
	_para = createVehicle [_class, [0,0,0], [], 0, "FLY"];
	_para setDir getDir _dropper;
	_para setPos getPos _dropper;
	_supply attachTo [_para, [0,0,0]];
};

_pPos = getPosASL player;

_heli = createVehicle["B_CTRG_Heli_Transport_01_tropic_F", player, [], 100, "FLY"]; 

_crate  = createVehicle["C_T_supplyCrate_F", [0,0,0], [], 0, "none"]; 
clearItemCargoGlobal _crate;
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearBackpackCargoGlobal _crate;


[_heli,_crate] call _supplyDropper;
sleep 1;
deleteVehicle _heli;