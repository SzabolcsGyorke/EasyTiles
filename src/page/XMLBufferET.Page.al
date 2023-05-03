page 80113 "XML Buffer ET"
{
    ApplicationArea = All;
    Caption = 'XML Buffer ET';
    PageType = List;
    SourceTable = "XML Buffer";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Data Type"; Rec."Data Type")
                {
                    ToolTip = 'Specifies the value of the Data Type field.';
                }
                field(Depth; Rec.Depth)
                {
                    ToolTip = 'Specifies the value of the Depth field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Import ID"; Rec."Import ID")
                {
                    ToolTip = 'Specifies the value of the Import ID field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the imported record.';
                }
                field(Namespace; Rec.Namespace)
                {
                    ToolTip = 'Specifies the value of the Namespace field.';
                }
                field("Node Number"; Rec."Node Number")
                {
                    ToolTip = 'Specifies the value of the Node Number field.';
                }
                field("Parent Entry No."; Rec."Parent Entry No.")
                {
                    ToolTip = 'Specifies the value of the Parent Entry No. field.';
                }
                field(Path; Rec.Path)
                {
                    ToolTip = 'Specifies the value of the Path field.';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Value"; Rec."Value")
                {
                    ToolTip = 'Specifies the value of the imported record.';
                }
                field("Long Value ET"; Rec."Long Value ET")
                {
                    ToolTip = 'Specifies the value of the Long Value field.';
                }
                field("Long Value Used ET"; Rec."Long Value Used ET")
                {
                    ToolTip = 'Specifies the value of the Long Value Used field.';
                }
            }
        }
    }
}
