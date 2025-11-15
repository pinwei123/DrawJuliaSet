# include <stdio.h>
# include <stdlib.h>

# include <sys/types.h>
# include <sys/stat.h>
# include <sys/mman.h>
# include <fcntl.h>


void name();
void id(int* id1,int* id2,int* id3,int* idSum);
void drawJuliaSet(int cY, int16_t (*frame)[640]);

int main(){
  //***************************************** name***********************************************
  printf("Function 1 : Name\n");
  name();
  //*********************************************************************************************

  //********************************************id***********************************************
  int id1, id2, id3, idSum ;


  printf("\nFunction 2 : ID\n") ;
  id(&id1, &id2, &id3, &idSum) ;
  
  printf("Main Function :\n");
  printf("*****Print All*****\n");
  printf("Team 015\n");
  printf("%d  CHEN YU XIANG\n", id1);
  printf("%d  LIN PIN WEI\n", id2);
  printf("%d  CHEN GUAN JIE\n", id3);
  printf("ID Summation = %d\n", idSum);
  printf("*****End Print*****\n");

  printf("\n***** Please enter p to draw Julia Set animation*****\n");
  //**********************************************************************************************
  while( getchar() != 'p' ) ;
  system("clear");

  int16_t frame[480][640];
  int cY, fd = open("/dev/fb0", (O_RDWR | O_SYNC));

  if ( fd < 0 ) printf("Frame Buffer Device Open Error!!\n");
  else {
    for( cY = 400 ; cY >= 270 ; cY -= 5 ){
      drawJuliaSet(cY, frame);
      write(fd, frame, sizeof(int16_t)*307200);  // 307200 = 640*480
      lseek(fd, 0, SEEK_SET);
    } // for(cY)

    printf(".*.*.*.<:: Happy New Year ::>.*.*.*.\n");

    printf("Team 015\n");  
	printf("%d  CHEN YU XIANG\n", id1);
	printf("%d  LIN PIN WEI\n", id2);
	printf("%d  CHEN GUAN JIE\n", id3);
	printf("ID Summation = %d\n", idSum);
	printf("*****End Print*****\n");	

    close(fd);
  } // else

  while( getchar() != 'p' ) ;
  
  return 0 ;
} // end main
