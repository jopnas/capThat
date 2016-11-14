disableSerialization;

_namespaceScoreUI       = uiNamespace getVariable "ct_transmitterGUI";
_ctrlScoreWest          = _namespaceScoreUI displayCtrl 1201;
_ctrlScoreEast          = _namespaceScoreUI displayCtrl 1202;
_ctrlScoreResistance    = _namespaceScoreUI displayCtrl 1203;

_scoreSideWest          = scoreSide west;
_scoreSideEast          = scoreSide east;
_scoreSideResistance    = scoreSide resistance;

_ctrlScoreWest ctrlSetText _scoreSideWest;
_ctrlScoreEast ctrlSetText _scoreSideEast;
_ctrlScoreResistance ctrlSetText _scoreSideResistance;
