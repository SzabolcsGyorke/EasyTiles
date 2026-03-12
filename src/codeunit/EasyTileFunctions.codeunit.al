codeunit 80100 "Easy Tile Functions"
{
    var
        EditMode: Boolean;
        PreviewMode: Boolean;
        PreviewTileGroupCode: Code[20];
        EmptyCaptionTxt: Label '<empty>';

    internal procedure SetPreviewTileGroup(NewPreviewTileGroupCode: Code[20])
    begin
        PreviewMode := true;
        PreviewTileGroupCode := NewPreviewTileGroupCode;
    end;

    internal procedure SetEditTileGroup(NewPreviewTileGroupCode: Code[20])
    begin
        PreviewMode := false;
        EditMode := true;
        PreviewTileGroupCode := NewPreviewTileGroupCode;
    end;

    internal procedure GenerateTileBuffer(UserId: Code[80]; var TempEasyTileBuffer: Record "Easy Tile Buffer"; var Caption: Text; var Layout: Option)
    var
        UserSettings: SessionSettings;
        EasyTileGroup: Record "Easy Tile Group";
        EasyTileGroupAssignment: Record "Easy Tile Group Assignment";
        EasyTileGroupLine: Record "Easy Tile Group Line";
        TileGroupId: Integer;
        EditMode: Boolean;
        IsHandled: Boolean;
        i: Integer;
        EmptyGuid: Guid;
        RefPosition: Integer;
        RefStyle: Text;
        RefValue: Decimal;
        GroupTileCount: array[4] of Integer;
        tilebackgroundcolour: Text;
        tilefontcolour: Text;
        PeekText: Text[50];
    begin
        TileGroupId := TempEasyTileBuffer."Tile Group Position";
        EditMode := TempEasyTileBuffer."Edit Mode";

        OnBeforeGenerateTileBuffer(UserId, TileGroupId, EditMode, TempEasyTileBuffer, Caption, IsHandled);
        if IsHandled then
            exit;

        UserSettings.Init();

        if (not PreviewMode) and (not EditMode) then begin
            //get the tilegroup assignment from most specified to leaset
            if not EasyTileGroupAssignment.Get(UserSettings.ProfileId(), UserSecurityId()) then
                if not EasyTileGroupAssignment.Get(UserSettings.ProfileId(), EmptyGuid) then
                    if not EasyTileGroupAssignment.Get('', EmptyGuid) then exit;

            case TileGroupId of
                0:
                    begin
                        EasyTileGroupLine.SetRange("Tile Group Code", EasyTileGroupAssignment."Main Group");
                        if EasyTileGroupAssignment."Main Group" = '' then exit;
                        EasyTileGroup.Get(EasyTileGroupAssignment."Main Group");
                    end;
                1:
                    begin
                        EasyTileGroupLine.SetRange("Tile Group Code", EasyTileGroupAssignment."Group 1");
                        if EasyTileGroupAssignment."Group 1" = '' then exit;
                        EasyTileGroup.Get(EasyTileGroupAssignment."Group 1");
                    end;
                2:
                    begin
                        EasyTileGroupLine.SetRange("Tile Group Code", EasyTileGroupAssignment."Group 2");
                        if EasyTileGroupAssignment."Group 2" = '' then exit;
                        EasyTileGroup.Get(EasyTileGroupAssignment."Group 2");
                    end;
                3:
                    begin
                        EasyTileGroupLine.SetRange("Tile Group Code", EasyTileGroupAssignment."Group 3");
                        if EasyTileGroupAssignment."Group 3" = '' then exit;
                        easyTileGroup.Get(EasyTileGroupAssignment."Group 3");
                    end;
                4:
                    begin
                        EasyTileGroupLine.SetRange("Tile Group Code", EasyTileGroupAssignment."Group 4");
                        if EasyTileGroupAssignment."Group 4" = '' then exit;
                        EasyTileGroup.Get(EasyTileGroupAssignment."Group 4");
                    end;
                5:
                    begin
                        EasyTileGroupLine.SetRange("Tile Group Code", EasyTileGroupAssignment."Group 5");
                        if EasyTileGroupAssignment."Group 5" = '' then exit;
                        EasyTileGroup.Get(EasyTileGroupAssignment."Group 5");
                    end;
                6:
                    begin
                        EasyTileGroupLine.SetRange("Tile Group Code", EasyTileGroupAssignment."Group 6");
                        if EasyTileGroupAssignment."Group 6" = '' then exit;
                        EasyTileGroup.Get(EasyTileGroupAssignment."Group 6");
                    end;
                7:
                    begin
                        EasyTileGroupLine.SetRange("Tile Group Code", EasyTileGroupAssignment."Group 7");
                        if EasyTileGroupAssignment."Group 7" = '' then exit;
                        EasyTileGroup.Get(EasyTileGroupAssignment."Group 7");
                    end;
                8:
                    begin
                        EasyTileGroupLine.SetRange("Tile Group Code", EasyTileGroupAssignment."Group 8");
                        if EasyTileGroupAssignment."Group 8" = '' then exit;
                        EasyTileGroup.Get(EasyTileGroupAssignment."Group 8");
                    end;
                9:
                    begin
                        EasyTileGroupLine.SetRange("Tile Group Code", EasyTileGroupAssignment."Group 9");
                        if EasyTileGroupAssignment."Group 9" = '' then exit;
                        EasyTileGroup.Get(EasyTileGroupAssignment."Group 9");
                    end;
            end;
        end else begin
            EasyTileGroup.Get(PreviewTileGroupCode);
            EasyTileGroupLine.SetRange("Tile Group Code", PreviewTileGroupCode);
        end;

        if not EditMode then
            EasyTileGroupLine.SetRange(Visible, true);

        if EasyTileGroupLine.IsEmpty then exit;

        TempEasyTileBuffer."No. of Tiles" := EasyTileGroupLine.Count();
        TempEasyTileBuffer."Tile Group Code" := EasyTileGroup.Code;

        if EasyTileGroupLine.FindSet() then
            repeat
                RefPosition := EasyTileGroupLine."Tile Position";
                RefValue := 0;
                RefStyle := '';
                tilebackgroundcolour := '';
                tilefontcolour := '';

                if EasyTileGroupLine.Visible and (not EditMode) then
                    CalcTileValues(TempEasyTileBuffer, RefPosition, RefStyle, RefValue, PeekText);

                if EditMode and EasyTileGroupLine.Visible then begin
                    RefStyle := 'Favorable';
                    RefValue := 1;
                end;

                if EditMode and (TempEasyTileBuffer."Tile To Move" = RefPosition) then begin
                    RefStyle := 'Unfavorable';
                    RefValue := 999;
                end;

                if EditMode and (not EasyTileGroupLine.Visible) then begin
                    RefStyle := 'Ambiguous';
                    EasyTileGroupLine.Visible := true;
                    EasyTileGroupLine.Caption := EmptyCaptionTxt;
                end;

                SetTileBufferValues(TempEasyTileBuffer, RefPosition, EasyTileGroupLine.Caption, EasyTileGroupLine.Visible, RefStyle, RefValue, PeekText);

                if EasyTileGroup.Layout = EasyTileGroup.Layout::"2x10" then begin
                    if EasyTileGroupLine."Tile Position" <= 10 then
                        GroupTileCount[1] += 1
                    else
                        GroupTileCount[2] += 1;
                end else begin //4x5
                    if EasyTileGroupLine."Tile Position" <= 5 then
                        GroupTileCount[1] += 1;
                    if (EasyTileGroupLine."Tile Position" > 5) and (EasyTileGroupLine."Tile Position" <= 10) then
                        GroupTileCount[2] += 1;
                    if (EasyTileGroupLine."Tile Position" > 10) and (EasyTileGroupLine."Tile Position" < 15) then
                        GroupTileCount[3] += 1;
                    if (EasyTileGroupLine."Tile Position" > 15) then
                        GroupTileCount[4] += 1;
                end;

            until EasyTileGroupLine.Next() < 1;

        //set the group captions to one space to avoid layout issues
        TempEasyTileBuffer."Group 1 Caption" := ' ';
        TempEasyTileBuffer."Group 2 Caption" := ' ';
        TempEasyTileBuffer."Group 3 Caption" := ' ';
        TempEasyTileBuffer."Group 4 Caption" := ' ';

        if GroupTileCount[1] > 0 then
            TempEasyTileBuffer."Group 1 Caption" := EasyTileGroup."Group 1 Caption";
        if GroupTileCount[2] > 0 then
            TempEasyTileBuffer."Group 2 Caption" := EasyTileGroup."Group 2 Caption";
        if GroupTileCount[3] > 0 then
            TempEasyTileBuffer."Group 3 Caption" := EasyTileGroup."Group 3 Caption";
        if GroupTileCount[4] > 0 then
            TempEasyTileBuffer."Group 4 Caption" := EasyTileGroup."Group 4 Caption";


        TempEasyTileBuffer.Insert();
        Caption := EasyTileGroup.Caption;
        Layout := EasyTileGroup.Layout;


        OnAfterGenerateTileBuffer(UserId, TileGroupId, EditMode, TempEasyTileBuffer, Caption);
    end;

    local procedure CalcTileValues(var TempEasyTileBuffer: Record "Easy Tile Buffer"; TilePosition: Integer; var RefStyle: Text; var RefValue: Decimal; var PeekText: text[50])
    var
        EasyTileGroupLine: Record "Easy Tile Group Line";
        InValue: Decimal;
        isHandled: Boolean;
        tilebackgroundcolour: Text;
        tilefontcolour: Text;
        hidecounter: Boolean;
        iconsvg: Text;

        Size: Enum "Easy Tile Size S8L";
        outcaption: Text;
    begin
        OnBeforeCalcTileValues(TempEasyTileBuffer, TilePosition, RefStyle, RefValue, isHandled);
        if isHandled then
            exit;

        if GetTileDefinition(TempEasyTileBuffer, TilePosition, EasyTileGroupLine, InValue, PeekText) then
            if not CalcTileValue(EasyTileGroupLine, RefValue) then begin
                PeekText := '!Ref';
                exit; //add some error handling!
            end;

        isHandled := false;
        OnBeforeFindTileStyle(EasyTileGroupLine, RefValue, RefStyle, isHandled);
        if isHandled then
            exit;

        GetTileStyle(TempEasyTileBuffer, TilePosition, tilebackgroundcolour, tilefontcolour, hidecounter, iconsvg, Size, outcaption, RefStyle, PeekText);

        //Style evaluation
        // if RefValue < EasyTileGroupLine."Threshold 1" then
        //     RefStyle := ConvertStyleToStyleText(EasyTileGroupLine."Low Range Style");

        // if (RefValue >= EasyTileGroupLine."Threshold 1") and (RefValue <= EasyTileGroupLine."Threshold 2") then
        //     RefStyle := ConvertStyleToStyleText(EasyTileGroupLine."Middle Range Style");

        // if RefValue > EasyTileGroupLine."Threshold 2" then
        //     RefStyle := ConvertStyleToStyleText(EasyTileGroupLine."High Range Style");
    end;



    [TryFunction]
    internal procedure CalcTileValue(EasyTileGroupLine: Record "Easy Tile Group Line"; var RefValue: Decimal)
    var
        EasyTilesFilterMgtSG: Codeunit "Easy Tiles Filter Mgt.SG";
        TempDecimal: Decimal;
        recref: RecordRef;
        fldref: FieldRef;
    begin
        if (EasyTileGroupLine."Table No." <> 0) then begin
            recref.Open(EasyTileGroupLine."Table No.");
            if recref.ReadPermission() then begin
                if EasyTileGroupLine."Selected Key Index" <> 0 then
                    recref.CurrentKeyIndex(EasyTileGroupLine."Selected Key Index");

                //if EasyTileGroupLine.GetTableFilter() <> '' then
                //recref.SetView(EasyTileGroupLine.GetTableFilter());
                if not IsNullGuid(EasyTileGroupLine."Filter Guid") then
                    EasyTilesFilterMgtSG.ApplyFilter(recref, EasyTileGroupLine."Filter Guid");

                recref.Ascending(not EasyTileGroupLine."Descending Order");

                if not EasyTileGroupLine."Hide Counter" then
                    case EasyTileGroupLine.Operation of
                        EasyTileGroupLine.Operation::Count:
                            RefValue := recref.Count();
                        EasyTileGroupLine.Operation::Sum:
                            if EasyTileGroupLine."Field No." <> 0 then begin
                                fldref := recref.Field(EasyTileGroupLine."Field No.");
                                if fldref.CalcSum() then
                                    RefValue := fldref.Value;
                            end;
                        EasyTileGroupLine.Operation::Average:
                            if EasyTileGroupLine."Field No." <> 0 then begin
                                fldref := recref.Field(EasyTileGroupLine."Field No.");
                                if fldref.CalcSum() and (recref.Count <> 0) then begin
                                    TempDecimal := fldref.Value;
                                    RefValue := Round((TempDecimal / recref.Count), 0.01);
                                end;
                            end;
                    end;
            end;
        end;
    end;

    internal procedure OnClick(var TempEasyTileBuffer: Record "Easy Tile Buffer"; TilePosition: Integer; var style: Text)
    var
        EasyTileGroupLine: Record "Easy Tile Group Line";
        xEasyTileGroupLine: Record "Easy Tile Group Line";
        xMoveEasyTileGroupLine: Record "Easy Tile Group Line";
        EasyTilesFilterMgtSG: Codeunit "Easy Tiles Filter Mgt.SG";
        recref: RecordRef;
        fldref: FieldRef;
        recrefopen: Boolean;
        varrecref: Variant;
        RefValue: Decimal;
        ImportQst: Label 'Import ?';
        PeekText: Text[50];
        IsHandled: Boolean;
    begin
        OnBeforeOnclick(TempEasyTileBuffer, TilePosition, style, IsHandled);
        if IsHandled then
            exit;

        if GetTileDefinition(TempEasyTileBuffer, TilePosition, EasyTileGroupLine, RefValue, PeekText) then begin
            if TempEasyTileBuffer."Edit Mode" then begin
                if TempEasyTileBuffer."Move Mode" and EasyTileGroupLine.Visible then begin
                    if TempEasyTileBuffer."Tile To Move" <> 0 then begin
                        GetTileDefinition(TempEasyTileBuffer, TempEasyTileBuffer."Tile To Move", xMoveEasyTileGroupLine, RefValue, PeekText);
                        SetTileBufferValues(TempEasyTileBuffer, TempEasyTileBuffer."Tile To Move", xMoveEasyTileGroupLine.Caption, true, 'Favorable', 1, '')
                    end;

                    TempEasyTileBuffer."Tile To Move" := TilePosition;
                    SetTileBufferValues(TempEasyTileBuffer, TilePosition, EasyTileGroupLine.Caption, true, 'Ambiguous', 999, '');
                    style := 'Ambiguous';
                    TempEasyTileBuffer.Modify();
                end else begin
                    xEasyTileGroupLine := EasyTileGroupLine;
                    if Page.RunModal(Page::"Easy Tile Setup Card", EasyTileGroupLine) = Action::LookupOK then begin
                        if EasyTileGroupLine.Visible then begin
                            SetTileBufferValues(TempEasyTileBuffer, TilePosition, EasyTileGroupLine.Caption, true, 'Unfavorable', 1, '');
                            if (xEasyTileGroupLine."Hide Counter" <> EasyTileGroupLine."Hide Counter") then
                                TempEasyTileBuffer."Reload Page" := true;
                            if (xEasyTileGroupLine.Size = xEasyTileGroupLine.Size::Large) and (xEasyTileGroupLine.Size <> EasyTileGroupLine.Size) then
                                TempEasyTileBuffer."Reload Page" := true;
                        end else
                            SetTileBufferValues(TempEasyTileBuffer, TilePosition, EmptyCaptionTxt, true, 'Unfavorable', 0, '');
                        style := 'Unfavorable';
                        TempEasyTileBuffer.Modify();
                    end;
                end;
            end else begin
                if EasyTileGroupLine."Table No." <> 0 then begin
                    recref.Open(EasyTileGroupLine."Table No.");

                    if EasyTileGroupLine."Selected Key Index" <> 0 then
                        recref.CurrentKeyIndex(EasyTileGroupLine."Selected Key Index");

                    recref.Ascending(not EasyTileGroupLine."Descending Order");

                    // if EasyTileGroupLine.GetTableFilter() <> '' then
                    //     recref.SetView(EasyTileGroupLine.GetTableFilter());
                    if not IsNullGuid(EasyTileGroupLine."Filter Guid") then
                        EasyTilesFilterMgtSG.ApplyFilter(recref, EasyTileGroupLine."Filter Guid");

                    recrefopen := (recref.FindFirst()) or (recref.Count = 0);
                    varrecref := recref;
                end;

                if EasyTileGroupLine."Object Id" <> 0 then begin
                    case EasyTileGroupLine."Object Type" of
                        EasyTileGroupLine."Object Type"::Page:
                            begin
                                if recrefopen then
                                    Page.Run(EasyTileGroupLine."Object Id", varrecref)
                                else
                                    Page.Run(EasyTileGroupLine."Object Id");
                            end;
                        EasyTileGroupLine."Object Type"::Codeunit:
                            begin
                                if recrefopen then
                                    Codeunit.Run(EasyTileGroupLine."Object Id", varrecref)
                                else
                                    Codeunit.Run(EasyTileGroupLine."Object Id");
                            end;
                        EasyTileGroupLine."Object Type"::Report:
                            begin
                                if recrefopen then
                                    Report.Run(EasyTileGroupLine."Object Id", true, false, varrecref)
                                else
                                    Report.Run(EasyTileGroupLine."Object Id", true, false);
                            end;
                        EasyTileGroupLine."Object Type"::"XML Port":
                            begin
                                if recrefopen then
                                    Xmlport.Run(EasyTileGroupLine."Object Id", Confirm(ImportQst, true), varrecref)
                                else
                                    Xmlport.Run(EasyTileGroupLine."Object Id");
                            end;
                    end;
                end;
            end;
        end;
    end;

    internal procedure GetTileDefinition(EasyTileBuffer: Record "Easy Tile Buffer" temporary; TilePosition: Integer; var EasyTileGroupLine: Record "Easy Tile Group Line"; var RefValue: Decimal; var PeekText: Text[50]): Boolean;
    var
        recref: RecordRef;
        fldref: FieldRef;
    begin
        case TilePosition of
            1:
                begin
                    RefValue := EasyTileBuffer."Value 1";
                    PeekText := EasyTileBuffer."Peek 1";
                end;
            2:
                begin
                    RefValue := EasyTileBuffer."Value 2";
                    PeekText := EasyTileBuffer."Peek 2";
                end;
            3:
                begin
                    RefValue := EasyTileBuffer."Value 3";
                    PeekText := EasyTileBuffer."Peek 3";
                end;
            4:
                begin
                    RefValue := EasyTileBuffer."Value 4";
                    PeekText := EasyTileBuffer."Peek 4";
                end;
            5:
                begin
                    RefValue := EasyTileBuffer."Value 5";
                    PeekText := EasyTileBuffer."Peek 5";
                end;
            6:
                begin
                    RefValue := EasyTileBuffer."Value 6";
                    PeekText := EasyTileBuffer."Peek 6";
                end;
            7:
                begin
                    RefValue := EasyTileBuffer."Value 7";
                    PeekText := EasyTileBuffer."Peek 7";
                end;
            8:
                begin
                    RefValue := EasyTileBuffer."Value 8";
                    PeekText := EasyTileBuffer."Peek 8";
                end;
            9:
                begin
                    RefValue := EasyTileBuffer."Value 9";
                    PeekText := EasyTileBuffer."Peek 9";
                end;
            10:
                begin
                    RefValue := EasyTileBuffer."Value 10";
                    PeekText := EasyTileBuffer."Peek 10";
                end;
            11:
                begin
                    RefValue := EasyTileBuffer."Value 11";
                    PeekText := EasyTileBuffer."Peek 11";
                end;
            12:
                begin
                    RefValue := EasyTileBuffer."Value 12";
                    PeekText := EasyTileBuffer."Peek 12";
                end;
            13:
                begin
                    RefValue := EasyTileBuffer."Value 13";
                    PeekText := EasyTileBuffer."Peek 13";
                end;
            14:
                begin
                    RefValue := EasyTileBuffer."Value 14";
                    PeekText := EasyTileBuffer."Peek 14";
                end;
            15:
                begin
                    RefValue := EasyTileBuffer."Value 15";
                    PeekText := EasyTileBuffer."Peek 15";
                end;
            16:
                begin
                    RefValue := EasyTileBuffer."Value 16";
                    PeekText := EasyTileBuffer."Peek 16";
                end;
            17:
                begin
                    RefValue := EasyTileBuffer."Value 17";
                    PeekText := EasyTileBuffer."Peek 17";
                end;
            18:
                begin
                    RefValue := EasyTileBuffer."Value 18";
                    PeekText := EasyTileBuffer."Peek 18";
                end;
            19:
                begin
                    RefValue := EasyTileBuffer."Value 19";
                    PeekText := EasyTileBuffer."Peek 19";
                end;
            20:
                begin
                    RefValue := EasyTileBuffer."Value 20";
                    PeekText := EasyTileBuffer."Peek 20";
                end;
        end;

        EasyTileGroupLine.SetRange("Tile Group Code", EasyTileBuffer."Tile Group Code");
        EasyTileGroupLine.SetRange("Tile Position", TilePosition);
        EasyTileGroupLine.SetRange("User Security Id", UserSecurityId());
        if not EasyTileGroupLine.FindFirst() then begin
            EasyTileGroupLine.SetRange("User Security Id");
            exit(EasyTileGroupLine.FindFirst());
        end;




        exit(true);

    end;

    internal procedure GetTileStyle(EasyTileBuffer: Record "Easy Tile Buffer" temporary; TilePosition: Integer; var tilebackgroundcolour: text; var tilefontcolour: text; var hidecounter: Boolean; var iconsvg: text; var Size: Enum "Easy Tile Size S8L"; var outcaption: text; var outstyle: Text; var PeekText: Text[50]): Boolean
    var
        EasyTileGroupLine: Record "Easy Tile Group Line";
        EasyTileSVGHeader: Record "Easy Tile SVG Header";
        EasyTileGroupLineStyle: Record "Easy Tile Group Line Style S8L";
        EasyTileSVGManagement: Codeunit "Easy Tile SVG Management";
        Visible: Boolean;
        Style: text;
        RefValue: Decimal;
    begin
        outcaption := '';
        tilefontcolour := '';
        tilebackgroundcolour := '';
        hidecounter := false;
        iconsvg := '';
        outstyle := '';
        PeekText := '';

        if GetTileDefinition(EasyTileBuffer, TilePosition, EasyTileGroupLine, RefValue, PeekText) then begin
            hidecounter := EasyTileGroupLine."Hide Counter";
            Size := EasyTileGroupLine.Size;
            outcaption := EasyTileGroupLine.Caption;

            EasyTileGroupLineStyle.SetRange("Tile Group Code", EasyTileGroupLine."Tile Group Code");
            EasyTileGroupLineStyle.SetRange("Tile Position", EasyTileGroupLine."Tile Position");
            EasyTileGroupLineStyle.SetRange("User Security Id", EasyTileGroupLine."User Security Id");
            EasyTileGroupLineStyle.SetFilter(Value, '<=%1', RefValue);
            if EasyTileGroupLineStyle.FindLast() then begin
                tilebackgroundcolour := EasyTileGroupLineStyle."Tile Background Colour";
                tilefontcolour := EasyTileGroupLineStyle."Tile Font Colour";
                outstyle := ConvertStyleToStyleText(EasyTileGroupLineStyle."Tile Style");
                if EasyTileSVGHeader.Get(EasyTileGroupLineStyle."Icon SVG Code") then
                    iconsvg := EasyTileSVGManagement.CreateSVG(EasyTileSVGHeader, '40', '40'); //icon size limit to 40x40
            end;
            exit((hidecounter or (tilebackgroundcolour <> '') or (tilefontcolour <> '') or (iconsvg <> '') or (Size = Size::Normal) or (Size <> Size::Normal)) and (EasyTileGroupLine.Visible)); //this will trigger always
        end;
    end;

    local procedure GetTileBufferValues(EasyTileBuffer: Record "Easy Tile Buffer" temporary; TilePosition: Integer; var Caption: Text; var Visible: Boolean; var Style: text; var Value: Decimal)
    var
        recref: RecordRef;
        fldref: FieldRef;
    begin
        recref.GetTable(EasyTileBuffer);
        //Position + 9

        //Caption + 29
        fldref := recref.Field(TilePosition + 29);
        Caption := fldref.Value;

        //Visible + 49
        fldref := recref.Field(TilePosition + 49);
        Visible := fldref.Value;

        //Style + 69
        fldref := recref.Field(TilePosition + 69);
        Style := fldref.Value;

        //Value + 89
        fldref := recref.Field(TilePosition + 89);
        Value := fldref.Value;


    end;

    local procedure SetTileBufferValues(var TempEasyTileBuffer: Record "Easy Tile Buffer" temporary; TilePosition: Integer; Caption: Text; Visible: Boolean; Style: text; Value: Decimal; Peek: Text[50])
    var
        recref: RecordRef;
        fldref: FieldRef;
    begin
        recref.GetTable(TempEasyTileBuffer);
        //Position +9
        fldref := recref.Field(TilePosition + 9);
        fldref.Value(TilePosition);

        //Caption + 29
        fldref := recref.Field(TilePosition + 29);
        fldref.Value(Caption);

        //Visible + 49
        fldref := recref.Field(TilePosition + 49);
        fldref.Value(Visible);

        //Style + 69
        fldref := recref.Field(TilePosition + 69);
        fldref.Value(Style);

        //Value + 89
        fldref := recref.Field(TilePosition + 89);
        fldref.Value(Value);

        //Peek + 109
        fldref := recref.Field(TilePosition + 109);
        fldref.Value(Peek);

        recref.SetTable(TempEasyTileBuffer);
    end;

    internal procedure EditGroupDefinition(TileGroupCode: Code[20]; ExtendedView: Boolean)
    var
        EmptyGuid: Guid;
    begin
        EditGroupDefintion(TileGroupCode, EmptyGuid, ExtendedView);
    end;

    internal procedure EditGroupDefintion(TileGroupCode: Code[20]; UserSecurityId: Guid; ExtendedView: Boolean)
    var
        EasyTileGroupLine: Record "Easy Tile Group Line";
        EasyTileOpenGroup: Codeunit "Easy Tile Open Group";
        EasyTilePreview: Page "Easy Tile Preview";
    begin
        if ExtendedView then begin
            EasyTileOpenGroup.SetEditMode(TileGroupCode);
            EditMode := true;
            EasyTilePreview.RunModal();
        end else begin
            EasyTileGroupLine.SetRange("Tile Group Code", TileGroupCode);
            EasyTileGroupLine.SetRange("User Security Id", UserSecurityId);
            page.RunModal(Page::"Easy Tile Group Lines", EasyTileGroupLine);
        end;
    end;

    procedure ConvertStyleToStyleText(Style: Enum "Cues And KPIs Style"): Text
    var
        Result: Text;
        Resolved: Boolean;
    begin
        case Style of
            Style::None:
                exit('None');
            Style::Favorable:
                exit('Favorable');
            Style::Unfavorable:
                exit('Unfavorable');
            Style::Ambiguous:
                exit('Ambiguous');
            Style::Subordinate:
                exit('Subordinate');
            else
                exit('');
        end;
    end;


    [IntegrationEvent(false, false)]
    local procedure OnBeforeGenerateTileBuffer(UserId: Code[80]; TileGroupId: Integer; EditMode: Boolean; var TempEasyTileBuffer: Record "Easy Tile Buffer" temporary; var Caption: Text; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGenerateTileBuffer(UserId: Code[80]; TileGroupId: Integer; EditMode: Boolean; var TempEasyTileBuffer: Record "Easy Tile Buffer" temporary; var Caption: Text)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnclick(var TempEasyTileBuffer: Record "Easy Tile Buffer" temporary; TilePosition: Integer; var style: Text; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeFindTileStyle(EasyTileGroupLine: Record "Easy Tile Group Line"; var RefValue: Decimal; var RefStyle: Text; var isHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalcTileValues(TempEasyTileBuffer: Record "Easy Tile Buffer"; TilePosition: Integer; var RefStyle: Text; var RefValue: Decimal; var isHandled: Boolean)
    begin
    end;
}
