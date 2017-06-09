#define groupX (0.229043 * safezoneW + safezoneX)
#define groupY (0.176985 * safezoneH + safezoneY)
#define tabWidth (0.0796933 * safezoneW)
#define tabHeight (0.0796933 * safezoneW)

// Loadingscreen
class pageLoadingScreen: RscPicture {
    idc = -1;
    text = "";
};

// Group
class shopGroup: RscControlsGroup {
    w = 0.5 * safezoneW;
    h = 0.714033 * safezoneH;
    x = groupX;
    y = groupY;
    colorBackground[] = {0.2,0.2,0.2,1};
    class Controls {};
};

// Items
class shopTopTabButton : RscButton {
    w = tabWidth;
    h = tabHeight;
    y = 0.125983 * safezoneH + safezoneY;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0.2,0.2,0.2,1};
    colorActive[] = {0,0.5,0,1};
    period = 0;
    periodFocus	= 0;
    periodOver = 0;
};

class shopSideTabButton : RscButton {
    w = tabWidth;
    h = tabHeight;
    x = groupX - tabWidth;
    y = groupY;
    colorText[] = {1,0,1,1};
    colorBackground[] = {0.1,0.3,0.1,1};
    colorActive[] = {0,0.5,0,1};
    period = 0;
    periodFocus	= 0;
    periodOver = 0;
};

class shopItemPicture : RscPictureKeepAspect {
    text = "";
    //style = 48;
    w = 0.2  * safezoneW;
    h = 0.15 * safezoneH;
    x = 0;
    y = 0;
    colorBackground[] = {0.2,0.2,0.2,1};
};

class shopItemName : RscText {
    text = "";
    w = (0.502068 * safezoneW) - (0.2  * safezoneW);
    h = (0.15 * safezoneH) / 3;
    x = 0.2  * safezoneW;
    y = 0;
    SizeEx = 0.02 * safezoneH;
    colorBackground[] = {0.2,0.2,0.2,1};
};

class shopItemPrice : RscText {
    text = "";
    w = (0.502068 * safezoneW) - (0.2  * safezoneW);
    h = (0.15 * safezoneH) / 3;
    x = 0.2  * safezoneW;
    y = (0.15 * safezoneH) / 3;
    SizeEx = 0.03 * safezoneH;
    colorBackground[] = {0.2,0.2,0.2,1};
};

class shopBuyItemButton : RscButton {
    text = "Buy";
    w = ((0.5 * safezoneW) - (0.2  * safezoneW)) / 2;
    h = (0.15 * safezoneH) / 3;
    x = 0.2  * safezoneW;
    y = ((0.15 * safezoneH) / 3) * 2
    colorText[] = {1,1,1,1};
    colorDisabled[] = {0.3,0.3,0.3,1};
    colorActive[] = {0,0.5,0,1};
    colorBackground[] = {0.5,0.5,0.5,1};
    colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
    colorBackgroundActive[] = {1,1,1,0.85};
    period = 0;
    periodFocus	= 0;
    periodOver = 0;
};

class shopEquipItemButton : RscButton {
    text = "Equip";
    w = ((0.5 * safezoneW) - (0.2  * safezoneW)) / 2;
    h = (0.15 * safezoneH) / 3;
    x = (0.2  * safezoneW) + (((0.5 * safezoneW) - (0.2  * safezoneW)) / 2);
    y = ((0.15 * safezoneH) / 3) * 2
    colorText[] = {1,1,1,1};
    colorDisabled[] = {0.3,0.3,0.3,1};
    colorActive[] = {0,0.5,0,1};
    colorBackground[] = {0.5,0.5,0.5,1};
    colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
    colorBackgroundActive[] = {1,1,1,0.85};
    period = 0;
    periodFocus	= 0;
    periodOver = 0;
};