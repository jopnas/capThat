disableSerialization;

shopBuyItem = {
    params["_itemClass"];
    systemChat "Buy this";
    _boughtEquipment = player getVariable["boughtEquipment", []];

    _boughtEquipment pushBackUnique _itemClass;

    profileNamespace setVariable["var_ct_boughtEquipment", _boughtEquipment];
    player setVariable["boughtEquipment", _boughtEquipment, false];
};

shopEquipItem = {
    params["_itemClass"];
    systemChat "Equip this";
};

buildList = {
    params["_cfgList"];
    _display        = findDisplay 7800;
    _shopItemGroup  = _display displayCtrl 1500;

    _itemList  = [];
    {
        _className      = configName _x;
        _itemBaseClass  = _className call BIS_fnc_baseWeapon;

        if(!(_itemBaseClass in _itemList))then{
            _listCount  = count _itemList;
            _itemList  pushBackUnique _itemBaseClass;
            _itemName   = getText(configFile >> "CfgWeapons" >> _className >> "displayName");
            _itemImg    = getText (configFile >> "CfgWeapons" >> _className >> "picture");

            _bg         = _display ctrlCreate ["RscPicture", -1, _shopItemGroup];
            _bg         ctrlSetText "#(argb,8,8,3)color(0,0,0,1)";
            _bg         ctrlSetPosition [0, _listCount * (0.15 * 2), 1.3, 0.15 * 2 + 0.05];
            _bg         ctrlCommit 0;

            _picture    = _display ctrlCreate ["shopItemPicture", -1, _shopItemGroup];
            _picture    ctrlSetText format["%1",_itemImg];
            _picture    ctrlSetPosition [0, _listCount * (0.15 * 2)];
            _picture    ctrlCommit 0;

            _title      = _display ctrlCreate ["shopItemName", -1, _shopItemGroup];
            _title      ctrlSetText format["%1",_itemName];
            _title      ctrlSetPosition [0.1, _listCount * (0.15 * 2)];
            _title      ctrlCommit 0;

            _title      = _display ctrlCreate ["shopItemPrice", -1, _shopItemGroup];
            _title      ctrlSetText format["%1",_itemName];
            _title      ctrlSetPosition [0.1, _listCount * (0.15 * 2) + 0.1];
            _title      ctrlCommit 0;

            _buttonBuy  = _display ctrlCreate ["shopBuyItemButton", -1, _shopItemGroup];
            _buttonBuy buttonSetAction "";
            _buttonBuy  ctrlSetPosition [0.2 * 2, _listCount * (0.15 * 2) + 0.1];
            _buttonBuy  ctrlCommit 0;

            _buttonEqp  = _display ctrlCreate ["shopEquipItemButton", -1, _shopItemGroup];
            _buttonBuy buttonSetAction "";
            _buttonEqp  ctrlSetPosition [0.2 * 2 + 0.3, _listCount * (0.15 * 2) + 0.1];
            _buttonEqp  ctrlCommit 0;
        };
    } forEach _cfgList;

};

shopBuildRifleList = {
    _cfgList = "(
        (getNumber (_x >> 'scope') == 2) &&
        (getText (_x >> 'nameSound') == 'rifle') &&
        (count  (getArray (_x >> 'muzzles')) == 1)
    )" configClasses (configFile >> "CfgWeapons");
    [_cfgList] call buildList;
};

shopBuildPistolList = {
    _cfgList = "(
        (getNumber (_x >> 'scope') == 2) &&
        (getText (_x >> 'nameSound') == 'Pistol')
    )" configClasses (configFile >> "CfgWeapons");
    [_cfgList] call buildList;
};

shopBuildLauncherList = {
    _cfgList = "(
        (getNumber (_x >> 'scope') == 2) &&
        (getText (_x >> 'nameSound') == 'atlauncher')
    )" configClasses (configFile >> "CfgWeapons");
    [_cfgList] call buildList;
};

// Action
_ok         = createDialog "shopGUI";
if (!_ok) then {
    systemChat "Dialog couldn't be opened!"
};

[] call shopBuildRifleList;
