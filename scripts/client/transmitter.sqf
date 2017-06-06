params["_hasCapObj"/**/,"_capObjDistance","_showDotDelay"];
disableSerialization;

_namespaceTransmitterUI    = uiNamespace getVariable "player_display";
_ctrlTransmitterLED        = _namespaceTransmitterUI displayCtrl 1204;

_capObjDistance = 0;
_showDotDelay = 0;

if(_hasCapObj)then{
    _ctrlTransmitterLED ctrlSetText "images\capthat_transmitter_led_off.paa";
    _capObjDistance = 0;
    _showDotDelay = 0;
}else{
    _capObjDistance = player distance capthat_object;
    _showDotDelay   = _capObjDistance/100;
    if(time > nextShowDot && _capObjDistance > 0 && _showDotDelay > 0)then{
        _ctrlTransmitterLED ctrlSetText "images\capthat_transmitter_led_on.paa";
        //playSound "transmitterBeep";
        sleep 0.2;
        _ctrlTransmitterLED ctrlSetText "images\capthat_transmitter_led_off.paa";
        if(_showDotDelay > 10)then{
            _showDotDelay = 10;
        };

        nextShowDot = time + _showDotDelay;
    }else{
        _ctrlTransmitterLED ctrlSetText "images\capthat_transmitter_led_off.paa";
    }
};

//systemChat format["hasCapObj: %1, capObj distance: %2, _showDotDelay: %3",_hasCapObj,_capObjDistance,_showDotDelay];
