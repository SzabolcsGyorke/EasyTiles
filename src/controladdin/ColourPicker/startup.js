HTMLContainer = document.getElementById("controlAddIn");

update = function(picker)
{
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("ColourChanged",[picker.toRGBString()]);
}

updatepreset = function(button)
{
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("ColourChanged",[button.background]);
}

//HTMLContainer.insertAdjacentHTML('beforeend','<button style="background:#00B7C3" onclick="updatepreset(this)">Primary Colour</button><br>');

//HTMLContainer.insertAdjacentHTML('beforeend','<input id="colourpicker" data-jscolor="{onChange:\'update(this)\', alpha:1.0}">');


HTMLContainer.innerHTML = '<table><tr>'+
                          '<td id = "cp" style="width:300px"><input id="colourpicker" data-jscolor="{onChange:\'update(this)\', alpha:1.0}"></td>'+
                          '<td id="presets">'+
                          '</td></tr></table>';

jscolor.install();

Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("ControlReady",[]);

