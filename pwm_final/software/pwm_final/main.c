#include <stdio.h>
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"
#include "system.h"

const alt_u32 BASE_FREQ = 5E7;

alt_u8 option = 0;
alt_u8 duty = 50;
alt_u32 freq = 10000;

alt_u8 div = 0;
alt_u32 max = 0;
alt_u32 D = 0;

alt_u8 division_factors[8] = {1, 2, 4, 8, 16, 32, 64, 128};

void get_option();
void update_parameters();
void send_parameters();

int main()
{
	while(1)
	{
		get_option();
		update_parameters();
		send_parameters();
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
		scanf("%lu", &freq);
		if(freq > 5E7)
		{
			printf("\nValor muito elevado. Frequência alterada para 500 kHz.");
			freq = 5E5;
		}
		printf("\n\n");
		break;
	default:
		printf("Opção inválida.");
		printf("\n\n");
		break;
	}
}

void update_parameters()
{
	alt_u32 M = 0;
	alt_u8 i = 0;
	for(; i < 8; i++)
	{
		M = (BASE_FREQ / division_factors[i]) / freq - 1;
		if((int)M < 99) continue;
		max = M;
		D = duty * (max + 1) / 100;
		div = division_factors[i];
	}
}

void send_parameters()
{
	IOWR_ALTERA_AVALON_PIO_DATA(PIO_D_BASE, D);
	IOWR_ALTERA_AVALON_PIO_DATA(PIO_DIV_BASE, div);
	IOWR_ALTERA_AVALON_PIO_DATA(PIO_MAX_BASE, max);
}
