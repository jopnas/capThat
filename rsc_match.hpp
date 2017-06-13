#define scorePicTop (0.88485 * safezoneH + safezoneY)
#define scorePicWidth (0.035 * safezoneW)
#define scorePicHeight (0.044 * safezoneH)

class scoreDefaultPicture: RscPicture {
    idc = -1;
    text = "images\scoreicon.paa";
    style = ST_PICTURE;
    x = 0.929688 * safezoneW + safezoneX;
    y = scorePicTop;
    w = scorePicWidth;
    h = scorePicHeight;
    colorText[] = {0,0,0,1};
};

class scoreDefaultText: RscText {
    idc = -1;
    text = "0 MB";
    style = 0x01 + 0x0c;
    x = 0.929688 * safezoneW + safezoneX;
    y = scorePicTop + scorePicHeight;
    w = scorePicWidth;
    h = 0.03 * safezoneH;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0.5};
};

class lcdText: RscText {
    colorText[] = {0,0.4,0,1};
    colorBackground[] = {0,0,0,0};
    shadow = 0;
    font = "EtelkaMonospaceProBold";
    SizeEx = 0.015 * safezoneH;
}