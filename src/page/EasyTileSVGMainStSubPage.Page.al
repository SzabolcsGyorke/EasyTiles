page 80111 "Easy Tile SVG Main St. SubPage"
{
    ApplicationArea = All;
    Caption = 'Easy Tile SVG Main St. SubPage';
    PageType = ListPart;
    SourceTable = "Easy Tile SVG Main Style Line";
    AutoSplitKey = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Attribute Type"; Rec."Attribute Type")
                {
                    ToolTip = 'Specifies the value of the Attribute Type field.';
                }

                field(Id; Rec."Manual Id")
                {
                    ToolTip = 'Specifies the value of the Id field.';
                    Editable = Rec."Attribute Type" = Rec."Attribute Type"::Manual;
                    ShowMandatory = Rec."Attribute Type" = Rec."Attribute Type"::Manual;
                }

                field("Value"; Rec."Value")
                {
                    ToolTip = 'Specifies the value of the Value field.';
                    ShowMandatory = true;
                }
            }
        }
    }
}
