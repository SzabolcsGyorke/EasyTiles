table 80100 "Easy Tile Buffer"
{
    Caption = 'Easy Tile Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Tile Group Position"; Integer)
        {
            Caption = 'Tile Group Filter';
            DataClassification = CustomerContent;
            TableRelation = "Easy Tile Group";
        }

        field(2; "Edit Mode"; Boolean)
        {
            Caption = 'Edit Mode Filter';
            DataClassification = CustomerContent;
        }
        field(3; "Tile Group Code"; Code[20])
        {
            Caption = 'Tile Group Code';
            DataClassification = CustomerContent;
            TableRelation = "Easy Tile Group";
        }
        field(4; "No. of Tiles"; Integer)
        {
            Caption = 'No. of Tiles';
            DataClassification = CustomerContent;
        }
        field(5; "Preview Mode"; Boolean)
        {
            Caption = 'Preview Mode';
            DataClassification = CustomerContent;
        }

        field(6; "Group 1 Caption"; Text[100])
        {
            Caption = 'Group 1 Caption';
            DataClassification = CustomerContent;
        }
        field(7; "Group 2 Caption"; Text[100])
        {
            Caption = 'Group 2 Caption';
            DataClassification = CustomerContent;
        }
        field(8; "Group 3 Caption"; Text[100])
        {
            Caption = 'Group 3 Caption';
            DataClassification = CustomerContent;
        }
        field(9; "Group 4 Caption"; Text[100])
        {
            Caption = 'Group 4 Caption';
            DataClassification = CustomerContent;
        }

        field(10; "Position 1"; Integer) { Caption = 'Postiion 1'; DataClassification = CustomerContent; }
        field(11; "Position 2"; Integer) { Caption = 'Postiion 2'; DataClassification = CustomerContent; }
        field(12; "Position 3"; Integer) { Caption = 'Postiion 3'; DataClassification = CustomerContent; }
        field(13; "Position 4"; Integer) { Caption = 'Postiion 4'; DataClassification = CustomerContent; }
        field(14; "Position 5"; Integer) { Caption = 'Postiion 5'; DataClassification = CustomerContent; }
        field(15; "Position 6"; Integer) { Caption = 'Postiion 6'; DataClassification = CustomerContent; }
        field(16; "Position 7"; Integer) { Caption = 'Postiion 7'; DataClassification = CustomerContent; }
        field(17; "Position 8"; Integer) { Caption = 'Postiion 8'; DataClassification = CustomerContent; }
        field(18; "Position 9"; Integer) { Caption = 'Postiion 9'; DataClassification = CustomerContent; }
        field(19; "Position 10"; Integer) { Caption = 'Postiion 10'; DataClassification = CustomerContent; }
        field(20; "Position 11"; Integer) { Caption = 'Postiion 11'; DataClassification = CustomerContent; }
        field(21; "Position 12"; Integer) { Caption = 'Postiion 12'; DataClassification = CustomerContent; }
        field(22; "Position 13"; Integer) { Caption = 'Postiion 13'; DataClassification = CustomerContent; }
        field(23; "Position 14"; Integer) { Caption = 'Postiion 14'; DataClassification = CustomerContent; }
        field(24; "Position 15"; Integer) { Caption = 'Postiion 15'; DataClassification = CustomerContent; }
        field(25; "Position 16"; Integer) { Caption = 'Postiion 16'; DataClassification = CustomerContent; }
        field(26; "Position 17"; Integer) { Caption = 'Postiion 17'; DataClassification = CustomerContent; }
        field(27; "Position 18"; Integer) { Caption = 'Postiion 18'; DataClassification = CustomerContent; }
        field(28; "Position 19"; Integer) { Caption = 'Postiion 19'; DataClassification = CustomerContent; }
        field(29; "Position 20"; Integer) { Caption = 'Postiion 20'; DataClassification = CustomerContent; }


        field(30; "Caption 1"; Text[50]) { Caption = 'Caption 1'; DataClassification = CustomerContent; }
        field(31; "Caption 2"; Text[50]) { Caption = 'Caption 2'; DataClassification = CustomerContent; }
        field(32; "Caption 3"; Text[50]) { Caption = 'Caption 3'; DataClassification = CustomerContent; }
        field(33; "Caption 4"; Text[50]) { Caption = 'Caption 4'; DataClassification = CustomerContent; }
        field(34; "Caption 5"; Text[50]) { Caption = 'Caption 5'; DataClassification = CustomerContent; }
        field(35; "Caption 6"; Text[50]) { Caption = 'Caption 6'; DataClassification = CustomerContent; }
        field(36; "Caption 7"; Text[50]) { Caption = 'Caption 7'; DataClassification = CustomerContent; }
        field(37; "Caption 8"; Text[50]) { Caption = 'Caption 8'; DataClassification = CustomerContent; }
        field(38; "Caption 9"; Text[50]) { Caption = 'Caption 9'; DataClassification = CustomerContent; }
        field(39; "Caption 10"; Text[50]) { Caption = 'Caption 10'; DataClassification = CustomerContent; }
        field(40; "Caption 11"; Text[50]) { Caption = 'Caption 11'; DataClassification = CustomerContent; }
        field(41; "Caption 12"; Text[50]) { Caption = 'Caption 12'; DataClassification = CustomerContent; }
        field(42; "Caption 13"; Text[50]) { Caption = 'Caption 13'; DataClassification = CustomerContent; }
        field(43; "Caption 14"; Text[50]) { Caption = 'Caption 14'; DataClassification = CustomerContent; }
        field(44; "Caption 15"; Text[50]) { Caption = 'Caption 15'; DataClassification = CustomerContent; }
        field(45; "Caption 16"; Text[50]) { Caption = 'Caption 16'; DataClassification = CustomerContent; }
        field(46; "Caption 17"; Text[50]) { Caption = 'Caption 17'; DataClassification = CustomerContent; }
        field(47; "Caption 18"; Text[50]) { Caption = 'Caption 18'; DataClassification = CustomerContent; }
        field(48; "Caption 19"; Text[50]) { Caption = 'Caption 19'; DataClassification = CustomerContent; }
        field(49; "Caption 20"; Text[50]) { Caption = 'Caption 20'; DataClassification = CustomerContent; }

        field(50; "Visible 1"; Boolean) { Caption = 'Visible 1'; DataClassification = CustomerContent; }
        field(51; "Visible 2"; Boolean) { Caption = 'Visible 2'; DataClassification = CustomerContent; }
        field(52; "Visible 3"; Boolean) { Caption = 'Visible 3'; DataClassification = CustomerContent; }
        field(53; "Visible 4"; Boolean) { Caption = 'Visible 4'; DataClassification = CustomerContent; }
        field(54; "Visible 5"; Boolean) { Caption = 'Visible 5'; DataClassification = CustomerContent; }
        field(55; "Visible 6"; Boolean) { Caption = 'Visible 6'; DataClassification = CustomerContent; }
        field(56; "Visible 7"; Boolean) { Caption = 'Visible 7'; DataClassification = CustomerContent; }
        field(57; "Visible 8"; Boolean) { Caption = 'Visible 8'; DataClassification = CustomerContent; }
        field(58; "Visible 9"; Boolean) { Caption = 'Visible 9'; DataClassification = CustomerContent; }
        field(59; "Visible 10"; Boolean) { Caption = 'Visible 10'; DataClassification = CustomerContent; }
        field(60; "Visible 11"; Boolean) { Caption = 'Visible 11'; DataClassification = CustomerContent; }
        field(61; "Visible 12"; Boolean) { Caption = 'Visible 12'; DataClassification = CustomerContent; }
        field(62; "Visible 13"; Boolean) { Caption = 'Visible 13'; DataClassification = CustomerContent; }
        field(63; "Visible 14"; Boolean) { Caption = 'Visible 14'; DataClassification = CustomerContent; }
        field(64; "Visible 15"; Boolean) { Caption = 'Visible 15'; DataClassification = CustomerContent; }
        field(65; "Visible 16"; Boolean) { Caption = 'Visible 16'; DataClassification = CustomerContent; }
        field(66; "Visible 17"; Boolean) { Caption = 'Visible 17'; DataClassification = CustomerContent; }
        field(67; "Visible 18"; Boolean) { Caption = 'Visible 18'; DataClassification = CustomerContent; }
        field(68; "Visible 19"; Boolean) { Caption = 'Visible 19'; DataClassification = CustomerContent; }
        field(69; "Visible 20"; Boolean) { Caption = 'Visible 20'; DataClassification = CustomerContent; }

        field(70; "Style 1"; Text[50]) { Caption = 'Style 1'; DataClassification = CustomerContent; }
        field(71; "Style 2"; Text[50]) { Caption = 'Style 2'; DataClassification = CustomerContent; }
        field(72; "Style 3"; Text[50]) { Caption = 'Style 3'; DataClassification = CustomerContent; }
        field(73; "Style 4"; Text[50]) { Caption = 'Style 4'; DataClassification = CustomerContent; }
        field(74; "Style 5"; Text[50]) { Caption = 'Style 5'; DataClassification = CustomerContent; }
        field(75; "Style 6"; Text[50]) { Caption = 'Style 6'; DataClassification = CustomerContent; }
        field(76; "Style 7"; Text[50]) { Caption = 'Style 7'; DataClassification = CustomerContent; }
        field(77; "Style 8"; Text[50]) { Caption = 'Style 8'; DataClassification = CustomerContent; }
        field(78; "Style 9"; Text[50]) { Caption = 'Style 9'; DataClassification = CustomerContent; }
        field(79; "Style 10"; Text[50]) { Caption = 'Style 10'; DataClassification = CustomerContent; }
        field(80; "Style 11"; Text[50]) { Caption = 'Style 11'; DataClassification = CustomerContent; }
        field(81; "Style 12"; Text[50]) { Caption = 'Style 12'; DataClassification = CustomerContent; }
        field(82; "Style 13"; Text[50]) { Caption = 'Style 13'; DataClassification = CustomerContent; }
        field(83; "Style 14"; Text[50]) { Caption = 'Style 14'; DataClassification = CustomerContent; }
        field(84; "Style 15"; Text[50]) { Caption = 'Style 15'; DataClassification = CustomerContent; }
        field(85; "Style 16"; Text[50]) { Caption = 'Style 16'; DataClassification = CustomerContent; }
        field(86; "Style 17"; Text[50]) { Caption = 'Style 17'; DataClassification = CustomerContent; }
        field(87; "Style 18"; Text[50]) { Caption = 'Style 18'; DataClassification = CustomerContent; }
        field(88; "Style 19"; Text[50]) { Caption = 'Style 19'; DataClassification = CustomerContent; }
        field(89; "Style 20"; Text[50]) { Caption = 'Style 20'; DataClassification = CustomerContent; }

        field(90; "Value 1"; Decimal) { Caption = 'Value 1'; DataClassification = CustomerContent; }
        field(91; "Value 2"; Decimal) { Caption = 'Value 2'; DataClassification = CustomerContent; }
        field(92; "Value 3"; Decimal) { Caption = 'Value 3'; DataClassification = CustomerContent; }
        field(93; "Value 4"; Decimal) { Caption = 'Value 4'; DataClassification = CustomerContent; }
        field(94; "Value 5"; Decimal) { Caption = 'Value 5'; DataClassification = CustomerContent; }
        field(95; "Value 6"; Decimal) { Caption = 'Value 6'; DataClassification = CustomerContent; }
        field(96; "Value 7"; Decimal) { Caption = 'Value 7'; DataClassification = CustomerContent; }
        field(97; "Value 8"; Decimal) { Caption = 'Value 8'; DataClassification = CustomerContent; }
        field(98; "Value 9"; Decimal) { Caption = 'Value 9'; DataClassification = CustomerContent; }
        field(99; "Value 10"; Decimal) { Caption = 'Value 10'; DataClassification = CustomerContent; }
        field(100; "Value 11"; Decimal) { Caption = 'Value 11'; DataClassification = CustomerContent; }
        field(101; "Value 12"; Decimal) { Caption = 'Value 12'; DataClassification = CustomerContent; }
        field(102; "Value 13"; Decimal) { Caption = 'Value 13'; DataClassification = CustomerContent; }
        field(103; "Value 14"; Decimal) { Caption = 'Value 14'; DataClassification = CustomerContent; }
        field(104; "Value 15"; Decimal) { Caption = 'Value 15'; DataClassification = CustomerContent; }
        field(105; "Value 16"; Decimal) { Caption = 'Value 16'; DataClassification = CustomerContent; }
        field(106; "Value 17"; Decimal) { Caption = 'Value 17'; DataClassification = CustomerContent; }
        field(107; "Value 18"; Decimal) { Caption = 'Value 18'; DataClassification = CustomerContent; }
        field(108; "Value 19"; Decimal) { Caption = 'Value 19'; DataClassification = CustomerContent; }
        field(109; "Value 20"; Decimal) { Caption = 'Value 20'; DataClassification = CustomerContent; }




        field(666; "Tile Group Code Filter"; Code[20])
        {
            Caption = 'Tile Group Code Filter';
            FieldClass = FlowFilter;
            TableRelation = "Easy Tile Group";
        }
    }
    keys
    {
        key(PK; "Tile Group Position", "Edit Mode", "Tile Group Code", "Preview Mode")
        {
            Clustered = true;
        }
    }
}
