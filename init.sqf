if(isServer)then{
    maxTeamScore = 50;

    scoreTeamWest = 0;
    scoreTeamEast = 0;
    scoreTeamResi = 0;

    publicVariable "scoreTeamWest";
    publicVariable "scoreTeamEast";
    publicVariable "scoreTeamResi";

	[] execVM "scripts\server.sqf";
};

if(!isDedicated)then{
	[] execVM "scripts\player.sqf";
};
