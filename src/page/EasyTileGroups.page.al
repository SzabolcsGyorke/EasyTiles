page 80103 "Easy Tile Groups"
{
    ApplicationArea = All;
    Caption = 'Easy Tile Groups';
    PageType = List;
    SourceTable = "Easy Tile Group";
    UsageCategory = Administration;
    AboutTitle = 'Create new tile groups';
    AboutText = 'Tile groups are a collection of 2x10 or 4x5 groups of tiles. Each group can have it''s individual caption.';
    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    AboutTitle = 'New Group - Code';
                    AboutText = 'Add a new to code to begin. This will identify the collection for assignment to roles.';
                }
                field(Caption; Rec.Caption)
                {
                    ToolTip = 'Specifies the value of the Caption field.';
                }
                field(Layout; Rec.Layout)
                {
                    ToolTip = 'Specifies the tile layout';
                    AboutTitle = 'Layout';
                    AboutText = 'Define the tile layout: 2x10 or 4x5 in maximum 20 tiles. This can be changed later but tiles might need reorganization as group captions will be reduced or increased.';
                }
                field("Enable Personalization"; Rec."Enable Personalization")
                {
                    ToolTip = 'Specifies the value of the Enable Personalization field.';
                    Visible = false;
                }
                field("Group 1 Caption"; Rec."Group 1 Caption")
                {
                    ToolTip = 'Specifies the value of the Group 1 Caption field.';
                    AboutTitle = 'Captions';
                    AboutText = 'Optional step to organize the tiles into groups.';
                }
                field("Group 2 Caption"; Rec."Group 2 Caption")
                {
                    ToolTip = 'Specifies the value of the Group 2 Caption field.';
                }
                field("Group 3 Caption"; Rec."Group 3 Caption")
                {
                    ToolTip = 'Specifies the value of the Group 3 Caption field.';
                    Editable = Rec.Layout = Rec.Layout::"4x5";
                }
                field("Group 4 Caption"; Rec."Group 4 Caption")
                {
                    ToolTip = 'Specifies the value of the Group 4 Caption field.';
                    Editable = Rec.Layout = Rec.Layout::"4x5";
                }
                field("Auto Refresh Interval"; Rec."Auto Refresh Interval")
                {
                    Caption = 'Auto Refresh Interval (sec)';
                    ToolTip = 'Specifies the refresh interval in seconds. 0 will mean it is not refreshing.', Comment = '%';
                    AboutTitle = 'Refresh';
                    AboutText = 'If you want your tiles periodically refreshed you can add a number in seconds to trigger it. If the ';
                }
            }
        }
    }
    actions
    {
        area(Promoted)
        {
            actionref(EditTiles_Ref; EditTiles) { }
        }
        area(Processing)
        {
            action(EditTiles)
            {
                Caption = 'Edit Tiles';
                ToolTip = 'Edit the default tile assignment of the group';
                Image = AbsenceCategory;
                AboutTitle = 'Edit mode';
                AboutText = 'To create, modify, move or delete tiles within the selected group use the Edit interface.';
                trigger OnAction()
                var
                    EasyTileFunctions: Codeunit "Easy Tile Functions";
                begin
                    EasyTileFunctions.EditGroupDefinition(Rec.Code, true);
                end;
            }
        }
    }
}
