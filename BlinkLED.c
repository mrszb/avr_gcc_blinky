#include <avr/io.h>
#include <util/delay.h>

#define BLINK_DELAY_MS 500

#define MS_DELAY 3000

int main (void) {
  // Arduino digital pin 13 (pin 5 of PORTB) for output
  DDRB |= 0B100000; // PORTB5

    while(1) {
        /*Set to one the fifth bit of PORTB to one
        **Set to HIGH the pin 13 */
            PORTB |= 0B100000; // PORTB5

        /*Wait 3000 ms */
        _delay_ms(MS_DELAY);

        /*Set to zero the fifth bit of PORTB
        **Set to LOW the pin 13 */
        PORTB &= ~ 0B100000; // PORTB5

        /*Wait 3000 ms */
        _delay_ms(MS_DELAY);
    }
}