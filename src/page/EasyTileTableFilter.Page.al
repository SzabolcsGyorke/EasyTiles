page 80117 "Easy Tile Table Filter"
{
    ApplicationArea = All;
    Caption = 'Easy Tile Table Filter';
    PageType = List;
    SourceTable = "Easy Tile Table Filter";
    AutoSplitKey = true;
    UsageCategory = None;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Field Number"; Rec."Field Number")
                {
                    ToolTip = 'Specifies the value of the Field Number field.', Comment = '%';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        "Field": Record "Field";
                        FieldSelection: Codeunit "Field Selection";
                    begin
                        Field.SetRange(TableNo, Rec."Table Number");
                        if FieldSelection.Open(Field) then begin
                            if Field."No." = Rec."Field Number" then
                                exit;
                            Rec.CheckDuplicateField(Field, FilterGuid);
                            FillSourceRecord(Field);
                            CurrPage.Update(true);
                        end;
                    end;

                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ToolTip = 'Specifies the value of the Field Caption field.', Comment = '%';
                    Editable = false;
                }
                field("Is Modified"; Rec."Is Modified")
                {
                    ToolTip = 'Condition if the field is modified via a modification trigger.', Comment = '%';
                    Visible = ConditionView;
                }

                field("Field Filter"; Rec."Field Filter")
                {
                    ToolTip = 'Specifies the value of the Field Filter field.', Comment = '%';
                    trigger OnAssistEdit()
                    var
                        EasyTilesFilterMgtSG: Codeunit "Easy Tiles Filter Mgt.SG";
                    begin
                        Rec."Field Filter" := CopyStr(EasyTilesFilterMgtSG.FieldValueLookup(Rec."Table Number", Rec."Field Number", Rec."Field Filter"), 1, MaxStrLen(Rec."Field Filter"));
                    end;
                }
            }
        }
    }
    var
        FilterGuid: Guid;
        FilterTableNo: Integer;
        FilterFieldNo: Integer;
        TableFilterLongErr: Label 'The filters are too large to be copied to the type "TableFilter".';
        ConditionView: Boolean;

    trigger OnOpenPage()
    begin
        FilterGuid := Rec.GetFilter("Filter Id");
        CurrPage.Editable(true);
    end;

    procedure SetFilterTableAndField(NewFilterTableNo: Integer; NewFilterFieldNo: Integer)
    begin
        FilterTableNo := NewFilterTableNo;
        FilterFieldNo := NewFilterFieldNo;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Filter Table No." := FilterTableNo;
        Rec."Filter Field No." := FilterFieldNo;
    end;

    local procedure FillSourceRecord("Field": Record "Field")
    begin
        Rec.SetRange("Field Number");
        Rec.Init();
        Rec."Filter Id" := FilterGuid;
        Rec."Table Number" := Field.TableNo;
        Rec."Table Name" := Field.TableName;
        Rec."Field Number" := Field."No.";
        Rec."Field Name" := Field.FieldName;
        Rec."Field Caption" := Field."Field Caption";
    end;

    procedure SetConditionView(NewConditionView: Boolean)
    begin
        ConditionView := NewConditionView;
        if ConditionView then
            CurrPage.Caption := 'Table Filter - Condition';
    end;

    procedure GetViewFilter(): Text
    var
        RecRef: RecordRef;
        FldRef: FieldRef;
    begin
        RecRef.Open(Rec."Table Number");
        if Rec.FindSet() then
            repeat
                FldRef := RecRef.Field(Rec."Field Number");
                FldRef.SetFilter(Rec."Field Filter");
            until Rec.Next() = 0;
        exit(RecRef.GetView());
    end;

    procedure CreateTextTableFilterWithoutTableName(CurrentLineOnly: Boolean): Text
    var
        TextTableFilter: Text;
        TextFieldFilter: Text;
        FirstField: Boolean;
    begin
        FirstField := true;
        if CurrentLineOnly then
            AppendFieldFilter(TextTableFilter, CreateTextFieldFilter())
        else
            if Rec.Find('-') then
                repeat
                    TextFieldFilter := CreateTextFieldFilter();
                    if StrLen(TextFieldFilter) > 0 then begin
                        if not FirstField then
                            TextTableFilter += ',';
                        FirstField := false;
                        AppendFieldFilter(TextTableFilter, TextFieldFilter);
                    end;
                until Rec.Next() = 0;

        exit(TextTableFilter);
    end;

    local procedure CreateTextFieldFilter(): Text
    begin
        if (Rec."Field Number" > 0) and (StrLen(Rec."Field Filter") > 0) and (not Rec."Is Modified") then
            exit(QuoteValue(Rec."Field Caption", '=') + '=' + QuoteValue(CopyStr(Rec."Field Filter", 1, 250), ','));

        if (Rec."Field Number" > 0) and Rec."Is Modified" then
            exit('Is Changed: ' + QuoteValue(Rec."Field Caption", '='));

        exit('');
    end;

    local procedure AppendFieldFilter(var TextTableFilter: Text; TextFieldFilter: Text)
    begin
        if (StrLen(TextTableFilter) + StrLen(TextFieldFilter)) > 200 then
            Error(TableFilterLongErr);

        TextTableFilter += TextFieldFilter;
    end;

    local procedure QuoteValue(TextValue: Text[250]; TextCausingQuotes: Text): Text
    var
        InnerQuotePosition: Integer;
        TextValue2: Text;
    begin
        // If quotes are not needed return initial value:
        if StrPos(TextValue, TextCausingQuotes) <= 0 then
            exit(TextValue);

        // Escape possible double quote characters:
        InnerQuotePosition := StrPos(TextValue, '"');
        while InnerQuotePosition > 0 do begin
            TextValue2 += CopyStr(TextValue, 1, InnerQuotePosition) + '"';
            TextValue := CopyStr(TextValue, InnerQuotePosition + 1, StrLen(TextValue));
            InnerQuotePosition := StrPos(TextValue, '"');
        end;

        // Surround by double quotes:
        TextValue2 += TextValue;
        TextValue2 := '"' + TextValue2 + '"';

        exit(TextValue2);
    end;
}
