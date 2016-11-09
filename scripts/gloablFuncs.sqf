addTakeCapObjectAction = {
    params["_capObject"];
    _capObject addAction["Take Object","scripts\takeCapObj.sqf",[],6,true,false,"","",2,false];
};

addDropCapObjectAction = {
    params["_player"];
    _player addAction["Drop Object",{
        _capObject = createVehicle [capObjectClass,position (_this select 1),[], 0, "CAN_COLLIDE"];
        [_capObject] remoteExec [addTakeCapObjectAction, 2, false];
        (_this select 1) removeAction (_this select 2);
    },[],6,false,true,"",""];
};