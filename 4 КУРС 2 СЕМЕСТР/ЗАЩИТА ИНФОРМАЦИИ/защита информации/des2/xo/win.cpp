#include "xo.cpp"

bool XO::IsWon(int i)
{
	bool won=false;
	int first;

	first =  n * abs( (i-0) / n ); // ���������� ��� �������� ������ �� ������� ������
	
	for (int j=0; j<=1; j++)
		for (int k=1; k>=-1; k--)
		{
			if (i-first >= 4 && j==0 )
				won = Check( i, i+(1*n)*j-1*k, i+(2*n)*j-2*k, i+(3*n)*j-3*k, i+(4*n)*j-4*k );
			if (first+n-1-i >= 4 && j==0 )
				won = Check( i-(4*n)*j+4*k, i-(3*n)*j+3*k, i-(2*n)*j+2*k, i-(1*n)*j+1*k, i );
			if (first+n-1-i >= 3 && j==0 )
				won = Check( i-(1*n)*j+1*k, i, i+(1*n)*j-1*k, i+(2*n)*j-2*k, i+(3*n)*j-3*k );
			if (i-first >= 3 && j==0 )
				won = Check( i-(3*n)*j+3*k, i-(2*n)*j+2*k, i-(1*n)*j+1*k, i, i+(1*n)*j-1*k );
			if (i-first >= 2 && j==0 )
				won = Check( i+(2*n)*j-2*k, i+(1*n)*j-1*k, i, i-(1*n)*j+1*k, i-(2*n)*j+2*k );
			else 
				won = Check( i, i+(1*n)*j-1*k, i+(2*n)*j-2*k, i+(3*n)*j-3*k, i+(4*n)*j-4*k ) ||
					  Check( i-(4*n)*j+4*k, i-(3*n)*j+3*k, i-(2*n)*j+2*k, i-(1*n)*j+1*k, i ) ||
					  Check( i-(1*n)*j+1*k, i, i+(1*n)*j-1*k, i+(2*n)*j-2*k, i+(3*n)*j-3*k ) ||
					  Check( i-(3*n)*j+3*k, i-(2*n)*j+2*k, i-(1*n)*j+1*k, i, i+(1*n)*j-1*k ) ||
					  Check( i+(2*n)*j-2*k, i+(1*n)*j-1*k, i, i-(1*n)*j+1*k, i-(2*n)*j+2*k );
			if (j==0)  break;
		}

/* if ����� ������ �� ������� �� ����������� 
   � ������� check ������ 5 ����������, ������� ����� 5-�� */ 
/*	won = //����� �����������
		  Check(i, i+1, i+2, i+3, i+4)||  //����� ��������� �� �����������
		  Check(i-4, i-3, i-2, i-1, i)|| //����� �� ������ ��������  
		  Check(i-1, i, i+1, i+2, i+3)|| //����� �� �������������� ��������
		  Check(i-3, i-2, i-1, i, i+1)|| //����� �� �������������� ��������
		  Check(i-2, i-1, i, i+1, i+2)|| //����� �� �������� �����
		  //�����  ���������
		  Check( i, i+(1*n), i+(2*n), i+(3*n), i+(4*n) )|| //����� �� ������� ��������
		  Check( i-(4*n), i-(3*n), i-(2*n), i-(1*n), i )|| //����� �� ���������� ��������
		  Check( i-(1*n), i, i+(1*n), i+(2*n), i+(3*n) )|| //����� �� �������������� ��������
		  Check( i-(3*n), i-(2*n), i-(1*n), i, i+(1*n) )|| //����� �� �������������� ��������
		  Check( i+(2*n), i+(1*n), i, i-(1*n), i-(2*n) )|| //����� �� �������� �����
		  //����� ��������� ������
          Check( i, i+(1*n)+1, i+(2*n)+2, i+(3*n)+3, i+(4*n)+4 )|| //����� �� ������� ��������
		  Check( i-(4*n)-4, i-(3*n)-3, i-(2*n)-2, i-(1*n)-1, i )|| //����� �� ���������� ��������
		  Check( i-(1*n)-1, i, i+(1*n)+1, i+(2*n)+2, i+(3*n)+3 )|| //����� �� �������������� ��������
		  Check( i-(3*n)-3, i-(2*n)-2, i-(1*n)-1, i, i+(1*n)+1 )|| //����� �� �������������� ��������
		  Check( i+(2*n)+2, i+(1*n)+1, i, i-(1*n)-1, i-(2*n)-2 )||  //����� �� �������� �����
		  //����� ��������� ������
          Check( i, i+(1*n)-1, i+(2*n)-2, i+(3*n)-3, i+(4*n)-4 )|| //����� �� ������� ��������
		  Check( i-(4*n)+4, i-(3*n)+3, i-(2*n)+2, i-(1*n)+1, i )|| //����� �� ���������� ��������
		  Check( i-(1*n)+1, i, i+(1*n)-1, i+(2*n)-2, i+(3*n)-3 )|| //����� �� �������������� ��������
		  Check( i-(3*n)+3, i-(2*n)+2, i-(1*n)+1, i, i+(1*n)-1 )|| //����� �� �������������� ��������
		  Check( i+(2*n)-2, i+(1*n)-1, i, i-(1*n)+1, i-(2*n)+2 );  //����� �� �������� ����� 
*/
	return won;
}
//�������� ������� � ����������� ����������
bool XO::Check(int i1,int i2,int i3,int i4,int i5)
{
	bool won=false;
	mode m;

	if(!(cells[i1].active && cells[i2].active && cells[i3].active && cells[i4].active && cells[i5].active))
		return won;
	if((m=cells[i1].mod) == cells[i2].mod
		&& cells[i2].mod == cells[i3].mod
		&& cells[i3].mod == cells[i4].mod
		&& cells[i4].mod == cells[i5].mod)
	{
		won=true;
	}
	
	if(!won && num_cells==n*n) //�����
		Select(2);

	if(won==true) // ������
	{
		char who= m==X ? 'X' : 'O';
		CString message="�������� ";
		message += who;
		MessageBox(message,"������������!");
		Select(3);
	}
	return won;
}