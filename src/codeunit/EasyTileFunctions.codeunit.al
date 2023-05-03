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
                    CalcTileValues(TempEasyTileBuffer, RefPosition, RefStyle, RefValue);

                if EditMode and EasyTileGroupLine.Visible then begin
                    RefStyle := 'Favorable';
                    RefValue := 1;
                end;

                if EditMode and (not EasyTileGroupLine.Visible) then begin
                    RefStyle := 'Ambiguous';
                    EasyTileGroupLine.Visible := true;
                    EasyTileGroupLine.Caption := EmptyCaptionTxt;
                end;

                SetTileBufferValues(TempEasyTileBuffer, RefPosition, EasyTileGroupLine.Caption, EasyTileGroupLine.Visible, RefStyle, RefValue);

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

    local procedure CalcTileValues(var TempEasyTileBuffer: Record "Easy Tile Buffer"; TilePosition: Integer; var RefStyle: Text; var RefValue: Decimal)
    var
        EasyTileGroupLine: Record "Easy Tile Group Line";
        recref: RecordRef;
        fldref: FieldRef;
    begin
        if GetTileDefinition(TempEasyTileBuffer, TilePosition, EasyTileGroupLine) then
            if (EasyTileGroupLine."Table No." <> 0) then begin
                recref.Open(EasyTileGroupLine."Table No.");
                if Format(EasyTileGroupLine."Table Filter") <> '' then
                    recref.SetView(TableFilter2View(Format(EasyTileGroupLine."Table Filter")));

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
                    end;


                //Style evaluation
                if RefValue < EasyTileGroupLine."Threshold 1" then
                    RefStyle := ConvertStyleToStyleText(EasyTileGroupLine."Low Range Style");

                if (RefValue >= EasyTileGroupLine."Threshold 1") and (RefValue <= EasyTileGroupLine."Threshold 2") then
                    RefStyle := ConvertStyleToStyleText(EasyTileGroupLine."Middle Range Style");

                if RefValue > EasyTileGroupLine."Threshold 2" then
                    RefStyle := ConvertStyleToStyleText(EasyTileGroupLine."High Range Style");
            end;
    end;

    internal procedure OnClick(var TempEasyTileBuffer: Record "Easy Tile Buffer"; TilePosition: Integer; var style: Text)
    var
        EasyTileGroupLine: Record "Easy Tile Group Line";
        recref: RecordRef;
        fldref: FieldRef;
        recrefopen: Boolean;
        varrecref: Variant;
        ImportQst: Label 'Import ?';
    begin
        if GetTileDefinition(TempEasyTileBuffer, TilePosition, EasyTileGroupLine) then begin
            if TempEasyTileBuffer."Edit Mode" then begin
                if Page.RunModal(Page::"Easy Tile Setup Card", EasyTileGroupLine) = Action::LookupOK then begin
                    if EasyTileGroupLine.Visible then
                        SetTileBufferValues(TempEasyTileBuffer, TilePosition, EasyTileGroupLine.Caption, true, 'Unfavorable', 1)
                    else
                        SetTileBufferValues(TempEasyTileBuffer, TilePosition, EmptyCaptionTxt, true, 'Unfavorable', 0);
                    style := 'Unfavorable';
                    TempEasyTileBuffer.Modify();
                end;
            end else begin
                if EasyTileGroupLine."Table No." <> 0 then begin
                    recref.Open(EasyTileGroupLine."Table No.");
                    if Format(EasyTileGroupLine."Table Filter") <> '' then
                        recref.SetView(TableFilter2View(Format(EasyTileGroupLine."Table Filter")));
                    recrefopen := not recref.IsEmpty();
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

    internal procedure GetTileDefinition(EasyTileBuffer: Record "Easy Tile Buffer" temporary; TilePosition: Integer; var EasyTileGroupLine: Record "Easy Tile Group Line"): Boolean;
    var
        recref: RecordRef;
        fldref: FieldRef;
    begin
        EasyTileGroupLine.SetRange("Tile Group Code", EasyTileBuffer."Tile Group Code");
        EasyTileGroupLine.SetRange("Tile Position", TilePosition);
        EasyTileGroupLine.SetRange("User Security Id", UserSecurityId());
        if not EasyTileGroupLine.FindFirst() then begin
            EasyTileGroupLine.SetRange("User Security Id");
            exit(EasyTileGroupLine.FindFirst());
        end;

        exit(true);

    end;

    internal procedure GetTileStyle(EasyTileBuffer: Record "Easy Tile Buffer" temporary; TilePosition: Integer; var tilebackgroundcolour: text; var tilefontcolour: text; var hidecounter: Boolean; var iconsvg: text): Boolean
    var
        EasyTileGroupLine: Record "Easy Tile Group Line";
        EasyTileSVGHeader: Record "Easy Tile SVG Header";
        EasyTileSVGManagement: Codeunit "Easy Tile SVG Management";
        Caption: Text;
        Visible: Boolean;
        Style: text;
        Value: Decimal;
    begin
        tilefontcolour := '';
        tilebackgroundcolour := '';
        hidecounter := false;
        iconsvg := '';

        if GetTileDefinition(EasyTileBuffer, TilePosition, EasyTileGroupLine) then begin
            tilebackgroundcolour := EasyTileGroupLine."Tile Background Colour";
            tilefontcolour := EasyTileGroupLine."Tile Font Colour";
            hidecounter := EasyTileGroupLine."Hide Counter";
            if EasyTileSVGHeader.Get(EasyTileGroupLine."Icon SVG Code") then
                iconsvg := EasyTileSVGManagement.CreateSVG(EasyTileSVGHeader, '40', '40'); //icon size limit to 40x40

            exit(hidecounter or (tilebackgroundcolour <> '') or (tilefontcolour <> '') or (iconsvg <> ''));
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

    local procedure SetTileBufferValues(var TempEasyTileBuffer: Record "Easy Tile Buffer" temporary; TilePosition: Integer; Caption: Text; Visible: Boolean; Style: text; Value: Decimal)
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


        recref.SetTable(TempEasyTileBuffer);
    end;

    internal procedure EditGroupDefintion(TileGroupCode: Code[20]; ExtendedView: Boolean)
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

    procedure TableFilter2View(TableFilter: Text) View: Text
    // TableFilter format:
    // <TableName>:<FieldCaption>=<FieldFilter>,<FieldCaption>=<FieldFilter>,..
    // View format:
    // [SORTING(<Key>)] WHERE(<FieldCaption>=FILTER(<FieldFilter>),<FieldCaption>=FILTER(<FieldFilter>),...)
    var
        CharNo: Integer;
    begin
        IF TableFilter = '' then
            exit('');

        View := 'WHERE(';

        for CharNo := StrPos(TableFilter, ':') + 1 TO StrLen(TableFilter) do begin
            CASE TableFilter[CharNo] OF
                '=':
                    View := View + '=filter(';
                ',':
                    View := View + '),';
                '"':
                    begin
                        CharNo := CharNo + 1;
                        repeat
                            View := View + Format(TableFilter[CharNo]);
                            CharNo := CharNo + 1;
                        until TableFilter[CharNo] = '"';
                        CharNo := CharNo + 1;
                    end;
                else
                    View := View + Format(TableFilter[CharNo]);
            end;
        end;

        View := View + '))';
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
}
