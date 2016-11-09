"CapObjSpawn" setMarkerAlpha 0;

capObjectClass  = "Land_Laptop_unfolded_F";

if(isServer)then{
    pointsTeamWest = 0;
    pointsTeamEast = 0;
    pointsTeamGuer = 0;
    publicVariable "pointsTeamWest";
    publicVariable "pointsTeamEast";
    publicVariable "pointsTeamGuer";

    execVM "scripts\gloablFuncs.sqf";
    execVM "scripts\initCapObject.sqf";
};

if(!isDedicated)then{
    player addVariable["hasCapObj",false,true];
    execVM "scripts\playerWhileAlive.sqf";
};