dropObjectActionID = 0;
nextShowDot = 0;

player setVariable["hasCapObj",false,true];
3 cutRsc ['ct_transmitter_gui', 'PLAIN',3];

while{true}do{
    _hasCapObj  = player getVariable["hasCapObj",false];
    [_hasCapObj] execVM "scripts\transmitter.sqf";

    // DEBUG
    sleep 0.1;
};