page 80110 "Easy Tile SVG Definition"
{
    ApplicationArea = All;
    Caption = 'Easy Tile SVG Definition';
    PageType = Document;
    SourceTable = "Easy Tile SVG Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Default; Rec.Default)
                {
                    ToolTip = 'Specifies the value of the Default field.';
                }

                field(Height; Rec.Height)
                {
                    ToolTip = 'Specifies the value of the Height field.';
                }

                field(Width; Rec.Width)
                {
                    ToolTip = 'Specifies the value of the Width field.';
                }
                field(Definition; Rec.Definition)
                {
                    ToolTip = 'Specifies the value of the Definition field.';
                }
                usercontrol(SVGPreview; SVGPreview)
                {
                    ApplicationArea = all;
                    trigger ControlReady()
                    begin
                        UpdateSVG();
                    end;

                    trigger svgUrlToPngCallback(callback: Text; code: Text)
                    var
                        Base64Convert: Codeunit "Base64 Convert";
                        TempBlob: Codeunit "Temp Blob";
                        InStr: InStream;
                        OutStr: OutStream;
                    begin
                        //TODO: do we need to save the preview for the image blob?
                        TempBlob.CreateOutStream(OutStr);
                        Base64Convert.FromBase64(CopyStr(callback, StrPos(callback, ',') + 1, StrLen(callback)), OutStr);
                        TempBlob.CreateInStream(InStr);
                        Rec.Image.ImportStream(InStr, Rec.Description, 'image/x-png');

                    end;
                }
            }
            part("Main Style"; "Easy Tile SVG Main St. SubPage")
            {
                ApplicationArea = All;
                Caption = 'Main Style Lines';
                SubPageLink = "SVG Header Code" = field(Code);
            }
            part(Lines; "Easy Tile SVG SubPage")
            {
                ApplicationArea = all;
                Caption = 'Lines';
                SubPageLink = "SVG Header Code" = field(Code);
            }
            group(import)
            {
                Caption = 'Import';

                field(svgintext; Rec."Import SVG")
                {
                    ApplicationArea = all;
                    ShowCaption = false;
                    MultiLine = true;

                }
                field(importfld; 'Import...')
                {
                    ApplicationArea = all;
                    ShowCaption = false;
                    Lookup = false;
                    DrillDown = true;
                    AssistEdit = false;
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        EasyTileSVGManagement.ReadSVG(Rec);
                    end;
                }

            }
        }
    }
    actions
    {
        area(Promoted)
        {
            actionref(act_createsvg_promoted; act_createsvg) { }
            actionref(act_applymainstyl_prometd; act_applymainstyl) { }
        }
        area(Processing)
        {
            action(act_createsvg)
            {
                ApplicationArea = all;
                Caption = 'Create SVG';
                Image = CreateDocument;
                trigger OnAction()
                begin
                    SVGUpdated := false;
                    UpdateSVG();
                end;
            }
            action(act_applymainstyl)
            {
                ApplicationArea = all;
                Caption = 'Apply main style';
                ToolTip = 'Applies the main style changes to the un-protected lines';
                Image = Apply;
                trigger OnAction()
                var
                    EasyTileSVGManagement: Codeunit "Easy Tile SVG Management";
                begin
                    EasyTileSVGManagement.ApplyMainStyle(Rec);
                end;
            }
        }
    }

    var
        EasyTileSVGManagement: Codeunit "Easy Tile SVG Management";
        SVGUpdated: Boolean;

    trigger OnAfterGetRecord()
    begin
        SVGUpdated := false;
        UpdateSVG();
    end;

    local procedure UpdateSVG()
    var
        Base64Convert: Codeunit "Base64 Convert";
        svgtext: Text;
    begin
        if SVGUpdated then exit;
        svgtext := EasyTileSVGManagement.CreateSVG(Rec, true);
        CurrPage.SVGPreview.ShowSvg(svgtext);
        CurrPage.SVGPreview.svgDefToPng(svgtext, Rec.Code);
        SVGUpdated := true;
    end;



}
