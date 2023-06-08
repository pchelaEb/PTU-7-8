#include "menu.cpp"

XO::XO()
{
	//{{AFX_DATA_INIT(XO)
	//}}AFX_DATA_INIT
	CString s=AfxRegisterWndClass(CS_HREDRAW|CS_VREDRAW ,
		AfxGetApp()->LoadCursor(IDC_CUR),
		(HBRUSH)GetStockObject(WHITE_BRUSH),
		AfxGetApp()->LoadIcon(IDI_IC));

	Create(s,"Добро пожаловать в Крестики-Нолики"); //титульная надпись
	menu.LoadMenu(IDR_MENU);  //задаем меню
	SetMenu(&menu);	//рисуем меню в проге
	CalcCellRect(); //устанавливаем размеры ячеек
	pen.CreatePen(PS_SOLID,2,RGB(0,0,0)); //рисуем линии
	start=false; //проверка на начало игры
	num_cells=0;

}

void XO::OnPaint()
{
	CPaintDC dc(this);
	dc.SelectObject(&pen);
	DrawFrame(&dc);	 //рисуем поле
	for(int i=0; i<n*n; i++)
		if(cells[i].active==true) //выбираем что будет нарисовано
			if(cells[i].mod==X)
			{
				pen.DeleteObject();
			    pen.CreatePen(PS_SOLID,5,RGB(91,92,113));
				dc.SelectObject(&pen);
							
				dc.MoveTo(cells[i].place.left,cells[i].place.top);
				dc.LineTo(cells[i].place.right,cells[i].place.bottom);
				dc.MoveTo(cells[i].place.left,cells[i].place.bottom);
				dc.LineTo(cells[i].place.right,cells[i].place.top);

				pen.DeleteObject();
				pen.CreatePen(PS_SOLID,2,RGB(0,0,0));
				dc.SelectObject(&pen);
			}
			else if(cells[i].mod==O)
			{
				pen.DeleteObject();
				pen.CreatePen(PS_SOLID,3,RGB(221,42,59));
				dc.SelectObject(&pen);

				dc.Ellipse(cells[i].place);

				pen.DeleteObject();
				pen.CreatePen(PS_SOLID,2,RGB(0,0,0));
				dc.SelectObject(&pen);
			}
}

void XO::DrawFrame(CPaintDC* dc)  //рисование поля
{
	
	CRect r;
	GetClientRect(&r);
	for (int i=1; i<n; i++)
	{
		dc->MoveTo(r.left,i*r.bottom/n);
		dc->LineTo(r.right,i*r.bottom/n);
		dc->MoveTo(i*r.right/n,r.top);
		dc->LineTo(i*r.right/n,r.bottom);
	}
}

void XO::CalcCellRect() //определяем размер, рисуемых фигур
{	
	CRect r;
	GetClientRect(&r);
	
	int cx = r.right;
	int cy = r.bottom;

	for(int j=0, t=r.top, b=r.top+cy/n; j<n;  j++, t+=cy/n, b+=cy/n)
		for(int i=0, l=r.left, p=r.left+cx/n;
		i<n;  i++, p+=cx/n, l+=cx/n)
		{
			int plc = 0;
			plc = j*n+i;
			cells[plc].place.left=l+2;  //сколько отступаем от границы клеточки
			cells[plc].place.right=p-2; //для рисования фигуры
			cells[plc].place.top=t+2;
			cells[plc].place.bottom=b-2;
		}
}

void XO::Draw(int i1)  //рисование заданой фигуры
{
	cells[i1].active=true; 
	cells[i1].mod=cur_mod;
	InvalidateRect(cells[i1].place); //рисуем фигуру на ее месте
	cur_mod= cur_mod== X ? O : X;  //меняем фигуру на противоположную
	num_cells++;  //счетчик ходовж
}

int XO::mesto (int i, int h, int N)
{
	int pos;	
	switch(N)
	{
	case 3: 
		pos= i-h*n;
		break;
	case 4: 
		pos= i-h*(n-1);
		break;
	case -1: 
		pos = i+h;
		break;
	case -2: 
		pos = i+h*(n+1);
		break;
	case -3: 
		pos = i+h*n;
		break;
	case -4: 
		pos = i+h*(n-1);
		break;
	case 1: 
		pos = i-h;
		break;
	case 2: 
		pos = i-h*(n+1);
		break;
	}

	return pos;
}

int XO::Prov(int i, int h, int N) // i - номер ячейки, куда сходили, h - сдвиг, N - номер направления, которое проверяем
{
	int w=0;
	int sum = 0;

	switch(N)
	{
	case 3: 
		sum = i-h*n; 
		if (sum>=0) 
		{
			if (cells[sum].active && cells[sum].mod==cells[i].mod) 
				w=2;
			if (cells[sum].active && cells[sum].mod!=cells[i].mod) 
				w=1;
		}
		break;
	case 4: 
		sum = i-h*(n-1);
		if (sum>=0) 
		{
			if (cells[sum].active && cells[sum].mod==cells[i].mod) 
				w=2;
			if (cells[sum].active && cells[sum].mod!=cells[i].mod) 
				w=1;
		}
		break;
	case -1: 
		sum = i+h;
		if (sum <=n*n)
		{
			if (cells[sum].active && cells[sum].mod==cells[i].mod) 
				w=2;
			if (cells[sum].active && cells[sum].mod!=cells[i].mod) 
				w=1;
		}
		break;
	case -2: 
		sum = i+h*(n+1);
		if (sum <=n*n)
		{
			if (cells[sum].active && cells[sum].mod==cells[i].mod) 
				w=2;
			if (cells[sum].active && cells[sum].mod!=cells[i].mod) 
				w=1;
		}
		break;
	case -3: 
		sum = i+h*n;
		if (sum <=n*n)
		{
			if (cells[sum].active && cells[sum].mod==cells[i].mod) 
				w=2;
			if (cells[sum].active && cells[sum].mod!=cells[i].mod) 
				w=1;
		}
		break;
	case -4: 
		sum = i+h*(n-1);
		if (sum <=n*n)
		{
			if (cells[sum].active && cells[sum].mod==cells[i].mod) 
				w=2;
			if (cells[sum].active && cells[sum].mod!=cells[i].mod) 
				w=1;
		}
		break;
	case 1: 
		sum = i-h;
		if (sum >=0)
		{
			if (cells[sum].active && cells[sum].mod==cells[i].mod) 
				w=2;
			if (cells[sum].active && cells[sum].mod!=cells[i].mod) 
				w=1;
		}
		break;
	case 2: 
		sum = i-h*(n+1); 
		if (sum >=0)
		{
			if (cells[sum].active && cells[sum].mod==cells[i].mod) 
				w=2;
			if (cells[sum].active && cells[sum].mod!=cells[i].mod) 
				w=1;
		}
		break;
	}
	return w;

}

int XO::Gran(int i, int t, int N)
{
	int gran=0;
	int fir;

	switch(N)
	{
	case 3: 
		fir = (i - abs (i/n)*n);
		if (i - fir >= (t-1)*n) 
			gran=1;
		break;
	case 4: 
		fir = (i - abs (i/n)*n);
		if (i - fir >= (t-1)*n && n * abs( i / n )+ n - i - 1 >= t-1) 
			gran=1; 
		break;
	case -1: 
		fir = n * abs( i / n )+ n - i - 1 ;
		if (fir >= t-1) 
			gran=1;
		break;
	case -2: 
		fir = ((n-1)*n + (i - abs (i/n)*n));
		if ( fir - i >= (t-1)*n &&  n * abs( i / n )+ n - i - 1 >= t-1) 
			gran=1;
		break;
	case -3: 
		fir = ((n-1)*n + (i - abs (i/n)*n));
		if (fir  - i >= (t-1)*n ) 
			gran=1;
		break;
	case -4: 
		fir = ((n-1)*n + (i - abs (i/n)*n));
		if ( fir -i >= (t-1)*n &&  i-(n * abs( i / n )) >= t-1) 
			gran=1;
		break;
	case 1: 
		fir = i-(n * abs( i / n ));
		if (fir >= t-1)
			gran=1;		
		break;
	case 2: 
		fir = (i - abs (i/n)*n);
		if (i-fir >= (t-1)*n && i-(n * abs( i / n )) >= t-1) 
			gran=1;
		break;
	}
	return gran;
}