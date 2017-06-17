/*_pos = getPos player; 
 
_para = createVehicle["B_Parachute_02_F", [_pos select 0,_pos select 1,(_pos select 2) + 201], [], 0, "FLY"]; 
_crate = createVehicle["Land_WoodenCrate_01_F", [_pos select 0,_pos select 1,(_pos select 2) + 200], [], 0, "FLY"]; 
_para attachTo [_crate, [0,0,0.5]]; 
_crate setVelocity [0, 0, -5]; */


/*
	File: supplydrop.sqf

	Description:
	Script for para-drop of objects. Spawns waitUntil that handles ground hit (detaching of object from parachute). Used by supplydrop service.

	Parameter(s):
	1: <object> air unit
	2: <string> object class that will be dropped (use: "reammobox" or "land" for dropping ammobox/car appropriate to side of air vehicle)
	
	Returns:
	N/A
*/

[] call BIS_fnc_supplydrop;
