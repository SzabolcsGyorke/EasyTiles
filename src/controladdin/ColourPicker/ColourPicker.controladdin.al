controladdin "ColourPicker"
{
    StartupScript = 'src/controladdin/ColourPicker/startup.js';
    Scripts = 'src/controladdin/ColourPicker/jscolor.js', 'src/controladdin/ColourPicker/script.js';
    HorizontalStretch = true;
    VerticalStretch = true;
    RequestedHeight = 150;
    event ControlReady();
    event ColourChanged(ColourCode: Text);
    procedure ShowColourPicker(initcolour: Text);
}