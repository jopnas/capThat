_pos = getPos player; 
 
_para = createVehicle["B_Parachute_02_F", [_pos select 0,_pos select 1,(_pos select 2) + 201], [], 0, "FLY"]; 
_crate = createVehicle["Land_WoodenCrate_01_F", [_pos select 0,_pos select 1,(_pos select 2) + 200], [], 0, "FLY"]; 
_crate disableCollisionWith _para; 
_para attachTo [_crate, [0,0,0.5]]; 
