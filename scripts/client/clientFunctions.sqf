savePlayerEquipment = {
    _equipedEquipment 	= player getVariable "equipedEquipment";
	_player 			= player;

	// Rifle
    (_equipedEquipment select 0) set [0,primaryWeapon _player];
   	// Rifle Surpessors
	(_equipedEquipment select 0) set [1,(primaryWeaponItems _player) select 0];
    // Pointer
	(_equipedEquipment select 0) set [3,(primaryWeaponItems _player) select 1];
     // Sights
	(_equipedEquipment select 0) set [4,(primaryWeaponItems _player) select 2];
	// Bipod
	(_equipedEquipment select 0) set [2,(primaryWeaponItems _player) select 3];

	// Handgun
    (_equipedEquipment select 1) set [0,handgunWeapon _player];
  	// Handgun Surpessors
	(_equipedEquipment select 1) set [1,(handgunItems _player) select 0];
    // Pointer
	(_equipedEquipment select 1) set [3,(handgunItems _player) select 1];
     // Sights
	(_equipedEquipment select 1) set [4,(handgunItems _player) select 2];
	// Bipod
	(_equipedEquipment select 1) set [2,(handgunItems _player) select 3];

	// Launcher
    (_equipedEquipment select 2) set [0,secondaryWeapon _player];
  	// Launcher Surpessors
	(_equipedEquipment select 2) set [1,(secondaryWeaponItems _player) select 0];
    // Pointer
	(_equipedEquipment select 2) set [3,(secondaryWeaponItems _player) select 1];
     // Sights
	(_equipedEquipment select 2) set [4,(secondaryWeaponItems _player) select 2];
	// Bipod
	(_equipedEquipment select 2) set [2,(secondaryWeaponItems _player) select 3];

    // Headgear
    (_equipedEquipment select 3) set [0,headgear _player];

    // Uniform
    (_equipedEquipment select 3) set [1,uniform _player];

    // Vest
    (_equipedEquipment select 3) set [2,vest _player];

    // Backpack
    (_equipedEquipment select 3) set [3,backpack _player];

	_profileNamespace = profileNamespace;
	_profileNamespace setVariable["var_ct_equipedEquipment", _equipedEquipment];
	_player setVariable["equipedEquipment", _equipedEquipment, false];
	saveProfileNamespace;
    systemChat "closed Shop";
};

addPlayersItems = {
    params["_itemClass","_lastWeapon","_addMags"];
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
        systemChat _lastWeapon;
        player addWeaponItem [_lastWeapon,_itemClass];
    };
};