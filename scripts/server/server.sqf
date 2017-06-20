// Vars
isDownloading = false;

// Functions
setIsDownloading = {
    params["_status"];
    isDownloading = _status;
};

createMarker["laptopPing", getPos capthat_object];
"laptopPing" setMarkerShape "Ellipse";
"laptopPing" setMarkerColor "ColorGreen";
"laptopPing" setMarkerSize [0,0];
"laptopPing" setMarkerAlpha 1;

showPing = {
    _duration   = 5;
    _startTime  = time;

    _alphaStep = 0.02;

    "laptopPing" setMarkerPos getPos capthat_object;


    while{true}do{
        _curSize    = (getMarkerSize "laptopPing") select 0;
        _curAlpha   = markerAlpha "laptopPing";
        _newAlpha = _curAlpha - _alphaStep;
        if(_newAlpha < 0)then{
            _newAlpha = 0;
        };

        "laptopPing" setMarkerAlpha _newAlpha;
        "laptopPing" setMarkerPos (getPos capthat_object);
        "laptopPing" setMarkerSize [_curSize + 2,_curSize + 2];
        if(time > _startTime + _duration) exitWith {
            "laptopPing" setMarkerSize [0,0];
            "laptopPing" setMarkerAlpha 1;
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

// Place Laptop
_loacationsArray = [];
_mapLocations = (configfile >> "CfgWorlds" >> worldName >> "Names") call BIS_fnc_getCfgSubClasses;

{
    _type = getText(configfile >> "CfgWorlds" >> worldName >> "Names" >> _x >> "type");
    if(_type == "NameCity" || _type == "NameVillage")then{
        _size   = 0;
        _pos    = getArray (configfile >> "CfgWorlds" >> worldName >> "Names" >> _x >> "position");
        _size  = getNumber (configfile >> "CfgWorlds" >> worldName >> "Names" >> _x >> "radiusA");

        _impPos = [(_pos select 0) + (_size/2),(_pos select 1) - (_size/2)];
        _loacationsArray pushBackUnique [_impPos,_size + (_size/2)];

        /*createMarker [format["_LaptopArea_%1",_forEachIndex], _impPos];
        format["_LaptopArea_%1",_forEachIndex] setMarkerShape "RECTANGLE";
        format["_LaptopArea_%1",_forEachIndex] setMarkerSize [_size + (_size/2),_size + (_size/2)];
        format["_LaptopArea_%1",_forEachIndex] setMarkerColor "ColorRed";*/
    };
} forEach _mapLocations;

_rdmLoc = selectRandom _loacationsArray;

_rdmLocPos    = _rdmLoc select 0;
_laptopAreaMarker = createMarker ["_LaptopArea_", _rdmLocPos];
_laptopAreaMarker setMarkerShape "RECTANGLE";
_laptopAreaMarker setMarkerSize [_rdmLoc select 1,_rdmLoc select 1];
_laptopAreaMarker setMarkerAlpha 0.5;
_laptopAreaMarker setMarkerColor "ColorGreen";

_enterableBuildings = [];
_buildingsInRdmLoc = nearestObjects [_rdmLocPos, ["House", "Building"], _rdmLoc select 1];
{
    _numDoors = getNumber (configFile >> "CfgVehicles" >> typeOf _x >> "numberOfDoors");
    if(_numDoors > 0)then{
        _enterableBuildings pushBackUnique _x;
    };
}forEach _buildingsInRdmLoc;

_rdmHouseInLoc = selectRandom _enterableBuildings;
_laptopPos = selectRandom(_rdmHouseInLoc buildingPos -1);

_laptopMarker = createMarker ["_Laptop_", _laptopPos];
_laptopMarker setMarkerShape "ICON";
_laptopMarker setMarkerType "mil_objective";
_laptopMarker setMarkerColor "ColorRed";

_placeOnObjects = ["Land_CampingChair_V1_F","Land_CampingTable_small_F","Land_CampingChair_V2_F","Land_ChairPlastic_F","Land_ChairWood_F","Land_WoodenTable_small_F","Land_Pallets_stack_F","Land_TablePlastic_01_F"];
_placeOnThis = _createVehicle [selectRandom _placeOnObjects, _laptopPos, [], 0, "none"];
capthat_object setVehiclePosition [(getPos _placeOnThis) select 0,(getPos _placeOnThis) select 1,((getPos _placeOnThis) select 2) + 1.5];

[] spawn {
    _nextPing = time;
    while{true}do{

		if(isDownloading && time > _nextPing)then{
            [] call showPing;
            _nextPing = time + 10;
		};

        sleep 0.1;
    };
};