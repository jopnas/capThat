dropObjectActionID = 0;
nextShowDot = 0;

player setVariable["hasCapObj",false,true];

3 cutRsc ['ct_gui','PLAIN',3,false];

while{true}do{
    _hasCapObj  = player getVariable["hasCapObj",false];
    [_hasCapObj] execVM "scripts\client\transmitter.sqf";
    [] execVM "scripts\client\score.sqf";

    sleep 0.1;
};