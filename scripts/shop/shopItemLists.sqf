freeUniforms    = ["U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_stripped","U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon","U_C_Poloshirt_redwhite","U_C_Commoner1_1","U_C_Commoner1_2","U_C_Commoner1_3","U_Rangemaster","B_RangeMaster_F","U_NikosBody","C_Nikos","U_OrestesBody"];
startPistol     = "hgun_Rook40_F";

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

rifleTypes     = ["AssaultRifle","MachineGun","Shotgun","Rifle","SubmachineGun","SniperRifle"];
launcherTypes  = ["GrenadeLauncher","Launcher","MissileLauncher","Mortar","RocketLauncher"];
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
                HeadgearList pushBackUnique [_price,_x,"CfgWeapons"];
            };
            if(_itemType == "Vest")then{
                _mass = getNumber (configFile >> "cfgWeapons" >> _x >> "ItemInfo" >> "mass");
                _price = _mass * 15;
                VestList pushBackUnique [_price,_x,"CfgWeapons"];
            };
            if(_itemType == "Uniform" && _x != "U_BasicBody")then{
                _mass = getNumber (configFile >> "cfgWeapons" >> _x >> "ItemInfo" >> "mass");
                _price = _mass * 20;
                UniformList pushBackUnique [_price,_x,"CfgWeapons"];
            };
        };

        //Attatchments
        if(_itemCategory == "Item")then{
            if(_itemType == "AccessoryBipod")then{
                _mass       = getNumber (configFile >> "cfgWeapons" >> _x >> "ItemInfo" >> "mass");
                _price      = _mass * 10;
                BipodList pushBackUnique [_price,_x,"CfgWeapons"];
            };
            if(_itemType == "AccessoryMuzzle")then{
                _mass       = getNumber (configFile >> "cfgWeapons" >> _x >> "ItemInfo" >> "mass");
                _price      = _mass * 20;
                SurpressorList pushBackUnique [_price,_x,"CfgWeapons"];
            };
            if(_itemType == "AccessorySights")then{
                _mass       = getNumber (configFile >> "cfgWeapons" >> _x >> "ItemInfo" >> "mass");
                _modes      =  (configFile >> "cfgWeapons" >> _x >> "ItemInfo" >> "OpticsModes") call BIS_fnc_getCfgSubClasses;
                _price      = _mass * 20 * (count _modes);
                OpticList pushBackUnique [_price,_x,"CfgWeapons"];
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

            if(!isClass(configFile >> "cfgWeapons" >> _x >> "LinkedItems"))then{
                if(_itemType == "Handgun")then{
                    _price      = 2000 * (_caliber + _inertia);
                    PistolList pushBackUnique [_price,_x,"CfgWeapons"];
                };
                if(_itemType in rifleTypes)then{
                    _price      = 3000 * (_caliber + _inertia);
                    RifleList pushBackUnique [_price,_x,"CfgWeapons"];
                };
                if(_itemType in launcherTypes)then{
                    _price      = 400 * (_mass + _inertia);
                    LauncherList pushBackUnique [_price,_x,"CfgWeapons"];
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
        BackpackList pushBackUnique [_price,_x,"CfgVehicles"];
    };
} forEach _vehicleList;