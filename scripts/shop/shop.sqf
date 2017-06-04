disableSerialization;

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
            _buttonBuy  = _display ctrlCreate ["shopBuyItemButton", 8210 + _listCount, _shopItemGroup];
            _buttonEqp  = _display ctrlCreate ["shopEquipItemButton", 8220 + _listCount, _shopItemGroup];

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
            _buttonBuy  buttonSetAction format["['%1',%2,%3] call shopBuyItem",_itemBaseClass,8210 + _listCount,8220 + _listCount];
            _buttonBuy  ctrlSetPosition [_posBtnBuy select 0,  _listCount * (_posPict select 3) + (_posPict select 3) - (_posBtnBuy select 3)];
            _buttonBuy  ctrlCommit 0;

            _posBtnEqp = ctrlPosition _buttonEqp;
            _buttonEqp  buttonSetAction format["['%1',%2] call shopEquipItem",_itemBaseClass,8220 + _listCount];
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

};

createDialog "shopGUI";

[] call shopBuildLists;
[] call openRifleShop;
