tableextension 80100 "XML Buffer ET" extends "XML Buffer"
{
    fields
    {
        field(80100; "Long Value ET"; Text[2048])
        {
            Caption = 'Long Value';
            DataClassification = CustomerContent;
        }
        field(80101; "Long Value Used ET"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Long Value Used';
        }
    }
}
