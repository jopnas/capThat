removeAllWeapons player;
player setVariable["hasLaptop",false,true];

_profileNamespace = profileNamespace;
_savedBoughtEquipment = _profileNamespace getVariable["var_ct_boughtEquipment", []];
player setVariable["boughtEquipment", _savedBoughtEquipment, false];

_savedEquipedEquipment = _profileNamespace getVariable["var_ct_equipedEquipment", []];
player setVariable["equipedEquipment", _savedEquipedEquipment, false];

nextShowDot = 0;
updateTransmitter = compile preprocessFile "scripts\transmitter.sqf";

// DEBUG >
    player addAction["Open Shop","scripts\shop\shop.sqf",[],6,false];
// < DEBUG

player addAction["Use Laptop",{
    player playAction "SitDown";
    sleep 4;
    [] execVM "scripts\shop\shop.sqf";
},[],6,false];

3 cutRsc ["player_gui","PLAIN",3,false];

player addEventHandler ["AnimDone", {
    params["_unit","_anim"];
    systemChat _anim;
    if(_anim == "SitDown" && _unit getVariable["hasLaptop",false])then{
        [] execVM "scripts\shop\shop.sqf";
    };
}];

player addEventHandler ["AnimChanged", {
    params["_unit","_anim"];
    if(_anim != "SitDown" && _unit getVariable["hasLaptop",false])then{
        [_laptop,true] remoteExec ["hideLaptopGlobal", 2];
    };
}];

player addEventHandler ["killed", {
    _unit       = _this select 0; // Object - Object the event handler is assigned to
    _killer     = _this select 1; // Object - Object that killed the unit. Contains the unit itself in case of collisions
    _instigator = _this select 1; // Object - Person who pulled the trigger
    _useEffects = _this select 1; // Boolean - same as useEffects in setDamage alt syntax

    // Laptop
    {
        detach _x;
        [_x,false] remoteExec ["hideLaptopGlobal", 2];
    } forEach attachedObjects _unit;
    _unit setVariable["hasLaptop", false, true];

    // Killer add XP and Credits
    if(_killer != player)then{
        {
            _profileNamespace = profileNamespace;
            _player_credits = _profileNamespace getVariable["var_ct_credits",0];
            _player_xp      = _profileNamespace getVariable["var_ct_xp",0];
            _profileNamespace setVariable ["var_ct_credits",_player_credits + 10];
            _profileNamespace setVariable ["var_ct_xp",_player_xp + 10];
            saveProfileNamespace;
        } remoteExec ["bis_fnc_call", _killer];
    };
}];

nul = [] spawn {
    _profileNamespace = profileNamespace;
	_nextScoreUp = time;
	while{true}do{
		_hasLaptop 	= player getVariable["hasLaptop",false];
		_team		= playerSide;

		if(alive player && _hasLaptop && time > _nextScoreUp)then{
            [_team,1] remoteExec ["raiseTeamScore", 2];

            _player_credits = _profileNamespace getVariable["var_ct_credits",0];
            _player_xp      = _profileNamespace getVariable["var_ct_xp",0];

            //_profileNamespace setVariable ["var_ct_credits",_player_credits + 1];
            //_profileNamespace setVariable ["var_ct_xp",_player_xp + 1];

            saveProfileNamespace;

            _nextScoreUp = time + 5;
		};

        // GUI Score
        [_hasLaptop] spawn updateTransmitter;
        [] execVM "scripts\updateGUI.sqf";

        hintSilent format ["hasLaptop: %1\nA3Score: %2",_hasLaptop,scoreSide (side player)];
		sleep 0.1;
	};
};
