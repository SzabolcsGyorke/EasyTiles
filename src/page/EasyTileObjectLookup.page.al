page 80106 "Easy Tile Object Lookup"
{
    ApplicationArea = All;
    Caption = 'Easy Tile Object Lookup';
    PageType = List;
    SourceTable = AllObjWithCaption;
    UsageCategory = None;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the object type.';
                }
                field("Object ID"; Rec."Object ID")
                {
                    ToolTip = 'Specifies the object ID.';
                }
                field("Object Caption"; Rec."Object Caption")
                {
                    ToolTip = 'Specifies the caption of the object.';
                }
            }
        }
    }
}
