nextSearch = 0;
while{true}do{

    _justPlayers = allPlayers - entities "HeadlessClient_F";
    {
        _player = _x;
        _hasCapObj = _player getVariable["hasCapObj",false];
        _sidePlayer = side _player;
        _playerSideScore = scoreSide _sidePlayer;

        //hint format[" _hasCapObj: %5 \n _playerSideScore: %1 \n _SideScore EAST: %2 \n _SideScore WEST: %3 \n _SideScore Resistance: %4",_playerSideScore,scoreSide east,scoreSide west,scoreSide resistance,_hasCapObj];
        if(_hasCapObj && time >= nextSearch && alive _player)then{
            _sidePlayer addScoreSide (_playerSideScore + 1);
            nextSearch = nextSearch + 30;
        };
    } forEach _justPlayers;

    sleep 0.1;
};
