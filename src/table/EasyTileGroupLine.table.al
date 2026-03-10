table 80102 "Easy Tile Group Line"
{
    Caption = 'Easy Tile Group Line';
    DataClassification = ToBeClassified;
    DataCaptionFields = Caption;
    fields
    {
        field(1; "Tile Group Code"; Code[20])
        {
            Caption = 'Tile Group Code ';
            DataClassification = CustomerContent;
            TableRelation = "Easy Tile Group";
        }
        field(3; "Tile Position"; Integer)
        {
            Caption = 'Tile Position';
            DataClassification = ToBeClassified;
            MinValue = 1;
            MaxValue = 20;
        }

        field(4; "User Security Id"; Guid)
        {
            Caption = 'User Security Id';
            DataClassification = CustomerContent;
            TableRelation = User."User Security ID";
        }
        field(5; Caption; Text[50])
        {
            Caption = 'Caption';
            DataClassification = CustomerContent;
        }
        field(6; "Visible"; Boolean)
        {
            Caption = 'Visible';
            DataClassification = CustomerContent;
            InitValue = true;
        }

        field(10; "Object Type"; Option)
        {
            Caption = 'Object Type';
            DataClassification = CustomerContent;
            OptionMembers = ,Page,Report,Codeunit,"XML Port";
            OptionCaption = ' ,Page,Report,Codeunit,XML Port';
            trigger OnValidate()
            begin
                if xRec."Object Type" <> "Object Type" then
                    Validate("Object Id", 0);
            end;
        }
        field(11; "Object Id"; Integer)
        {
            Caption = 'Object Id';
            DataClassification = CustomerContent;
            BlankZero = true;
            trigger OnValidate()
            var
                AllObjWithCaption: Record AllObjWithCaption;
            begin
                if "Object Id" = 0 then begin
                    "Object Caption" := '';
                    exit;
                end;

                case "Object Type" of
                    "Object Type"::Codeunit:
                        AllObjWithCaption.SetRange(AllObjWithCaption."Object Type", AllObjWithCaption."Object Type"::Codeunit);
                    "Object Type"::Page:
                        AllObjWithCaption.SetRange(AllObjWithCaption."Object Type", AllObjWithCaption."Object Type"::Page);
                    "Object Type"::Report:
                        AllObjWithCaption.SetRange(AllObjWithCaption."Object Type", AllObjWithCaption."Object Type"::Report);
                    "Object Type"::"XML Port":
                        AllObjWithCaption.SetRange(AllObjWithCaption."Object Type", AllObjWithCaption."Object Type"::XMLport);
                end;
                AllObjWithCaption.SetRange("Object ID", "Object Id");
                AllObjWithCaption.FindFirst();
                "Object Caption" := AllObjWithCaption."Object Caption";
            end;

            trigger OnLookup()
            var
                AllObjWithCaption: Record AllObjWithCaption;
                PageMetadata: Record "Page Metadata";
            begin

                case "Object Type" of
                    "Object Type"::Codeunit:
                        AllObjWithCaption.SetRange(AllObjWithCaption."Object Type", AllObjWithCaption."Object Type"::Codeunit);
                    "Object Type"::Page:
                        begin
                            AllObjWithCaption.SetRange(AllObjWithCaption."Object Type", AllObjWithCaption."Object Type"::Page);
                            if "Table No." <> 0 then begin
                                PageMetadata.SetRange(SourceTable, "Table No.");
                                if PageMetadata.FindSet() then begin
                                    repeat
                                        AllObjWithCaption.Get(AllObjWithCaption."Object Type"::Page, PageMetadata.ID);
                                        AllObjWithCaption.Mark(true);
                                    until PageMetadata.Next() < 1;
                                    AllObjWithCaption.MarkedOnly(true);
                                end;
                            end;

                        end;
                    "Object Type"::Report:
                        AllObjWithCaption.SetRange(AllObjWithCaption."Object Type", AllObjWithCaption."Object Type"::Report);
                    "Object Type"::"XML Port":
                        AllObjWithCaption.SetRange(AllObjWithCaption."Object Type", AllObjWithCaption."Object Type"::XMLport);
                end;

                if Page.Runmodal(Page::"Easy Tile Object Lookup", AllObjWithCaption) = Action::LookupOK then
                    Validate("Object Id", AllObjWithCaption."Object ID");
            end;

        }

        field(12; "Object Caption"; Text[249])
        {
            Caption = 'Object Caption';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(20; "Table No."; Integer)
        {
            Caption = 'Table No.';
            DataClassification = CustomerContent;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));

            trigger OnValidate()
            var
                ConfigMgt: Codeunit "Config. Management";
                FoundPageID: Integer;
            begin
                if "Table No." <> xRec."Table No." then begin
                    "Selected Key Index" := 1;
                    Operation := Operation::Count;
                    ClearTableFilter();
                    FoundPageID := ConfigMgt.FindPage("Table No.");
                    if FoundPageID <> 0 then begin
                        "Object Type" := "Object Type"::Page;
                        Validate("Object Id", FoundPageID);
                    end;
                end;
            end;
        }
        field(21; "Table Name"; Text[250])
        {
            Caption = 'Table Name';
            FieldClass = FlowField;
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Table), "Object ID" = field("Table No.")));
            Editable = false;
        }
        field(22; "Table Filter"; BLOB)
        {
            Caption = 'Table Filter';
        }
        field(23; "Filter Guid"; Guid)
        {
            Caption = 'Filter Guid';
            Editable = false;
        }

        field(24; "Operation"; Option)
        {
            Caption = 'Operation';
            OptionMembers = ,Count,Sum,Average;
            OptionCaption = ' ,Count,Sum,Average';
            DataClassification = CustomerContent;
        }
        field(25; "Field No."; Integer)
        {
            Caption = 'Field No.';
            DataClassification = CustomerContent;
            TableRelation = Field."No." where(TableNo = field("Table No."));
        }
        field(26; "Hide Counter"; Boolean)
        {
            Caption = 'Hide Counter';
            DataClassification = CustomerContent;
        }
        field(27; "Tile Background Colour"; Text[50])
        {
            Caption = 'Tile Background Colour';
            DataClassification = CustomerContent;
        }
        field(28; "Tile Font Colour"; Text[50])
        {
            Caption = 'Tile Font Colour';
            DataClassification = CustomerContent;
        }
        field(29; "Icon SVG Code"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Icon SVG Code';
            TableRelation = "Easy Tile SVG Header";
        }

        field(30; "Low Range Style"; Enum "Cues And KPIs Style")
        {
            Caption = 'Low Range Style', Comment = 'The Style to use if the cue''s value is below Threshold 1';
        }
        field(31; "Threshold 1"; Decimal)
        {
            trigger OnValidate()
            begin
                ValidateThresholds();
            end;
        }
        field(32; "Middle Range Style"; Enum "Cues And KPIs Style")
        {
            Caption = 'Middle Range Style', Comment = 'The Style to use if the cue''s value is between Threshold 1 and Threshold 2';
        }
        field(33; "Threshold 2"; Decimal)
        {

            trigger OnValidate()
            begin
                ValidateThresholds();
            end;
        }
        field(34; "High Range Style"; Enum "Cues And KPIs Style")
        {
            Caption = 'High Range Style', Comment = 'The Style to use if the cue''s value is above Threshold 2';
        }

        field(35; "LR Background Colour"; Text[50])
        {
            Caption = 'Low Range Custom Background Colour';
            DataClassification = CustomerContent;
        }
        field(36; "LR Tile Font Colour"; Text[50])
        {
            Caption = 'Low Range Custom Font Colour';
            DataClassification = CustomerContent;
        }
        field(37; "MR Background Colour"; Text[50])
        {
            Caption = 'Middle Range Custom Background Colour';
            DataClassification = CustomerContent;
        }
        field(38; "MR Tile Font Colour"; Text[50])
        {
            Caption = 'Middle Range Custom Font Colour';
            DataClassification = CustomerContent;
        }
        field(39; "HR Background Colour"; Text[50])
        {
            Caption = 'High Range Custom Background Colour';
            DataClassification = CustomerContent;
        }
        field(40; "HR Tile Font Colour"; Text[50])
        {
            Caption = 'High Range Custom Font Colour';
            DataClassification = CustomerContent;
        }

        field(50; "Selected Key Index"; Integer)
        {
            Caption = 'Selected Key Index';
            DataClassification = CustomerContent;
            TableRelation = "Key"."No." where(TableNo = field("Table No."));
        }
        field(51; "Selected Key"; Text[1024])
        {
            Caption = 'Selected Key';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Key."Key" where(TableNo = field("Table No."), "No." = field("Selected Key Index")));
        }
        field(52; "Field Name"; Text[80])
        {
            Caption = 'Field Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field("Table No."), "No." = field("Field No.")));
        }
        field(53; "Descending Order"; Boolean)
        {
            Caption = 'Descending Order';
            DataClassification = CustomerContent;
        }



    }
    keys
    {
        key(PK; "Tile Group Code", "Tile Position", "User Security Id")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        EasyTileTableFilter: Record "Easy Tile Table Filter";
    begin
        EasyTileTableFilter.SetRange("Filter Id", "Filter Guid");
        EasyTileTableFilter.DeleteAll();
    end;

    procedure SetTableFilter("Filter": Text)
    var
        OutStream: OutStream;
    begin
        "Table Filter".CreateOutStream(OutStream);
        OutStream.Write(Filter);
    end;

    procedure GetTableFilter() Value: Text
    var
        InStream: InStream;
    begin
        CalcFields("Table Filter");
        "Table Filter".CreateInStream(InStream);
        InStream.Read(Value);
    end;

    local procedure ValidateThresholds()
    var
        WrongThresholdsErr: Label '%1 must be greater than %2.', Comment = '%1 Upper threshold %2 Lower threshold';
    begin
        if ("Threshold 2" <= "Threshold 1") and ("Threshold 1" <> 0) then
            Error(
              WrongThresholdsErr,
              FieldCaption("Threshold 2"),
              FieldCaption("Threshold 1"));
    end;

    local procedure ClearTableFilter()
    var
        EasyTileTableFilter: Record "Easy Tile Table Filter";
    begin
        if IsNullGuid("Filter Guid") then
            "Filter Guid" := CreateGuid()
        else begin
            EasyTileTableFilter.SetRange("Filter Id", "Filter Guid");
            EasyTileTableFilter.DeleteAll();
        end;
    end;

    internal procedure SelectKey(): Integer
    var
        "Key": Record "Key";
    begin
        "Key".SetRange(TableNo, Rec."Table No.");
        "Key".SetRange(Enabled, true);

        if Page.RunModal(Page::"Easy Tile Select Key", "Key") = Action::LookupOK then
            exit("Key"."No.")
        else
            exit(Rec."Selected Key Index");
    end;

    internal procedure SelectField(): Integer
    var
        Field: Record Field;
    begin
        Field.SetRange(TableNo, Rec."Table No.");
        Field.SetRange(ObsoleteState, Field.ObsoleteState::No);
        Field.SetFilter(Type, '%1|%2', Field.Type::Integer, Field.Type::Decimal);
        if Page.RunModal(Page::"Fields Lookup", Field) = Action::LookupOK then
            exit(Field."No.")
        else
            exit("Field No.");
    end;
}
