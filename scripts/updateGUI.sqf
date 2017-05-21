disableSerialization;
_namespaceUI = uiNamespace getVariable "player_display";

_ctrlScoreWestText = _namespaceUI displayCtrl 1000;
_ctrlScoreEastText = _namespaceUI displayCtrl 1001;
_ctrlScoreResiText = _namespaceUI displayCtrl 1002;

_ctrlScoreWestText ctrlSetText format["%1 MB",scoreTeamWest];
_ctrlScoreEastText ctrlSetText format["%1 MB",scoreTeamEast];
_ctrlScoreResiText ctrlSetText format["%1 MB",scoreTeamResi];


