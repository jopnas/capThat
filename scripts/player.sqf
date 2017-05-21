// Mission Variables
player setVariable["hasLaptop",false,true];
nextShowDot = 0;
updateTransmitter = compile preprocessFile "scripts\transmitter.sqf";


3 cutRsc ['player_gui','PLAIN',3,false];

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
    {
        _profileNamespace = profileNamespace;
        _player_credits = _profileNamespace getVariable["var_ct_credits",0];
        _player_xp      = _profileNamespace getVariable["var_ct_xp",0];
        _profileNamespace setVariable ["var_ct_credits",_player_credits + 10];
        _profileNamespace setVariable ["var_ct_xp",_player_xp + 10];
        saveProfileNamespace;
    } remoteExec ["bis_fnc_call", _killer];
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

            _profileNamespace setVariable ["var_ct_credits",_player_credits + 1];
            _profileNamespace setVariable ["var_ct_xp",_player_xp + 1];

            saveProfileNamespace;

            _nextScoreUp = time + 5;
		};

        // GUI Score
        [_hasLaptop] spawn updateTransmitter;
        [] execVM "scripts\updateGUI.sqf";

        hintSilent format ["hasLaptop: %1\nteam: %2\nwestScore: %3\neastScore: %4\nresiScore: %5\nCredits: %6\nXP: %7",_hasLaptop,_team,scoreTeamWest,scoreTeamEast,scoreTeamResi,_profileNamespace getVariable "var_ct_credits",_profileNamespace getVariable "var_ct_xp"];
		sleep 0.1;
	};
};