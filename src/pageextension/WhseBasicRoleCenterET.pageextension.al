pageextension 80105 "Whse. Basic Role Center ET" extends "Whse. Basic Role Center"
{
    layout
    {
        addafter(Control51)
        {
            part(TileGroup0; "Easy Tile Activities")
            {
                Caption = 'TileGroup0';
                SubPageView = where("Tile Group Position" = const(0), "Edit Mode" = const(false));
                ApplicationArea = all;
            }
        }
        addafter(Control1906245608)
        {
            part(TileGroup1; "Easy Tile Activities")
            {
                Caption = 'TileGroup1';
                SubPageView = where("Tile Group Position" = const(1), "Edit Mode" = const(false));
                ApplicationArea = all;
            }
            part(TileGroup2; "Easy Tile Activities")
            {
                Caption = 'TileGroup2';
                SubPageView = where("Tile Group Position" = const(2), "Edit Mode" = const(false));
                ApplicationArea = all;
            }
            part(TileGroup3; "Easy Tile Activities")
            {
                Caption = 'TileGroup3';
                SubPageView = where("Tile Group Position" = const(3), "Edit Mode" = const(false));
                ApplicationArea = all;
            }
            part(TileGroup4; "Easy Tile Activities")
            {
                Caption = 'TileGroup4';
                SubPageView = where("Tile Group Position" = const(4), "Edit Mode" = const(false));
                ApplicationArea = all;
            }
            part(TileGroup5; "Easy Tile Activities")
            {
                Caption = 'TileGroup5';
                SubPageView = where("Tile Group Position" = const(5), "Edit Mode" = const(false));
                ApplicationArea = all;
            }
            part(TileGroup6; "Easy Tile Activities")
            {
                Caption = 'TileGroup6';
                SubPageView = where("Tile Group Position" = const(6), "Edit Mode" = const(false));
                ApplicationArea = all;
            }
            part(TileGroup7; "Easy Tile Activities")
            {
                Caption = 'TileGroup7';
                SubPageView = where("Tile Group Position" = const(7), "Edit Mode" = const(false));
                ApplicationArea = all;
            }
            part(TileGroup8; "Easy Tile Activities")
            {
                Caption = 'TileGroup8';
                SubPageView = where("Tile Group Position" = const(8), "Edit Mode" = const(false));
                ApplicationArea = all;
            }
            part(TileGroup9; "Easy Tile Activities")
            {
                Caption = 'TileGroup9';
                SubPageView = where("Tile Group Position" = const(9), "Edit Mode" = const(false));
                ApplicationArea = all;
            }
        }
    }
}
