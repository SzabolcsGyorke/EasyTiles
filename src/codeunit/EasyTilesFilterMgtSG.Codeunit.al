codeunit 80103 "Easy Tiles Filter Mgt.SG"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Filter Tokens", 'OnResolveDateFilterToken', '', false, false)]
    local procedure AddEIDateFilters(DateToken: Text; var FromDate: Date; var ToDate: Date; var Handled: Boolean)
    var
        StartDate: Date;
        EndDate: Date;
    begin
        case true of
            UpperCase(DateToken).Contains('HELP'):
                begin
                    Message('CDT[1D] - use CDT to calculate a date formula based on today''s date.\' +
                            'CWDT[1W] - same as CDT just using the workdate\' +
                            'APS - allowed posting date Start\' +
                            'APE = - allowed posting date End');
                    Handled := true;
                end;
            UpperCase(DateToken).Contains('CDT['):
                begin
                    FromDate := FindDateFormulaAndCalculate(DateToken, Today());
                    ToDate := FromDate;
                    Handled := true;
                end;
            UpperCase(DateToken).Contains('CWDT['):
                begin
                    FromDate := FindDateFormulaAndCalculate(DateToken, WorkDate());
                    ToDate := FromDate;
                    Handled := true;
                end;
            UpperCase(DateToken).Contains('APS'):
                begin
                    FindAllowedPostingDate(StartDate, EndDate);
                    FromDate := StartDate;
                    ToDate := FromDate;
                    Handled := true;
                end;
            UpperCase(DateToken).Contains('APE'):
                begin
                    FindAllowedPostingDate(StartDate, EndDate);
                    FromDate := EndDate;
                    ToDate := FromDate;
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Filter Tokens", 'OnResolveTextFilterToken', '', false, false)]
    local procedure AddEITextFilters(TextToken: Text; var TextFilter: Text; var Handled: Boolean)
    begin
        case TextToken of
            'USERSID':
                begin
                    TextFilter := Format(UserSecurityId());
                    Handled := true;
                end;
        end;
    end;



    local procedure FindAllowedPostingDate(var StartDate: Date; var EndDate: Date): Boolean
    var
        UserSetup: Record "User Setup";
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        if UserSetup.Get(UserId()) then
            if (UserSetup."Allow Posting From" <> 0D) or (UserSetup."Allow Posting To" <> 0D) then begin
                StartDate := UserSetup."Allow Posting From";
                EndDate := UserSetup."Allow Posting To";
                exit(true);
            end;

        GeneralLedgerSetup.GetRecordOnce();
        if (GeneralLedgerSetup."Allow Posting From" <> 0D) or (GeneralLedgerSetup."Allow Posting To" <> 0D) then begin
            StartDate := GeneralLedgerSetup."Allow Deferral Posting From";
            EndDate := GeneralLedgerSetup."Allow Posting To";
            exit(true);
        end;

        StartDate := 20010101D;
        EndDate := 99991231D;
        exit(true);
    end;

    local procedure FindDateFormulaAndCalculate(DateToken: Text; BaseDate: Date): Date
    var
        StartPos, EndPos : Integer;
        DateF: DateFormula;
    begin
        StartPos := StrPos(DateToken, '[') + 1;
        EndPos := StrPos(DateToken, ']');
        Evaluate(DateF, CopyStr(DateToken, StartPos, EndPos - StartPos));
        exit(CalcDate(DateF, BaseDate));
    end;
}
