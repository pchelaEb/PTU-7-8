unit ClassModule;

interface
uses
  SysUtils, Dialogs, Messages, Classes, Contnrs, Math,  Windows, Uravn;
type
 // ��������������
  TModel = class;

  //����� � ��������
  TMetka = record
    // ���� �����
   mColor: Integer;
    // ������� ����� ����� ����� � �������
   mTimelife: Integer;
 end;

  // ����� �������
  TPosizia = class
  public
 // ����� ������� � ������
  pModel: TModel;
  //������ ����� � �������
  pMetki: array of TMetka;
 // ������������ ������� �������
  pMaxVolume: Integer;
 // ����� �������������  �����
  pPositive: Integer;
 // ����� ������������� �����
  pNegative: Integer;
 // ����� ����� �����, ������ � �������
  pTotal: Integer;
  // ����������: �������� �����, ������ � �������
   pMaximum: Integer;
 //������� ��������� �����
  pFlag: Integer;
  //������� �������� ��������� �����. �������. ����� � ������ ������
  pNPplus: boolean;
  //������� �������� ��������� �����. �������. ����� � ������ ������
  pNPminus: boolean;
  //������� �������� ����� �� ��������� �������
  pNPdel: boolean;
  //����� ��� ������������ ���������� �������� (������ �������������)
  pNP: Real;
  //����� ��������� ������� � ������� ��������� �������
  pNPnumber: Integer;
   //���-�� ��������� ������������� ����� �� ���� � ��������� �������
   PRIXOD1: Integer;
   //���-�� ��������� ������������� ����� �� ���� � ��������� �������
   PRIXOD2: Integer;

 // ����������� �������� �������
  constructor Create(model: TModel; Kol_positive, Kol_negative, flag, NP: Integer; volume: Integer);
  // �������� ����� �� �������
  procedure Send (x: Integer; y: Integer);
 // ����� ��������� ���������� �����
  function CanSend: Integer;
  // ����� ��������� ���������� ������������� �����
  function CanSend1: Integer;
  // ����� ��������� ���������� ������������� �����
  function CanSend2: Integer;
 //������� ����� ��������� ����������� �����  ��������
  function CanRecieve: Integer;
 // �������� ����� x - ����� 1, y - ����� 2
  procedure Recieve (x: Integer; y: Integer);
 // ������� ������� ������������ �������� ��� ��������� �������
  function NPodschet (m1, m2: array of real): real;
  end;
    // ���� ����� ���������� � ���������
 TDuga = record
    // ����������� �������
   dPosizia: TPosizia;
    // ��������� ����� ����� a
   dWes1: Integer;
    // ��������� ����� ����� b
   dWes2: Integer;
    // ���� ���������� �� ����� �
   dZnak1: Integer;
   // ���� ���������� �� ����� b
   dZnak2: Integer;
 end;

   // ����� �������
  TPerexod = class
  public
  // ������
  pModel: TModel;
  // ����� ����� ������������ ��������
  pSrab: Integer;
  //���� - ����� � ���������
  pInDugi, pOutDugi, pIngib: array of TDuga;
  //������� ������ ��������
  pStopping: Boolean;
  // ����������: ����� �������������� �������� ��-�� �������
  pStops: Integer;
  //��������� ��������
  pPrior: Integer;
  //������� ������ �������� (��� ��������� � ���������� �����������)
  pRab: Integer;
  //������� �������� (��� ��������� � ���������� �����������)
  pSchetchik: Integer;
  // ���������� �����������
  pPok: Integer;
  // �������� ��������
  constructor Create (model: TModel);
  // �������� ����������� ������������ ��������
  function CanTransfer: Boolean;
  // ������������ ��������
  procedure Transfer;
  end;
  // ��������� ���� �����
  TModel = class
  public
   // �������
    mPosition: array of TPosizia;
    // ��������
    mPerexod: array of TPerexod;
    // ������������ ��������� � ������ �����������
    mPriorPerex: array of Integer;
     // ������� ���������
    mChange: Boolean;
     // �������� ������ ��������� ���� �����
    constructor Create;
    // ���������� ������
    destructor Destroy; override;
    // ����������� ���������� �������������� ��������� ����
    procedure Step;
    procedure Udalenie;
  end;


implementation

uses UMain;
  { TPosizia }
constructor TPosizia.Create(model: TModel; Kol_positive, Kol_negative, flag, NP, volume: Integer);
var i: Integer;
begin
  pModel := model;
  pMaxVolume := volume;
  pPositive := Kol_positive;
  pNegative := Kol_negative;
  pTotal := Kol_positive + Kol_negative;
  pMaximum := Kol_positive + Kol_negative;
  pFlag := flag;
  PRIXOD1 := 0;
  PRIXOD2 := 0;
  pNPnumber := 0;
  pNP := NP;
  SetLength(pMetki, pPositive + pNegative);
   for i := 0 to (High(pMetki) - pNegative) do  with (pMetki[i]) do
   begin
    mColor := 1;
    mTimelife := 0;
   end;
   for i := (High(pMetki) - pNegative + 1) to High(pMetki) do  with (pMetki[i]) do
    begin
    mColor := 2;
    mTimelife := 0;
   end;

end;

function TPosizia.CanSend: Integer;
begin
  Result := pPositive + pNegative;
end;

function TPosizia.CanSend1: Integer;
begin
  Result := pPositive;
end;

function TPosizia.CanSend2: Integer;
begin
  Result := pNegative;
end;
// �������� � - ������ ��� ������������ �������� ���������� ������������� �����, � - ���������� �������������,
// b - ������� ������� ����� ������� ����� � ������ ������� ��������
procedure TPosizia.Send(x: Integer; y: Integer);
Label B;
var
  X1, Y1, Z, D, j, i, l, es, fl, SumUd1, SumUd2: Integer;
begin
  SumUd1 := 0; SumUd2 := 0;
  Z := Min((x + y), CanSend);
  if (pFlag = 1) then goto B;
  if ((x <> 0) and (y <> 0)) then begin
    if (Z < (x + y)) then Exit;
  end;
  X1 := Min (x, pPositive);
    if (X1 < x) then Exit;
    Y1 := Min (y, pNegative);
    if (Y1 < y) then Exit;

B:  es := 0;
if ((pFlag = 1)and ((pNPplus = true) or(pNPminus = true) or ((pNPplus = true) and (pNPminus = true))))  then
  begin
    es := 1;
    if ((pNPplus = true) and (pNPminus = true)) then begin
    pNPplus := false; pNPminus := false;
  //  if pNPplus=true then begin
    pPositive := PRIXOD1;
    SetLength(pMetki, PRIXOD1);
    for i := 0 to High(pMetki) do with pMetki[i] do begin
          mColor := 1;
          mTimelife := -1;
    end;
  //  end;
  //  if pNPminus=true then begin
    pNegative := PRIXOD2;
    D := Length(pMetki) + PRIXOD2;
    SetLength(pMetki,D);
    for i := (Length(pMetki) - PRIXOD2) to High(pMetki) do with pMetki[i] do begin
          mColor := 2;
          mTimelife := -1;
    end;
    end
    else begin
     if (pNPplus = true) then begin
     pNPplus := false; pNPminus := false;
     pPositive := PRIXOD1;
     SetLength(pMetki, PRIXOD1);
     for i := 0 to High(pMetki) do with pMetki[i] do begin
          mColor := 1;
          mTimelife := -1;
     end;
     pNegative := 0;
     end;
     if (pNPminus = true) then begin
     pNPplus := false; pNPminus := false;
     pNegative := PRIXOD2;
     SetLength(pMetki, PRIXOD2);
     for i := 0 to High(pMetki) do with pMetki[i] do begin
          mColor := 2;
          mTimelife := -1;
     end;
     pPositive := 0;
     end;
    end;
  pNPdel := true;
  pModel.mChange := true;
 end
 else begin
  if ((pFlag = 1) and (es = 0))then begin
   pPositive := 0;
   pNegative := 0;
   SetLength(pMetki, 0);
   pMetki := Nil;
   pNPdel := true;
   pModel.mChange := true;
  end
  else begin
    Dec(pPositive, x);
    Dec(pNegative, y);
   l := (Q - 1);
    repeat
  // for i:=0 to High(pMetki) do with pMetki[i] do
    i := 0;
    while (i < (Length(pMetki))) do with (pMetki[i]) do
    begin
    fl := 0;
    if ((SumUd1 = x) and (SumUd2 = y)) then break
    else  begin
      if ((mTimelife = l) and (mColor = 1) and (SumUd1 <> x)) then
      begin
        fl := 1;
        for j := i to (Length(pMetki) - 1) do begin
          pMetki[j] := pMetki[j + 1];
        end;
       SetLength(pMetki, Length(pMetki) - 1);
       Inc(SumUd1);
      end;
       if ((mTimelife = l) and (mColor = 2) and (SumUd2 <> y)) then
       begin
       fl := 1;
        for j := i to (Length(pMetki) - 1) do begin
          pMetki[j] := pMetki[j + 1];
        end;
       SetLength(pMetki, Length(pMetki) - 1);
       Inc(SumUd2);
       end;

   end;
   if (fl = 0) then Inc(i);
  end;
   if ((SumUd1 < x) or (SumUd2 < y)) then Dec(l);
 until ((SumUd1 = x) and (SumUd2 = y));
    pModel.mChange := true;
 end;
 end;
end;

function TPosizia.CanRecieve: Integer;
begin
  Result := pMaxVolume - pPositive - pNegative;
end;

procedure TPosizia.Recieve (x: Integer; y: Integer);
var X1, R, i: integer;

begin
 // s1:=IntToStr(x);
  //s2:=IntToStr(y);
 // Showmessage(s1);
 // Showmessage(s2);
  X1 := Min((x + y), CanRecieve);
  if (X1 < (x + y)) then Exit;
       if (x <> 0) then
        begin
          if (pFlag = 1) then
           begin
           pNPplus := true;
           PRIXOD1 := PRIXOD1 + x;
       //    s2:=IntToStr(PRIXOD1);
        //  Showmessage(s2);
           end;
          R := length(pMetki);
          SetLength(pMetki, (R + x));
          for i := R to High(pMetki) do with pMetki[i] do begin
          mColor := 1;
          mTimelife := -1;
          end;
          repeat
            Inc(pPositive);
            Inc(pTotal);
            Dec(x);
          until (x <= 0);
        end;
        If (y <> 0) then
        begin
          if (pFlag = 1) then
          begin
          pNPminus := true;
          PRIXOD2 := PRIXOD2 + y;
          end;
          R := length(pMetki);
          SetLength(pMetki, (R + y));
          for i := R to High(pMetki) do with pMetki[i] do begin
          mColor := 2;
          mTimelife := -1;
          end;
          repeat
          Inc(pNegative);
          Inc(pTotal);
          Dec(y);
          until (y <= 0);
        end;
   pModel.mChange := true;
end;

function TPosizia.NPodschet (m1, m2: array of Real): Real;
var
 C: array of Real;
 i, g, d, d1: Integer;
 S1, S2, P3: Real;
begin
 d1 := 0;
 d := Length(m1);
 SetLength(C, d*2);
 S1 := 0; S2 := 0; P3 := 0; g := 0;
 for i := 0 to Length(Uravn.Eq) do
  if Uravn.Eq[i] <> 0 then d1 := 1;
 if (d1 = 1) then
 begin
  for i := 0 to (d - 1) do
  begin
   C[i] := Uravn.FormUravnenie.calculate(m1[i]);
   S1 := S1 + C[i];
  end;
  g := 0;
  for i := d to (d*2 - 1) do
  begin
   C[i] := Uravn.FormUravnenie.calculate(m2[g]);
   S2 := S2 + C[i];
   Inc(g);
  end;
 end
 else begin
 for i := 0 to (d - 1) do
 begin
   C[i] := ((Q - i) / Q) * m1[i];
   S1 := S1 + C[i];
 end;
 g := 0;
 for i := d to (d*2 - 1) do
 begin
   C[i] := ((Q - g) / Q)* m2[g];
   S2 := S2 + C[i];
   Inc(g);
 end;
 end;
 P3 := S1 - S2;
 Result := P3;
end;

 { TPerexod }
constructor TPerexod.Create (model: TModel);
begin
  pModel := model;
  pSrab := 0;
  pStopping := false;
  pStops := 0;
  pPrior := 0;
  pRab := 0;
  pSchetchik := 0;
  pPok := 0;
end;

function TPerexod.CanTransfer: Boolean;
Label A;
var
  i: Integer;
  
begin
	Result := false;
	// ������� ������ ����� ������� � �������� ����
	if  ((Length(pInDugi) = 0) or (Length(pOutDugi) = 0)) then Exit;

	// ��� ����� ������ ����� ���-�� ����� �������������� ���� � ����� ������� ���
	for i := 0 to High(pInDugi) do with pInDugi[i] do begin

    if  (dPosizia.pFlag = 1)  then   goto A;
    if (dPosizia.CanSend1 < dWes1) then Exit;
    if (dPosizia.CanSend2 < dWes2) then Exit;
   A:	end;
   //������������ ���� ��������� ������������ ���������
  	for i := 0 to High(pIngib) do with pIngib[i] do begin
     // if ((dWes1=0) and (dWes2=0)) then begin
     //  ShowMessage('�� ������ ��� ������������ ����!');
     //  Exit;
     // end;
      if ((dZnak1 <> 0) and (dZnak2 = 0)) then begin
       if dZnak1 = 1 then
       if dPosizia.pPositive > dWes1 then Exit;
       if dZnak1 = 2 then
       if dPosizia.pPositive < dWes1 then Exit;
       if dZnak1 = 3 then
       if dPosizia.pPositive = dWes1 then Exit;
       if dZnak1 = 4 then
       if dPosizia.pPositive <> dWes1 then Exit;
       if dZnak1 = 5 then
       if dPosizia.pPositive >= dWes1 then Exit;
       if dZnak1 = 6 then
       if dPosizia.pPositive <= dWes1 then Exit;
      end;
      if ((dZnak2 <> 0) and (dZnak1 = 0)) then begin
       if dZnak2 = 1 then
       if dPosizia.pNegative > dWes2 then Exit;
       if dZnak2 = 2 then
       if dPosizia.pNegative < dWes2 then Exit;
       if dZnak2 = 3 then
       if dPosizia.pNegative = dWes2 then Exit;
       if dZnak2 = 4 then
       if dPosizia.pNegative <> dWes2 then Exit;
       if dZnak2 = 5 then
       if dPosizia.pNegative >= dWes2 then Exit;
       if dZnak2 = 6 then
       if dPosizia.pNegative <= dWes2 then Exit;
      end;
      if ((dZnak1 <> 0) and (dZnak2 <> 0)) then begin
       if ((dZnak1 = 1) and (dZnak2 = 1)) then
        if ((dPosizia.pPositive > dWes1) and (dPosizia.pNegative > dWes2)) then Exit;
       if ((dZnak1 = 2) and (dZnak2 = 2)) then
        if ((dPosizia.pPositive<dWes1) and (dPosizia.pNegative < dWes2)) then Exit;
       if ((dZnak1 = 3) and (dZnak2 = 3)) then
        if ((dPosizia.pPositive=dWes1) and (dPosizia.pNegative = dWes2)) then Exit;
       if ((dZnak1 = 4) and (dZnak2 = 4)) then
        if ((dPosizia.pPositive <> dWes1) and (dPosizia.pNegative <> dWes2)) then Exit;
       if ((dZnak1 = 5) and (dZnak2 = 5)) then
        if ((dPosizia.pPositive>=dWes1) and (dPosizia.pNegative >= dWes2)) then Exit;
       if ((dZnak1 = 6) and (dZnak2 = 6)) then
        if ((dPosizia.pPositive <= dWes1) and (dPosizia.pNegative <= dWes2)) then Exit;
       if ((dZnak1 = 1) and (dZnak2 = 2)) then
        if ((dPosizia.pPositive > dWes1) and (dPosizia.pNegative < dWes2)) then Exit;
       if ((dZnak1 = 1) and (dZnak2 = 3)) then
        if ((dPosizia.pPositive > dWes1) and (dPosizia.pNegative = dWes2)) then Exit;
       if ((dZnak1 = 1) and (dZnak2 = 4)) then
        if ((dPosizia.pPositive > dWes1) and (dPosizia.pNegative <> dWes2)) then Exit;
       if ((dZnak1 = 1) and (dZnak2 = 5)) then
        if ((dPosizia.pPositive > dWes1) and (dPosizia.pNegative >= dWes2)) then Exit;
       if ((dZnak1 = 1) and (dZnak2 = 6)) then
        if ((dPosizia.pPositive > dWes1) and (dPosizia.pNegative >= dWes2)) then Exit;
       if ((dZnak1 = 2) and (dZnak2 = 1)) then
        if ((dPosizia.pPositive < dWes1) and (dPosizia.pNegative > dWes2)) then Exit;
       if ((dZnak1 = 2) and (dZnak2=3)) then
        if ((dPosizia.pPositive < dWes1) and (dPosizia.pNegative = dWes2)) then Exit;
       if ((dZnak1 = 2) and (dZnak2 = 4)) then
        if ((dPosizia.pPositive < dWes1) and (dPosizia.pNegative <> dWes2)) then Exit;
       if ((dZnak1 = 2) and (dZnak2 = 5)) then
        if ((dPosizia.pPositive < dWes1) and (dPosizia.pNegative >= dWes2)) then Exit;
       if ((dZnak1 = 2) and (dZnak2 = 6)) then
        if ((dPosizia.pPositive < dWes1) and (dPosizia.pNegative <= dWes2)) then Exit;
       if ((dZnak1 = 3) and (dZnak2 = 1)) then
        if ((dPosizia.pPositive = dWes1) and (dPosizia.pNegative > dWes2)) then Exit;
       if ((dZnak1 = 3) and (dZnak2 = 2)) then
        if ((dPosizia.pPositive = dWes1) and (dPosizia.pNegative < dWes2)) then Exit;
       if ((dZnak1 = 3) and (dZnak2 = 4)) then
        if ((dPosizia.pPositive = dWes1) and (dPosizia.pNegative <> dWes2)) then Exit;
       if ((dZnak1 = 3) and (dZnak2 = 5)) then
        if ((dPosizia.pPositive = dWes1) and (dPosizia.pNegative >= dWes2)) then Exit;
       if ((dZnak1 = 3) and (dZnak2 = 6)) then
        if ((dPosizia.pPositive = dWes1) and (dPosizia.pNegative <= dWes2)) then Exit;
       if ((dZnak1 = 4) and (dZnak2 = 1)) then
        if ((dPosizia.pPositive <> dWes1) and (dPosizia.pNegative > dWes2)) then Exit;
       if ((dZnak1 = 4) and (dZnak2 = 2)) then
        if ((dPosizia.pPositive <> dWes1) and (dPosizia.pNegative < dWes2)) then Exit;
       if ((dZnak1 = 4) and (dZnak2 = 3)) then
        if ((dPosizia.pPositive <> dWes1) and (dPosizia.pNegative = dWes2)) then Exit;
       if ((dZnak1 = 4) and (dZnak2 = 5)) then
        if ((dPosizia.pPositive <> dWes1) and (dPosizia.pNegative >= dWes2)) then Exit;
       if ((dZnak1 = 4) and (dZnak2 = 6)) then
        if ((dPosizia.pPositive <> dWes1) and (dPosizia.pNegative <= dWes2)) then Exit;
       if ((dZnak1 = 5) and (dZnak2 = 1)) then
        if ((dPosizia.pPositive >= dWes1) and (dPosizia.pNegative > dWes2)) then Exit;
       if ((dZnak1 = 5) and (dZnak2 = 2)) then
        if ((dPosizia.pPositive >= dWes1) and (dPosizia.pNegative < dWes2)) then Exit;
       if ((dZnak1 = 5) and (dZnak2 = 3)) then
        if ((dPosizia.pPositive >= dWes1) and (dPosizia.pNegative = dWes2)) then Exit;
       if ((dZnak1 = 5) and (dZnak2 = 4)) then
        if ((dPosizia.pPositive >= dWes1) and (dPosizia.pNegative <> dWes2)) then Exit;
       if ((dZnak1 = 5) and (dZnak2 = 6)) then
        if ((dPosizia.pPositive >= dWes1) and (dPosizia.pNegative <= dWes2)) then Exit;
       if ((dZnak1 = 6) and (dZnak2 = 1)) then
        if ((dPosizia.pPositive <= dWes1) and (dPosizia.pNegative > dWes2)) then Exit;
       if ((dZnak1 = 6) and (dZnak2 = 2)) then
        if ((dPosizia.pPositive <= dWes1) and (dPosizia.pNegative < dWes2)) then Exit;
       if ((dZnak1 = 6) and (dZnak2 = 3)) then
        if ((dPosizia.pPositive <= dWes1) and (dPosizia.pNegative = dWes2)) then Exit;
       if ((dZnak1 = 6) and (dZnak2 = 4)) then
        if ((dPosizia.pPositive <= dWes1) and (dPosizia.pNegative <> dWes2)) then Exit;
       if ((dZnak1 = 6) and (dZnak2 = 5)) then
        if ((dPosizia.pPositive <= dWes1) and (dPosizia.pNegative >= dWes2)) then Exit;
      end;
     end;
//	  end;

 // ��� ������ ������ ���� �������� ������� �����,��������������� ���� � ����� �������� ���
 	for i := 0 to High(pOutDugi) do with pOutDugi[i] do
	begin
		if (dPosizia.CanRecieve < (dWes1 + dWes2)) then
		begin
			if not pStopping then
			begin
				pStopping := true;
				Inc(pStops);
			end;
      if (pStopping = true) then
      pStopping := false;
			Exit;
		end;

	end;
 	Result := true;
end;

procedure TPerexod.Transfer;
var
	i: Integer;
begin
  pStopping := false;
	Inc(pSrab);
 	// ������� ����� �� ������� �������
  for i := 0 to High(pInDugi) do with pInDugi[i] do begin
    dPosizia.Send(dWes1, dWes2);
	end;
  // ���������� ������� �������� �������
	for i := 0 to High(pOutDugi) do with pOutDugi[i] do begin
		dPosizia.Recieve(dWes1, dWes2);
	end;
  pModel.mChange := true;
end;

{TModel}
constructor TModel.Create ;
begin
mChange := true;
end;

destructor TModel.Destroy;
var
	i: Integer;
begin
	for i := 0 to High(mPosition) do FreeAndNil(mPosition[i]);
	for i := 0 to High(mPerexod) do FreeAndNil(mPerexod[i]);
	inherited;
end;

procedure TModel.Step;
var
	i, j, l, a, opr, aa, b, u, e, Sh,  f, dd, O, y: Integer;

  h1, h2: Real;
  F1, F2: array of Real;
  V: boolean;
begin
 F1 := Nil; F2 := Nil; K1 := Nil; K2 := Nil; dd := 0; aa := 1; O := 0;
 Tupik := false;
 mChange := false;
 for i := 0 to High (mPosition) do with mPosition[i] do begin
   PRIXOD1 := 0; PRIXOD2 := 0;
 end;
 for i := 0 to High(mPerexod) do with mPerexod[mPriorPerex[i]] do begin
  opr := 0;
  for f := 0 to High(mPerexod)  do begin
   if ((mPerexod[f].pPrior = pPrior) and (mPerexod[f] <> mPerexod[mPriorPerex[i]])) then
    opr := 1;
  end;
  if opr = 1 then begin
  for f := 0 to High(mPerexod)  do begin
   if ((mPerexod[f] <> mPerexod[mPriorPerex[i]]) and (pRab = 0) and CanTransfer
       and (mPerexod[f].CanTransfer) and (mPerexod[f].pRab = 0) and
           (mPerexod[f].pPrior = pPrior) ) then
    aa := 0
   end;
  if aa = 0 then  begin
   pRab := 1;
   O := mPriorPerex[i];
  end;
  if (pRab = 1) then
   Inc(pSchetchik);
  if (pSchetchik > Q) then  begin
  for f := 0 to High(mPerexod)  do begin
   if ((mPerexod[f] <> mPerexod[mPriorPerex[i]]) and (pRab = 1) and CanTransfer
   and (mPerexod[f].CanTransfer) and (mPerexod[f].pRab = 0) and (mPerexod[f].pPrior = pPrior)  ) then  begin
    mPerexod[f].pRab := 1;
    pSchetchik := 0;
    mPerexod[f].pSchetchik := 0;
    dd := 1; Break;
   end;
  end;
   end;
 if dd = 0 then begin
   pSchetchik := 0;
    for f := 0 to High(mPerexod)  do
    mPerexod[f].pRab := 0;
   for f := 0 to High(mPerexod)  do  begin
    if  (mPerexod[f].pPrior = pPrior)  then begin
     if (mPerexod[f] = mPerexod[O]) then
     mPerexod[f].pRab := 1
     else
     mPerexod[f].pRab := 0;
    end;
   end;
  end;
 end;
 If ((opr = 0) and (CanTransfer)) then
  pRab := 1;

  if ((Ppok = 0)  and (pRab = 1) and (CanTransfer)) then Transfer;
  end; u := w + 1;
  SetLength(K1, x, u); SetLength(K2, x, u);
  if w <> 0 then begin
  Inc(w);
  end;
  for i := 0 to High (M) do with mPerexod[M[i]] do begin
  V := false;
   for b := 0 to High(pInDugi) do with pInDugi[b]do begin
      y := dPosizia.pNPnumber;
      K1[y, w] := dPosizia.pPositive;
      K2[y, w] := dPosizia.pNegative;
      e := w;
      if w < 4 then Sh := w
      else Sh := Q-1;
      Setlength(F1, Sh + 1);
      Setlength(F2, Sh + 1);
      for j := 0 to Sh do begin
       h1 := K1[y, e];
       h2 := K2[y, e];
       F1[j] := h1;
       F2[j] := h2;
       Dec(e);
      end;
   
      if (dPosizia.NPodschet(F1, F2) >= dPosizia.pNP) then
      V := true;
    end;
    if (V = true) then begin
    if (CanTransfer) then Transfer;
    end;
    end;

 if (mChange = false) then begin
  ShowMessage('��� ������������� ������ ���� �������� ��������� ��������!!!');
  Tupik := true;
  Exit;
 end;
end;

procedure TModel.Udalenie;
var    i, j, l, fl: Integer;

begin

for i := 0 to High(mPosition) do with mPosition[i] do begin
       j := 0;
   while (j < (Length(pMetki))) do with pMetki[j] do begin
       fl := 0;
     if ((mTimelife) < (Q - 1)) then begin
     Inc(mTimelife);
    end
    else begin
       if (mColor = 1) then begin
        Dec(pPositive);  fl := 1;
       for  l := j to (Length(pMetki) - 1)  do begin
        pMetki[l] := pMetki[l + 1];
       end;
       end;
      if (mColor = 2) then begin
        Dec(pNegative);  fl := 1;
        for  l := j to (Length(pMetki) - 1)  do begin
        pMetki[l] := pMetki[l + 1];
         end;
         end;
        SetLength(pMetki, (Length(pMetki) - 1));

    end;

    if (fl = 0) then Inc(j);
    end;
    end;
end;

end.





