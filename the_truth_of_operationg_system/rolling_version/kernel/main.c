#include "print.h"
#include "init.h"
#include "debug/debug.h"
#include "../lib/string.h"

int main(void)
{
   put_str("I am kernel\n");
   init_all();
   // ASSERT(123123<0);
   char *a = "123";
   char *b = "abc";
   strcat(a, b);
   put_str(a);

   while (1)
      ;

   return 0;
}
