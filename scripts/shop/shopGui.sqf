disableSerialization;

_ok         = createDialog "shopGUI";
if (!_ok) then {
    systemChat "Dialog couldn't be opened!"
};

[] call shopBuildRifleList;
