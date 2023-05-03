page 80115 "Easy Tile SVG Tag Selector"
{
    ApplicationArea = All;
    Caption = 'SVG Tag Selector';
    PageType = List;
    SourceTable = "Easy Tile SVG Tag";
    UsageCategory = None;
    Editable = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Selected; Rec.Selected)
                {
                    ToolTip = 'Specifies the value of the Selected field.';
                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        CurrPage.Editable(true);
    end;
}
