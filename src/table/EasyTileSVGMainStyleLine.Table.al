table 80106 "Easy Tile SVG Main Style Line"
{
    Caption = 'Easy Tile SVG Main Style Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SVG Header Code"; Code[100])
        {
            Caption = 'SVG Header Code';
            DataClassification = CustomerContent;
            TableRelation = "Easy Tile SVG Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Attribute Type"; Enum "Easy Tile SVG Attribute Type")
        {
            Caption = 'Attribute Type';
            DataClassification = CustomerContent;
        }

        field(4; "Manual Id"; Text[50])
        {
            Caption = 'Manual Id';
            DataClassification = CustomerContent;
        }
        field(5; "Value"; Text[50])
        {
            Caption = 'Value';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "SVG Header Code", "Line No.")
        {
            Clustered = true;
        }
    }
}
