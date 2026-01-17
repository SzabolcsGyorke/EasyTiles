controladdin "ColourPicker"
{
    StartupScript = 'src/controladdin/ColourPicker/startup.js';
    Scripts = 'src/controladdin/ColourPicker/jscolor.js', 'src/controladdin/ColourPicker/script.js';
    StyleSheets = 'src/controladdin/ColourPicker/stylesheets.css';
    HorizontalStretch = true;
    VerticalStretch = true;
    RequestedHeight = 350;

    event ControlReady();
    event ColourChanged(ColourCode: Text);
    event PresetCalled(ColourCode: Text);

    procedure ShowColourPicker(initcolour: Text);
    procedure addPreset(buttonName: Text; hexcolourcode: Text; rgbcolourcode: Text);
}