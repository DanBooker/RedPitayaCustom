/* Red Pitaya C API example Acquiring a signal from a buffer
* This application acquires a signal on a specific channel */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "redpitaya/rp.h"

#define M_PI 3.1415926535897932384

int log2(int N)    /*function to calculate the log2(.) of int numbers*/
{
	int k = N, i = 0;
	while (k) {
		k >>= 1;
		i++;
	}
	return i - 1;
}

int check(int n)    //checking if the number of element is a power of 2
{
	return n > 0 && (n & (n - 1)) == 0;
}

int reverse(int N, int n)    //calculating revers number
{
	int j, p = 0;
	for (j = 1; j <= log2(N); j++) {
		if (n & (1 << (log2(N) - j)))
			p |= 1 << (j - 1);
	}
	return p;
}

void ordina(complex<double>* f1, int N) //using the reverse order in the array
{
	complex<double> f2[MAX];
	for (int i = 0; i < N; i++)
		f2[i] = f1[reverse(N, i)];
	for (int j = 0; j < N; j++)
		f1[j] = f2[j];
}

void transform(complex<double>* f, int N) //
{
	ordina(f, N);    //first: reverse order
	complex<double> *W;
	W = (complex<double> *)malloc(N / 2 * sizeof(complex<double>));
	W[1] = polar(1., -2. * M_PI / N);
	W[0] = 1;
	for (int i = 2; i < N / 2; i++)
		W[i] = pow(W[1], i);
	int n = 1;
	int a = N / 2;
	for (int j = 0; j < log2(N); j++) {
		for (int i = 0; i < N; i++) {
			if (!(i & n)) {
				complex<double> temp = f[i];
				complex<double> Temp = W[(i * a) % (n * a)] * f[i + n];
				f[i] = temp + Temp;
				f[i + n] = temp - Temp;
			}
		}
		n *= 2;
		a = a / 2;
	}
}

void FFT(complex<double>* f, int N, double d)
{
	transform(f, N);
	for (int i = 0; i < N; i++)
		f[i] *= d; //multiplying by step
}

int main(int argc, char **argv) {

	/* Print error, if rp_Init() function failed */
	if (rp_Init() != RP_OK) {
		fprintf(stderr, "Rp api init failed!\n");
	}

	/*LOOB BACK FROM OUTPUT 2 - ONLY FOR TESTING*/
	rp_GenReset();
	rp_GenFreq(RP_CH_1, 20000.0);
	rp_GenAmp(RP_CH_1, 1.0);
	rp_GenWaveform(RP_CH_1, RP_WAVEFORM_SINE);
	rp_GenOutEnable(RP_CH_1);


	uint32_t buff_size = 16384;
	float *buff = (float *)malloc(buff_size * sizeof(float));

	rp_AcqReset();
	rp_AcqSetDecimation(1);
	rp_AcqSetTriggerLevel(0.01); //Trig level is set in Volts while in SCPI 
	rp_AcqSetTriggerDelay(0);

	rp_AcqStart();

	/* After acquisition is started some time delay is needed in order to acquire fresh samples in to buffer*/
	/* Here we have used time delay of one second but you can calculate exact value taking in to account buffer*/
	/*length and smaling rate*/

	sleep(1);
	rp_AcqSetTriggerSrc(RP_TRIG_SRC_CHA_PE);
	rp_acq_trig_state_t state = RP_TRIG_STATE_TRIGGERED;

	while (1) {
		rp_AcqGetTriggerState(&state);
		if (state == RP_TRIG_STATE_TRIGGERED) {
			break;
		}
	}

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