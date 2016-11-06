hideObjectGlobal (_this select 0);
player addAction["Drop Object",{
    _capObject = createVehicle [capObjectClass,position player,[], 0, "NONE"];
    _capObject addAction["Take Object","scripts\takeCapObj.sqf",[],6,true,false,"","",2,false];
    player removeAction (_this select 2);
},[],6,false,true,"",""];