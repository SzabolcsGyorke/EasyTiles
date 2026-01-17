var timerObject;

Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnControlAddinReady');

function StartTimer(milliSeconds) {
    //window.alert('Timer Started')
    timerObject = window.setInterval(TimerAction, milliSeconds);
}



function StopTimer() {
    //window.alert('Timer Stopped');
    clearInterval(timerObject);
}

// function TimerAction() {
//     Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnTimer');
// }


function TimerAction() {
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
        "OnTimer",
        null,
        true,
        () => {
            DoNothing();
        },
        () => { /* error handling and perhaps retrying */ });
}

function DoNothing()
{}