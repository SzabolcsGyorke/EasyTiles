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
                    // CurrPage.ColourPicker.addPreset('Accent', '#00B7C3', 'rgb(0, 183, 195)');
                    // CurrPage.ColourPicker.addPreset('Strong', '#212121', 'rgb(33, 33, 33)');
                    // CurrPage.ColourPicker.addPreset('Favorable', '#35AB22', 'rgb(53, 171, 34)');
                    // CurrPage.ColourPicker.addPreset('Ambiguous', '#9F9700', 'rgb(159, 151, 0)');
                    // CurrPage.ColourPicker.addPreset('Attention', '#EB6965', 'rgb(235, 105, 101)');
                    // CurrPage.ColourPicker.addPreset('Subordinate', '#A7ADB6', 'rgb(167, 173, 182)');

                    CurrPage.ColourPicker.addPreset('', '#00B7C3', 'rgb(0, 183, 195)');
                    CurrPage.ColourPicker.addPreset('', '#212121', 'rgb(33, 33, 33)');
                    CurrPage.ColourPicker.addPreset('', '#35AB22', 'rgb(53, 171, 34)');
                    CurrPage.ColourPicker.addPreset('', '#9F9700', 'rgb(159, 151, 0)');
                    CurrPage.ColourPicker.addPreset('', '#EB6965', 'rgb(235, 105, 101)');
                    CurrPage.ColourPicker.addPreset('', '#A7ADB6', 'rgb(167, 173, 182)');
                    CurrPage.ColourPicker.addPreset('', '#C9C472', 'rgb(201, 196, 114)');
                    CurrPage.ColourPicker.addPreset('', '#88CE81', 'rgb(136, 206, 129)');
                    CurrPage.ColourPicker.addPreset('', '#E97768', 'rgb(233, 119, 104)');
                    CurrPage.ColourPicker.addPreset('', '#75B5E7', 'rgb(117, 181, 231)');
                    CurrPage.ColourPicker.addPreset('', '#59CCB4', 'rgb(89, 204, 180)');
                    CurrPage.ColourPicker.addPreset('', '#75D8E7', 'rgb(117, 216, 231)');
                    CurrPage.ColourPicker.addPreset('', '#EEEA86', 'rgb(238, 234, 134)');
                    CurrPage.ColourPicker.addPreset('', '#E89E63', 'rgb(232, 158, 99)');
                    CurrPage.ColourPicker.addPreset('', '#DBBDEB', 'rgb(219, 189, 235)');
                    CurrPage.ColourPicker.addPreset('', '#39B294', 'rgb(57, 178, 148)');
                    CurrPage.ColourPicker.addPreset('', '#73BA5A', 'rgb(115, 186, 90)');
                    CurrPage.ColourPicker.addPreset('', '#E65E6D', 'rgb(230, 94, 109)');
                    CurrPage.ColourPicker.addPreset('', '#008489', 'rgb(0, 132, 137)');

                    CurrPage.ColourPicker.ShowColourPicker(InColour);
                end;

                trigger ColourChanged(ColourCode: Text)
                begin
                    ColourChanged := ColourCode <> InColour;
                    OutColour := ColourCode;
                end;

                trigger PresetCalled(ColourCode: Text)
                begin
                    ColourChanged := ColourCode <> InColour;
                    OutColour := ColourCode;
                    CurrPage.Close();
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
