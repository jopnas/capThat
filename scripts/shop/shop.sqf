disableSerialization;
shopCtrls = [];
tabsCtrls = [7000,1701,1702,1703,17004,1705,1706,1707,1708,1709];

shopBuyItem = {
    params["_itemClass","_idcBuy","_idcEquip","_price"];
    systemChat format["%1, %2",_idcBuy,_idcEquip];
    _player_cash = profileNamespace getVariable["var_ct_cash",0];
    if(_player_cash >= _price)then{

        _boughtEquipment = player getVariable["boughtEquipment", []];
        _boughtEquipment pushBackUnique _itemClass;

        profileNamespace setVariable["var_ct_boughtEquipment", _boughtEquipment];
        player setVariable["boughtEquipment", _boughtEquipment, false];

        _dspl       = findDisplay 7800;
        _btnBuy     = _dspl displayCtrl _idcBuy;
        _btnEquip   = _dspl displayCtrl _idcEquip;

        _btnBuy ctrlEnable false;
        _btnEquip ctrlEnable true;

        profileNamespace setVariable ["var_ct_cash",_player_cash - _price];
        saveProfileNamespace;
    };
};

shopEquipItem = {
    params["_itemClass","_idcEquip"];

    _equipedEquipment = player getVariable["equipedEquipment", []];
    _equipedEquipment pushBackUnique _itemClass;

    profileNamespace setVariable["var_ct_equipedEquipment", _equipedEquipment];
    player setVariable["equipedEquipment", _equipedEquipment, false];

    player addWeapon _itemClass;

    _dspl       = findDisplay 7800;
    _btnEquip   = _dspl displayCtrl _idcEquip;

    _btnEquip ctrlEnable true;

    saveProfileNamespace;
};

buildList = {
    params["_cfgList","_idc"];

    _display            = findDisplay 7800;
    _shopItemGroup      = _display displayCtrl _idc;

    _itemList  = [];
    {
        _className      = configName _x;
        _itemBaseClass  = _className call BIS_fnc_baseWeapon;

        _hasBought      = ( _itemBaseClass in (player getVariable["boughtEquipment",[]]) );
        _hasEquiped     = ( _itemBaseClass in (player getVariable["equipedEquipment",[]]) );


        if(!(_itemBaseClass in _itemList))then{
            _listCount  = count _itemList;
            _itemList   pushBackUnique _itemBaseClass;

            _itemName   = getText(configFile >> "CfgWeapons" >> _itemBaseClass >> "displayName");
            _itemImg    = getText (configFile >> "CfgWeapons" >> _itemBaseClass >> "picture");

            _modes      = getArray (configFile >> "CfgWeapons" >> _itemBaseClass >> "modes");
            _magazines  = getArray (configFile >> "CfgWeapons" >> _itemBaseClass >> "magazines");
            _ammo       = getText (configFile >> "CfgMagazines" >> (_magazines select 0) >> "ammo");
            _caliber    = getNumber (configFile >> "CfgAmmo" >> _ammo >> "caliber");

            _price      = _caliber * (count _modes) * 1000;

            //_bg         = _display ctrlCreate ["RscPicture", -1, _shopItemGroup];
            _picture    = _display ctrlCreate ["shopItemPicture", -1, _shopItemGroup];
            _title      = _display ctrlCreate ["shopItemName", -1, _shopItemGroup];
            _priceText  = _display ctrlCreate ["shopItemPrice", -1, _shopItemGroup];


            _btn_buy_id = _idc + 7100 + (_listCount * 10);
            _btn_Eqp_id = _idc + 7200 + (_listCount * 10);
            _buttonBuy  = _display ctrlCreate ["shopBuyItemButton", _btn_buy_id, _shopItemGroup];
            _buttonEqp  = _display ctrlCreate ["shopEquipItemButton",_btn_Eqp_id, _shopItemGroup];
            systemChat format["%1, %2",_btn_buy_id,_btn_Eqp_id];

            _posPict    = ctrlPosition _picture;

            _picture    ctrlSetText format["%1",_itemImg];
            _picture    ctrlSetPosition [0, _listCount * (_posPict select 3)];
            _picture    ctrlCommit 0;

            _title      ctrlSetText format["%1",_itemName];
            _title      ctrlSetPosition [ctrlPosition _title select 0,  _listCount * (_posPict select 3)];
            _title      ctrlCommit 0;

            _priceText  ctrlSetText format["$ %1",_price];
            _priceText  ctrlSetPosition [ctrlPosition _priceText select 0,  _listCount * (_posPict select 3) + (ctrlPosition _title select 3)];
            _priceText  ctrlCommit 0;

            _posBtnBuy = ctrlPosition _buttonBuy;
            _buttonBuy  buttonSetAction format["['%1',%2,%3,%4] call shopBuyItem",_itemBaseClass,_btn_buy_id,_btn_Eqp_id,_price];
            _buttonBuy  ctrlSetPosition [_posBtnBuy select 0,  _listCount * (_posPict select 3) + (_posPict select 3) - (_posBtnBuy select 3)];
            _buttonBuy  ctrlCommit 0;

            _posBtnEqp = ctrlPosition _buttonEqp;
            _buttonEqp  buttonSetAction format["['%1',%2] call shopEquipItem",_itemBaseClass,_btn_Eqp_id];
            _buttonEqp  ctrlSetPosition [_posBtnEqp select 0,  _listCount * (_posPict select 3) + (_posPict select 3) - (_posBtnBuy select 3)];
            _buttonEqp  ctrlCommit 0;

            if(_hasBought)then{
                _buttonBuy ctrlEnable false;
                _buttonEqp ctrlEnable true;
            }else{
                _buttonBuy ctrlEnable true;
                _buttonEqp ctrlEnable false;
            };
        };
    } forEach _cfgList;
    shopCtrls pushBackUnique _idc;
};

// Init Groups
shopBuildLists = {
    // Weapons
    [RifleList,1500] call buildList;
    [PistolList,1501] call buildList;
    [LauncherList,1502] call buildList;

    // Attatchments
    [OpticList,1503] call buildList;
    [SurpressorList,1504] call buildList;
    [BipodList,1505] call buildList;

    // Clothes
    [HeadgearList,1506] call buildList;
    [UniformList,1507] call buildList;
    [VestList,1508] call buildList;
    [BackpackList,1509] call buildList;
};

// Toggle Shops
toggleTabs = {
    params["_showIdcs"];
    _dspl       = findDisplay 7800;
    {
        _thisCtrl = _dspl displayCtrl _x;
        if(ctrlShown _thisCtrl) then {
            _thisCtrl ctrlShow false;
        };

        if (_forEachIndex + 1 == count tabsCtrls) then {
            {
                _showCtrl = _dspl displayCtrl _x;
                _showCtrl ctrlShow true;
            } forEach _showIdcs;
        };
    } forEach tabsCtrls;
};

togglePage = {
    params["_showIdc"];
    _dspl       = findDisplay 7800;
    _showCtrl   = _dspl displayCtrl _x;
    {
        _thisCtrl = _dspl displayCtrl _x;
        if(ctrlShown _thisCtrl) exitWith {
            _thisCtrl ctrlShow false;
            _showCtrl ctrlShow true;
        };
    } forEach shopCtrls;
};

// Weaponshop
/*openRifleShop = {
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

// Attatchmentshop
openOpticShop = {
    _dspl   = findDisplay 7800;
    _ctrlRi = _dspl displayCtrl 1503;
    _ctrlPi = _dspl displayCtrl 1504;
    _ctrlLa = _dspl displayCtrl 1505;
    _ctrlRi ctrlShow true;
    _ctrlPi ctrlShow false;
    _ctrlLa ctrlShow false;
};

openSuppressorShop = {
    _dspl   = findDisplay 7800;
    _ctrlRi = _dspl displayCtrl 1503;
    _ctrlPi = _dspl displayCtrl 1504;
    _ctrlLa = _dspl displayCtrl 1505;
    _ctrlRi ctrlShow false;
    _ctrlPi ctrlShow true;
    _ctrlLa ctrlShow false;
};

openBipodShop = {
    _dspl   = findDisplay 7800;
    _ctrlRi = _dspl displayCtrl 1503;
    _ctrlPi = _dspl displayCtrl 1504;
    _ctrlLa = _dspl displayCtrl 1505;
    _ctrlRi ctrlShow false;
    _ctrlPi ctrlShow false;
    _ctrlLa ctrlShow true;
};*/

// Clothshop
openHeadgearShop = {
    _dspl   = findDisplay 7800;
    _ctrlClHe = _dspl displayCtrl 1506;
    _ctrlClUn = _dspl displayCtrl 1507;
    _ctrlClVe = _dspl displayCtrl 1508;
    _ctrlBaPa = _dspl displayCtrl 1509;
    _ctrlClHe ctrlShow true;
    _ctrlClUn ctrlShow false;
    _ctrlClVe ctrlShow false;
    _ctrlBaPa ctrlShow false;
};

openUniformShop = {
    _dspl   = findDisplay 7800;
    _ctrlClHe = _dspl displayCtrl 1506;
    _ctrlClUn = _dspl displayCtrl 1507;
    _ctrlClVe = _dspl displayCtrl 1508;
    _ctrlBaPa = _dspl displayCtrl 1509;
    _ctrlClHe ctrlShow false;
    _ctrlClUn ctrlShow true;
    _ctrlClVe ctrlShow false;
    _ctrlBaPa ctrlShow false;
};

openVestShop = {
    _dspl   = findDisplay 7800;
    _ctrlClHe = _dspl displayCtrl 1506;
    _ctrlClUn = _dspl displayCtrl 1507;
    _ctrlClVe = _dspl displayCtrl 1508;
    _ctrlBaPa = _dspl displayCtrl 1509;
    _ctrlClHe ctrlShow false;
    _ctrlClUn ctrlShow false;
    _ctrlClVe ctrlShow true;
    _ctrlBaPa ctrlShow false;
};

openBackpackShop = {
    _dspl   = findDisplay 7800;
    _ctrlClHe = _dspl displayCtrl 1506;
    _ctrlClUn = _dspl displayCtrl 1507;
    _ctrlClVe = _dspl displayCtrl 1508;
    _ctrlBaPa = _dspl displayCtrl 1509;
    _ctrlClHe ctrlShow false;
    _ctrlClUn ctrlShow false;
    _ctrlClVe ctrlShow false;
    _ctrlBaPa ctrlShow true;
};

createDialog "shopGUI";
[] call shopBuildLists;