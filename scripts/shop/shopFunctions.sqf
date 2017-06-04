shopBuyItem = {
    params["_itemClass","_idcBuy","_idcEquip"];
    systemChat format["%1",_itemClass];

    _boughtEquipment = player getVariable["boughtEquipment", []];
    _boughtEquipment pushBackUnique _itemClass;

    profileNamespace setVariable["var_ct_boughtEquipment", _boughtEquipment];
    player setVariable["boughtEquipment", _boughtEquipment, false];

    _dspl       = findDisplay 7800;
    _btnBuy     = _dspl displayCtrl _idcBuy;
    _btnEquip   = _dspl displayCtrl _idcEquip;

    _btnBuy ctrlEnable false;
    _btnEquip ctrlEnable true;
};

shopEquipItem = {
    params["_itemClass","_idcEquip"];
    systemChat format["%1",_itemClass];

    _equipedEquipment = player getVariable["equipedEquipment", []];
    _equipedEquipment pushBackUnique _itemClass;

    profileNamespace setVariable["var_ct_equipedEquipment", _equipedEquipment];
    player setVariable["equipedEquipment", _equipedEquipment, false];

    player addWeapon _itemClass;

    _dspl       = findDisplay 7800;
    _btnEquip   = _dspl displayCtrl _idcEquip;

    _btnEquip ctrlEnable true;
};

shopBuildLists = {
    _cfgList = "(
        (getNumber (_x >> 'scope') == 2) &&
        (getText (_x >> 'nameSound') == 'rifle') &&
        (count  (getArray (_x >> 'muzzles')) == 1)
    )" configClasses (configFile >> "CfgWeapons");
    [_cfgList,1500] call buildList;

    _cfgList = "(
        (getNumber (_x >> 'scope') == 2) &&
        (getText (_x >> 'nameSound') == 'Pistol')
    )" configClasses (configFile >> "CfgWeapons");
    [_cfgList,1501] call buildList;

    _cfgList = "(
        (getNumber (_x >> 'scope') == 2) &&
        (getText (_x >> 'nameSound') == 'atlauncher')
    )" configClasses (configFile >> "CfgWeapons");
    [_cfgList,1502] call buildList;
};

openRifleShop = {
    _dspl   = findDisplay 7800;
    _ctrlRi = _dspl displayCtrl 1500;
    _ctrlPi = _dspl displayCtrl 1501;
    _ctrlLa = _dspl displayCtrl 1502;
    _ctrlRi ctrlShow true;
    _ctrlPi ctrlShow false;
    _ctrlLa ctrlShow false;
};

openPistolShop = {
    _dspl   = findDisplay 7800;
    _ctrlRi = _dspl displayCtrl 1500;
    _ctrlPi = _dspl displayCtrl 1501;
    _ctrlLa = _dspl displayCtrl 1502;
    _ctrlRi ctrlShow false;
    _ctrlPi ctrlShow true;
    _ctrlLa ctrlShow false;
};

openLauncherShop = {
    _dspl   = findDisplay 7800;
    _ctrlRi = _dspl displayCtrl 1500;
    _ctrlPi = _dspl displayCtrl 1501;
    _ctrlLa = _dspl displayCtrl 1502;
    _ctrlRi ctrlShow false;
    _ctrlPi ctrlShow false;
    _ctrlLa ctrlShow true;
};
