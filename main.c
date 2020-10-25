#define _XTAL_FREQ 4000000
#include <stdio.h>
#include <htc.h>
#include "usart.h"

__CONFIG(LVPDIS & INTCLK & WDTDIS & UNPROTECT & BORDIS & PWRTDIS);

#define bit_set(var,bitno) ((var) |= 1 << (bitno))
#define testbit_on(data,bitno) ((data>>bitno)&0x01)

int Delay_Count;
int Delay_Count2;
#define PHILIPS_IR_US_RESET_DELAY 1850
#define PHILIPS_LOW_MIN     810
#define PHILIPS_LOW_MAX     975
#define PHILIPS_HIGH_MIN    1640
#define PHILIPS_HIGH_MAX    1850
#define PHILIPS_COMMAND_VOLUME_UP       16
#define PHILIPS_COMMAND_VOLUME_DOWN     17
#define PHILIPS_COMMAND_CHANNEL_UP      32
#define PHILIPS_COMMAND_CHANNEL_DOWN    33
#define PHILIPS_COMMAND_MUTE            0x0d
#define PHILIPS_COMMAND_ON_OFF          0x0c
#define PANASONIC_CMD_CHANNEL_UP        0x34
#define PANASONIC_CMD_CHANNEL_DOWN      0x35
#define PANASONIC_CMD_VOLUME_UP         0x20
#define PANASONIC_CMD_VOLUME_DOWN       0x21
#define PANASONIC_CMD_MUTE              0x32
#define PANASONIC_CMD_ON_OFF            0x3d
#define PANASONIC_OEM_DEVICE1           0x02;
#define PANASONIC_OEM_DEVICE2           0x20;
#define PANASONIC_DEVICE                0x80;
#define PANASONIC_SUB_DEVICE            0x00;


volatile unsigned int timer1_overflow = 0;
volatile unsigned int last_capture = 0, this_capture = 0;
volatile long delta = 0;
volatile char printButton = 0;
volatile char fault = 0;
volatile int runningT = 0;
volatile unsigned int currentBit = 0;
volatile unsigned int currentByte = 0;
volatile int bitCounter = 0;
volatile unsigned char txOEMDevice1 = PANASONIC_OEM_DEVICE1;
volatile unsigned char txOEMDevice2 = PANASONIC_OEM_DEVICE2;
volatile unsigned char txDevice     = PANASONIC_DEVICE;
volatile unsigned char txSubDevice  = PANASONIC_SUB_DEVICE;
volatile unsigned char txCommand;
volatile unsigned char txCheck;
volatile unsigned char databyte;

//  These methods are in a separate file as the use asm.
void send_panasonic(void);
void sleep_microprocessor_sleep();

void startTimer1() {
    TMR1H = TMR1L = 0;

    T1CON = 0b00000001;
    //**00****   1 prescale
    //****0***   oscillator off
    //*****0**   This bit is ignored as the internal clock is in use.
    //******0*   Internal clock
    //*******1   Start the timer.
}

void initializeCapturePin1() {
    //  PORT B is used for the capture and for the transmission
    TRISB = 0b11101111;

    CCP1CON = 0x00;
    CCP1CON = 0x04; // falling edge.

    CCP1IE = 1;
    startTimer1();
}

void resetIRCounters() {
    runningT = 0;
    currentBit = 0;
    currentByte = 0;
    bitCounter = 0;
    fault = 0;
}
interrupt handlerRoutine(void) {

    if (TMR1IF == 1) {
        TMR1IF = 0;
        timer1_overflow++;
        if (timer1_overflow > 1){
            resetIRCounters();
        }
    }

    if (CCP1IF == 1) {
        CCP1IF = 0;

        this_capture = CCPR1H;
        this_capture = this_capture << 8;
        this_capture |= CCPR1L;

        if (!timer1_overflow) {
            delta = this_capture - last_capture;
        } else {
            delta = timer1_overflow - 1;
            delta = (delta << 16);
            last_capture = 0 - last_capture;
            delta = delta + last_capture;
            delta = delta + this_capture;
        }

        last_capture = this_capture;
        timer1_overflow = 0;


        if (delta > PHILIPS_IR_US_RESET_DELAY) {
            resetIRCounters();
            CCP1CON = 0x00;
            CCP1CON = 0x04; // now capture falling
            return;
        }

        if (testbit_on(CCP1CON, 0)) {
            CCP1CON = 0x00;
            CCP1CON = 0x04; // now capture falling
        } else {
            CCP1CON = 0x00;
            CCP1CON = 0x05; // now capture rising
        }

        int t = delta;
        if (delta > PHILIPS_LOW_MIN && delta < PHILIPS_LOW_MAX) {
            t = 1;
        }
        else if (delta > PHILIPS_HIGH_MIN && delta <= PHILIPS_HIGH_MAX) {
                t = 2;
        }
        else {
                fault = 1;
                return;
        }

        runningT += t;

        if (runningT%2 == 0) {
            if (t == 2) {
                currentBit = ~currentBit;
            }
            currentByte = currentByte << 1;
            currentByte |= (0x01 & currentBit);
            ++bitCounter;
        }

        if (bitCounter == 13) {
            printButton = 1;
            return;
        }
        if (bitCounter > 13) {
            resetIRCounters();
        }
    }
}
/*
void main(void) {

    INTCON=0;   // purpose of disabling the interrupts.
    TRISA = 0b11111110;
    TRISB = 0b11110000;
    TRISD = 0b11111011;

    init_comms();   // set up the USART - settings defined in usart.h
    initializeCapturePin1();

    PEIE = 1;   // Enable peripheral interrupts.
    GIE = 1;    // Enable interrupts.
    
    while(1){
        resetIRCounters();
        printButton = 0;
        int portAStatus = 0xff;
        
        int sleepCounter = 0;
        while (printButton == 0 && fault == 0) {
            // Sleep/power saving functionality puts the
            // processor to rest until something happens,
            // it wakes up for while then goes back to sleep

            __delay_ms(200);

            if (sleepCounter++ > 80) {
               sleepCounter = 0;
               sleep_microprocessor_sleep();
            }            
        }

        if (fault == 1) {
            printf("fault delta = %d\r", delta);
            continue;
        }     

        unsigned char command = (0xff & currentByte);
        if (command == PHILIPS_COMMAND_VOLUME_UP) {
            printf("Sound volume up\r");
            txCommand = PANASONIC_CMD_VOLUME_UP;
        }
        else if (command == PHILIPS_COMMAND_VOLUME_DOWN) {
            printf("Sound volume down\r");
            txCommand = PANASONIC_CMD_VOLUME_DOWN;
        }
        else if (command == PHILIPS_COMMAND_CHANNEL_UP) {
            printf("Channel up\r");
            txCommand = PANASONIC_CMD_CHANNEL_UP;
        }
        else if (command == PHILIPS_COMMAND_CHANNEL_DOWN) {
            printf("Channel down\r");
            txCommand = PANASONIC_CMD_CHANNEL_DOWN;
        }
        else if (command == PHILIPS_COMMAND_MUTE) {
            printf("Mute\r");
            txCommand = PANASONIC_CMD_MUTE;
        }
        else if (command == PHILIPS_COMMAND_ON_OFF ) {
            printf("On/Off\r");
            txCommand = PANASONIC_CMD_ON_OFF;
        }
        else {
            printf("%x\r", command );
            continue;
        }

        txCheck = txDevice ^ txSubDevice ^ txCommand;

        CCP1IE = 0;
        __delay_ms(200);
        send_panasonic();
        __delay_ms(50);
        CCP1IE = 1;
    }
}*/


void main(void) {
    INTCON=0;   // purpose of disabling the interrupts.

    init_comms();   // set up the USART - settings defined in usart.h
    initializeCapturePin1();

    PEIE = 1;   // Enable peripheral interrupts.
    GIE = 1;    // Enable interrupts.

    while(1){
        resetIRCounters();
        printButton = 0;

        int sleepCounter = 0;
        while (printButton == 0 && fault == 0) {
            // Sleep/power saving functionality puts the
            // processor to rest until something happens,
            // it wakes up for while then goes back to sleep

            __delay_us(20);

            if (sleepCounter++ > 10000) {
               sleepCounter = 0;
               sleep_microprocessor_sleep();
            }
        }

        if (fault == 1) {
            printf("fault delta = %d\r", delta);
            continue;
        }

        unsigned char command = (0xff & currentByte);
        if (command == PHILIPS_COMMAND_VOLUME_UP) {
            printf("Sound volume up\r");
            txCommand = PANASONIC_CMD_VOLUME_UP;
        }
        else if (command == PHILIPS_COMMAND_VOLUME_DOWN) {
            printf("Sound volume down\r");
            txCommand = PANASONIC_CMD_VOLUME_DOWN;
        }
        else if (command == PHILIPS_COMMAND_CHANNEL_UP) {
            printf("Channel up\r");
            txCommand = PANASONIC_CMD_CHANNEL_UP;
        }
        else if (command == PHILIPS_COMMAND_CHANNEL_DOWN) {
            printf("Channel down\r");
            txCommand = PANASONIC_CMD_CHANNEL_DOWN;
        }
        else if (command == PHILIPS_COMMAND_MUTE) {
            printf("Mute\r");
            txCommand = PANASONIC_CMD_MUTE;
        }
        else if (command == PHILIPS_COMMAND_ON_OFF ) {
            printf("On/Off\r");
            txCommand = PANASONIC_CMD_ON_OFF;
        }
        else {
            printf("%x\r", command );
            continue;
        }

        txCheck = txDevice ^ txSubDevice ^ txCommand;

        CCP1IE = 0;
        __delay_ms(200);
        __delay_ms(200);
        __delay_ms(200);
        send_panasonic();
        __delay_ms(50);
        CCP1IE = 1;
    }
}