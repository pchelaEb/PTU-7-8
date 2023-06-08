// ������� �������
#include "option.cpp" //������ �����

void XO::OnGameNew() //����� ����
{
	for(int i=0; i<n*n; i++) //������ ������ �� ���������
	{
		cells[i].active=false;
		InvalidateRect(cells[i].place);
	}
	start=true;
	cur_mod=cur_mode;  //�� � ���� ���������� ����
	num_cells=0;

	if (!start)
		Select(1);
	
}

void XO::OnGameOption() //����������� ���� ;)
{
	Option dlg;
	dlg.DoModal();

	if (IDC_Agree && (IDC_10 || IDC_15 || IDC_19) && (IDC_20 || IDC_25 || IDC_30)) 
	{
		app.HideApplication();
		app.InitInstance();
	}

}

void XO::OnGameExit() //����������� ���� ;)
{
	CFrameWnd::OnClose();	
}

void XO::OnAbout() //�� ���������
{
	MessageBox("��������-������ ver 2.0. \n������ ������� ������ �� melnikovy@mail.ru", "��������-������ � ���������");
}

void XO::OnTwo() //����� ���� � ���������
{
	tip = 2;
	cur_mode=X;
	CFrameWnd::SetWindowText("������ � ������");
	OnGameNew();
}

void XO::OnComp() //����� ���� � ���������
{
	tip = 1;
	cur_mode=X;
	CFrameWnd::SetWindowText("���� � ������, ������� �");
	OnGameNew();
}

void XO::OnTwoO() //����� ���� � ���������
{
	tip = 2;
	cur_mode=O;
	CFrameWnd::SetWindowText("������ � ������");
	OnGameNew();
}

void XO::OnCompO() //����� ���� � ���������
{
	tip = 1;
	cur_mode=O;
	CFrameWnd::SetWindowText("���� � ������, ������� O");
	OnGameNew();
}
