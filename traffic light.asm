.MODEL SMALL
.STACK 100H

.DATA

RED_MSG     DB 'RED LIGHT - STOP!$'
YELLOW_MSG  DB 'YELLOW LIGHT - WAIT!$'
GREEN_MSG   DB 'GREEN LIGHT - GO!$'

.CODE

MAIN PROC

    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

START:

    ; Clear screen
    CALL CLEAR_SCREEN

    ; ==========================
    ; RED LIGHT
    ; ==========================

    ; Set text color RED
    MOV BL, 04H
    CALL SET_COLOR

    ; Print message
    LEA DX, RED_MSG
    CALL PRINT_STRING

    ; Delay 30 sec
    MOV CX, 30
    CALL DELAY_SECONDS

    ; ==========================
    ; YELLOW LIGHT
    ; ==========================

    CALL CLEAR_SCREEN

    ; Set text color YELLOW
    MOV BL, 0EH
    CALL SET_COLOR

    ; Print message
    LEA DX, YELLOW_MSG
    CALL PRINT_STRING

    ; Delay 5 sec
    MOV CX, 5
    CALL DELAY_SECONDS

    ; ==========================
    ; GREEN LIGHT
    ; ==========================

    CALL CLEAR_SCREEN

    ; Set text color GREEN
    MOV BL, 02H
    CALL SET_COLOR

    ; Print message
    LEA DX, GREEN_MSG
    CALL PRINT_STRING

    ; Delay 15 sec
    MOV CX, 15
    CALL DELAY_SECONDS

    ; Repeat forever
    JMP START

MAIN ENDP


; ==========================================
; PRINT STRING
; DX = address of string
; ==========================================

PRINT_STRING PROC

    MOV AH, 09H
    INT 21H

    RET

PRINT_STRING ENDP


; ==========================================
; SET TEXT COLOR
; BL = color
; ==========================================

SET_COLOR PROC

    MOV AH, 09H
    MOV AL, ' '        ; Character
    MOV BH, 00H        ; Page number
    MOV CX, 1
    INT 10H

    RET

SET_COLOR ENDP


; ==========================================
; CLEAR SCREEN
; ==========================================

CLEAR_SCREEN PROC

    MOV AX, 0003H
    INT 10H

    RET

CLEAR_SCREEN ENDP


; ==========================================
; DELAY PROCEDURE
; CX = number of seconds
; ==========================================

DELAY_SECONDS PROC

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV BX, CX

WAIT_LOOP:

    MOV AH, 86H

    ; 1 second delay
    ; 1000000 microseconds = 000F4240h

    MOV CX, 000FH
    MOV DX, 4240H

    INT 15H

    DEC BX
    JNZ WAIT_LOOP

    POP DX
    POP CX
    POP BX
    POP AX

    RET

DELAY_SECONDS ENDP

END MAIN