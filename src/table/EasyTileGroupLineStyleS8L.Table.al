table 80109 "Easy Tile Group Line Style S8L"
{
    Caption = 'Easy Tile Group Line Style S8L';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Tile Group Code"; Code[20])
        {
            Caption = 'Tile Group Code';
            TableRelation = "Easy Tile Group";
        }
        field(2; "Tile Position"; Integer)
        {
            Caption = 'Tile Position';
        }
        field(3; "User Security Id"; Guid)
        {
            Caption = 'User Security Id';
            TableRelation = User."User Security ID";
            ValidateTableRelation = false;
        }
        field(4; "Value"; Decimal)
        {
            Caption = 'Value';
            InitValue = 0;
        }
        field(5; "Tile Background Colour"; Text[50])
        {
            Caption = 'Tile Background Colour';
        }
        field(6; "Tile Font Colour"; Text[50])
        {
            Caption = 'Tile Font Colour';
        }
        field(7; "Tile Style"; Enum "Cues And KPIs Style")
        {
            Caption = 'Tile Style';
        }
        field(8; "Icon SVG Code"; Code[100])
        {
            Caption = 'Icon SVG Code';
            TableRelation = "Easy Tile SVG Header";
        }
    }
    keys
    {
        key(PK; "Tile Group Code", "Tile Position", "User Security Id", "Value")
        {
            Clustered = true;
        }
    }
}
