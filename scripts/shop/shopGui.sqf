disableSerialization;

shopBuildRifleList = {
    _display        = findDisplay 7800;
    _shopItemGroup  = _display displayCtrl 1500;

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
            _listCount  = count _rifleList;
            _rifleList  pushBackUnique _itemBaseClass;
            _itemName   = getText(configFile >> "CfgWeapons" >> _className >> "displayName");
            _itemImg    = getText (configFile >> "CfgWeapons" >> _className >> "picture");

            _picture    = _display ctrlCreate ["RscPicture", -1, _shopItemGroup];
            _picture    ctrlSetText format["%1",_itemImg];
            _picture    ctrlSetPosition [0,_listCount * (0.15 * 2),0.2 * 2,0.15 * 2];
            _picture    ctrlCommit 0;

            _title      = _display ctrlCreate ["RscText", -1, _shopItemGroup];
            _title      ctrlSetText format["%1",_itemName];
            _title      ctrlSetPosition [0.2 * 2,_listCount * (0.15 * 2),0.5,0.1];
            _title      ctrlCommit 0;

            _buttonBuy  = _display ctrlCreate ["RscButton", -1, _shopItemGroup];
            _buttonBuy  ctrlSetText "Buy";
            _buttonBuy  ctrlSetPosition [0.2 * 2,_listCount * (0.15 * 2) + 0.1,0.2,0.05];
            _buttonBuy  ctrlCommit 0;

            _buttonEqp  = _display ctrlCreate ["RscButton", -1, _shopItemGroup];
            _buttonEqp  ctrlSetText "Equip";
            _buttonEqp  ctrlSetPosition [0.2 * 2 + 0.3,_listCount * (0.15 * 2) + 0.1,0.2,0.05];
            _buttonEqp  ctrlCommit 0;
        };
    } forEach _riflesBase;
};

// Action
_ok         = createDialog "shopGUI";
if (!_ok) then {
    systemChat "Dialog couldn't be opened!"
};

[] call shopBuildRifleList;
