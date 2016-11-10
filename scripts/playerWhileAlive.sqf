while{true}do{
    _hasCapObj  = player getVariable["hasCapObj",false];
    _sidePlayer = side player;

    if(_hasCapObj)then{

        switch(side player)do{
            case "west": {
                pointsTeamWest = pointsTeamWest + 1;
            };
            case "east": {
                pointsTeamEast = pointsTeamEast + 1;
            };
            case "resistance": {
                pointsTeamGuer = pointsTeamGuer + 1;
            };
            default: {};
        };

        [(side player) addScoreSide 1;] remoteExec ["bis_fnc_call",2,false];
    };

    // DEBUG
    hint format["hasCapObj: %1\npointsTeamWest: %2\npointsTeamEast: %3\npointsTeamGuer: %4\nscoreSide west: %5\nscoreSide east: %6\nscoreSide resistance: %7",_hasCapObj,pointsTeamWest,pointsTeamEast,pointsTeamGuer,scoreSide west,scoreSide east,scoreSide resistance];
};