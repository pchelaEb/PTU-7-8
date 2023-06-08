// ������������ ������� �� ������

void XO::MsgWon(int i)
{
	mode m;
	m=cells[i].mod;
	char who= m==X ? 'X' : 'O';	
	CString message="�������� ";
	message += who;
	MessageBox(message,"������������!");
	Select(3);
}

bool XO::IsWon(int i, int t) // t - ������ ������
{
	int s=0; //���������� �������� ����������
	bool won=false;

	for ( int a=-4; a<=4; a++) 
	{
		s=0;
		if (Gran(i, 5, a)==1)
		{
			for (int j=1; j<t; j++) //5-�� �� �����
				if (Prov(i, j, a)==2)
					s++	;
				else 
					break;
			if ( s==(t-1) )
				won=true;
		}

		if (Gran(i, t-1, a)==1 && Gran(i, 1, -a)==1 )
		{
			s=0;
			for (int j=1; j<t-1; j++) //5-�� �� ������������� �����
				if (Prov(i, j, a)==2)
					s++	;
				else 
					break;
			if(Prov(i, 1, -a)==2 )
					s++;
			if(s==(t-1))
				won=true;
		}
		
		if (Gran(i, t-2, a)==1 && Gran(i, 2, -a)==1 )
		{
			s=0; 
			for (int j=1; j<t-2; j++) //5-�� � ��������
				if (Prov(i, j, a)==2)
					s++	;
				else 
					break;
			for (j=1; j<t-2; j++) 
				if(Prov(i, j, -a)==2)
					s++;
				else
					break;
			if(s==(t-1))
				won=true;
		}
	}
	return won;
}
