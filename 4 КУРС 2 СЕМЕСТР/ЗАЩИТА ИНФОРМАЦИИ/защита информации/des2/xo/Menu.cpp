// Функции менюшки
#include "option.cpp" //диалог опций

void XO::OnGameNew() //старт игры
{
	for(int i=0; i<n*n; i++) //делаем клетки не активными
	{
		cells[i].active=false;
		InvalidateRect(cells[i].place);
	}
	start=true;
	cur_mod=cur_mode;  //то с чего начинается игра
	num_cells=0;

	if (!start)
		Select(1);
	
}

void XO::OnGameOption() //догадайтесь сами ;)
{
	Option dlg;
	dlg.DoModal();

	if (IDC_Agree && (IDC_10 || IDC_15 || IDC_19) && (IDC_20 || IDC_25 || IDC_30)) 
	{
		app.HideApplication();
		app.InitInstance();
	}

}

void XO::OnGameExit() //догадайтесь сами ;)
{
	CFrameWnd::OnClose();	
}

void XO::OnAbout() //не тормозите
{
	MessageBox("Крестики-Нолики ver 2.0. \nОтзывы просьба писать на melnikovy@mail.ru", "Крестики-Нолики о программе");
}

void XO::OnTwo() //выбор игры с человеком
{
	tip = 2;
	cur_mode=X;
	CFrameWnd::SetWindowText("Играем с другом");
	OnGameNew();
}

void XO::OnComp() //выбор игры с человеком
{
	tip = 1;
	cur_mode=X;
	CFrameWnd::SetWindowText("Игра с компом, играете Х");
	OnGameNew();
}

void XO::OnTwoO() //выбор игры с человеком
{
	tip = 2;
	cur_mode=O;
	CFrameWnd::SetWindowText("Играем с другом");
	OnGameNew();
}

void XO::OnCompO() //выбор игры с человеком
{
	tip = 1;
	cur_mode=O;
	CFrameWnd::SetWindowText("Игра с компом, играете O");
	OnGameNew();
}
