#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>      
#include <unistd.h>     
#include <stdint.h>     
#include <sys/ioctl.h>

#define PATH "/dev/my_SPI"


int main(void)
{
   int fd = 0;
   char data_tx 0;

   printf("------------------------------------------------------------------\n");
   printf("OPENING DRIVER: %s\n", PATH);

   if ((fd = open(PATH, O_RDWR))< 0)
   {
      printf("FAILURE OPENING DRIVER\n");
      return -1;
   }

   printf("DRIVER OPENED\n\n");



   printf("------------------------------------------------------------------\n");
   printf("WRITTING DRIVER\n");
   write(fd, (char *) &data_tx, sizeof(char));
   printf ("Data write: %d\n", data_tx);

  
   printf("------------------------------------------------------------------\n");
   printf("CLOSING DRIVER\n");
   close(fd);
   printf ("DRIVER CLOSED\n\n");
  
   return 0;
}