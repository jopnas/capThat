params["_hasCapObj"/**/,"_capObjDistance","_showDotDelay"];
disableSerialization;

_namespaceDetectorUI    = uiNamespace getVariable "ct_detectorGUI";
_ctrlDetectorDot        = _namespaceDetectorUI displayCtrl 1200;

_capObjDistance = 0;
_showDotDelay = 0;

if(_hasCapObj)then{
    _ctrlDetectorDot ctrlSetTextColor [1,1,1,0];
}else{
    _capObject      = nearestObjects [position player,[capObjectClass],20000] select 0;
    _capObjDistance = player distance _capObject;
    _showDotDelay   = _capObjDistance/100;
    if(time > nextShowDot)then{
        _ctrlDetectorDot ctrlSetTextColor [1,1,1,1];
        sleep 0.2;
        _ctrlDetectorDot ctrlSetTextColor [1,1,1,0];
        if(_showDotDelay > 10)then{
            _showDotDelay = 10;
        };

        nextShowDot = time + _showDotDelay;
    }else{
        _ctrlDetectorDot ctrlSetTextColor [1,1,1,0];
    }
};

hintSilent format[" hasCapObj: %1 \n capObj distance: %2 \n _showDotDelay: %3",_hasCapObj,_capObjDistance,_showDotDelay];
