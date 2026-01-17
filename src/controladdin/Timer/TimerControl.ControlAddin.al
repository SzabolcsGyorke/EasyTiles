controladdin TimerControl
{
    RequestedHeight = 1;
    MinimumHeight = 1;
    MaximumHeight = 1;
    RequestedWidth = 1;
    MinimumWidth = 1;
    MaximumWidth = 1;
    HorizontalStretch = true;
    HorizontalShrink = true;
    Scripts =
        'src/controladdin/Timer/timer.js';
    //StyleSheets =
    //    'style.css';
    // StartupScript = 'src/controladdin/Timer/startup.js';
    //RecreateScript = 'recreateScript.js';
    //RefreshScript = 'refreshScript.js';

    event OnControlAddinReady()
    event OnTimer()
    event OnTimerError(errortext: Text)

    procedure StartTimer(milisec: Integer)
    procedure StopTimer()
}