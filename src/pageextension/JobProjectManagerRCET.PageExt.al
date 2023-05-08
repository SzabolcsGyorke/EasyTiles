pageextension 80109 "Job Project Manager RC ET" extends "Job Project Manager RC"
{
    layout
    {
        addafter(Control102)
        {
            part(TileGroup0; "Easy Tile Activities")
            {
                Caption = 'TileGroup0';
                SubPageView = where("Tile Group Position" = const(0), "Edit Mode" = const(false));
                ApplicationArea = all;
            }
        }
        addafter(Control33)
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
