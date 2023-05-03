page 80103 "Easy Tile Groups"
{
    ApplicationArea = All;
    Caption = 'Easy Tile Groups';
    PageType = List;
    SourceTable = "Easy Tile Group";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Caption; Rec.Caption)
                {
                    ToolTip = 'Specifies the value of the Caption field.';
                }
                field(Layout; Rec.Layout)
                {
                    ToolTip = 'Specifies the tile layout';
                }
                field("Enable Personalization"; Rec."Enable Personalization")
                {
                    ToolTip = 'Specifies the value of the Enable Personalization field.';
                }
                field("Group 1 Caption"; Rec."Group 1 Caption")
                {
                    ToolTip = 'Specifies the value of the Group 1 Caption field.';
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
                ToolTip = 'Edit the defult tile assignment of the group';
                Image = AbsenceCategory;
                trigger OnAction()
                var
                    EasyTileFunctions: Codeunit "Easy Tile Functions";
                begin
                    EasyTileFunctions.EditGroupDefintion(Rec.Code, true);
                end;
            }
        }
    }
}
