page 80112 "Easy Tile SVG SubPage"
{
    ApplicationArea = All;
    Caption = 'Easy Tile SVG SubPage';
    PageType = ListPart;
    SourceTable = "Easy Tile SVG Line";
    AutoSplitKey = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Shape Type"; Rec."Shape Type")
                {
                    ToolTip = 'Specifies the value of the Shape Type field.';
                }
                field(Parameters; Rec.Parameters)
                {
                    ToolTip = 'Specifies the value of the Parameters field.';
                }

                field(fill; Rec.fill)
                {
                    ToolTip = 'Specifies the value of the fill field.';
                }
                field(stroke; Rec.stroke)
                {
                    ToolTip = 'Specifies the value of the stroke field.';
                }
                field("stroke-linecap"; Rec."stroke-linecap")
                {
                    ToolTip = 'Specifies the value of the stroke-linecap field.';
                }
                field("stroke-miterlimit"; Rec."stroke-miterlimit")
                {
                    ToolTip = 'Specifies the value of the stroke-miterlimit field.';
                }
                field("stroke-width"; Rec."stroke-width")
                {
                    ToolTip = 'Specifies the value of the stroke-width field.';
                }

                field(Style; Rec.Style)
                {
                    ToolTip = 'Specifies the value of the Style field.';
                }

                field("Protected Style"; Rec."Protected Style")
                {
                    ToolTip = 'Specifies the value of the Protected Style field.';
                }
                field("Manual Line"; Rec."Manual Line")
                {
                    ToolTip = 'Specifies the value of the Manual Line field.';
                }
                field(Class; Rec.Class)
                {
                    ToolTip = 'Specifies the value of the Class field.';
                }
            }
        }
    }
}
