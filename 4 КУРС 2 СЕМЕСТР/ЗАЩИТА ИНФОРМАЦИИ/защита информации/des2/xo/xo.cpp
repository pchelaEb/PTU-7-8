#include <afxwin.h>
#include"resource.h"
#include"XOClass.h" //�������� ����� � � � � ������ ��
#include"Won.cpp"  //���� ���������� ����� � ����
#include"Pole.cpp" //��������� ���� � ����
#include"ai.cpp"   //��������� ����������

//#include <fstream.h>  //��� ������ � ���� ������

// ��������� ������� ����
BOOL XO::PreCreateWindow(CREATESTRUCT& cs) //������ �������� ����
{
	cs.style &= ~WS_MAXIMIZEBOX; // �� ���� ����������� ����
	cs.style &= ~WS_THICKFRAME;
	cs.cx = razmer*n+10;  //������ ������ ����
	cs.cy = razmer*n+48; // +10 ������� ������ �����, +48 ������� ������ � �����, ��-�� ��� ���� �� ������� � �� ������ ��� ����������
	
	int x = GetSystemMetrics(SM_CXSCREEN); //��������� ������ ������ � ��������
	int y = GetSystemMetrics(SM_CYSCREEN);

	cs.x=x/2-cs.cx/2; //������ ����������� � ������ ������
	cs.y=y/2-cs.cy/2;

	return CFrameWnd::PreCreateWindow(cs);
}

//////////////////////////////////////////////////////////////////
// ��������������� ���������
void XO::Select(int num)
{
	int Res;
	switch (num)
	{
	case 1:  //����� ����
		Res = MessageBox("���� �� ��������, ��������� ����?","��������",
					MB_YESNO+MB_ICONQUESTION);
		break;
	case 2: //�����
		MessageBox("������ ������ ����������, ����� �����!!!","�����");
		Res = MessageBox("�������� ��������� \n �������� ��� ���?","��������",
					MB_YESNO+MB_ICONQUESTION);
		break;
	case 3: //������
		Res = MessageBox("������! \n��������� ����� ����?","��������",
					MB_YESNO+MB_ICONQUESTION);
		break;
	}

	if (Res == IDYES) 
		OnGameNew() ;
	else if (Res == IDNO)
	{
		MessageBox("�� ��������","��������");
		OnGameExit();
	}
}

//////////////////////////////////////////////////////////////////

void XO::OnLButtonDown(UINT nFlags, CPoint point) //�� ������� �� ����� ������ ����
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