disableSerialization;

player setVariable["curTabCtrls",[1700,1701,1702,1703,1704,1705,1706,1707,1708,1709],false];
player setVariable["curGroupCtrl",[1500],false];

shopBuyItem = {
    params["_itemClass","_idcBuy","_idcEquip","_price"];
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

    _fncItemType    = _itemClass call bis_fnc_itemType;
    _itemCategory   = _fncItemType select 0;
    _itemType       = _fncItemType select 1;

    systemChat format["%1, %2, %3",_itemClass,_itemCategory,_itemType] ;

    _equipedEquipment = player getVariable["equipedEquipment", []];
    _equipedEquipment pushBackUnique _itemClass;

    profileNamespace setVariable["var_ct_equipedEquipment", _equipedEquipment];
    player setVariable["equipedEquipment", _equipedEquipment, false];


    if(_itemType == "Headgear")then{
        player addWeapon _itemClass;
    };

    if(_itemCategory == "Weapon")then{
        if(_itemClass in LauncherList)then{
            _addMags = 2;
        };
        if(_itemClass in RifleList)then{
            _addMags = 4;
        };
        if(_itemClass in PistolList)then{
            _addMags = 2;
        };

        [player, _itemClass, _addMags] call BIS_fnc_addWeapon;
    };

    if(_itemType == "Backpack")then{
        player addBackpack _itemClass;
    };

    if(_itemType == "Vest")then{
        player addVest _itemClass;
    };

    if(_itemType == "Uniform")then{
        player forceAddUniform _itemClass;
    };

    if(_itemCategory == "Item")then{
        player addPrimaryWeaponItem _itemClass;
    };

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
        _class          = _x select 0;
        _price          = _x select 1;
        _cfgName        = _x select 2;

        _hasBought      = ( _class in (player getVariable["boughtEquipment",[]]) );
        _hasEquiped     = ( _class in (player getVariable["equipedEquipment",[]]) );


        if(!(_class in _itemList))then{
            _listCount  = count _itemList;
            _itemList   pushBackUnique _class;

            _itemName   = getText(configFile >> _cfgName >> _class >> "displayName");
            _itemImg    = getText (configFile >> _cfgName >> _class >> "picture");

            _picture    = _display ctrlCreate ["shopItemPicture", -1, _shopItemGroup];
            _title      = _display ctrlCreate ["shopItemName", -1, _shopItemGroup];
            _priceText  = _display ctrlCreate ["shopItemPrice", -1, _shopItemGroup];


            _btn_buy_id = _idc + 7100 + (_listCount * 10);
            _btn_Eqp_id = _idc + 7200 + (_listCount * 10);
            _buttonBuy  = _display ctrlCreate ["shopBuyItemButton", _btn_buy_id, _shopItemGroup];
            _buttonEqp  = _display ctrlCreate ["shopEquipItemButton",_btn_Eqp_id, _shopItemGroup];

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
            _buttonBuy  buttonSetAction format["['%1',%2,%3,%4] call shopBuyItem",_class,_btn_buy_id,_btn_Eqp_id,_price];
            _buttonBuy  ctrlSetPosition [_posBtnBuy select 0,  _listCount * (_posPict select 3) + (_posPict select 3) - (_posBtnBuy select 3)];
            _buttonBuy  ctrlCommit 0;

            _posBtnEqp = ctrlPosition _buttonEqp;
            _buttonEqp  buttonSetAction format["['%1',%2] call shopEquipItem",_class,_btn_Eqp_id];
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

    _shopItemGroup ctrlShow false;
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

    // Show first Category and first type
    [[1700,1701,1702],1500] call toggleCats;
};

// Toggle Side-Tabs
toggleCats = {
    params["_catShowTabs","_catFirstType"];
    _curTabCtrls    = player getVariable "curTabCtrls";
    _dspl           = findDisplay 7800;

    {
        _hideCtrl = _dspl displayCtrl _x;
        _hideCtrl ctrlShow false;
    } forEach _curTabCtrls;

    {
        _showCtrl = _dspl displayCtrl _x;
        _showCtrl ctrlShow true;
    } forEach _catShowTabs;

    player setVariable["curTabCtrls",_catShowTabs,false];
    [_catFirstType] call toggleTypes;
};

// Toggle Top-Tabs
toggleTypes = {
    params["_showIdc"];
    _curGroupCtrl = player getVariable "curGroupCtrl";
    _dspl       = findDisplay 7800;
    _showCtrl   = _dspl displayCtrl _showIdc;
    _hideCtrl   = _dspl displayCtrl (_curGroupCtrl select 0);

    _hideCtrl ctrlShow false;
    _showCtrl ctrlShow true;

    player setVariable["curGroupCtrl",[_showIdc],false];
};

createDialog "shopGUI";
[] call shopBuildLists;

