controladdin "Easy Tile Controller"
{
    Scripts = 'https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js', 'src/controladdin/EasyTileController/Script.js';
    StartupScript = 'src/controladdin/EasyTileController/Startup.js';
    StyleSheets = 'src/controladdin/EasyTileController/Style.css';

    MaximumHeight = 3;
    MaximumWidth = 3;
    HorizontalShrink = true;
    VerticalShrink = true;

    event ControlAddinReady();

    event InitFinished(controlid: Text)

    procedure FindAndSetTileGroup(elementid: Text; caption: Text; setfindcontrol: Text)
    procedure FindAndRemoveTileGroup(elementid: Text)
    procedure SetGroupCaption1(elementid: Text; Caption1: Text; Caption2: Text)
    procedure SetGroupCaption2(elementid: Text; Caption1: Text; Caption2: Text; Caption3: Text; Caption4: Text)

    procedure EditTile(elementid: Text; groupid: integer; tileid: integer; removenumber: Boolean; peektext: Text; peektextstyle: Text; tilebackground: text; tilefontcolor: text; iconsvg: Text)
}