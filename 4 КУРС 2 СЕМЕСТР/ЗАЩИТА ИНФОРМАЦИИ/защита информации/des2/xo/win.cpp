#include "xo.cpp"

bool XO::IsWon(int i)
{
	bool won=false;
	int first;

	first =  n * abs( (i-0) / n ); // использует для проверки выхода за границу строки
	
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

/* if ловит выходы за границу по горизонтали 
   в формуле check задаем 5 параметров, которые ловят 5-ки */ 
/*	won = //ловим горизонтали
		  Check(i, i+1, i+2, i+3, i+4)||  //ловит последнем по горизонтали
		  Check(i-4, i-3, i-2, i-1, i)|| //конец по первом крестику  
		  Check(i-1, i, i+1, i+2, i+3)|| //конец по предпоследнему крестику
		  Check(i-3, i-2, i-1, i, i+1)|| //конец по предпоследнему крестику
		  Check(i-2, i-1, i, i+1, i+2)|| //конец по середине линии
		  //ловим  вертикали
		  Check( i, i+(1*n), i+(2*n), i+(3*n), i+(4*n) )|| //конец по первому крестику
		  Check( i-(4*n), i-(3*n), i-(2*n), i-(1*n), i )|| //конец по последнему крестику
		  Check( i-(1*n), i, i+(1*n), i+(2*n), i+(3*n) )|| //конец по предпоследнему крестику
		  Check( i-(3*n), i-(2*n), i-(1*n), i, i+(1*n) )|| //конец по предпоследнему крестику
		  Check( i+(2*n), i+(1*n), i, i-(1*n), i-(2*n) )|| //конец по середине линии
		  //ловим диагональ первую
          Check( i, i+(1*n)+1, i+(2*n)+2, i+(3*n)+3, i+(4*n)+4 )|| //конец по первому крестику
		  Check( i-(4*n)-4, i-(3*n)-3, i-(2*n)-2, i-(1*n)-1, i )|| //конец по последнему крестику
		  Check( i-(1*n)-1, i, i+(1*n)+1, i+(2*n)+2, i+(3*n)+3 )|| //конец по предпоследнему крестику
		  Check( i-(3*n)-3, i-(2*n)-2, i-(1*n)-1, i, i+(1*n)+1 )|| //конец по предпоследнему крестику
		  Check( i+(2*n)+2, i+(1*n)+1, i, i-(1*n)-1, i-(2*n)-2 )||  //конец по середине линии
		  //ловим диагональ вторую
          Check( i, i+(1*n)-1, i+(2*n)-2, i+(3*n)-3, i+(4*n)-4 )|| //конец по первому крестику
		  Check( i-(4*n)+4, i-(3*n)+3, i-(2*n)+2, i-(1*n)+1, i )|| //конец по последнему крестику
		  Check( i-(1*n)+1, i, i+(1*n)-1, i+(2*n)-2, i+(3*n)-3 )|| //конец по предпоследнему крестику
		  Check( i-(3*n)+3, i-(2*n)+2, i-(1*n)+1, i, i+(1*n)-1 )|| //конец по предпоследнему крестику
		  Check( i+(2*n)-2, i+(1*n)-1, i, i-(1*n)+1, i-(2*n)+2 );  //конец по середине линии 
*/
	return won;
}
//проверка условий и определение победителя
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
	
	if(!won && num_cells==n*n) //Ничья
		Select(2);

	if(won==true) // Победа
	{
		char who= m==X ? 'X' : 'O';
		CString message="Победили ";
		message += who;
		MessageBox(message,"Поздравления!");
		Select(3);
	}
	return won;
}