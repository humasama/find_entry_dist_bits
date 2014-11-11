#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NUM 8
int main(int argc, char **argv){
	FILE *fp = fopen(argv[1], "r");
	if(!fp) exit(1);
	
	char *p;
	char buf[100];

	int set[NUM] = {0}, cnt = 0; 
	float mask[NUM] = {0.0}, percent[NUM] = {0.0};
	float base = 370.0, max = 0.0, min = 100000.0, tmp = 0.0;
	
	int i = 0, id = 0;
	for(; i < NUM; i++){
		mask[i] = base + i * 10.0;
	}
	
	while(fgets(buf, 100, fp)){
		p = strchr(buf, ':');
		p = p + 1;
		tmp = atof(p);
		cnt ++;
		//printf("%f:", tmp);
		i = 0;
		while(tmp > mask[i]) i ++;

		if(i == 0){
			printf("value < min mask, update mask!\n");
			exit(0);
		}
		id = i - 1;
		set[id] ++;
		//printf(": mask[%d]\n", id);
	}

	i = 0;
	for(; i < NUM; i ++){
		percent[i] = (float)set[i] / (float)cnt;
		printf("%f : %d, %f\n", mask[i], set[i], percent[i]);
	}

	fclose(fp);

	exit(0);
}


