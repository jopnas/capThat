disableSerialization;

shopOpen = true;
if(count (attachedObjects player) > 0)then{
    [(attachedObjects player) select 0,false] remoteExec ["hideLaptopGlobal", 2];
};

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
    params["_itemClass","_idcEquip","_addMags"];

    _fncItemType    = _itemClass call bis_fnc_itemType;
    _itemCategory   = _fncItemType select 0;
    _itemType       = _fncItemType select 1;

    if(_itemCategory == "Weapon")then{
        if(_itemType in rifleTypes)then{
            _addMags = 4;
        };
        if(_itemType == "Handgun")then{
            _addMags = 6;
        };
        if(_itemType in launcherTypes)then{
            _addMags = 2;
        };
        [player, _itemClass, _addMags] call BIS_fnc_addWeapon;
    };

     if(_itemType == "Headgear")then{
        player addWeapon _itemClass;
    };

    if(_itemType == "Uniform")then{
        player forceAddUniform _itemClass;
    };

    if(_itemType == "Vest")then{
        player addVest _itemClass;
    };

    if(_itemType == "Backpack")then{
        player addBackpack _itemClass;
    };

    if(_itemCategory == "Item")then{
        player addWeaponItem [currentWeapon player, _itemClass];
    };

    _dspl       = findDisplay 7800;
    _btnEquip   = _dspl displayCtrl _idcEquip;

    _btnEquip ctrlEnable true;
};

buildList = {
    disableSerialization;
    params["_cfgList","_idc"];

    _sortedArray    = _cfgList apply { _x select 1;_x};
    _sortedArray sort true;

    _display        = findDisplay 7800;
    _shopItemGroup  = _display displayCtrl _idc;
    _shopItemGroup ctrlShow false;

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
    } forEach _sortedArray;
};

// Init Groups
shopBuildLists = {
    params["_display"];
    _shopLoadingScreen      = _display ctrlCreate ["pageLoadingScreen", 9990];
    // _shopLoadingScreen ctrlSetAngle 45

    // Weapons
    _RifleListReady         = [RifleList,1500] spawn buildList;
    _PistolListReady        = [PistolList,1501] spawn buildList;
    _LauncherListReady      = [LauncherList,1502] spawn buildList;

    // Attatchments
    _OpticListReady         = [OpticList,1503] spawn buildList;
    _SurpressorListReady    = [SurpressorList,1504] spawn buildList;
    _BipodListReady         = [BipodList,1505] spawn buildList;

    // Clothes
    _HeadgearListReady      = [HeadgearList,1506] spawn buildList;
    _UniformListReady       = [UniformList,1507] spawn buildList;
    _VestListReady          = [VestList,1508] spawn buildList;
    _BackpackListReady      = [BackpackList,1509] spawn buildList;

    // Show first Category and first type
    _toggleFirstTabsReady   = [[1700,1701,1702],1500] spawn toggleCats;

    waitUntil {
        scriptDone _RifleListReady &&
        scriptDone _PistolListReady &&
        scriptDone _LauncherListReady &&
        scriptDone _OpticListReady &&
        scriptDone _SurpressorListReady &&
        scriptDone _BipodListReady &&
        scriptDone _HeadgearListReady &&
        scriptDone _UniformListReady &&
        scriptDone _VestListReady &&
        scriptDone _BackpackListReady &&
        scriptDone _toggleFirstTabsReady
    };

    sleep 5;
     _shopLoadingScreen ctrlShow false;
};

// Toggle Side-Tabs
toggleCats = {
    disableSerialization;
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
_display = findDisplay 7800;
[_display] call shopBuildLists;

_display displayAddEventHandler ["Unload", {
    shopOpen = false;
    if(count (attachedObjects player) > 0)then{
        [(attachedObjects player) select 0,true] remoteExec ["hideLaptopGlobal", 2];
    };
    [] call savePlayerEquipment;
}];

