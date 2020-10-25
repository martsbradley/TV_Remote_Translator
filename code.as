PSECT text0,class=CODE,local,delta=2

GLOBAL _send_panasonic
SIGNAT _send_panasonic,4201
_send_panasonic
    ; Fred is passed in the W register - assign it
    ; to ?a_rotate_left.
    movlw 0x00
    ; Rotate left. The result is placed in the W register.
    ;rlf PORTA,w

    ;Mixing C and Assembler Code
    ; The return is already in the W register as required.
    return
