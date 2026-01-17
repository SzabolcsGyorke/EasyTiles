page 80107 "Easy Tile Preview"
{
    ApplicationArea = All;
    Caption = 'Easy Tile Preview';
    PageType = Card;
    SourceTable = "Easy Tile Buffer";
    SourceTableTemporary = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    AboutTitle = 'Edit Tile Group';
    AboutText = 'Here you can create, modify, delete tile definitions and change the order of them.';
    layout
    {
        area(Content)
        {
            part(TileGroup1; "Easy Tile Activities")
            {
                Caption = 'TileGroup1';
                SubPageView = where("Preview Mode" = const(true), "Edit Mode" = const(true));
                ApplicationArea = all;
                AboutTitle = 'Tiles';
                AboutText = 'To edit a tile just click on it. If you want to move it around toggle the move mode then click on the tile - the selected tile will be marked and show 999. Use the Left and Right action to move the selected tile.';
            }
        }
    }


}
