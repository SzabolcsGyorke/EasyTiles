page 80108 "Easy Tile colour Picker"
{
    ApplicationArea = All;
    Caption = 'Easy Tile colour Picker';
    PageType = StandardDialog;
    layout
    {
        area(Content)
        {
            usercontrol(ColourPicker; ColourPicker)
            {
                trigger ControlReady()
                begin
                    CurrPage.ColourPicker.ShowColourPicker(InColour);
                end;

                trigger ColourChanged(ColourCode: Text)
                begin
                    ColourChanged := ColourCode <> InColour;
                    OutColour := ColourCode;
                end;
            }
        }
    }
    var
        InColour: Text;
        OutColour: Text;
        ColourChanged: Boolean;

    procedure InitColour(_InColour: Text)
    begin
        InColour := _InColour;
    end;

    procedure GetColour(): Text
    begin
        exit(OutColour);
    end;

    procedure IsColourChanged(): Boolean
    begin
        exit(ColourChanged);
    end;
}
