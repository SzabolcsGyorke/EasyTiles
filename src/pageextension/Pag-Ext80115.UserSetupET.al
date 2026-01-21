pageextension 80115 "User Setup ET" extends "User Setup"
{
    layout
    {
        addafter(Email)
        {

            field("EasyTile Admin SG"; Rec."EasyTile Admin SG")
            {
                ApplicationArea = All;
                ToolTip = 'Admins can edit the tiles and tile groups.', Comment = '%';
            }
        }
    }
}
