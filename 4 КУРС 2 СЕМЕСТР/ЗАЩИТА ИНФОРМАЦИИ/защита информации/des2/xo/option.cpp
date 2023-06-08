#include "option.h"

void Option::OnButtonAgree()
{
	EndDialog(IDC_Agree);
}

void Option::OnButtonDisagree()
{
	EndDialog(IDC_Disagree);
}

void Option::On10()
{
	n=10;
}

void Option::On15()
{
	n=15;
}

void Option::On19()
{
	n=19;
}

void Option::On20()
{
	razmer=20;
}

void Option::On25()
{
	razmer=25;
}

void Option::On30()
{
	razmer=30;
}
