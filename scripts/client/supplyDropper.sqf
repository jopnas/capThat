_supplyDropper = {
	params["_dropper","_supplyClass"];
	_class = format [
		"%1_parachute_02_F", 
		toString [(toArray faction player) select 0]
	];
	_para = createVehicle [_class, [0,0,0], [], 0, "FLY"];
	_para setDir getDir _dropper;
	_para setPos getPos _dropper;
	_supply = createVehicle[_supplyClass, [0,0,0], [], 0, "none"]; 
	_supply attachTo [_para, [0,0,0]];
};

_pPos = getPosASL player;
_heli = createVehicle["B_CTRG_Heli_Transport_01_tropic_F", player, [], 100, "FLY"]; 
createVehicleCrew _heli;
sleep 1;
[_heli,"C_T_supplyCrate_F"] call _supplyDropper;
sleep 5;
deleteVehicle _heli;