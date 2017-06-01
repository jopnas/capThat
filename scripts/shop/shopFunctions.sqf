shopBuyItem = {
    params["_itemClass","_idcBuy","_idcEquip"];
    systemChat format["Buy this, %1",_itemClass];

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
    systemChat format["Equip this, %1",_itemClass];

    _equipedEquipment = player getVariable["equipedEquipment", []];
    _equipedEquipment pushBackUnique _itemClass;

    profileNamespace setVariable["var_ct_equipedEquipment", _equipedEquipment];
    player setVariable["equipedEquipment", _equipedEquipment, false];

    player addWeapon _itemClass;

    _dspl       = findDisplay 7800;
    _btnEquip   = _dspl displayCtrl _idcEquip;

    _btnEquip ctrlEnable true;
};
