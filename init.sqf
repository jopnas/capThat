if(isServer)then{
	[] execVM "scripts\server.sqf";
};

if(!isDedicated)then{
	[] execVM "scripts\player.sqf";
};
