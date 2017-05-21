params["_hasCapObj"/**/,"_capObjDistance","_showDotDelay"];
disableSerialization;

_namespaceTransmitterUI    = uiNamespace getVariable "player_display";
_ctrlTransmitterDot        = _namespaceTransmitterUI displayCtrl 1203;

_capObjDistance = 0;
_showDotDelay = 0;

if(_hasCapObj)then{
    _ctrlTransmitterDot ctrlSetTextColor [1,1,1,0];
    _capObjDistance = 0;
    _showDotDelay = 0;
}else{
    _capObjDistance = player distance capthat_object;
    _showDotDelay   = _capObjDistance/100;
    if(time > nextShowDot && _capObjDistance > 0 && _showDotDelay > 0)then{
        _ctrlTransmitterDot ctrlSetTextColor [1,1,1,1];
        //playSound "transmitterBeep";
        sleep 0.2;
        _ctrlTransmitterDot ctrlSetTextColor [1,1,1,0];
        if(_showDotDelay > 10)then{
            _showDotDelay = 10;
        };

        nextShowDot = time + _showDotDelay;
    }else{
        _ctrlTransmitterDot ctrlSetTextColor [1,1,1,0];
    }
};

//systemChat format["hasCapObj: %1, capObj distance: %2, _showDotDelay: %3",_hasCapObj,_capObjDistance,_showDotDelay];
