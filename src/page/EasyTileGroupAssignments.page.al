page 80102 "Easy Tile Group Assignments"
{
    ApplicationArea = All;
    Caption = 'Easy Tile Group Assignments';
    PageType = Card;
    SourceTable = "Easy Tile Group Assignment";
    UsageCategory = Administration;
    DataCaptionFields = "Profile ID";
    layout
    {
        area(content)
        {
            Group(General)
            {
                field("Profile ID"; Rec."Profile ID")
                {
                    ToolTip = 'Specifies the value of the Profile ID field.';
                    Visible = true;
                }
                field("User Name"; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the User Name field.';
                    AssistEdit = true;
                    trigger OnAssistEdit()
                    var
                        User: Record User;
                    begin
                        if page.RunModal(Page::Users, User) = Action::LookupOK then
                            Rec."User Security Id" := User."User Security ID";

                        CurrPage.Update();
                    end;
                }
                field("User Security Id"; Rec."User Security Id")
                {
                    ToolTip = 'Specifies the value of the User Security Id field.';
                    Visible = false;
                }

                field("Main Group"; Rec."Main Group")
                {
                    ToolTip = 'Specifies the value of the Main Group field.';
                }
                field("Group 1"; Rec."Group 1")
                {
                    ToolTip = 'Specifies the value of the Group 1 field.';
                }
                field("Group 2"; Rec."Group 2")
                {
                    ToolTip = 'Specifies the value of the Group 2 field.';
                }
                field("Group 3"; Rec."Group 3")
                {
                    ToolTip = 'Specifies the value of the Group 3 field.';
                }
                field("Group 4"; Rec."Group 4")
                {
                    ToolTip = 'Specifies the value of the Group 4 field.';
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSettings: SessionSettings;
    begin
        Rec."User Security Id" := UserSecurityId();
        Rec."Profile ID" := UserSettings.ProfileId();
    end;
}
