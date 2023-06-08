
enum mode { X , O }; 
//const n=10; //������ ������� �������� �����
int xod[4]={0,0,0,0};
int n=10; //������ ����
int tip=1; //1 - ���� � ������, 2 - ���� ���� � ������
int razmer=30;
mode cur_mode=X;

struct Cell
{
	mode	mod;  //������ �������� ������
	bool	active;  //��� ���� ������� ��� ���
	CRect	place;   //��� ���������� �����
};

class XO : public CFrameWnd
{

public:
	void Xod(int i1); //��� �������� ������ ��������
	int firstXod(int i1); //������ ��� ���������� � ����� ����
	void variant(int shag, int i2); //���������� ��������� ����������
	void komp(int shag, mode fig);
	int IsWon1(int i, int t); //���������� ������

	void Draw(int i1); //��������� ������
	void Select(int num); //����� ������ ��� ������ ���� ����� �� ��� ���
	void DrawFrame(CPaintDC*); //��������� ����
	void CalcCellRect();  //������� �������� � � �
	void MsgWon(int i); //����� ��������� ���������
	bool IsWon(int i, int t); //���������� ������
	
	int Prov(int i, int h, int N); //���������� ��������� ������ � ������������ ������� �� ���� ������ � ������� ����
	int Gran(int i, int t, int N); //���������� ������ 5-�� � ����������� ���������� ��
	int mesto(int i, int h, int N);

	XO();
public:
	int prevxod ;

private:
	CMenu menu;  //������� ����
	CPen pen;  //����� ��� ���������
	mode cur_mod; //�������� ��� ������ ������
	Cell cells[19*19]; //����� ���������� �������
	bool start;
	int num_cells;
	
protected:
	//{{AFX_VIRTUAL(XO)
	protected:
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	//}}AFX_VIRTUAL

protected:
	//{{AFX_MSG(XO)
	afx_msg void OnPaint(); //��������� ��� �������� � � �
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnGameNew();  //����� ����
	afx_msg void OnGameOption();
	afx_msg void OnTwo();
	afx_msg void OnComp();
	afx_msg void OnTwoO();
	afx_msg void OnCompO();
	afx_msg void OnGameExit();  //����� �� ����
	afx_msg void OnAbout();  // � ���������

	//}}AFX_MSG

	//{{AFX_DATA(XO)
	//}}AFX_DATA

	DECLARE_MESSAGE_MAP()
};

BEGIN_MESSAGE_MAP(XO,CFrameWnd)
	//{{AFX_MSG_MAP(XO)
	ON_WM_PAINT() 
	ON_WM_LBUTTONDOWN()
	ON_COMMAND(ID_GAME_NEW, OnGameNew)  //������������ ���� �� �������
	ON_COMMAND(ID_GAME_Option, OnGameOption)
	ON_COMMAND(ID_Tip_Two, OnTwo)
	ON_COMMAND(ID_Tip_Comp, OnComp)
	ON_COMMAND(ID_Tip_TwoO, OnTwoO)
	ON_COMMAND(ID_Tip_CompO, OnCompO)
	ON_COMMAND(ID_GAME_EXIT, OnGameExit)  //������������ ���� � �������
	ON_COMMAND(ID_HELP_ABOUT, OnAbout) //������������ ���� � �������
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

////////////////////////////////////////////////////////////
class MyApp : public CWinApp //������ ����
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
