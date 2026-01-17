page 80116 "Easy Tile Select Key"
{
    ApplicationArea = All;
    Caption = 'Select Key';
    SourceTableView = where(Enabled = const(true));
    PageType = List;
    SourceTable = "Key";
    UsageCategory = None;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Key"; Rec."Key")
                {
                    ToolTip = 'Specifies the value of the Key field.', Comment = '%';
                }
                field(TableNo; Rec.TableNo)
                {
                    ToolTip = 'Specifies the value of the TableNo field.', Comment = '%';
                }
            }
        }
    }
}
