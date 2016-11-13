addTakeCapObjectAction = {
    params["_capObject"];
    _capObject addAction["Take Object","scripts\takeCapObj.sqf",[],6,true,false,"","",2,false];
};

addDropCapObjectAction = {
    params["_player"];
    _player addAction["Drop Object",{
        _player = _this select 1;
        _capObject = createVehicle [capObjectClass,position _player,[], 0, "CAN_COLLIDE"];
        [_capObject] remoteExec ["addTakeCapObjectAction", 2, false];
        _player removeAction (_this select 2);
        _player setVariable["hasCapObj",false,true];
    },[],6,false,true,"",""];
};