_capObj = _this select 0;
_player = _this select 1;

_player setVariable["hasCapObj",true,true];

deleteVehicle _capObj;
[_player] remoteExec ["addDropCapObjectAction", 2, false];
