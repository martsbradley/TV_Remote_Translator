void sleep_microprocessor_sleep(){
#asm
    sleep;
#endasm
}


void send_panasonic(void){

#asm
#include <caspic.h>
GLOBAL _txOEMDevice1, _txOEMDevice2, _txDevice, _txSubDevice, _txCommand, _txCheck, _databyte



call	Send2Panasonic
                return

;  T = 440us
;  Preamble is flash for 10T, off for 4T then deliver the signal
;  0 = 1T off for 3T
;  1 = 1T off for 1T


Send2Panasonic
                ; VERY IMPORTANT TO SELECT BANK 0.

                movlw   130
                movwf   _Delay_Count2
CarrierLoopSynPulse
                ;  On for 8 Periods of 440

                ;(440*8)= 3520
                ; 3520/25=140.8

                                                        ;
                bsf     RB4_bit
                movlw   3                               ;
                movwf   _Delay_Count                     ;
                decfsz  _Delay_Count, F                  ;
                goto    $-1
                goto    $+1                             ;
                                                        ;
                bcf	RB4_bit
                movlw	3
                movwf 	_Delay_Count
                decfsz 	_Delay_Count, F
                goto 	$-1             		; LED off for 13us
                decfsz	_Delay_Count2, F			; + 1us
                goto	CarrierLoopSynPulse 	        ; + 2us

                ; Now off for 4 cycles of 440
			;1758 cycles
                movlw	0x5F
                movwf	_Delay_Count
                movlw	0x02
                movwf	_Delay_Count2
Delay_0_PRELUDE
                decfsz	_Delay_Count, f
                goto	$+2 
                decfsz	_Delay_Count2, f
                goto	Delay_0_PRELUDE

			;2 cycles
                goto	$+1

                bcf RP0_bit
                bcf RP1_bit   
                movf   _txOEMDevice1, w
                movwf   _databyte
                call    BytesAway

                bcf RP0_bit
                bcf RP1_bit
                movf   _txOEMDevice2,w
                movwf   _databyte
                call    BytesAway

                bcf RP0_bit
                bcf RP1_bit
                movf   _txDevice,w
                movwf   _databyte
                call    BytesAway

                bcf RP0_bit
                bcf RP1_bit
                movf   _txSubDevice,w
                movwf   _databyte
                call    BytesAway

                bcf RP0_bit
                bcf RP1_bit
                movf   _txCommand,w
                movwf   _databyte
                call    BytesAway

                bcf RP0_bit
                bcf RP1_bit
                movf   _txCheck,w
                movwf   _databyte
                call    BytesAway

                ; send final zero
                call 	SendOne
                return
BytesAway

                ; SEND DATA
                ; Shift Out _databyte from LSB to MSB
                    ; bit 0
                rrf     _databyte, F				; Shift out LSB.. C = LSB
                btfss	CARRY_bit				; if bit is 1, skip next instr.
                call 	SendZero				; bit is 0, send a zero
                btfsc	CARRY_bit				; NOTE!!
                call	SendOne					; bit is 1, send a one


                    ; bit 1
                rrf     _databyte, F				; Shift out LSB.. C = LSB
                btfss	CARRY_bit				; if bit is 1, skip next instr.
                call 	SendZero				; bit is 0, send a zero
                btfsc	CARRY_bit				; NOTE!!
                call	SendOne					; bit is 1, send a one

                    ; bit 2
                rrf     _databyte, F				; Shift out LSB.. C = LSB
                btfss	CARRY_bit				; if bit is 1, skip next instr.
                call 	SendZero				; bit is 0, send a zero
                btfsc	CARRY_bit				; NOTE!!
                call	SendOne					; bit is 1, send a one

                    ; bit 3
                rrf     _databyte, F				; Shift out LSB.. C = LSB
                btfss	CARRY_bit				; if bit is 1, skip next instr.
                call 	SendZero				; bit is 0, send a zero
                btfsc	CARRY_bit				; NOTE!!
                call	SendOne					; bit is 1, send a one

                    ; bit 4
                rrf     _databyte, F				; Shift out LSB.. C = LSB
                btfss	CARRY_bit				; if bit is 1, skip next instr.
                call 	SendZero				; bit is 0, send a zero
                btfsc	CARRY_bit				; NOTE!!
                call	SendOne					; bit is 1, send a one

                    ; bit 5
                rrf     _databyte, F				; Shift out LSB.. C = LSB
                btfss	CARRY_bit				; if bit is 1, skip next instr.
                call 	SendZero				; bit is 0, send a zero
                btfsc	CARRY_bit				; NOTE!!
                call	SendOne					; bit is 1, send a one

                    ; bit 6
                rrf     _databyte, F				; Shift out LSB.. C = LSB
                btfss	CARRY_bit				; if bit is 1, skip next instr.
                call 	SendZero				; bit is 0, send a zero
                btfsc	CARRY_bit				; NOTE!!
                call	SendOne					; bit is 1, send a one

                    ; bit 7
                rrf     _databyte, F				; Shift out LSB.. C = LSB
                btfss	CARRY_bit				; if bit is 1, skip next instr.
                call 	SendZero				; bit is 0, send a zero
                btfsc	CARRY_bit				; NOTE!!
                call	SendOne					; bit is 1, send a one
                return

SendOne
                ; On for 440us and then off for 440*3us
                movlw   16
                movwf   _Delay_Count2
CarrierLoopForOne
                bsf     RB4_bit
                movlw   3                            ; 1us
                movwf   _Delay_Count                     ; 1us
                decfsz  _Delay_Count, F                  ; 1us 1us 1us
                goto    $-1
                goto    $+1
                                                        ; LED on for 10us
                bcf	RB4_bit
                movlw	3
                movwf 	_Delay_Count
                decfsz 	_Delay_Count, F
                goto 	$-1             		; LED off for 13us
                decfsz	_Delay_Count2, F			; + 1us
                goto	CarrierLoopForOne 	        ; + 2us

                ; Off for 440*3us

			;1318 cycles
                movlw	0x07
                movwf	_Delay_Count
                movlw	0x02
                movwf	_Delay_Count2
Delay_Off
                decfsz	_Delay_Count, f
                goto	$+2
                decfsz	_Delay_Count2, f
                goto	Delay_Off

			;2 cycles
                goto	$+1
                return

SendZero
                ; On for 440us and then off for 440
                movlw   16
                movwf   _Delay_Count2
CarrierLoopForOff
                bsf     RB4_bit
                movlw   3                           ; 1us
                movwf   _Delay_Count                     ; 1us
                decfsz  _Delay_Count, F                  ; 1us 1us 1us
                goto    $-1
                goto    $+1
                                                        ; LED on for 10us
                bcf	RB4_bit
                movlw	3
                movwf 	_Delay_Count
                decfsz 	_Delay_Count, F
                goto 	$-1             		; LED off for 13us
                decfsz	_Delay_Count2, F			; + 1us
                goto	CarrierLoopForOff 	        ; + 2us

                ; Off for 440*us
                movlw	0x92
                movwf	_Delay_Count
Delay_Off2
                decfsz	_Delay_Count , f
                goto	Delay_Off2
			;1 cycle
                nop
                return

#endasm

}