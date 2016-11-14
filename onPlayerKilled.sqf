private["_capObject"];
_oldUnit = _this select 0;
_killer = _this select 1;
_respawn = _this select 2;
_respawnDelay = _this select 3;

_capObject = createVehicle [capObjectClass,getPos _oldUnit,[], 0, "CAN_COLLIDE"];
_oldUnit setVariable["hasCapObj",false,true];
