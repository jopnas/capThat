disableSerialization;

_namespaceScoreUI       = uiNamespace getVariable "ctGUI";
_ctrlScoreWest          = _namespaceScoreUI displayCtrl 1000;
_ctrlScoreEast          = _namespaceScoreUI displayCtrl 1001;
_ctrlScoreResistance    = _namespaceScoreUI displayCtrl 1002;

_scoreSideWest          = scoreSide west;
_scoreSideEast          = scoreSide east;
_scoreSideResistance    = scoreSide resistance;

_ctrlScoreWest ctrlSetText (str _scoreSideWest);
_ctrlScoreEast ctrlSetText (str _scoreSideEast);
_ctrlScoreResistance ctrlSetText (str _scoreSideResistance);
