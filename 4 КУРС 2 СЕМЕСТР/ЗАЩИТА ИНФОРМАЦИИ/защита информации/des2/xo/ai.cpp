//#include <fstream.h>
// »Ќ“≈Ћ≈ “  ќћѕ№ё“≈–ј!!!!
void XO::Xod(int i1)
{
	if (num_cells==1) 
		firstXod(i1);
	else 
	{
		mode cur=cur_mode;
		if (cur_mode == X)
			cur = X ? O : X ;
		else 
			cur = O ? O : X ;
		komp(2, cur);
		komp(1, cur_mod);
		if (xod[1]==0 || num_cells==n*n) //Ќичь€
		{
			Select(2);
		}
		else 
		{
			int mes;
			mes = mesto(xod[0],xod[3],xod[2]);
			if (xod[3]!=0 && xod[2]!=0 )
				Draw(mes);
			if ( IsWon(xod[0],5) )
					MsgWon(xod[0]);
			for (int i=0; i<=3; i++)
				xod[i]=0;
		}
	}
}

void XO::komp(int shag, mode fig)
{
/*	ofstream bug1;
	
	bug1.open("bug1.txt");*/

	for (int i=0; i<=n; i++)
		for (int i2=i; i2 <n*n; i2=i2+n)
		{
			if (Prov(i2,0,3)==2)
				if (cells[i2].mod==fig)
					variant(shag, i2);
		}
/*	bug1 << xod[1] <<" " << xod[0] <<" " << xod[2] <<" " << xod[3] ;
	bug1.close();*/
}

void XO::variant(int shag, int i2) //xod[1] - приоритет комбинации
{
	for (int q = 5; q>= shag ; q-- )
	{
		int prior=IsWon1(i2,q)%100; //вычисление приоретета
		if (prior < 0 ) //делаем приоретет положительным, если он отрицательный
			prior=-prior;
		int napr=IsWon1(i2,q)/100; //вычисление направлени€ хода
	
		if ( prior == 11 )
		{
			xod[0]=i2; //номер €чейки которую провер€ем
			xod[1]=11; //еще раз пишем приоретет
			xod[2]=napr; //направление которое мы перекрываем
			xod[3]=2;  //отступ или место хода
		}

		if ( (prior == 8 && xod[1]<=8) || (prior == 6 && xod[1]<=6) ||
			 (prior == 5 && xod[1]<=5) || (prior == 12 && xod[1]<=12) ||
			 (prior == 2 && xod[1]<=2) )  //блокировка дырки в середине у 3-ки
		{
			xod[0]=i2;
			xod[1]=prior;
			xod[2]=napr;
			xod[3]=q;
		}

		if ( (prior == 3 && xod[1]<=3) || ( prior == 4 && xod[1]<=4) ||
			 (prior == 9 && xod[1]<=9) || ( prior == 7 && xod[1]<=7) || 
			 (prior == 10 && xod[1]<=10) )  //блокировка дырки в середине у 3-ки
		{
			xod[0]=i2;
			xod[1]=prior;
			xod[2]=napr;
			xod[3]=1;
		}
	}

}

int XO::IsWon1(int i, int t) // t - размер фигуры
{
	int s = 0;
	int pr=0;
	for (int a=-4; a<=4; a++) //все фигуры с дырками
	{
		if (Gran(i, 5, a)==1)
		{
			if ( t==5 ) //5-ки
			{
				if ( Prov(i,1,a)==2 && Prov(i,2,a)==0 && Prov(i,3,a)==2 && Prov(i,4,a)==2 )	
				{
					pr=11;
					s=a*100+pr;
				}
				if ( Prov(i,1,a)==0 && Prov(i,2,a)==2 && Prov(i,3,a)==2 && Prov(i,4,a)==2 ) 
				{
					pr = 10;
					s=a*100+pr;
				}
			}

			if ( t==4 ) //4-ки
			{
				if (Prov(i, 1, a)==0 &&  Prov(i, 2, a)==2 && Prov(i, 3, a)==2 && ( Prov(i, 4, a)==0 && Prov(i, 1, -a)==0) )
					if (pr<9)
					{
						pr=9;
						if (a>0)
							s=a*100+pr;
						else 
							s=a*100-pr;
					}

				if (Prov(i, 1, a)==0 &&  Prov(i, 2, a)==2 && Prov(i, 3, a)==2 && ( Prov(i, 4, a)==0 || Prov(i, 4, a)==2 || Prov(i, 4, a)==1) )
					if (pr<7)
					{
						pr=7;
						if (a>0)
							s=a*100+pr;
						else 
							s=a*100-pr;
					}

				if (Prov(i, 1, a)==2 &&  Prov(i, 2, a)==2 && Prov(i, 3, a)==2 && ( Prov(i, 4, a)==0 ) )
					if (pr<12)
					{
						pr = 12;
						if (a>0)
							s=a*100+pr;
						else 
							s=a*100-pr;
					}
			}

			if ( t==3 )  // 3-ка с дыркой
			{
				if (Prov(i, 1, a)==0 &&  Prov(i, 2, a)==2 && Prov(i, 3, a)==0 && Prov(i, 4, a)==0 )
					if (pr<3)
					{
						pr=3;
						if (a>0)
							s=a*100+pr;
						else 
							s=a*100-pr;
					}
				if (Prov(i, 1, a)==2 &&  Prov(i, 2, a)==2 && Prov(i, 3, a)==0 && Prov(i, 4, a)==0 )
					if (pr<6)
					{
						pr=6;
						if (a>0)
							s=a*100+pr;
						else 
							s=a*100-pr;
					}
			}

			if ( t==2 )
				if ( Prov(i,1,a)==2 && Prov(i, 2, a)==0 && Prov(i, 3, a)==0 && Prov(i, 4, a)==0 ) 
					if (pr<5)
					{
						pr=5;
						if (a>0)
							s=a*100+pr;
						else 
							s=a*100-pr;
					}
			if ( t== 1 )
				if ( Prov(i,1,a)==0 && Prov(i, 2, a)==0 && Prov(i, 3, a)==0 && Prov(i, 4, a)==0 )
					if (pr<2)
					{
						pr=2;
						if (a>0)
							s=a*100+pr;
						else 
							s=a*100-pr;
					}
		}
		
		if (Gran(i, 4, a)==1 && Gran(i, 1, -a)==1)
		{ 
			if ( t==3 )
			{
				if (Prov(i, 1, a)==0 &&  Prov(i, 2, a)==2 && Prov(i, 3, a)==0 && Prov(i, 1, -a)==0)
					if (pr<4)
					{
						pr=4;
						if (a>0)
							s=a*100+pr;
						else 
							s=a*100-pr;
					}
				if (Prov(i, 1, a)==2 &&  Prov(i, 2, a)==2 && Prov(i, 3, a)==0 && Prov(i, 1, -a)==0 )
					if (pr<8)
					{
						pr=8;
						if (a>0)
							s=a*100+pr;
						else 
							s=a*100-pr;
					}
			}
			if ( t==2 )
				if (Prov(i,1,a)==2 && Prov(i, 2, a)==0 && Prov(i, 3, a)==0 && Prov(i, 1, -a)==0 )
					if (pr<3)
					{
						pr=3;
						if (a>0)
							s=a*100+pr;
						else 
							s=a*100-pr;
					}
			if ( t== 1 )
				if ( Prov(i,1,a)==0 && Prov(i, 2, a)==0 && Prov(i, 3, a)==0 && Prov(i, 1, -a)==0 )
					if (pr<2)
					{
						pr=2;
						if (a>0)
							s=a*100+pr;
						else 
							s=a*100-pr;
					}
		}

	}
	
	return 	s;
}

int XO::firstXod(int i1)
{
	int nap=0, mes;

	as:	nap = 0;
		while (nap==0)
		{
			srand(time(NULL));
			nap=rand()% 8 - 4;
		}
		mes = mesto(i1, 1, nap);
	if (mes>=n*n )
	{
		goto as;
	}
	if (mes <=0)
		goto as;
	
	Draw(mes);

	return 2;
}