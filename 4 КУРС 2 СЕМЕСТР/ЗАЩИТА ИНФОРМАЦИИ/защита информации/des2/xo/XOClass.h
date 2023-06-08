
enum mode { X , O }; 
//const n=10; //задаем сколько рисовать линий
int xod[4]={0,0,0,0};
int n=10; //размер пол€
int tip=1; //1 - игра с компом, 2 - игра друг с другом
int razmer=30;
mode cur_mode=X;

struct Cell
{
	mode	mod;  //делает активной фигуру
	bool	active;  //чет типа активна или нет
	CRect	place;   //тип определ€ет место
};

class XO : public CFrameWnd
{

public:
	void Xod(int i1); //тут пытаетс€ играть компютер
	int firstXod(int i1); //первый ход компьютера в центр пол€
	void variant(int shag, int i2); //нахождение различных комбинаций
	void komp(int shag, mode fig);
	int IsWon1(int i, int t); //вычисление победы

	void Draw(int i1); //рисование фигуры
	void Select(int num); //выбор выхода или старта игры через ƒа или Ќет
	void DrawFrame(CPaintDC*); //рисование пол€
	void CalcCellRect();  //задание размеров ’ и ќ
	void MsgWon(int i); //вывод победного сообщени€
	bool IsWon(int i, int t); //вычисление победы
	
	int Prov(int i, int h, int N); //определ€ет свободную €чейку в определенном радиусе от хода игрока и границы пол€
	int Gran(int i, int t, int N); //вычисление границ 5-ок и возможность построени€ их
	int mesto(int i, int h, int N);

	XO();
public:
	int prevxod ;

private:
	CMenu menu;  //создаем меню
	CPen pen;  //ручка дл€ рисовани€
	mode cur_mod; //выбираем что рисуем первое
	Cell cells[19*19]; //скоко поместитс€ фигурок
	bool start;
	int num_cells;
	
protected:
	//{{AFX_VIRTUAL(XO)
	protected:
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	//}}AFX_VIRTUAL

protected:
	//{{AFX_MSG(XO)
	afx_msg void OnPaint(); //описывает как рисуютс€ ’ и ќ
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnGameNew();  //старт игры
	afx_msg void OnGameOption();
	afx_msg void OnTwo();
	afx_msg void OnComp();
	afx_msg void OnTwoO();
	afx_msg void OnCompO();
	afx_msg void OnGameExit();  //выход из игры
	afx_msg void OnAbout();  // о программе

	//}}AFX_MSG

	//{{AFX_DATA(XO)
	//}}AFX_DATA

	DECLARE_MESSAGE_MAP()
};

BEGIN_MESSAGE_MAP(XO,CFrameWnd)
	//{{AFX_MSG_MAP(XO)
	ON_WM_PAINT() 
	ON_WM_LBUTTONDOWN()
	ON_COMMAND(ID_GAME_NEW, OnGameNew)  //сопоставл€ем меню со стартом
	ON_COMMAND(ID_GAME_Option, OnGameOption)
	ON_COMMAND(ID_Tip_Two, OnTwo)
	ON_COMMAND(ID_Tip_Comp, OnComp)
	ON_COMMAND(ID_Tip_TwoO, OnTwoO)
	ON_COMMAND(ID_Tip_CompO, OnCompO)
	ON_COMMAND(ID_GAME_EXIT, OnGameExit)  //сопоставл€ем меню с выходом
	ON_COMMAND(ID_HELP_ABOUT, OnAbout) //сопоставл€ем меню с помощью
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

////////////////////////////////////////////////////////////
class MyApp : public CWinApp //запуск игры
{
public:
	virtual BOOL InitInstance()
	{
		m_pMainWnd = new XO;
		m_pMainWnd->ShowWindow(SW_SHOWNORMAL);
		return TRUE;
	}
};

MyApp app;
