"CapObjSpawn" setMarkerAlpha 0;
capObjectClass  = "Land_Laptop_unfolded_F";

if(isServer)then{

    execVM "scripts\gloablFuncs.sqf";
    execVM "scripts\initCapObject.sqf";
    execVM "scripts\serverCore.sqf";

};

if(!isDedicated)then{
    player execVM "scripts\playerWhileAlive.sqf";
};