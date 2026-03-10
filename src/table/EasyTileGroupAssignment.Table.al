table 80103 "Easy Tile Group Assignment"
{
    Caption = 'Easy Tile Group Assignment';
    DataClassification = ToBeClassified;
    LookupPageId = "Easy Tile Group Assignments";
    DataCaptionFields = "Profile ID", "User Name";
    fields
    {
        field(1; "Profile ID"; Code[30])
        {
            Caption = 'Profile ID';
            DataClassification = CustomerContent;
            TableRelation = "All Profile"."Profile ID";
        }
        field(2; "User Security Id"; Guid)
        {
            Caption = 'User Security Id';
            DataClassification = EndUserPseudonymousIdentifiers;
            TableRelation = User."User Security ID";
        }
        field(3; "User Name"; Code[50])
        {
            Caption = 'User Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(User."User Name" where("User Security ID" = field("User Security Id")));
        }

        field(10; "Main Group"; Code[20])
        {
            Caption = 'Main Group';
            DataClassification = CustomerContent;
            TableRelation = "Easy Tile Group";
        }
        field(11; "Group 1"; Code[20])
        {
            Caption = 'Group 1';
            DataClassification = CustomerContent;
            TableRelation = "Easy Tile Group";
        }
        field(12; "Group 2"; Code[20])
        {
            Caption = 'Group 2';
            DataClassification = CustomerContent;
            TableRelation = "Easy Tile Group";
        }
        field(13; "Group 3"; Code[20])
        {
            Caption = 'Group 3';
            DataClassification = CustomerContent;
            TableRelation = "Easy Tile Group";
        }
        field(14; "Group 4"; Code[20])
        {
            Caption = 'Group 4';
            DataClassification = CustomerContent;
            TableRelation = "Easy Tile Group";
        }
        field(15; "Group 5"; Code[20])
        {
            Caption = 'Group 5';
            DataClassification = CustomerContent;
            TableRelation = "Easy Tile Group";
        }
        field(16; "Group 6"; Code[20])
        {
            Caption = 'Group 6';
            DataClassification = CustomerContent;
            TableRelation = "Easy Tile Group";
        }
        field(17; "Group 7"; Code[20])
        {
            Caption = 'Group 7';
            DataClassification = CustomerContent;
            TableRelation = "Easy Tile Group";
        }
        field(18; "Group 8"; Code[20])
        {
            Caption = 'Group 8';
            DataClassification = CustomerContent;
            TableRelation = "Easy Tile Group";
        }
        field(19; "Group 9"; Code[20])
        {
            Caption = 'Group 9';
            DataClassification = CustomerContent;
            TableRelation = "Easy Tile Group";
        }
    }
    keys
    {
        key(PK; "Profile ID", "User Security Id")
        {
            Clustered = true;
        }
    }

}
