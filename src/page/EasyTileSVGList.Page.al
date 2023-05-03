page 80109 "Easy Tile SVG List"
{
    ApplicationArea = All;
    Caption = 'Easy Tile SVG List';
    PageType = List;
    SourceTable = "Easy Tile SVG Header";
    UsageCategory = Administration;
    Editable = false;
    CardPageId = "Easy Tile SVG Definition";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
            usercontrol(SVGPreview; SVGPreview)
            {
                ApplicationArea = all;
                Visible = true;

                trigger svgUrlToPngCallback(callback: Text; code: Text)
                var
                    EasyTileSVGHeader: Record "Easy Tile SVG Header";
                    Base64Convert: Codeunit "Base64 Convert";
                    TempBlob: Codeunit "Temp Blob";
                    InStr: InStream;
                    OutStr: OutStream;
                begin
                    //only update the ones without image
                    if EasyTileSVGHeader.Get(code) then begin
                        TempBlob.CreateOutStream(OutStr);
                        Base64Convert.FromBase64(CopyStr(callback, StrPos(callback, ',') + 1, StrLen(callback)), OutStr);
                        TempBlob.CreateInStream(InStr);
                        EasyTileSVGHeader.Image.ImportStream(InStr, Rec.Description, 'image/x-png');
                        EasyTileSVGHeader.Modify();
                        commit;
                    end;

                    // if not WindowOpen then
                    //     Window.Close();
                end;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(act_delete_selected)
            {
                ApplicationArea = All;
                Caption = 'Delete Selected';
                Image = Delete;
                //Enabled = (not CurrPage.LookupMode);
                ToolTip = 'Delete the selected records';
                trigger OnAction()
                var
                    EasyTileSVGHeader: Record "Easy Tile SVG Header";
                    DeletSelectedReqQst: Label 'Do you want to delete the selected recoords?';
                begin
                    if not Confirm(DeletSelectedReqQst, false) then exit;
                    CurrPage.SetSelectionFilter(EasyTileSVGHeader);
                    EasyTileSVGHeader.SetAutoCalcFields("Assigned to Tiles");
                    if EasyTileSVGHeader.FindSet() then
                        repeat
                            if (not EasyTileSVGHeader.Default) and (EasyTileSVGHeader."Assigned to Tiles" = 0) then
                                EasyTileSVGHeader.Delete(true);

                        until EasyTileSVGHeader.Next() < 1;
                end;
            }
            action(act_download)
            {
                ApplicationArea = all;
                Caption = 'Download IONIC pack';
                ToolTip = 'please visit https://ionic.io/ionicons/ for further details';
                Image = Download;
                trigger OnAction()
                var
                    EasyTileSVGManagement: Codeunit "Easy Tile SVG Management";
                    DownloadIconsQst: Label 'The icon pack is provided by https://ionic.io/ under MIT licese.\Do you want to download?';
                begin
                    If Confirm(DownloadIconsQst, false) then
                        EasyTileSVGManagement.GetIonicIcons();
                end;
            }
            action(act_updatepreview)
            {
                ApplicationArea = all;
                Caption = 'Update Preview Images';
                ToolTip = 'Calculate preview for the svg definition';
                Image = PreviewChecks;
                trigger OnAction()
                var
                    EasyTileSVGHeader: Record "Easy Tile SVG Header";
                    EasyTileSVGManagement: Codeunit "Easy Tile SVG Management";
                    SVGDef: Text;
                begin

                    if EasyTileSVGHeader.FindSet() then
                        repeat
                            if not EasyTileSVGHeader.Image.HasValue() then begin
                                SVGDef := EasyTileSVGManagement.CreateSVG(EasyTileSVGHeader, '100', '100');
                                CurrPage.SVGPreview.ShowSvg(SVGDef);
                                CurrPage.SVGPreview.svgDefToPng(SVGDef, EasyTileSVGHeader.Code);
                            end;
                        until EasyTileSVGHeader.Next() < 1;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        EasyTileSVGManagement: Codeunit "Easy Tile SVG Management";
        svgtext: Text;
    begin
        svgtext := EasyTileSVGManagement.CreateSVG(Rec, true);
        CurrPage.SVGPreview.ShowSvg(svgtext);
        CurrPage.SVGPreview.svgDefToPng(svgtext, Rec.Code);
    end;
}
