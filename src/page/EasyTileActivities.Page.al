page 80101 "Easy Tile Activities"
{
    ApplicationArea = All;
    Caption = 'Easy Tile Activities';
    PageType = CardPart;
    SourceTable = "Easy Tile Buffer";
    SourceTableTemporary = true;
    DataCaptionFields = "Tile Group Code";
    layout
    {
        area(content)
        {
            //group 0 horizontal 2x10
            cuegroup(grop01)
            {
                Caption = 'group01';
                Visible = Visible0;
                field(Tile1; Rec."Value 1")
                {
                    CaptionClass = Rec."Caption 1";
                    Visible = Visible1;
                    StyleExpr = Style1;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 1, Style1);
                    end;
                }

                field(Tile2; Rec."Value 2")
                {
                    CaptionClass = Rec."Caption 2";
                    Visible = Visible2;
                    StyleExpr = Style2;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 2, Style2);
                    end;
                }
                field(Tile3; Rec."Value 3")
                {
                    CaptionClass = Rec."Caption 3";
                    Visible = Visible3;
                    StyleExpr = Style3;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 3, Style3);
                    end;
                }
                field(Tile4; Rec."Value 4")
                {
                    CaptionClass = Rec."Caption 4";
                    Visible = Visible4;
                    StyleExpr = Style4;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 4, Style4);
                    end;
                }
                field(Tile5; Rec."Value 5")
                {
                    CaptionClass = Rec."Caption 5";
                    Visible = Visible5;
                    StyleExpr = Style5;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 5, Style5);
                    end;
                }
                field(Tile6; Rec."Value 6")
                {
                    CaptionClass = Rec."Caption 6";
                    Visible = Visible6;
                    StyleExpr = Style6;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 6, Style6);
                    end;
                }
                field(Tile7; Rec."Value 7")
                {
                    CaptionClass = Rec."Caption 7";
                    Visible = Visible7;
                    StyleExpr = Style7;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 7, Style7);
                    end;
                }
                field(Tile8; Rec."Value 8")
                {
                    CaptionClass = Rec."Caption 8";
                    Visible = Visible8;
                    StyleExpr = Style8;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 8, Style8);
                    end;
                }
                field(Tile9; Rec."Value 9")
                {
                    CaptionClass = Rec."Caption 9";
                    Visible = Visible9;
                    StyleExpr = Style9;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 9, Style9);
                    end;
                }
                field(Tile10; Rec."Value 10")
                {
                    CaptionClass = Rec."Caption 10";
                    Visible = Visible10;
                    StyleExpr = Style10;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 10, Style10);
                    end;
                }
            }
            cuegroup(group02)
            {
                Caption = 'group02';
                Visible = Visible0;
                field(Tile11; Rec."Value 11")
                {
                    CaptionClass = Rec."Caption 11";
                    Visible = Visible11;
                    StyleExpr = Style11;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 11, Style11);
                    end;
                }

                field(Tile12; Rec."Value 12")
                {
                    CaptionClass = Rec."Caption 12";
                    Visible = Visible12;
                    StyleExpr = Style12;
                    Editable = false;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 12, Style12);
                    end;
                }
                field(Tile13; Rec."Value 13")
                {
                    CaptionClass = Rec."Caption 13";
                    Visible = Visible13;
                    StyleExpr = Style13;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 13, Style13);
                    end;
                }
                field(Tile14; Rec."Value 14")
                {
                    CaptionClass = Rec."Caption 14";
                    Visible = Visible14;
                    StyleExpr = Style14;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 14, Style14);
                    end;
                }
                field(Tile15; Rec."Value 15")
                {
                    CaptionClass = Rec."Caption 15";
                    Visible = Visible15;
                    StyleExpr = Style15;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 15, Style15);
                    end;
                }
                field(Tile16; Rec."Value 16")
                {
                    CaptionClass = Rec."Caption 16";
                    Visible = Visible16;
                    StyleExpr = Style16;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 16, Style16);
                    end;
                }
                field(Tile17; Rec."Value 17")
                {
                    CaptionClass = Rec."Caption 17";
                    Visible = Visible17;
                    StyleExpr = Style17;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 17, Style17);
                    end;
                }
                field(Tile18; Rec."Value 18")
                {
                    CaptionClass = Rec."Caption 18";
                    Visible = Visible18;
                    StyleExpr = Style18;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 18, Style18);
                    end;
                }
                field(Tile19; Rec."Value 19")
                {
                    CaptionClass = Rec."Caption 19";
                    Visible = Visible19;
                    StyleExpr = Style19;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 19, Style19);
                    end;
                }
                field(Tile20; Rec."Value 20")
                {
                    CaptionClass = Rec."Caption 20";
                    Visible = Visible20;
                    StyleExpr = Style20;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 20, Style20);
                    end;
                }
            }


            cuegroup(group11)
            {
                Caption = 'group11';
                Visible = not Visible0;
                field(Tile1a; REc."Value 1")
                {
                    CaptionClass = Rec."Caption 1";
                    Visible = Visible1;
                    StyleExpr = Style1;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 1, Style1);
                    end;
                }

                field(Tile2a; Rec."Value 2")
                {
                    CaptionClass = Rec."Caption 2";
                    Visible = Visible2;
                    StyleExpr = Style2;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 2, Style2);
                    end;
                }
                field(Tile3a; Rec."Value 3")
                {
                    CaptionClass = Rec."Caption 3";
                    Visible = Visible3;
                    StyleExpr = Style3;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 3, Style3);
                    end;
                }
                field(Tile4a; Rec."Value 4")
                {
                    CaptionClass = Rec."Caption 4";
                    Visible = Visible4;
                    StyleExpr = Style4;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 4, Style4);
                    end;
                }
                field(Tile5a; Rec."Value 5")
                {
                    CaptionClass = Rec."Caption 5";
                    Visible = Visible5;
                    StyleExpr = Style5;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 5, Style5);
                    end;
                }
            }

            cuegroup(group12)
            {
                Caption = 'group12';
                Visible = not Visible0;
                field(Tile6a; Rec."Value 6")
                {
                    CaptionClass = Rec."Caption 6";
                    Visible = Visible6;
                    StyleExpr = Style6;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 6, Style6);
                    end;
                }
                field(Tile7a; Rec."Value 7")
                {
                    CaptionClass = Rec."Caption 7";
                    Visible = Visible7;
                    StyleExpr = Style7;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 7, Style7);
                    end;
                }
                field(Tile8a; Rec."Value 8")
                {
                    CaptionClass = Rec."Caption 8";
                    Visible = Visible8;
                    StyleExpr = Style8;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 8, Style8);
                    end;
                }
                field(Tile9a; Rec."Value 9")
                {
                    CaptionClass = Rec."Caption 9";
                    Visible = Visible9;
                    StyleExpr = Style9;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 9, Style9);
                    end;
                }
                field(Tile10a; Rec."Value 10")
                {
                    CaptionClass = Rec."Caption 10";
                    Visible = Visible10;
                    StyleExpr = Style10;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 10, Style10);
                    end;
                }
            }
            cuegroup(group13)
            {
                Caption = 'group13';
                Visible = not Visible0;
                field(Tile11a; Rec."Value 11")
                {
                    CaptionClass = Rec."Caption 11";
                    Visible = Visible11;
                    StyleExpr = Style11;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 11, Style11);
                    end;
                }

                field(Tile12a; Rec."Value 12")
                {
                    CaptionClass = Rec."Caption 12";
                    Visible = Visible12;
                    StyleExpr = Style12;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 12, Style12);
                    end;
                }
                field(Tile13a; Rec."Value 13")
                {
                    CaptionClass = Rec."Caption 13";
                    Visible = Visible13;
                    StyleExpr = Style13;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 13, Style13);
                    end;
                }
                field(Tile14a; Rec."Value 14")
                {
                    CaptionClass = Rec."Caption 14";
                    Visible = Visible14;
                    StyleExpr = Style14;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 14, Style14);
                    end;
                }
                field(Tile15a; Rec."Value 15")
                {
                    CaptionClass = Rec."Caption 15";
                    Visible = Visible15;
                    StyleExpr = Style15;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 15, Style15);
                    end;
                }
            }
            cuegroup(group14)
            {
                Caption = 'group14';
                Visible = not Visible0;
                field(Tile16a; Rec."Value 16")
                {
                    CaptionClass = Rec."Caption 16";
                    Visible = Visible16;
                    StyleExpr = Style16;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 16, Style16);
                    end;
                }
                field(Tile17a; Rec."Value 17")
                {
                    CaptionClass = Rec."Caption 17";
                    Visible = Visible17;
                    StyleExpr = Style17;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 17, Style17);
                    end;
                }
                field(Tile18a; Rec."Value 18")
                {
                    CaptionClass = Rec."Caption 18";
                    Visible = Visible18;
                    StyleExpr = Style18;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 18, Style18);
                    end;
                }
                field(Tile19a; Rec."Value 19")
                {
                    CaptionClass = Rec."Caption 19";
                    Visible = Visible19;
                    StyleExpr = Style19;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 19, Style19);
                    end;
                }
                field(Tile20a; Rec."Value 20")
                {
                    CaptionClass = Rec."Caption 20";
                    Visible = Visible20;
                    StyleExpr = Style20;
                    DecimalPlaces = 0 : 2;
                    trigger OnDrillDown()
                    begin
                        EasyTileFunctions.OnClick(Rec, 20, Style20);
                    end;
                }
            }
            usercontrol(TileController; "Easy Tile Controller")
            {
                ApplicationArea = all;

                trigger ControlAddinReady()
                begin
                    if Rec."No. of Tiles" = 0 then
                        CurrPage.TileController.FindAndRemoveTileGroup(controlid);

                    if not EditMode then
                        CurrPage.TileController.FindAndSetTileGroup(controlid, GroupCaption, idcontrol);

                    if layout = layout::"2x10" then
                        CurrPage.TileController.SetGroupCaption1(controlid, Rec."Group 1 Caption", Rec."Group 2 Caption")
                    else
                        CurrPage.TileController.SetGroupCaption2(controlid, Rec."Group 1 Caption", Rec."Group 2 Caption", rec."Group 3 Caption", rec."Group 4 Caption");
                    UpdateVariables();
                end;

            }


        }

    }
    actions
    {
        area(Processing)
        {
            action(refresh)
            {
                Caption = 'Refresh';
                Image = Refresh;
                trigger OnAction()
                begin
                    UpdatPage();
                end;
            }
            action(Edit)
            {
                Caption = 'Edit Tile Group';
                Image = Edit;
                Enabled = not EditMode;
                trigger OnAction()
                var
                    EasyTileFunctions: Codeunit "Easy Tile Functions";
                begin
                    EasyTileFunctions.EditGroupDefintion(Rec."Tile Group Code", true);
                    UpdatPage();
                end;
            }
        }
    }

    var
        lbl_tb: Label 'TileBrickProducts';
        EasyTileFunctions: Codeunit "Easy Tile Functions";
        [InDataSet]
        Visible0: Boolean;
        [InDataSet]
        Visible1: Boolean;
        [InDataSet]
        Visible2: Boolean;
        [InDataSet]
        Visible3: Boolean;
        [InDataSet]
        Visible4: Boolean;
        [InDataSet]
        Visible5: Boolean;
        [InDataSet]
        Visible6: Boolean;
        [InDataSet]
        Visible7: Boolean;
        [InDataSet]
        Visible8: Boolean;
        [InDataSet]
        Visible9: Boolean;
        [InDataSet]
        Visible10: Boolean;
        [InDataSet]
        Visible11: Boolean;
        [InDataSet]
        Visible12: Boolean;
        [InDataSet]
        Visible13: Boolean;
        [InDataSet]
        Visible14: Boolean;
        [InDataSet]
        Visible15: Boolean;
        [InDataSet]
        Visible16: Boolean;
        [InDataSet]
        Visible17: Boolean;
        [InDataSet]
        Visible18: Boolean;
        [InDataSet]
        Visible19: Boolean;
        [InDataSet]
        Visible20: Boolean;
        [InDataSet]
        Style1: Text;
        [InDataSet]
        Style2: Text;
        [InDataSet]
        Style3: Text;
        [InDataSet]
        Style4: Text;
        [InDataSet]
        Style5: Text;
        [InDataSet]
        Style6: Text;
        [InDataSet]
        Style7: Text;
        [InDataSet]
        Style8: Text;
        [InDataSet]
        Style9: Text;
        [InDataSet]
        Style10: Text;
        [InDataSet]
        Style11: Text;
        [InDataSet]
        Style12: Text;
        [InDataSet]
        Style13: Text;
        [InDataSet]
        Style14: Text;
        [InDataSet]
        Style15: Text;
        [InDataSet]
        Style16: Text;
        [InDataSet]
        Style17: Text;
        [InDataSet]
        Style18: Text;
        [InDataSet]
        Style19: Text;
        [InDataSet]
        Style20: Text;
        layout: Option "2x10","4x5";
        controlid: Text;
        idcontrol: Text;
        serchControl: Label '[title="Actions for TileGroup%1"]', Locked = true;
        idcontrolTxt: Label 'TileGroup%1', Locked = true;
        idcontrolQueryTxt: Label '[id="TileGroup%1"]', Locked = true;
        GroupCaption: Text;
        PreviewMode: Boolean;
        PreviewTileGroupCode: Code[20];
        ValueTest: integer;
        EasyTileOpenGroup: Codeunit "Easy Tile Open Group";
        EditSearchControl: Label '[controlname="Easy Tile Activities"]', Locked = true;
        [indataset]
        EditMode: Boolean;


    trigger OnOpenPage()
    begin
        if rec."Preview Mode" and (EasyTileOpenGroup.GetPreviewMode() or EasyTileOpenGroup.GetEditMode()) then begin
            PreviewMode := EasyTileOpenGroup.GetPreviewMode();
            EditMode := EasyTileOpenGroup.GetEditMode();
            PreviewTileGroupCode := EasyTileOpenGroup.GetTileGroupCode();
            rec."Edit Mode" := EditMode;
            controlid := StrSubstNo(serchControl, 1);
        end;


        if PreviewMode then
            EasyTileFunctions.SetPreviewTileGroup(PreviewTileGroupCode);

        if EditMode then
            EasyTileFunctions.SetEditTileGroup(PreviewTileGroupCode);


        if EditMode then
            controlid := EditSearchControl
        else
            controlid := StrSubstNo(serchControl, rec."Tile Group Position");

        idcontrol := StrSubstNo(idcontrolTxt, rec."Tile Group Position");

        EasyTileFunctions.GenerateTileBuffer(UserId(), Rec, GroupCaption, layout);
        Visible0 := (layout = layout::"2x10");
    end;


    local procedure SetValue(Value1: Decimal): Integer
    begin
        exit(round(Value1, 1));
    end;

    local procedure UpdatPage()
    var
        xEasyTileBuffer: Record "Easy Tile Buffer";
    begin
        xEasyTileBuffer := Rec;
        Rec.Delete();
        Rec.Init();
        Rec."Tile Group Code" := xEasyTileBuffer."Tile Group Code";
        Rec."Tile Group Position" := xEasyTileBuffer."Tile Group Position";
        Rec."Edit Mode" := xEasyTileBuffer."Edit Mode";
        Rec."Preview Mode" := xEasyTileBuffer."Preview Mode";

        EasyTileFunctions.GenerateTileBuffer(UserId(), Rec, GroupCaption, layout);



        if layout = layout::"2x10" then
            CurrPage.TileController.SetGroupCaption1(controlid, Rec."Group 1 Caption", Rec."Group 2 Caption")
        else
            CurrPage.TileController.SetGroupCaption2(controlid, Rec."Group 1 Caption", Rec."Group 2 Caption", rec."Group 3 Caption", rec."Group 4 Caption");
        UpdateVariables();
        CurrPage.Update(true);
    end;

    local procedure UpdateVariables()
    var
        recref: RecordRef;
        fldref: FieldRef;
        tilebackgroundcolour: Text;
        tilefontcolour: Text;
        hidecounter: Boolean;
        tiledisplayid: Integer;
        i: Integer;
        tilegroup: Integer;
        controlid2: Text;
        iconsvg: Text;
    begin
        Visible1 := Rec."Visible 1";
        Visible2 := Rec."Visible 2";
        Visible3 := Rec."Visible 3";
        Visible4 := Rec."Visible 4";
        Visible5 := Rec."Visible 5";
        Visible6 := Rec."Visible 6";
        Visible7 := Rec."Visible 7";
        Visible8 := Rec."Visible 8";
        Visible9 := Rec."Visible 9";
        Visible10 := Rec."Visible 10";
        Visible11 := Rec."Visible 11";
        Visible12 := Rec."Visible 12";
        Visible13 := Rec."Visible 13";
        Visible14 := Rec."Visible 14";
        Visible15 := Rec."Visible 15";
        Visible16 := Rec."Visible 16";
        Visible17 := Rec."Visible 17";
        Visible18 := Rec."Visible 18";
        Visible19 := Rec."Visible 19";
        Visible20 := Rec."Visible 20";
        Style1 := Rec."Style 1";
        Style2 := Rec."Style 2";
        Style3 := Rec."Style 3";
        Style4 := Rec."Style 4";
        Style5 := Rec."Style 5";
        Style6 := Rec."Style 6";
        Style7 := Rec."Style 7";
        Style8 := Rec."Style 8";
        Style9 := Rec."Style 9";
        Style10 := Rec."Style 10";
        Style11 := Rec."Style 11";
        Style12 := Rec."Style 12";
        Style13 := Rec."Style 13";
        Style14 := Rec."Style 14";
        Style15 := Rec."Style 15";
        Style16 := Rec."Style 16";
        Style17 := Rec."Style 17";
        Style18 := Rec."Style 18";
        Style19 := Rec."Style 19";
        Style20 := Rec."Style 20";

        if not EditMode then
            controlid2 := StrSubstNo(idcontrolQueryTxt, rec."Tile Group Position");

        recref.GetTable(Rec);
        for i := 1 to 20 do begin
            fldref := recref.Field(i + 49);

            if layout = layout::"2x10" then begin
                if i < 11 then begin
                    //check how many tiles we have on display - every group needs to restart the numbering
                    if fldref.Value then
                        tiledisplayid += 1;
                    tilegroup := 1;
                end else begin
                    if i = 11 then tiledisplayid := 0;
                    if fldref.Value then
                        tiledisplayid += 1;

                    tilegroup := 2;
                end;
                if EasyTileFunctions.GetTileStyle(Rec, i, tilebackgroundcolour, tilefontcolour, hidecounter, iconsvg) then
                    CurrPage.TileController.EditTile(controlid2, tilegroup, tiledisplayid, hidecounter, '', '', tilebackgroundcolour, tilefontcolour, iconsvg);
            end;

            if layout = layout::"4x5" then begin
                if i < 6 then begin
                    if fldref.Value then
                        tiledisplayid += 1;
                    tilegroup := 1;
                end;

                if (i > 5) and (i < 11) then begin
                    if i = 6 then tiledisplayid := 0;
                    if fldref.Value then
                        tiledisplayid += 1;
                    tilegroup := 2;
                end;

                if (i > 10) and (i < 16) then begin
                    if i = 11 then tiledisplayid := 0;
                    if fldref.Value then
                        tiledisplayid += 1;
                    tilegroup := 3;
                end;

                if (i > 15) then begin
                    if i = 16 then tiledisplayid := 0;
                    if fldref.Value then
                        tiledisplayid += 1;
                    tilegroup := 4;
                end;
                if EasyTileFunctions.GetTileStyle(Rec, i, tilebackgroundcolour, tilefontcolour, hidecounter, iconsvg) then
                    CurrPage.TileController.EditTile(controlid2, tilegroup, tiledisplayid, hidecounter, '', '', tilebackgroundcolour, tilefontcolour, iconsvg);
            end;


        end;
    end;


}
