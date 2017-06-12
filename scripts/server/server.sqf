// Vars
isDownloading = false;

// Functions
setIsDownloading = {
    params["_status"];
    isDownloading = _status;
};

showPing = {
    _duration   = 3;
    _startTime  = time;
    _laptopPing = createMarker["laptopPing", getPos capthat_object];
    _laptopPing setMarkerShape "Ellipse";
    _laptopPing setMarkerColor "ColorGreen";
    _laptopPing setMarkerSize [0,0];
    _laptopPing setMarkerAlpha 1;
    while{true}do{
        _curSize    = (getMarkerSize _laptopPing) select 0;
        _curAlpha   = markerAlpha _laptopPing;
        _newAlpha = (_curAlpha - (1 / (_duration * 60)));
        if(_newAlpha < 0)then{
            _newAlpha = 0;
        };
        _laptopPing setMarkerAlpha _newAlpha;
        _laptopPing setMarkerPos (getPos capthat_object);
        _laptopPing setMarkerSize [_curSize + 0.1,_curSize + 0.1];
        if(time > _startTime + _duration) exitWith {
            deleteMarker "laptopPing";
        };
        sleep 0.1;
    };
};

hideLaptopGlobal = {
    params["_laptop", "_status"];
    _laptop hideObjectGlobal _status;
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

[] spawn ={
    _nextPing = time
    while(true)do{

		if(isDownloading && time > _nextPing)then{
            [] call showPing;
            _nextPing = time + 10;
		};

        sleep 0.1;
    };
};