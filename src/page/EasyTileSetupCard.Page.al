page 80105 "Easy Tile Setup Card"
{
    ApplicationArea = All;
    Caption = 'Easy Tile Setup Card';
    DataCaptionFields = Caption;
    PageType = Card;
    SourceTable = "Easy Tile Group Line";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(Caption; Rec.Caption)
                {
                    ToolTip = 'Specifies the value of the Caption field.';
                }
                field(Visible; Rec.Visible)
                {
                    ToolTip = 'Specifies the value of the Visible field.';
                }
                group(Value)
                {
                    Caption = 'Value';
                    field("Hide Counter"; Rec."Hide Counter")
                    {
                        ToolTip = 'Specifies the value of the Hide Counter field.';
                    }

                    field("Table No."; Rec."Table No.")
                    {
                        ToolTip = 'Specifies the value of the Table No. field.';

                    }
                    field("Table Name"; Rec."Table Name")
                    {
                        ToolTip = 'Specifies the value of the Table Name field.';
                    }
                    field(TableFilterValue; TableFilter)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Table Filter';
                        ToolTip = 'Specifies the synchronization inclusion filter on the Business Central table.';
                        Editable = false;

                        trigger OnAssistEdit()
                        var
                            FilterPageBuilder: FilterPageBuilder;
                        begin
                            Rec.Calcfields("Table Name");
                            FilterPageBuilder.AddTable(Rec."Table Name", Rec."Table No.");
                            TableFilter := Rec.GetTableFilter();
                            if TableFilter <> '' then
                                FilterPageBuilder.SetView(Rec."Table Name", TableFilter);
                            if FilterPageBuilder.RunModal() then begin
                                TableFilter := FilterPageBuilder.GetView(Rec."Table Name", false);
                                Rec.SetTableFilter(TableFilter);
                            end;
                        end;
                    }
                    field(Operation; Rec.Operation)
                    {
                        ToolTip = 'Specifies the value of the Operation field.';
                    }
                    field("Field No."; Rec."Field No.")
                    {
                        Visible = (Rec.Operation <> rec.Operation::Count);
                        ToolTip = 'Specifies the value of the Field No. field.';
                        LookupPageId = "Fields Lookup";
                    }

                }

                group(DrillDown)
                {
                    Caption = 'DrillDown';

                    field("Object Type"; Rec."Object Type")
                    {
                        ToolTip = 'Specifies the value of the Object Type field.';
                    }
                    field("Object Id"; Rec."Object Id")
                    {
                        ToolTip = 'Specifies the value of the Object Id field.';
                    }
                    field("Object Caption"; Rec."Object Caption")
                    {
                        ToolTip = 'Specifies the value of the Object Caption field.';
                    }
                }

            }
            group(Style)
            {
                Caption = 'Style';
                field("Icon SVG Code"; Rec."Icon SVG Code")
                {
                    ToolTip = 'Specifies the value of the Icon SVG Code field.';
                    trigger OnValidate()
                    begin
                        if xRec."Icon SVG Code" <> Rec."Icon SVG Code" then
                            CurrPage.SVGPreview.ShowSvg(EasyTileSVGManagement.CreateSVG(Rec."Icon SVG Code", true));
                    end;
                }

                usercontrol(SVGPreview; SVGPreview)
                {
                    ApplicationArea = all;
                    trigger ControlReady()
                    begin
                        CurrPage.SVGPreview.ShowSvg(EasyTileSVGManagement.CreateSVG(Rec."Icon SVG Code", true));
                    end;
                }
                field("Tile Background Colour"; Rec."Tile Background Colour")
                {
                    ToolTip = 'Specifies the value of the Tile Background Colour field.';
                    trigger OnAssistEdit()
                    var
                        EasyTilecolourPicker: Page "Easy Tile colour Picker";
                    begin
                        CurrPage.SaveRecord();
                        EasyTilecolourPicker.InitColour(Rec."Tile Background Colour");
                        EasyTilecolourPicker.RunModal();
                        if EasyTilecolourPicker.IsColourChanged() then begin
                            Rec."Tile Background Colour" := EasyTilecolourPicker.GetColour();
                            Rec.Modify();
                        end;
                    end;
                }


                field("Tile Font Colour"; Rec."Tile Font Colour")
                {
                    ToolTip = 'Specifies the value of the Tile Font Colour field.';
                    Visible = false;  //TODO: make this work 
                    trigger OnAssistEdit()
                    var
                        EasyTilecolourPicker: Page "Easy Tile colour Picker";
                    begin
                        CurrPage.SaveRecord();
                        EasyTilecolourPicker.InitColour(Rec."Tile Background Colour");
                        EasyTilecolourPicker.RunModal();
                        if EasyTilecolourPicker.IsColourChanged() then begin
                            Rec."Tile Font Colour" := EasyTilecolourPicker.GetColour();
                            Rec.Modify();
                        end;
                    end;
                }

                field("Low Range Style"; Rec."Low Range Style")
                {
                    StyleExpr = LowRangeStyleExpr;
                    ToolTip = 'Specifies the color of the indicator when the value of data in the Cue is less than the value that is specified by the Threshold 1 field.';

                    trigger OnValidate()
                    begin
                        LowRangeStyleExpr := EasyTileFunctions.ConvertStyleToStyleText(Rec."Low Range Style");
                    end;
                }

                field("Threshold 1"; Rec."Threshold 1")
                {
                    ToolTip = 'Specifies the value of the Threshold 1 field.';
                }
                field("Middle Range Style"; Rec."Middle Range Style")
                {
                    StyleExpr = MiddleRangeStyleExpr;
                    ToolTip = 'Specifies the color of the indicator when the value of data in the Cue is greater than or equal to the value that is specified by the Threshold 1 field but less than or equal to the value that is specified by the Threshold 2 field.';

                    trigger OnValidate()
                    begin
                        MiddleRangeStyleExpr := EasyTileFunctions.ConvertStyleToStyleText(Rec."Middle Range Style");
                    end;
                }
                field("Threshold 2"; Rec."Threshold 2")
                {
                    ToolTip = 'Specifies the value of the Threshold 2 field.';
                }
                field("High Range Style"; Rec."High Range Style")
                {
                    StyleExpr = HighRangeStyleExpr;
                    ToolTip = 'Specifies the color of the indicator when the value in the Cue is greater than the value of the Threshold 2 field.';

                    trigger OnValidate()
                    begin
                        HighRangeStyleExpr := EasyTileFunctions.ConvertStyleToStyleText(Rec."High Range Style");

                    end;
                }
            }
        }
    }
    var
        EasyTileFunctions: Codeunit "Easy Tile Functions";
        EasyTileSVGManagement: Codeunit "Easy Tile SVG Management";
        LowRangeStyleExpr: Text;
        MiddleRangeStyleExpr: Text;
        HighRangeStyleExpr: Text;
        TableFilter: Text;
        SetFilterTxt: Label 'Set Filter';

    trigger OnAfterGetRecord()
    begin
        LowRangeStyleExpr := EasyTileFunctions.ConvertStyleToStyleText(Rec."Low Range Style");
        MiddleRangeStyleExpr := EasyTileFunctions.ConvertStyleToStyleText(Rec."Middle Range Style");
        HighRangeStyleExpr := EasyTileFunctions.ConvertStyleToStyleText(Rec."High Range Style");

        TableFilter := Rec.GetTableFilter();
        if TableFilter = '' then
            TableFilter := SetFilterTxt;
    end;


}
