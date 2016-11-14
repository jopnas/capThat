params["_hasCapObj"/**/,"_capObjDistance","_showDotDelay"];
disableSerialization;

_namespaceTransmitterUI    = uiNamespace getVariable "ctGUI";
_ctrlTransmitterDot        = _namespaceTransmitterUI displayCtrl 1200;

_capObjDistance = 0;
_showDotDelay = 0;

if(_hasCapObj)then{
    _ctrlTransmitterDot ctrlSetTextColor [1,1,1,0];
    _capObjDistance = 0;
    _showDotDelay = 0;
}else{
    _capObject      = nearestObjects [position player,[capObjectClass],20000] select 0;
    _capObjDistance = player distance _capObject;
    _showDotDelay   = _capObjDistance/100;
    if(time > nextShowDot && _capObjDistance > 0 && _showDotDelay > 0)then{
        _ctrlTransmitterDot ctrlSetTextColor [1,1,1,1];
        playSound "transmitterBeep";
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

hintSilent format[" hasCapObj: %1 \n capObj distance: %2 \n _showDotDelay: %3",_hasCapObj,_capObjDistance,_showDotDelay];
