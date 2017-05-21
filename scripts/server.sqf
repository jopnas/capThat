// Functions
hideLaptopGlobal = {
    params["_laptop", "_state"];
    _laptop hideObjectGlobal _state;
};

raiseTeamScore = {
    params["_team", "_add"];
    switch (str _team) do {
        case "WEST": {
            scoreTeamWest = scoreTeamWest + _add;
            publicVariable "scoreTeamWest";

            if(scoreTeamWest >= maxTeamScore)then{
                systemChat "Team West Wins";
                endMission "END1";
            };
        };
        case "EAST": {
            scoreTeamEast = scoreTeamEast + _add;
            publicVariable "scoreTeamEast";

            if(scoreTeamEast >= maxTeamScore)then{
                systemChat "Team East Wins";
                endMission "END1";
            };
        };
        case "GUER": {
            scoreTeamResi = scoreTeamResi + _add;
            publicVariable "scoreTeamResi";

            if(scoreTeamResi >= maxTeamScore)then{
                systemChat "Team Resistance Wins";
                endMission "END1";
            };
        };
    };
};

/*[] spawn ={
    while(true)do{

    };
};*/