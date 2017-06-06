class RscText
{
    type = 0;
    idc = -1;
    x = 0;
    y = 0;
    h = 0.037;
    w = 0.3;
    style = 0x100;
    font="TahomaB";
    SizeEx = 0.03;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0, 0, 0, 1};
    linespacing = 1;
    shadow = 1;
};

class RscPicture
{
    access = 0;
    type = 0;
    idc = -1;
    style = 48;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    font="TahomaB";
    SizeEx = 0.03;
};

class ScrollBar {
   color[] = {1,1,1,0.6};
   colorActive[] = {1,1,1,1};
   colorDisabled[] = {1,1,1,0.3};
   thumb = "#(argb,8,8,3)color(0.5,0.5,0.5,1)";
   arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
   arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
   border = "#(argb,8,8,3)color(1,1,1,1)";
   shadow = 0;
};

class RscControlsGroup {
	type = 15;
	idc = -1;
	style = 16;
    x = 0;
    y = 0;
    w = 1;
    h = 1;
	shadow=0;

	class VScrollbar:ScrollBar {
		width = 0.021;
        shadow=0;
	};

	class HScrollbar:ScrollBar {
		height = 0;
	};

	class Controls {}; // an empty class telling the engine, no custom, additional controls
};

class RscButton {
    access = 0;
    type = 1;
    text = "";
    colorText[] = {1,1,1,1};
    colorDisabled[] = {1,1,1,0.85};
    colorBackground[] = {0,0,0,1};
    colorBackgroundDisabled[] = {0,0,0,0};
    colorBackgroundActive[] = {1,1,1,0.85};
    colorFocused[] = {1,1,1,1};
    colorShadow[] = {0.023529,0,0.0313725,1};
    colorBorder[] = {0.023529,0,0.0313725,1};
    soundEnter[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundEnter", 0.09, 1};
    soundPush[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundPush", 0.0, 0};
    soundClick[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundClick", 0.07, 1};
    soundEscape[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundEscape", 0.09, 1};
    style = 2;
    x = 0;
    y = 0;
    w = 0.055589;
    h = 0.039216;
    shadow = 0;
    font = "puristaMedium";
    sizeEx = 0.03921;
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0;
    offsetPressedY = 0;
    borderSize = 0;
};