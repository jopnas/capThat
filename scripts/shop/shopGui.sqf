disableSerialization;

_ok         = createDialog "shopGUI";
if (!_ok) then {
    systemChat "Dialog couldn't be opened!"
};

_itemlb = (findDisplay 7800) displayCtrl 1306;

for "_i" from 1 to 10 do {
    _itemlb lbAdd format["Item %1",_i];
};
