pageextension 80108 "Production Planner RC ET" extends "Production Planner Role Center"
{
    layout
    {
        addafter(Control45)
        {
            part(TileGroup0; "Easy Tile Activities")
            {
                Caption = 'TileGroup0';
                SubPageView = where("Tile Group Position" = const(0), "Edit Mode" = const(false));
                ApplicationArea = all;
            }
        }
        addafter(Control1905113808)
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
        }
    }
}
