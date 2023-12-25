#include "print.h"
#include "init.h"
#include "debug/debug.h"

void main(void) {
   put_str("I am kernel\n");
   init_all();
   ASSERT(123123<0);

   while(1);
}
