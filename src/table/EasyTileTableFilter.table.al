
table 80108 "Easy Tile Table Filter"
{
    Caption = 'Table Filter';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Filter Id"; Guid)
        {
            Caption = 'Filter Id';
            DataClassification = CustomerContent;
        }

        field(2; "Table Number"; Integer)
        {
            Caption = 'Table Number';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Table Name"; Text[30])
        {
            Caption = 'Table Name';
        }
        field(5; "Field Number"; Integer)
        {
            Caption = 'Field Number';
            TableRelation = Field."No." where(TableNo = field("Table Number"));

            trigger OnValidate()
            var
                "Field": Record "Field";
                TypeHelper: Codeunit "Type Helper";
            begin
                if xRec."Field Number" = "Field Number" then
                    exit;

                Field.Get("Table Number", "Field Number");
                TypeHelper.TestFieldIsNotObsolete(Field);
                CheckDuplicateField(Field, "Filter Id");

                "Field Caption" := Field."Field Caption";
                "Field Filter" := '';
            end;
        }
        field(6; "Field Name"; Text[30])
        {
            Caption = 'Field Name';
        }
        field(7; "Field Caption"; Text[80])
        {
            Caption = 'Field Caption';
        }
        field(8; "Field Filter"; Text[1024])
        {
            Caption = 'Field Filter';


            trigger OnValidate()
            begin
                if "Field Filter" <> '' then
                    TestField("Is Modified", false);
            end;
        }
        field(9; "Filter Table No."; Integer)
        {
            Caption = 'Filter Table No.';
            DataClassification = CustomerContent;
        }
        field(10; "Filter Field No."; Integer)
        {
            Caption = 'Filter Field No.';
            DataClassification = CustomerContent;
        }
        field(11; "Is Modified"; Boolean)
        {
            Caption = 'Is Modified';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField("Field Filter", '');
            end;
        }


    }

    keys
    {
        key(Key1; "Filter Id", "Table Number", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        FilterExistsErr: Label 'The filter for the field %1 %2 already exists.', Comment = 'The filter for the field %1 <Field Number> %2 <Field Name> already exists. Example: The filter for the field 15 Base Unit of Measure already exists.';

    procedure CheckDuplicateField("Field": Record "Field"; FilterGuid: guid)
    var
        TableFilter: Record "Easy Tile Table Filter";
    begin
        TableFilter.Copy(Rec);
        Reset();
        SetRange("Filter Id", FilterGuid);
        SetRange("Table Number", Field.TableNo);
        SetRange("Field Number", Field."No.");
        SetFilter("Line No.", '<>%1', "Line No.");
        if not IsEmpty() then
            Error(FilterExistsErr, Field."No.", Field."Field Caption");
        Copy(TableFilter);
    end;
}

