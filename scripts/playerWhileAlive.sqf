while{true}do{
    _hasCapObj = player getVariable["hasCapObj",false];

    if(_hasCapObj)then{
        switch(side player)do{
            case "west": {
                pointsTeamWest = pointsTeamWest + 1;
            };
            case "east": {
                pointsTeamEast = pointsTeamEast + 1;
            };
            case "guer": {
                pointsTeamGuer = pointsTeamGuer + 1;
            };
            default: {};
        };
    };

    // DEBUG
    hint format["hasCapObj: %1\npointsTeamWest: %2\npointsTeamEast: %3\npointsTeamGuer: %4\n",_hasCapObj,pointsTeamWest,pointsTeamEast,pointsTeamGuer];
};