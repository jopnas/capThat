"CapObjSpawn" setMarkerAlpha 0;
capObjectClass  = "Land_Laptop_unfolded_F";

if(isServer)then{

    execVM "scripts\server\gloablFuncs.sqf";
    execVM "scripts\server\initCapObject.sqf";
    execVM "scripts\server\serverCore.sqf";

};

if(!isDedicated)then{
    player execVM "scripts\client\playerWhileAlive.sqf";
};