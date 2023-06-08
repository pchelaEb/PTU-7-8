#include <afxwin.h>
#include"resource.h"
#include"XOClass.h" //описание фигур Х и О и класса ХО
#include"Won.cpp"  //Блок вычисления побед в игре
#include"Pole.cpp" //рисование поля в игре
#include"ai.cpp"   //интеллект компьютера

//#include <fstream.h>  //для записи в файл ошибок

// установка размера поля
BOOL XO::PreCreateWindow(CREATESTRUCT& cs) //размер игрового поля
{
	cs.style &= ~WS_MAXIMIZEBOX; // не даем растягивать окно
	cs.style &= ~WS_THICKFRAME;
	cs.cx = razmer*n+10;  //задаем размер окна
	cs.cy = razmer*n+48; // +10 границы справа слева, +48 границы сверху и снизу, из-за них поле не квадрат и мы делаем его квадратным
	
	int x = GetSystemMetrics(SM_CXSCREEN); //вычисляем размер экрана в пикселях
	int y = GetSystemMetrics(SM_CYSCREEN);

	cs.x=x/2-cs.cx/2; //делаем изобрадение в центре экрана
	cs.y=y/2-cs.cy/2;

	return CFrameWnd::PreCreateWindow(cs);
}

//////////////////////////////////////////////////////////////////
// Вспомогательные сообщения
void XO::Select(int num)
{
	int Res;
	switch (num)
	{
	case 1:  //Старт игры
		Res = MessageBox("Игра не запущена, запустить игру?","Внимание",
					MB_YESNO+MB_ICONQUESTION);
		break;
	case 2: //ничья
		MessageBox("Играть дальше бесполезно, будет НИЧЬЯ!!!","Ничья");
		Res = MessageBox("Ничейный результат \n Сыграете еще раз?","Внимание",
					MB_YESNO+MB_ICONQUESTION);
		break;
	case 3: //победа
		Res = MessageBox("Победа! \nЗапустить новую игру?","Внимание",
					MB_YESNO+MB_ICONQUESTION);
		break;
	}

	if (Res == IDYES) 
		OnGameNew() ;
	else if (Res == IDNO)
	{
		MessageBox("До свидания","Прощание");
		OnGameExit();
	}
}

//////////////////////////////////////////////////////////////////

void XO::OnLButtonDown(UINT nFlags, CPoint point) //по нажатию на левую кнопку мыши
{
	if (!start)
	{
		Select(1);
	}

	for (int i=0; i<n*n; i++)
		if(cells[i].place.PtInRect(point) && !cells[i].active)
		{
			Draw(i);
			if (tip == 2)
			{
				if ( IsWon(i,5) )
				{
					MsgWon(i);
					break;
				}
			}
			if (tip == 1)
			{
				if ( IsWon(i,5) )
					MsgWon(i);
				else
					Xod(i);
				break;
			}
		}
}