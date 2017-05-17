// Mission Variables
player setVariable["hasLaptop",false,true];

3 cutRsc ['scores', 'PLAIN', 0, false];

player addEventHandler ["killed", {
    _unit       = _this select 0; // Object - Object the event handler is assigned to
    _killer     = _this select 1; // Object - Object that killed the unit. Contains the unit itself in case of collisions
    _instigator = _this select 1; // Object - Person who pulled the trigger
    _useEffects = _this select 1; // Boolean - same as useEffects in setDamage alt syntax

    {
        systemChat format["%1",_x];
        detach _x;
        [_x, false] remoteExec ["hideLaptopGlobal", 2];
    } forEach attachedObjects _unit;
    _unit setVariable["hasLaptop", false, true];
}];

[] spawn {
    _namespace = profileNamespace;
	_nextScoreUp = time;
	while{true}do{
		_hasLaptop 	= player getVariable["hasLaptop",false];
		_team		= playerSide;

		_westScore = scoreSide west;
		_eastScore = scoreSide east;
		_resiScore = scoreSide resistance;

		if(_hasLaptop && time > _nextScoreUp)then{
            {_team addScoreSide 1;} remoteExec ["bis_fnc_call", 2];

            _player_credits = _namespace getVariable "var_ct_credits";
            _player_xp      = _namespace getVariable "var_ct_xp";

            _namespace setVariable ["var_ct_credits",_player_credits + 1];
            _namespace setVariable ["var_ct_xp",_player_xp + 1];

            saveProfileNamespace;

            _nextScoreUp = time + 5;
		};

        // GUI Score
        [] execVM "scripts\updateGUI.sqf";

        hintSilent format ["hasLaptop: %1\nteam: %2\nwestScore: %3\neastScore: %4\nguerScore: %5\$: %6\nXP: %7",_hasLaptop,_team,_westScore,_eastScore,_resiScore,_namespace getVariable "var_ct_credits",_namespace getVariable "var_ct_xp"];
		sleep 0.1;
	};
};