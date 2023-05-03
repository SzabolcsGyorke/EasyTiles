table 80107 "Easy Tile SVG Tag"
{
    Caption = 'Easy Tile SVG Tag';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Code"; Code[100])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Selected; Boolean)
        {
            Caption = 'Selected';
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
}
