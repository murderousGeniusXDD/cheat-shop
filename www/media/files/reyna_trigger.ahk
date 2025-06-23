#NoEnv
#Persistent
#MaxThreadsPerHotkey 2
#KeyHistory 0
ListLines Off
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
CoordMode, Pixel, Screen

;HOTKEYS
key_hold_mode := "Home"    ; Горячая клавиша для активации
key_exit := "End"          ; Горячая клавиша для завершения
key_hold := "Alt"     ; Клавиша удержания

;SETTINGS
global pixel_box := 3             
global pixel_sens := 60           
global pixel_color := "0xFEFE40"  
global tap_time := 52             

leftbound := A_ScreenWidth / 2 - pixel_box
rightbound := A_ScreenWidth / 2 + pixel_box
topbound := A_ScreenHeight / 2 - pixel_box
bottombound := A_ScreenHeight / 2 + pixel_box

; Назначение горячих клавиш
hotkey, %key_hold_mode%, holdmode_on
hotkey, %key_exit%, terminate
return

start:
SoundBeep, 500, 1000
return

terminate:
SoundPlay off
SoundBeep, 500, 500
Sleep 400
exitapp
return

holdmode_on:
SoundPlay, *64 ; Звук для обозначения активации
setTimer, loop2, 10 ; Запускаем таймер с задержкой
return

loop2:
if (GetKeyState(key_hold, "P")) ; Проверка удержания клавиши XButton2
{
    PixelSearch_Debug()
}
return

PixelSearch_Debug() {
    global pixel_box, pixel_sens, pixel_color, tap_time
    global FoundX, FoundY, leftbound, topbound, rightbound, bottombound

    ; Поиск пикселя в области
    PixelSearch, FoundX, FoundY, leftbound, topbound, rightbound, bottombound, pixel_color, pixel_sens, Fast RGB

    if !(ErrorLevel)
    {
        if !GetKeyState("LButton") ; Проверяем состояние левой кнопки
        {
            SendInput "{Ctrl DownTemp}" ; Нажимаем Ctrl на минимальное время
            Sleep 10 ; Краткая задержка
            SendInput "{Ctrl Up}" ; Отпускаем Ctrl
            SimulateMouseClick() ; Симуляция клика
            SendInput "y" ; Нажимаем клавишу Y
        }
    }
    Sleep 50 ; Задержка для стабильности
    return
}

SimulateMouseClick() {
    ; Используем PostMessage для отправки сообщения о нажатии и отпускании левой кнопки мыши
    WinGet, hwnd, ID, A  ; Получаем ID активного окна
    ; Нажатие левой кнопки мыши
    PostMessage, 0x201, 0x0001, 0,, ahk_id %hwnd%
    ; Отпускание левой кнопки мыши
    PostMessage, 0x202, 0x0000, 0,, ahk_id %hwnd%
}