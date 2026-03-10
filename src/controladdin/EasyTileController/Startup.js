window.__controlAddInError__NAV = window.__controlAddInError;
window.__controlAddInError = function (e) {
    console.error("BC Add-in Error: " + e.message + " - Stack: " + e.stack);
    window.__controlAddInError__NAV(e);
};

InitializeControl('controlAddIn');

Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlAddInReady', null);