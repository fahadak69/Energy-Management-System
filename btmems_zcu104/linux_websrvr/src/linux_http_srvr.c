/*Linux web server using HTTP*/


#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(/*int argc, char **argv, char **envp*/)
{
	  char *method;

	  char *content_lengthstr;
	  int content_length;

	  char file_path[30] = "../../../usr/"; //file path starting from /www/srv/cgi-bin directory

	  // Use strcat to create a relative file path
	  strcat(file_path, "usr_param.txt" );

	  method = getenv("REQUEST_METHOD");

	  if ((strcmp(method,"post")==0)||(strcmp(method,"POST")==0))
	  {
		  content_lengthstr = getenv("CONTENT_LENGTH");
		  content_length = atoi(content_lengthstr);
		  FILE *cgiIn;
		  cgiIn = stdin;
		  char *post_dataptr;
		  post_dataptr = (char *) malloc(content_length);

		  //reading data sent by post into memory
		  fread(post_dataptr, 1,content_length, cgiIn);

		  // Open the file and write post data
		  FILE *file_hndl;
		  file_hndl = fopen(file_path, "r+");
		  if (!file_hndl)
		  {
		      printf("Failed to open user parameters file\n");
		      exit(1);
		  }
		  fseek(file_hndl, 0, SEEK_SET );
		  fprintf (file_hndl,"%s\n",post_dataptr);

		  fclose (file_hndl);
		  free(post_dataptr);

	  }
    return 0;
}
