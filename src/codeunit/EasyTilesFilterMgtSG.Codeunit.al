codeunit 80103 "Easy Tiles Filter Mgt.SG"
{
    var
        TempChangedFieldsGlobal: Record "Name/Value Buffer" temporary;
        TodayTxt: Label '%TODAY';
        WorkDateTxt: Label '%WORKDATE';
        CurrentDateTimeTxt: Label '%CURRENTDATETIME';
        NowTxt: Label '%NOW';
        UserIdTxt: Label '%USERID';
        UserSIDTxt: Label '%USERSID';
        DFText: Label '%DATEFORMULA';

    internal procedure FieldValueLookup(Tableno: Integer; FieldNo: Integer; xValue: Text): Text
    var
        Field: Record Field;
        TempNameValueBuffer: Record "Name/Value Buffer" temporary;
        RecRef: RecordRef;
        KeyRef: KeyRef;
        AddVirtualFieldTxt: Label 'Virtual Field: %1', Comment = '%1 field caption';
        BooleanNoTxt: label 'No';
        BooleanYesTxt: label 'Yes';
        DateFormulaTxt: Label '%DATEFORMULA[%1,%2]', Comment = '%1 - Formula %2 - Date', Locked = true;
        OptionValue: Text;
    begin

        if Field.Get(Tableno, FieldNo) then
            case Field.Type of
                Field.Type::Option:
                    begin
                        RecRef.Open(Tableno);

                        foreach OptionValue in RecRef.Field(FieldNo).OptionCaption.Split(',') do
                            TempNameValueBuffer.AddNewEntry(Format(Field.Type), OptionValue);
                    end;
                Field.Type::Boolean:
                    begin
                        TempNameValueBuffer.AddNewEntry(Format(Field.Type), BooleanYesTxt);
                        TempNameValueBuffer.AddNewEntry(Format(Field.Type), BooleanNoTxt);
                    end;
                Field.Type::Date:
                    begin
                        TempNameValueBuffer.AddNewEntry(Format(Field.Type), TodayTxt);
                        TempNameValueBuffer.AddNewEntry(Format(Field.Type), WorkDateTxt);
                        TempNameValueBuffer.AddNewEntry(Format(Field.Type), StrSubstNo(DateFormulaTxt, '1D', TodayTxt));
                    end;
                Field.Type::DateTime:
                    TempNameValueBuffer.AddNewEntry(Format(Field.Type), CurrentDateTimeTxt);
                Field.Type::Time:
                    TempNameValueBuffer.AddNewEntry(Format(Field.Type), NowTxt);
                Field.Type::Code:
                    begin
                        TempNameValueBuffer.AddNewEntry(Format(Field.Type), UserIdTxt);
                        if Field.RelationTableNo <> 0 then begin
                            RecRef.Open(Field.RelationTableNo);
                            KeyRef := RecRef.KeyIndex(RecRef.CurrentKeyIndex()); //should be PK
                            if RecRef.FindSet() then
                                repeat
                                    //if there is a relation then use the second field. 
                                    //Example Bin - 1 location Code, 2 Bin Code => we want the 2nd field as bin not the location code so check if it has any relations
                                    if KeyRef.FieldIndex(1).Relation = 0 then
                                        TempNameValueBuffer.AddNewEntry(CopyStr(RecRef.Caption, 1, 250), KeyRef.FieldIndex(1).Value)
                                    else
                                        TempNameValueBuffer.AddNewEntry(CopyStr(RecRef.Caption, 1, 250), KeyRef.FieldIndex(2).Value);
                                until RecRef.Next() = 0;
                        end;
                    end;
                Field.Type::Text:
                    begin
                        TempNameValueBuffer.AddNewEntry(Format(Field.Type), UserIdTxt);
                    end;
                Field.Type::GUID:
                    TempNameValueBuffer.AddNewEntry(Format(Field.Type), UserSIDTxt);
            end;



        if (not TempNameValueBuffer.IsEmpty) and (Page.RunModal(Page::"Name/Value Lookup", TempNameValueBuffer) = Action::LookupOK) then
            exit(TempNameValueBuffer.Value)
        else
            exit(xValue);
    end;

    internal procedure ApplyFilter(var recref: RecordRef; FilterGuid: Guid)
    var
        EasyTileTableFilter: Record "Easy Tile Table Filter";
    begin
        EasyTileTableFilter.SetRange("Filter Id", FilterGuid);
        EasyTileTableFilter.SetRange("Table Number", recref.Number);
        if EasyTileTableFilter.FindSet() then
            repeat
                recref.Field(EasyTileTableFilter."Field Number").SetFilter(CalcDynamicValue(EasyTileTableFilter."Field Filter"));
            until EasyTileTableFilter.Next() = 0;
    end;

    local procedure CalcDynamicValue(ImportValue: Text) retval: Text
    var
        Parameter1: Text;
        Parameter2: Text;
        TextToReplace: Text;
    begin
        //%DATEFORMULA[%1,%2] 
        //Static values
        // TodayTxt: Label '%TODAY';
        // WorkDateTxt: Label '%WORKDATE';
        // CurrentDateTimeTxt: Label '%CURRENTDATETIME';
        // NowTxt: Label '%NOW';
        // UserIdTxt: Label '%USERID';
        // CommentTxt: Label '%COMMENT';
        // UserSIDTxt: Label '%USERSID';
        retval := ImportValue;
        if not (
                ImportValue.Contains(NowTxt) or
                ImportValue.Contains(TodayTxt) or
                ImportValue.Contains(DFText) or
                ImportValue.Contains(WorkDateTxt) or
                ImportValue.Contains(UserSIDTxt) or
                ImportValue.Contains(UserIdTxt) or
                ImportValue.Contains(CurrentDateTimeTxt)) then
            exit;

        retval := ImportValue.Replace(NowTxt, Format(Time())).Replace(TodayTxt, Format(Today())).Replace(WorkDateTxt, Format(WorkDate())).Replace(UserSIDTxt, Format(UserSecurityId())).Replace(CurrentDateTimeTxt, Format(CurrentDateTime()));
        retval := EvaluateExpression(retval);
    end;



    procedure EvaluateExpression(Expression: Text) retval: text
    var
        SubExpression: Text;
    begin
        Expression := DelChr(Expression, '<>', ' ');
        Expression := Expression.ToUpper();
        Expression := Expression.Replace(DFText, 'D');
        while HasExpression(Expression, SubExpression) do
            Expression := Expression.Replace(SubExpression, Format(CalculateExpression(SubExpression)));

        retval := Expression;
    end;

    procedure HasExpression(Expression: Text; var SubExpression: Text): Boolean
    var
        FromChar: Integer;
        Operation: Text;
        i: Integer;
    begin
        for i := 1 to StrLen(Expression) do begin
            if Expression[i] = '[' then
                FromChar := i;

            if Expression[i] = ']' then begin
                Operation := Expression[FromChar - 1];
                SubExpression := Operation + CopyStr(Expression, FromChar, i - FromChar + 1);
                exit(true);
            end;

        end;
    end;

    procedure CalculateExpression(Expression: Text) retval: Variant
    var
        InnerExpression: Text;
        Parameters: List of [Text];
        Parameter: Text;
        DF: DateFormula;
        InDate: Date;
    begin
        InnerExpression := CopyStr(Expression, 3, StrLen(Expression) - 3);
        case Expression[1] of
            'D':
                begin
                    Parameters := InnerExpression.Split(',');
                    Parameters.Get(1, Parameter);
                    Evaluate(DF, Parameter);
                    Parameters.Get(2, Parameter);
                    Evaluate(InDate, Parameter);

                    retval := CalcDate(DF, InDate);
                end;
        end;
    end;

}
