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
            begin

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
                    FoundPageID := ConfigMgt.FindPage("Table No.");
                    if FoundPageID <> 0 then begin
                        "Object Type" := "Object Type"::Page;
                        "Object Id" := FoundPageID;
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

        field(23; "Operation"; Option)
        {
            Caption = 'Operation';
            OptionMembers = ,Count,Sum;
            OptionCaption = ' ,Count,Sum';
            DataClassification = CustomerContent;
        }
        field(24; "Field No."; Integer)
        {
            Caption = 'Field No.';
            DataClassification = CustomerContent;
            TableRelation = Field."No." where(TableNo = field("Table No."));
        }
        field(25; "Hide Counter"; Boolean)
        {
            Caption = 'Hide Counter';
            DataClassification = CustomerContent;
        }
        field(26; "Tile Background Colour"; Text[50])
        {
            Caption = 'Tile Background Colour';
            DataClassification = CustomerContent;
        }
        field(27; "Tile Font Colour"; Text[50])
        {
            Caption = 'Tile Font Colour';
            DataClassification = CustomerContent;
        }
        field(28; "Icon SVG Code"; Code[100])
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

    }
    keys
    {
        key(PK; "Tile Group Code", "Tile Position", "User Security Id")
        {
            Clustered = true;
        }
    }


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
        if "Threshold 2" <= "Threshold 1" then
            Error(
              WrongThresholdsErr,
              FieldCaption("Threshold 2"),
              FieldCaption("Threshold 1"));
    end;
}
