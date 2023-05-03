controladdin "SVGPreview"
{
    StartupScript = 'src/controladdin/SVGPreview/startup.js';
    Scripts = 'src/controladdin/SVGPreview/script.js';
    HorizontalStretch = true;
    VerticalStretch = true;
    RequestedHeight = 100;
    RequestedWidth = 100;
    event ControlReady();

    procedure ShowSvg(svgdefinition: Text);
    procedure svgDefToPng(svgUrl: text; code: Text);
    event svgUrlToPngCallback(callback: Text; code: Text);
}