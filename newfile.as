#include <aspic.h>

GLOBAL _send_panasonic
SIGNAT _send_panasonic,4217

psect mytext,local,class=CODE,delta=2
_send_panasonic:
    ; W is loaded by the calling function;
    ;BANKSEL     (PORTB)    ; select the bank of this object
    ;ADDWF       BANKMASK(PORTB),w
    ; add parameter to port
    ; the result is already in the required location (W)so we can
    ; just return immediately

    movlw    0xfe;
    RETURN

