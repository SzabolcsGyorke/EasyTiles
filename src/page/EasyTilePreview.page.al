page 80107 "Easy Tile Preview"
{
    ApplicationArea = All;
    Caption = 'Easy Tile Preview';
    PageType = Card;
    SourceTable = "Easy Tile Buffer";
    SourceTableTemporary = true;
    layout
    {
        area(Content)
        {
            part(TileGroup1; "Easy Tile Activities")
            {
                Caption = 'TileGroup1';
                SubPageView = where("Preview Mode" = const(true), "Edit Mode" = const(true));
                ApplicationArea = all;
            }
        }
    }


}
