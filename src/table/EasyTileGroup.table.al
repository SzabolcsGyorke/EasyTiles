table 80101 "Easy Tile Group"
{
    Caption = 'Easy Tile Group';
    DataClassification = CustomerContent;
    LookupPageId = "Easy Tile Groups";
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Caption; Text[50])
        {
            Caption = 'Caption';
            DataClassification = CustomerContent;
        }
        field(3; "Enable Personalization"; Boolean)
        {
            Caption = 'Enable Personalization';
            DataClassification = CustomerContent;
        }
        field(4; "Layout"; Option)
        {
            Caption = 'Layout';
            DataClassification = CustomerContent;
            OptionMembers = "2x10","4x5";
            OptionCaption = '2x10,4x5';
        }
        field(5; "Group 1 Caption"; Text[100])
        {
            Caption = 'Group 1 Caption';
            DataClassification = CustomerContent;
        }
        field(6; "Group 2 Caption"; Text[100])
        {
            Caption = 'Group 2 Caption';
            DataClassification = CustomerContent;
        }
        field(7; "Group 3 Caption"; Text[100])
        {
            Caption = 'Group 3 Caption';
            DataClassification = CustomerContent;
        }
        field(8; "Group 4 Caption"; Text[100])
        {
            Caption = 'Group 4 Caption';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        EasyTileGroupLine: Record "Easy Tile Group Line";
        i: Integer;
    begin
        for i := 1 to 20 do begin
            EasyTileGroupLine.Init();
            EasyTileGroupLine."Tile Group Code" := Code;
            EasyTileGroupLine."Tile Position" := i;
            EasyTileGroupLine.Visible := false;
            EasyTileGroupLine.Insert();
        end;
    end;

    trigger OnDelete()
    var
        EasyTileGroupAssignment: Record "Easy Tile Group Assignment";
        EasyTileGroupLine: Record "Easy Tile Group Line";
        NoOfAssignments: Integer;
        AssignmentsExistsErr: Label 'Please un-assign the Tile Group %1 first.', Comment = '%1 - Code';
    begin
        EasyTileGroupAssignment.SetRange("Main Group", Code);
        NoOfAssignments := EasyTileGroupAssignment.Count();
        EasyTileGroupAssignment.Reset();
        EasyTileGroupAssignment.SetRange("Group 1", Code);
        NoOfAssignments += EasyTileGroupAssignment.Count();
        EasyTileGroupAssignment.Reset();
        EasyTileGroupAssignment.SetRange("Group 2", Code);
        NoOfAssignments += EasyTileGroupAssignment.Count();
        EasyTileGroupAssignment.Reset();
        EasyTileGroupAssignment.SetRange("Group 3", Code);
        NoOfAssignments += EasyTileGroupAssignment.Count();
        EasyTileGroupAssignment.Reset();
        EasyTileGroupAssignment.SetRange("Group 4", Code);
        NoOfAssignments += EasyTileGroupAssignment.Count();

        if NoOfAssignments > 0 then
            Error(AssignmentsExistsErr, Code);

        EasyTileGroupLine.SetRange("Tile Group Code", Code);
        EasyTileGroupLine.DeleteAll(true);
    end;
}
