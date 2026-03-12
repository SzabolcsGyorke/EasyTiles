page 80113 "Easy Tile Grp. Line St. PP S8L"
{
    ApplicationArea = All;
    Caption = 'Style Configuration';
    PageType = ListPart;
    SourceTable = "Easy Tile Group Line Style S8L";
    PopulateAllFields = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Value"; Rec."Value")
                {
                    ToolTip = 'Specifies the value of the Value field.', Comment = '%';
                }
                field("Tile Background Colour"; Rec."Tile Background Colour")
                {
                    ToolTip = 'Specifies the value of the Tile Background Colour field.', Comment = '%';
                    trigger OnAssistEdit()
                    var
                        EasyTilecolourPicker: Page "Easy Tile colour Picker";
                    begin
                        CurrPage.SaveRecord();
                        EasyTilecolourPicker.InitColour(Rec."Tile Background Colour");
                        Commit();
                        EasyTilecolourPicker.RunModal();
                        if EasyTilecolourPicker.IsColourChanged() then begin
                            Rec."Tile Background Colour" := EasyTilecolourPicker.GetColour();
                            if not Rec.Modify() then
                                Rec.Insert();
                        end;
                    end;
                }
                field("Tile Font Colour"; Rec."Tile Font Colour")
                {
                    ToolTip = 'Specifies the value of the Tile Font Colour field.', Comment = '%';
                    trigger OnAssistEdit()
                    var
                        EasyTilecolourPicker: Page "Easy Tile colour Picker";
                    begin
                        CurrPage.SaveRecord();
                        EasyTilecolourPicker.InitColour(Rec."Tile Font Colour");
                        Commit();
                        EasyTilecolourPicker.RunModal();
                        if EasyTilecolourPicker.IsColourChanged() then begin
                            Rec."Tile Font Colour" := EasyTilecolourPicker.GetColour();
                            if not Rec.Modify() then
                                Rec.Insert();
                        end;
                    end;
                }
                field("Tile Style"; Rec."Tile Style")
                {
                    ToolTip = 'Specifies the value of the Tile Style field.', Comment = '%';
                }
                field("Icon SVG Code"; Rec."Icon SVG Code")
                {
                    ToolTip = 'Specifies the value of the Icon SVG Code field.', Comment = '%';
                    trigger OnValidate()
                    begin
                        if xRec."Icon SVG Code" <> Rec."Icon SVG Code" then
                            CurrPage.SVGPreview.ShowSvg(EasyTileSVGManagement.CreateSVG(Rec."Icon SVG Code", true));
                    end;
                }
            }
            usercontrol(SVGPreview; SVGPreview)
            {
                ApplicationArea = all;
                trigger ControlReady()
                begin
                    SVGAddinReady := true;
                    CurrPage.SVGPreview.ShowSvg(EasyTileSVGManagement.CreateSVG(Rec."Icon SVG Code", true));
                end;
            }
        }
    }
    var
        EasyTileSVGManagement: Codeunit "Easy Tile SVG Management";
        SVGAddinReady: Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        if SVGAddinReady then
            CurrPage.SVGPreview.ShowSvg(EasyTileSVGManagement.CreateSVG(Rec."Icon SVG Code", true));
    end;
}
