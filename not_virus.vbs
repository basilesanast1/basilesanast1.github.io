Randomize

Set shell = CreateObject("WScript.Shell")

' Get real screen size using WMI
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set colItems = objWMI.ExecQuery("Select * from Win32_VideoController")

For Each objItem in colItems
    screenW = objItem.CurrentHorizontalResolution
    screenH = objItem.CurrentVerticalResolution
    Exit For
Next

' Fallback if detection fails
If screenW = "" Then screenW = 1920
If screenH = "" Then screenH = 1080

messages = Array( _
    "Critical Error: System failure!", _
    "Warning: Memory corruption detected!", _
    "Error: Access denied!", _
    "Fatal exception at 0x00000000", _
    "System32 missing!", _
    "Unknown hardware error!" _
)

Do
    Dim x, y, w, h, msg, cmd

    ' Random size
    w = 200 + Int(200 * Rnd)
    h = 100 + Int(150 * Rnd)

    ' Random position (keeps window fully on screen)
    x = Int((screenW - w) * Rnd)
    y = Int((screenH - h) * Rnd)

    ' Random message
    msg = messages(Int((UBound(messages) + 1) * Rnd))

    cmd = "mshta ""javascript:" & _
          "window.resizeTo(" & w & "," & h & ");" & _
          "window.moveTo(" & x & "," & y & ");" & _
          "alert('" & msg & "');close();"""

    shell.Run cmd, 0, False

    WScript.Sleep 250
Loop