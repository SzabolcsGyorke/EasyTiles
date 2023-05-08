pageextension 80102 "User Settings SG" extends "User Settings"
{
    layout
    {
        addafter(MyNotificationsLbl)
        {
            field(TileGroups; CahmgeTileGroupAssTxt)
            {
                Caption = 'Tiles';
                ApplicationArea = All;
                Editable = false;
                Lookup = false;
                AssistEdit = false;
                DrillDown = true;
                trigger OnDrillDown()
                var
                    EasyTileGroupAssignment: Record "Easy Tile Group Assignment";
                    SessionSettings: SessionSettings;
                begin
                    SessionSettings.Init();
                    if not EasyTileGroupAssignment.Get(SessionSettings.ProfileId, UserSecurityId()) then begin
                        EasyTileGroupAssignment.Init();
                        EasyTileGroupAssignment."User Security Id" := UserSecurityId();
                        EasyTileGroupAssignment."Profile ID" := SessionSettings.ProfileId();
                        EasyTileGroupAssignment.Insert();
                        Commit();
                    end;
                    Page.RunModal(Page::"Easy Tile Group Assignments", EasyTileGroupAssignment);
                end;
            }
        }
    }

    var
        CahmgeTileGroupAssTxt: Label 'Change Easy Tile Group Assignmnets';
}
