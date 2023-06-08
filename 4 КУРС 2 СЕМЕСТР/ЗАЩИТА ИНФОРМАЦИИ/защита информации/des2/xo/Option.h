class Option : public CDialog  //рисование окна опций
{
public:

	Option(CWnd* p=NULL) : CDialog(IDD_Option,p){}

protected:
	virtual void DoDataExchange(CDataExchange* pDX);

protected:
	//{{AFX_MSG(Option)
	afx_msg void OnButtonAgree();
	afx_msg void OnButtonDisagree();
	afx_msg void On10();
	afx_msg void On15();
	afx_msg void On19();
	afx_msg void On20();
	afx_msg void On25();
	afx_msg void On30();
	//}}AFX_MSG

	//{{AFX_DATA(Dlg)
	//}}AFX_DATA

	DECLARE_MESSAGE_MAP()
	

};

BEGIN_MESSAGE_MAP(Option,CDialog)
	//{{AFX_MSG_MAP(Option)
	
	ON_COMMAND(IDC_Agree, OnButtonAgree) //сопоставляем меню с помощью
	ON_COMMAND(IDC_Disagree, OnButtonDisagree)
	ON_COMMAND(IDC_10, On10)
	ON_COMMAND(IDC_15, On15)
	ON_COMMAND(IDC_19, On19)
	ON_COMMAND(IDC_20, On20)
	ON_COMMAND(IDC_25, On25)
	ON_COMMAND(IDC_30, On30)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

void Option::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}