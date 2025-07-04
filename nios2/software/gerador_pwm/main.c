/*
 * main.c
 *
 *  Created on: Jun 27, 2025
 *      Author: Administrador
 */

#include "altera_avalon_pio_regs.h"
#include "alt_types.h"
#include "system.h"

const alt_u32 BASE_FREQ = 5E7;

alt_u8 option = 0;
alt_u8 duty = 0;
alt_u32 freq = 0;

alt_u8 div = 0;
alt_u32 max = 0;
alt_u32 D = 0;

alt_u8 division_factors[8] = {1, 2, 4, 8, 16, 32, 64, 128};

void get_option();
void update_frequency();
void update_parameters();
void send_parameters();

int main()
{
	while(1)
	{
		get_option();
	}
	return 0;
}

void get_option()
{
	puts("Escolha uma opção:");
	puts("1) Alterar DUTY CYCLE");
	puts("2) Alterar FREQUÊNCIA do sinal PWM");
	scanf("%hhd", &option);
	switch(option)
	{
	case 1:
		printf("\n\nInsira o valor de DUTY CYCLE: ");
		scanf("%hhu", &duty);
		printf("\n\n");
		break;
	case 2:
		printf("\n\nInsira o valor de FREQUÊNCIA: ");
		scanf("%u", &freq);
		if(freq > 5E7)
		{
			printf("\nValor muito elevado. Frequência alterada para 50 MHz.");
			freq = 5E7;
		}
		printf("\n\n");
		break;
	default:
		printf("Opção inválida.");
		printf("\n\n");
		break;
	}
}

void update_frequency()
{
	alt_u8 M = 0;
	for(alt_u8 i = 0; i < 8; i++)
	{
		M = BASE_FREQ / freq - 1;
		if(M == 0) break;
		max = M;
	}
}

void update_parameters()
{
	alt_u8 M = 0;
	alt_u8 i = 0;
	for(; i < 8; i++)
	{
		M = (BASE_FREQ / division_factors[i]) / freq - 1;
		if(M == 0) break;
		max = M;
		D = duty * max / 100;
		div = division_factors[i];
	}
}

void send_parameters()
{
	IOWR_ALTERA_AVALON_PIO_DATA(base, data)
}
