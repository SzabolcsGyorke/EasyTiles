page 80104 "Easy Tile Group Lines"
{
    ApplicationArea = All;
    Caption = 'Easy Tile Group Lines';
    PageType = List;
    SourceTable = "Easy Tile Group Line";
    UsageCategory = None;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Tile Group Code"; Rec."Tile Group Code")
                {
                    ToolTip = 'Specifies the value of the Tile Group Code  field.';
                    Visible = false;
                }
                field("Tile Position"; Rec."Tile Position")
                {
                    ToolTip = 'Specifies the value of the Tile Position field.';
                    Editable = false;
                }
                field(Caption; Rec.Caption)
                {
                    ToolTip = 'Specifies the value of the Caption field.';
                }
                field(Visible; Rec.Visible)
                {
                    ToolTip = 'Specifies the value of the Visible field.';
                }
                field(Edit; 'Edit...')
                {
                    Caption = 'Action';
                    Editable = false;
                    Lookup = false;
                    AssistEdit = false;
                    DrillDown = true;
                    trigger OnDrillDown()
                    begin
                        page.Run(Page::"Easy Tile Setup Card", Rec);
                    end;
                }

            }
        }
    }
    actions
    {
        area(Promoted)
        {
            actionref(open_tilegroup_ref; open_tilegroup) { }
        }
        area(Navigation)
        {
            action(open_tilegroup)
            {
                Caption = 'Preview';
                ToolTip = 'Display the Tile Group in a separate window';
                Image = "Invoicing-MDL-PreviewDoc";
                // RunObject = page "Easy Tile Preview";
                // RunPageLink = "Preview Mode" = const(true), "Tile Group Code" = field("Tile Group Code");
                trigger OnAction()
                var
                    TempEasyTileBuffer: Record "Easy Tile Buffer" temporary;
                    EasyTilePreview: Page "Easy Tile Preview";
                    EasyTileOpenGroup: Codeunit "Easy Tile Open Group";
                begin
                    EasyTileOpenGroup.SetPreviewMode(Rec."Tile Group Code");
                    EasyTilePreview.Run();
                    //EasyTileOpenGroup.Reset();
                end;
            }
        }
    }
}
