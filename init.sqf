if(isServer)then{
	pointsWest 	= 0;
	pointsEast 	= 0;
	pointsGuer	= 0;
	[] execVM "scripts\gameLogic.sqf";
};

if(!isDedicated)then{
	[] execVM "scripts\player.sqf";
};
