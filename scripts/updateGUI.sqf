private["_calcedDist"];
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
_profileNamespace   = profileNamespace;
_capObjDistance     = player distance capthat_object;
_player_distance    = _profileNamespace getVariable["var_ct_xp",0];
_player_credits     = _profileNamespace getVariable["var_ct_cash",0];

_ctrlDistanceText   = _namespaceUI displayCtrl 1202;
_ctrlCashText       = _namespaceUI displayCtrl 1203;

if(player getVariable["hasLaptop",false])then{
    _calcedDist = "-.-";
}else{
    _calcedDist = floor(player distance capthat_object) / 1000;
};

_ctrlDistanceText   ctrlSetText format["km %1",_calcedDist];
_ctrlCashText       ctrlSetText format["$  %1",_player_credits];
