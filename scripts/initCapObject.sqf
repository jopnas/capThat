_enterableBuildings = [];
_buildingsForCapObj = nearestObjects [getMarkerPos "CapObjSpawn", ["Building"], 500];
{
    if(count (_x buildingPos -1) > 0)then{
        _enterableBuildings pushBack _x;
    };
}forEach _buildingsForCapObj;

_rdmBuilding    = selectRandom _enterableBuildings;
_rdmBuildingPos = selectRandom (_rdmBuilding buildingPos -1);
_capObject      = createVehicle [capObjectClass,_rdmBuildingPos,[], 0, "NONE"];
_capObject setPosATL _rdmBuildingPos;

_capObject addAction["Take Object","scripts\takeCapObj.sqf",[],6,true,false,"","",2,false];

// Debug
_markerstr = createMarker ["CapObjDebug", [_rdmBuildingPos select 0,_rdmBuildingPos select 1]];
_markerstr setMarkerShape "ICON";
_markerstr setMarkerType "hd_dot";
"CapObjDebug" setMarkerColor "ColorRed";