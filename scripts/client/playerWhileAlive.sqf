dropObjectActionID = 0;
nextShowDot = 0;

player setVariable["hasCapObj",false,true];

3 cutRsc ['ct_transmitter_gui', 'PLAIN',3];
3 cutRsc ['ct_scoreboard_gui', 'PLAIN',3];

while{true}do{
    [] execVM "scripts\client\score.sqf";

    _hasCapObj  = player getVariable["hasCapObj",false];
    [_hasCapObj] execVM "scripts\client\transmitter.sqf";

    // DEBUG
    sleep 0.1;
};