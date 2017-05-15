disableSerialization;
_namespaceUI = uiNamespace getVariable "scores_display";

_westScore = scoreSide west;
_eastScore = scoreSide east;
_resiScore = scoreSide resistance;

_ctrlScoreWestText = _namespaceUI displayCtrl 1000;
_ctrlScoreEastText = _namespaceUI displayCtrl 1001;
_ctrlScoreResiText = _namespaceUI displayCtrl 1002;

_ctrlScoreWestText ctrlSetText format["%1",_westScore];
_ctrlScoreEastText ctrlSetText format["%1",_eastScore];
_ctrlScoreResiText ctrlSetText format["%1",_resiScore];


