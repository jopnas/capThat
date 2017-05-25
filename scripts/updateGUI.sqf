disableSerialization;
_namespaceUI = uiNamespace getVariable "player_display";

// Team
_ctrlScoreWestText = _namespaceUI displayCtrl 1303;
_ctrlScoreEastText = _namespaceUI displayCtrl 1304;
_ctrlScoreResiText = _namespaceUI displayCtrl 1305;

_ctrlScoreWestText ctrlSetText format["%1 MB",scoreTeamWest];
_ctrlScoreEastText ctrlSetText format["%1 MB",scoreTeamEast];
_ctrlScoreResiText ctrlSetText format["%1 MB",scoreTeamResi];

// Player
_profileNamespace = profileNamespace;
_player_xp      = _profileNamespace getVariable["var_ct_xp",0];
_player_credits = _profileNamespace getVariable["var_ct_credits",0];

_ctrlXPtext         = _namespaceUI displayCtrl 1203;
_ctrlCashText       = _namespaceUI displayCtrl 1204;

_ctrlXPtext     ctrlSetText format["XP: %1",_player_xp];
_ctrlCashText   ctrlSetText format["$: %1",_player_credits];
