page 80114 "JSON Buffer ET"
{
    ApplicationArea = All;
    Caption = 'JSON Buffer ET';
    PageType = List;
    SourceTable = "JSON Buffer";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field(Depth; Rec.Depth)
                {
                    ToolTip = 'Specifies the value of the Depth field.';
                }
                field(Path; Rec.Path)
                {
                    ToolTip = 'Specifies the value of the Path field.';
                }
                field("Token type"; Rec."Token type")
                {
                    ToolTip = 'Specifies the value of the Token type field.';
                }
                field("Value Type"; Rec."Value Type")
                {
                    ToolTip = 'Specifies the value of the Value Type field.';
                }
                field("Value"; Rec."Value")
                {
                    ToolTip = 'Specifies the value of the Value field.';
                }
            }
        }
    }
}
