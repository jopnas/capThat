player setVariable["hasLaptop",false,true];

[] spawn {
	_nextScoreUp = time;
	while{alive player}do{
		_hasLaptop 	= player getVariable["hasLaptop",false];
		_team		= playerSide;

		_westScore = scoreSide west;
		_eastScore = scoreSide east;
		_guerScore = scoreSide resistance;

		hintSilent format ["hasLaptop: %1\nteam: %2\nwestScore: %3\neastScore: %4\nguerScore: %5",_hasLaptop,_team,_westScore,_eastScore,_guerScore];


		if(_hasLaptop && time > _nextScoreUp)then{
			_team addScoreSide 1;
			_nextScoreUp = time + 5;
		};

		sleep 0.1;
	}
};