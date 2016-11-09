"CapObjSpawn" setMarkerAlpha 0;

capObjectClass = "Land_Laptop_unfolded_F";

if(isServer)then{
    execVM "scripts\gloablFuncs.sqf";
    execVM "scripts\initCapObject.sqf";
};