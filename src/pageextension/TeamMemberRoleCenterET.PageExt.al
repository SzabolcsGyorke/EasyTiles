pageextension 80113 "Team Member Role Center ET" extends "Team Member Role Center"
{
    layout
    {
        addafter(Control11)
        {
            part(TileGroup0; "Easy Tile Activities")
            {
                Caption = 'TileGroup0';
                SubPageView = where("Tile Group Position" = const(0), "Edit Mode" = const(false));
                ApplicationArea = all;
            }
        }
        addafter(Control3)
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
