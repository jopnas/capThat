RifleList       = [];
PistolList      = [];
LauncherList    = [];
OpticList       = [];
SurpressorList  = [];
BipodList       = [];
HeadgearList    = [];
UniformList     = [];
VestList        = [];
BackpackList    = [];

_rifleTypes     = ["AssaultRifle","MachineGun","Shotgun","Rifle","SubmachineGun","SniperRifle"];
_launcherTypes  = ["GrenadeLauncher","Launcher","MissileLauncher","Mortar","RocketLauncher"];
_weaponsList = (configFile >> "CfgWeapons") call BIS_fnc_getCfgSubClasses;
{
    private["_itemType"];
    _fncItemType    = _x call bis_fnc_itemType;
    _itemCategory   = _fncItemType select 0;
    _itemType       = _fncItemType select 1;

    if(getnumber (configFile >> "cfgWeapons" >> _x >> "scope") > 1)then{
        // Cloth
        if(_itemCategory == "Equipment")then{
            if(_itemType == "Headgear")then{
                _mass = getNumber (configFile >> "cfgWeapons" >> _x >> "ItemInfo" >> "mass");
                _price = _mass * 10;
                HeadgearList pushBackUnique [_x,_price,"CfgWeapons"];
            };
            if(_itemType == "Vest")then{
                _mass = getNumber (configFile >> "cfgWeapons" >> _x >> "ItemInfo" >> "mass");
                _price = _mass * 15;
                VestList pushBackUnique [_x,_price,"CfgWeapons"];
            };
            if(_itemType == "Uniform" && _x != "U_BasicBody")then{
                _mass = getNumber (configFile >> "cfgWeapons" >> _x >> "ItemInfo" >> "mass");
                _price = _mass * 20;
                UniformList pushBackUnique [_x,_price,"CfgWeapons"];
            };
        };

        //Attatchments
        if(_itemCategory == "Item")then{
            if(_itemType == "AccessoryBipod")then{
                _mass = getNumber (configFile >> "cfgWeapons" >> _x >> "ItemInfo" >> "mass");
                _price = _mass * 10;
                BipodList pushBackUnique [_x,_price,"CfgWeapons"];
            };
            if(_itemType == "AccessoryMuzzle")then{
                _mass = getNumber (configFile >> "cfgWeapons" >> _x >> "ItemInfo" >> "mass");
                _price = _mass * 20;
                SurpressorList pushBackUnique [_x,_price,"CfgWeapons"];
            };
            if(_itemType == "AccessorySights")then{
                _mass = getNumber (configFile >> "cfgWeapons" >> _x >> "ItemInfo" >> "mass");
                _modes = count(getArray (configFile >> "cfgWeapons" >> _x >> "ItemInfo" >> "OpticsModes"));
                _price = _mass *  _modes;
                OpticList pushBackUnique [_x,_price,"CfgWeapons"];
            };
        };

        // Weapons
        if(_itemCategory == "Weapon")then{
            _modes      = getArray (configFile >> "CfgWeapons" >> _x >> "modes");
            _inertia    = getNumber (configFile >> "CfgWeapons" >> _x >> "inertia");
            _magazines  = getArray (configFile >> "CfgWeapons" >> _x >> "magazines");

            _ammo       = getText (configFile >> "CfgMagazines" >> (_magazines select 0) >> "ammo");
            _mass       = getNumber (configFile >> "CfgMagazines" >> (_magazines select 0) >> "mass");
            _caliber    = getNumber (configFile >> "CfgAmmo" >> _ammo >> "caliber");

            if(count(getArray (configFile >> "cfgWeapons" >> _x >> "LinkedItems")) == 0)then{
                if(_itemType == "Handgun")then{
                    _price      = 2000 * (_caliber + _inertia);
                    PistolList pushBackUnique [_x,_price,"CfgWeapons"];
                };
                if(_itemType in _rifleTypes)then{
                    _price      = 3000 * (_caliber + _inertia);
                    RifleList pushBackUnique [_x,_price,"CfgWeapons"];
                };
                if(_itemType in _launcherTypes)then{
                    _price      = 4000 * (_mass + _inertia);
                    LauncherList pushBackUnique [_x,_price,"CfgWeapons"];
                };
            };
        };
    };
} forEach _weaponsList;

// Backpacks
_excludeBackpacks = ["Bag_Base","B_Parachute"];
_vehicleList = (configFile >> "CfgVehicles") call BIS_fnc_getCfgSubClasses;
{
    _countTransportMagazines = count((configFile >> 'CfgVehicles' >> _x >> 'TransportMagazines') call BIS_fnc_getCfgSubClasses);
    _countTransportWeapons = count((configFile >> 'CfgVehicles' >> _x >> 'TransportWeapons') call BIS_fnc_getCfgSubClasses);
    _countTransportItems = count((configFile >> 'CfgVehicles' >> _x >> 'TransportItems') call BIS_fnc_getCfgSubClasses);

    _countTransport = _countTransportMagazines + _countTransportWeapons + _countTransportItems;

    if( !(_x in _excludeBackpacks) && _countTransport == 0 && getNumber (configFile >> 'CfgVehicles' >> _x >> 'maximumLoad') > 0 && getNumber (configFile >> 'CfgVehicles' >> _x >> 'isbackpack') == 1 && getNumber (configFile >> 'CfgVehicles' >> _x >> 'scope') > 0)then{
        _maxLoad    = getNumber (configFile >> "CfgVehicles" >> _x >> "maximumLoad");
        _price      = _maxLoad * 10;
        BackpackList pushBackUnique [_x,_price,"CfgVehicles"];
    };
} forEach _vehicleList;