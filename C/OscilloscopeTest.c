/* Red Pitaya C API example Acquiring a signal from a buffer
* This application acquires a signal on a specific channel */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "redpitaya/rp.h"

int main(int argc, char **argv) {
	printf("Step 1")
	/* Print error, if rp_Init() function failed */
	if (rp_Init() != RP_OK) {
		fprintf(stderr, "Rp api init failed!\n");
	}
	printf("Step 2")
	/*LOOB BACK FROM OUTPUT 2 - ONLY FOR TESTING*/
	rp_GenReset();
	rp_GenFreq(RP_CH_1, 20000.0);
	rp_GenAmp(RP_CH_1, 1.0);
	rp_GenWaveform(RP_CH_1, RP_WAVEFORM_SINE);
	rp_GenOutEnable(RP_CH_1);


	uint32_t buff_size = 16384;
	float *buff = (float *)malloc(buff_size * sizeof(float));
	printf("Step 3")
	rp_AcqReset();
	rp_AcqSetDecimation(1);
	rp_AcqSetTriggerLevel(0.01); //Trig level is set in Volts while in SCPI 
	rp_AcqSetTriggerDelay(0);

	rp_AcqStart();

	/* After acquisition is started some time delay is needed in order to acquire fresh samples in to buffer*/
	/* Here we have used time delay of one second but you can calculate exact value taking in to account buffer*/
	/*length and smaling rate*/
	printf("Step 4")
	sleep(1);
	rp_AcqSetTriggerSrc(RP_TRIG_SRC_CHA_PE);
	rp_acq_trig_state_t state = RP_TRIG_STATE_TRIGGERED;
	printf("Step 5")
	while (1) {
		rp_AcqGetTriggerState(&state);
		if (state == RP_TRIG_STATE_TRIGGERED) {
			break;
		}
	}
	printf("Step 6")
	rp_AcqGetOldestDataV(RP_CH_1, &buff_size, buff);
	int i;
	for (i = 0; i < buff_size; i++) {
		printf("%f\n", buff[i]);
	}
	/* Releasing resources */
	free(buff);
	rp_Release();
	return 0;
}