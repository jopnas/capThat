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
    if(getnumber (configFile >> "cfgWeapons" >> _x >> "scope") > 0)then{
        // Cloth
        if(_itemCategory == "Equipment")then{
            if(_itemType == "Headgear")then{
                HeadgearList pushBackUnique [_x,100];
            };
            if(_itemType == "Vest")then{
                VestList pushBackUnique [_x,300];
            };
            if(_itemType == "Uniform" && _x != "U_BasicBody")then{
                UniformList pushBackUnique [_x,600];
            };
        };

        //Attatchments
        if(_itemCategory == "Item")then{
            if(_itemType == "AccessoryBipod")then{
                BipodList pushBackUnique [_x,200];
            };
            if(_itemType == "AccessoryMuzzle")then{
                SurpressorList pushBackUnique [_x,300];
            };
            if(_itemType == "AccessorySights")then{
                OpticList pushBackUnique [_x,500];
            };
        };

        // Weapons
        if(_itemCategory == "Weapon")then{
            _modes      = getArray (configFile >> "CfgWeapons" >> _class >> "modes");
            _inertia    = getArray (configFile >> "CfgWeapons" >> _class >> "inertia");
            _magazines  = getArray (configFile >> "CfgWeapons" >> _class >> "magazines");

            _mass       = getNumber (configFile >> "CfgMagazines" >> (_magazines select 0) >> "mass");
            _ammo       = getText (configFile >> "CfgMagazines" >> (_magazines select 0) >> "ammo");

            _caliber    = getNumber (configFile >> "CfgAmmo" >> _ammo >> "caliber");

            if(count(getArray (configFile >> "cfgWeapons" >> _x >> "LinkedItems")) == 0)then{
                if(_itemType == "Handgun")then{
                    _price      = 2 * (_caliber + _inertia);
                    PistolList pushBackUnique [_x,_price];
                };
                if(_itemType in _rifleTypes)then{
                    _price      = 3 * (_caliber + _inertia);
                    RifleList pushBackUnique [_x,_price];
                };
                if(_itemType in _launcherTypes)then{
                    _price      = 4 * (_mass + _inertia);
                    LauncherList pushBackUnique [_x,_price];
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
        BackpackList pushBackUnique [_x,2000];
    };
} forEach _vehicleList;