function ShowColourPicker(initcolour){
    document.getElementById('colourpicker').jscolor.fromString(initcolour);
    document.getElementById('colourpicker').jscolor.show();
}

function addPreset(buttonName, hexcolourcode ,rgbcolourcode)
{
    debugger;
    var placeholder = document.getElementById('presets');

    var button = document.createElement('button');

    button.textContent = buttonName;
    button.style.backgroundColor = hexcolourcode;
    button.style.height = '40px';
    button.style.width = '60px';

    button.onclick = function() {
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('PresetCalled', [rgbcolourcode]);
    }

    placeholder.appendChild(button);
}