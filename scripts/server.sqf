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
        };
        case "EAST": {
            scoreTeamEast = scoreTeamEast + _add;
            publicVariable "scoreTeamEast";
        };
        case "GUER": {
            scoreTeamResi = scoreTeamResi + _add;
            publicVariable "scoreTeamResi";
        };
    };

    if(scoreTeamWest >= maxTeamScore || scoreTeamEast >= maxTeamScore || scoreTeamResi >= maxTeamScore)then{
        // [endName,isVictory,fadeType,playMusic,completeTasks] spawn BIS_fnc_endMission;
        if(scoreTeamWest >= maxTeamScore) then {
            ["wonCapThat",true,2,false,true] remoteExec["BIS_fnc_endMission",West];
        }else{
            ["failedCapThat",false,2,false,true] remoteExec["BIS_fnc_endMission",West];
        };

        if(scoreTeamEast >= maxTeamScore) then {
            ["wonCapThat",true,2,false,true] remoteExec["BIS_fnc_endMission",East];
        }else{
            ["failedCapThat",false,2,false,true] remoteExec["BIS_fnc_endMission",East];
        };

        if(scoreTeamResi >= maxTeamScore) then {
            ["wonCapThat",true,2,false,true] remoteExec["BIS_fnc_endMission",Resistance];
        }else{
            ["failedCapThat",false,2,false,true] remoteExec["BIS_fnc_endMission",Resistance];
        };
    };
};

/*[] spawn ={
    while(true)do{

    };
};*/