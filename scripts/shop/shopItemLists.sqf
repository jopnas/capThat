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
    //_itemCategory   = _fncItemType select 0;
    _itemType       = _fncItemType select 1;
    if(getnumber (configFile >> "cfgWeapons" >> _x >> "scope") > 0)then{
        // Cloth
        if(_itemType == "Headgear")then{
            HeadgearList pushBackUnique _x;
        };
        if(_itemType == "Vest")then{
            VestList pushBackUnique _x;
        };
        if(_itemType == "Uniform" && _x != "U_BasicBody")then{
            UniformList pushBackUnique _x;
        };

        //Attatchments
        if(_itemType == "AccessoryBipod")then{
            BipodList pushBackUnique _x;
        };
        if(_itemType == "AccessoryMuzzle")then{
            SurpressorList pushBackUnique _x;
        };
        if(_itemType == "AccessorySights")then{
            OpticList pushBackUnique _x;
        };

        // Weapons
        if(_itemType == "Handgun")then{
            PistolList pushBackUnique _x;
        };
        if(_itemType in _rifleTypes)then{
            RifleList pushBackUnique _x;
        };
        if(_itemType in _launcherTypes)then{
            LauncherList pushBackUnique _x;
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
        BackpackList pushBackUnique _x;
    };
} forEach _vehicleList;