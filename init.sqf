if(isServer)then{
	[] execVM "scripts\gameLogic.sqf";
};

if(!isDedicated)then{
	[] execVM "scripts\player.sqf";
};
