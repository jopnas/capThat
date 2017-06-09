if(isServer)then{
    maxTeamScore = 10;

    scoreTeamWest = 0;
    scoreTeamEast = 0;
    scoreTeamResi = 0;

    publicVariable "scoreTeamWest";
    publicVariable "scoreTeamEast";
    publicVariable "scoreTeamResi";

	[] execVM "scripts\server\server.sqf";
};

if(!isDedicated)then{
    [] execVM "scripts\shop\shopItemLists.sqf";
    [] execVM "scripts\client\player.sqf";
    [] execVM "scripts\shop\shopFunctions.sqf";
};