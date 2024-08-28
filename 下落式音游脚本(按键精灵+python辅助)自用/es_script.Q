[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=e1ada62f-aae0-411a-987f-1942a646b9ff
Description=2thread2
Enable=1
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
//延迟设置
Const DELAY_SHORT = 20
Const DELAY_LONG = 50
Const MOVE_STEP = 5
Const MOVE_DELAY = 2

i = 0
//启动cover层
start_cover 

//双线程,分别识别一半的区域
BeginThread thread1
BeginThread thread2


Sub thread1
    Do While i = 0
        Call ProcessColor(77, 384, 777, 831, Array("07B6FF", "FAAC56", "8EBCF2", "761DF7", "1F5CF7"), Array(Array(83, 389, 171, 471), Array(239, 569, 319, 660), Array(440, 694, 528, 781), Array(674, 739, 760, 821)),Array(Array(131, 435), Array(279, 620), Array(484, 745), Array(718, 786)))
    Loop
End Sub

Sub thread2
    Do While i = 0
        Call ProcessColor(875, 382, 1351, 837,Array("07B6FF", "FAAC56", "8EBCF2", "761DF7", "1F5CF7"),Array(Array(908, 697, 997, 778), Array(1117, 575, 1201, 655), Array(1265, 386, 1348, 470)),Array(Array(954, 744), Array(1159, 619), Array(1302, 436)))
    Loop
End Sub

//分别对应:识别区域,识别颜色,多个点击域的范围,多个点击域对应的点击坐标
Sub ProcessColor(x1, y1, x2, y2, colors, list1, list2)
    On Error Resume Next
    For Each color In colors
        FindColorEx x1, y1, x2, y2, color, 0, 0.4, x, y
        If x > 0 And y > 0 Then
            Delay DELAY_LONG
            //坐标映射
            For j = 0 To UBound(list1)
                If x >= list1(j)(0) And x <= list1(j)(2) And y >= list1(j)(1) And y <= list1(j)(3) Then
                    x = list2(j)(0)
                    y = list2(j)(1)
                    Exit For
                End If
            Next

            MoveTo x, y
            HandleColorAction color, x, y
            Delay DELAY_SHORT
        End If
    Next
End Sub

//处理左右滑动
Sub HandleColorAction(color, x, y)
    Select Case color
        Case "761DF7"
            Call move2l(x, y)
        Case "1F5CF7"
            Call move2r(x, y)
        Case Else
            LeftClick 1
    End Select
End Sub

//鼠标左滑
Function move2l(x, y)
    MoveTo x, y
    LeftDown 1
    Delay 30
    For i = 1 To 10
        x = x - MOVE_STEP
        MoveTo x, y
        Delay MOVE_DELAY
    Next
    LeftUp 1
    Delay 30
End Function

//鼠标右滑
Function move2r(x, y)
    MoveTo x, y
    LeftDown 1
    Delay 30
    For i = 1 To 10
        x = x + MOVE_STEP
        MoveTo x, y
        Delay MOVE_DELAY
    Next
    LeftUp 1
    Delay 30
End Function

//启动遮罩图层
Sub start_cover()
	Set WshShell = CreateObject("WScript.Shell")

//指定 Python 脚本所在的目录
pythonScriptDirectory = "E:\code\es\pythonProject1\"

//指定 Python 脚本的名称
pythonScriptFile = "cover.py"

command = "cmd.exe /K cd /D " & pythonScriptDirectory & " && python " & pythonScriptFile

WshShell.Run command, 0, False
End Sub
