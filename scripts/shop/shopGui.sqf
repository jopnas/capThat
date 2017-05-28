disableSerialization;

_ok         = createDialog "shopGUI";
if (!_ok) then {
    systemChat "Dialog couldn't be opened!"
};

shopShowRifleList = {
    _itemlb = (findDisplay 7800) displayCtrl 1306;
    lbClear _itemlb;
    _rifleList  = [];
    _riflesBase = "(
        (getNumber (_x >> 'scope') == 2) &&
        (getText (_x >> 'nameSound') == 'rifle') &&
        (count  (getArray (_x >> 'muzzles')) == 1)
    )" configClasses (configFile >> "CfgWeapons");

    {
        _className      = configName _x;
        _itemBaseClass  = _className call BIS_fnc_baseWeapon;

        if(!(_itemBaseClass in _rifleList))then{
            _rifleList pushBackUnique _itemBaseClass;
            _itemName   = getText(configFile >> "CfgWeapons" >> _className >> "displayName");
            _itemImg    = getText (configFile >> "CfgWeapons" >> _className >> "picture");

            _itemlb lbAdd format["%1",_itemName];
            _itemlb lbSetPicture [count _rifleList - 1, _itemImg];
        };
    } forEach _riflesBase;
    _itemlb lbSetSelected [lbCurSel _itemlb, false];
};

shopShowPistolList = {
    _itemlb = (findDisplay 7800) displayCtrl 1306;
    _itemlb lbSetSelected [lbCurSel _itemlb, false];
    lbClear _itemlb;
    _pistolList  = [];
    _pistolsBase = "(
        (getNumber (_x >> 'scope') == 2) &&
        (getText (_x >> 'nameSound') == 'Pistol')
    )" configClasses (configFile >> "CfgWeapons");

    {
        _className      = configName _x;
        _itemBaseClass  = _className call BIS_fnc_baseWeapon;

        if(!(_itemBaseClass in _pistolList))then{
            _pistolList pushBackUnique _itemBaseClass;
            _itemName   = getText(configFile >> "CfgWeapons" >> _className >> "displayName");
            _itemImg    = getText (configFile >> "CfgWeapons" >> _className >> "picture");

            _itemlb lbAdd format["%1",_itemName];
            _itemlb lbSetPicture [count _pistolList - 1, _itemImg];
        };
    } forEach _pistolsBase;
};

shopShowLauncherList = {
    _itemlb = (findDisplay 7800) displayCtrl 1306;
    _itemlb lbSetSelected [lbCurSel _itemlb, false];
    lbClear _itemlb;
    _launcherList  = [];
    _launcherBase = "(
        (getNumber (_x >> 'scope') == 2) &&
        (getText (_x >> 'nameSound') == 'atlauncher')
    )" configClasses (configFile >> "CfgWeapons");

    {
        _className      = configName _x;
        _itemBaseClass  = _className call BIS_fnc_baseWeapon;

        if(!(_itemBaseClass in _launcherList))then{
            _launcherList pushBackUnique _itemBaseClass;
            _itemName   = getText(configFile >> "CfgWeapons" >> _className >> "displayName");
            _itemImg    = getText (configFile >> "CfgWeapons" >> _className >> "picture");

            _itemlb lbAdd format["%1",_itemName];
            _itemlb lbSetPicture [count _launcherList - 1, _itemImg];
        };
    } forEach _launcherBase;
};

[] call shopShowRifleList;
