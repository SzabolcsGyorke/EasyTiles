HTMLContainer = document.getElementById("controlAddIn");

update = function(picker)
{
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("ColourChanged",[picker.toRGBString()]);
}

HTMLContainer.insertAdjacentHTML('beforeend','<input id="colourpicker" data-jscolor="{onChange:\'update(this)\', alpha:1.0}">');
jscolor.install();

Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("ControlReady",[]);

