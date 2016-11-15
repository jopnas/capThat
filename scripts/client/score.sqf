disableSerialization;

_namespaceUI            = uiNamespace getVariable "ctGUI";
_ctrlScoreWest          = _namespaceUI displayCtrl 1201;
_ctrlScoreEast          = _namespaceUI displayCtrl 1202;
_ctrlScoreResistance    = _namespaceUI displayCtrl 1203;

_scoreSideWest          = scoreSide west;
_scoreSideEast          = scoreSide east;
_scoreSideResistance    = scoreSide resistance;

_ctrlScoreWest ctrlSetText format["%1 MB]",_scoreSideWest/1000];
_ctrlScoreEast ctrlSetText format["%1 MB]",_scoreSideEast/1000];
_ctrlScoreResistance ctrlSetText format["%1 MB]",_scoreSideResistance/1000];

systemChat format["score: [%1,%2,%3]",_scoreSideWest,_scoreSideEast,_scoreSideResistance];