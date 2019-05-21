uses  Lists, crt;
const _SIZE = 8;
  width = 120;
type mas = array [1.._SIZE] of string;
var rk:char;
    s, s1,s2: string;
    beginy, posx, posy,i, s_2, code, count, kol : integer;
    lis : List;
    a : array [1..100000] of string;
    b : pelem;
    command : mas;

procedure tab(const str : string);
var buf : string;
  t : integer;
begin
  i:=1;
  buf := '';
  while (i <= length(s)) and (s[i] = ' ') do inc(i);

  if (Pos(LowerCase(copy(s, i, (wherey-beginy)* width + wherex - 2 - i)), str) = 1) then begin
    GoToXY((i + 2) mod width, beginy + (i + 2) div width);
    for t := 1 to length(s) - i + 1 do write(' ');
    GoToXY((i + 2) mod width, beginy + (i + 2) div width);
    write(str);
    for t := 1 to i - 1 do buf := buf + ' ';
    s := buf + str;
  end;
end;

procedure cmnd_str;
var i, t : integer;
 begin
    s1 := '';
    s2 := '';
    s:='';
    write('>:');
    beginy := wherey();
  repeat
   rk:=ReadKey;

  if rk=#0 then begin
   rk:=ReadKey;
  if (rk = #75) then begin
    if (wherex() > 3) and (wherey() = beginy)then GoToXY(wherex() - 1, wherey);
    if (wherex() = 1) and (beginy < wherey()) then GoToXY(width, wherey() - 1);
    if (wherey() > beginy) then GoTOXY(wherex() - 1,wherey());
  end;
  if (rk=#77) then begin
    if (wherex() + width * (wherey() - beginy) <= length(s) + 2) then GoToXY(wherex() + 1, wherey());
    if (wherex() = width) then GoToXY(1, wherey() + 1);
  end;

  if (rk=#72) then begin
    while (wherey() <> beginy) do begin
      DelLine();
      GoToXY(1, wherey() - 1);
    end;
    DelLine();
    GoToXY(1, wherey());
    if (count < kol - 1) then inc(count);
    s := a[kol-count];
    write('>:' + s);
  end;

  if (rk=#80) then begin
    while (wherey() <> beginy) do begin
      DelLine();
      GoToXY(1, wherey() - 1);
    end;
    DelLine();
    GoToXY(1, wherey());
    if (count > 1) then dec(count);
    s := a[kol-count];
    write('>:' + s);
  end;

   if rk=#83 then begin
    delete(s,(wherey-beginy)* width + (wherex - 2),1);
    posx := wherex();
    posy := wherey();
    GoToXY(3, beginy);
  for i := 1 to (length(s) + 1) do write(' ');
    GoToXY(3,beginy);
    write(s);
    GoToXY(posx, posy)
  end;

  end else if (rk>#31) and (rk<#123) then
  begin
    insert(rk,s,(wherey-beginy)* width + (wherex - 2));
    posx := wherex() + 1;
    posy := wherey();
    if (wherey() > 30) then begin clrscr(); write('>:'); beginy := 1; end else GoToXY(3,beginy);
    write(s);
    if (posx = width + 1) then GoToXY(1, posy + 1) else GoToXY(posx, posy);
  end;

   if rk=#8 then begin
      delete(s,(wherey-beginy)* width + (wherex - 3),1);
      posx := wherex();
      posy := wherey();
      GoToXY(3, beginy);
   for i := 1 to length(s) + 1 do write(' ');
      GoToXY(3,beginy);
      write(s);
   if (posy > beginy) and (posx = 1) then GoToXY(width, (posy - 1)) else
   if (posy > beginy) then GoToXY((posx-1), posy) else
   if (posy = beginy) and (posx = 3) then GoToXY(posx, posy) else
   if (posy = beginy) and (posx > 3) then GoToXY(posx-1,posy);
  end;

  if (rk = #9) then begin
  for t := 1 to _SIZE do tab(command[t]);
end;

  until rk = #13;
    if (kol > 100000) then kol := 1;
    a[kol] := s;
    inc(kol);
    count := 0;
    writeln;
  if (s <> '') then begin
    i:=1;
    while (i <= length(s))and (s[i] = ' ') do inc(i);
    if (Pos(' ', copy(s, i, length(s) - i + 1)) = 0) then begin
      s1 := copy(s, i, length(s) - i + 1);
      s2 := '';
    end else begin
      s1 := copy(s, i, Pos(' ', copy(s, i, length(s) - i + 1)) - 1);
      i:= i + Pos(' ', copy(s, i, length(s) - i + 1)) - 1;
    while (i <= length(s)) and (s[i] = ' ') do inc(i);
    if (Pos(' ', copy(s, i, length(s) - i)) = 0)
      then s2 := copy(s, i, length(s) - i + 1)
      else s2 := copy(s, i, Pos(' ', copy(s, i, length(s) - i)) - 1);
    end;
   end;
  end;

procedure help;
 begin
  writeln('help ');
  writeln('PushF[] - занесение элемента в начало списка ');
  writeln('PushB[] - занесение элемента в конец списка ');
  writeln('delete - удаление списка ');
  writeln('size - узнать количество элементов в списке ');
  writeln('output - вывести все элементы очереди ');
  writeln('clrscr - очистка экрана ');
  writeln('help - помощь ');
  writeln('стрелки вверх/вниз - история команд ');
  writeln('exit - выход из программы ');
 end;

begin
command[1] := 'help';
command[2] := 'pushf';
command[3] := 'pushb';
command[4] := 'popf';
command[5] := 'popb';
command[6] := 'size';
command[7] := 'print';
command[8] := 'exit';
command[9] := 'delete';

 kol := 1;
  repeat
  cmnd_str;
s1:=LowerCase(s1);
case s1 of
 'help': help;
 'pushf':
  begin
    new(b);
    val(s2,b^.data,code);
   if code=0 then
    PushF(lis, b)
   else writeln('Неправильный набор параметров');
  end;
'pushb':
 begin
    new(b);
    val(s2,b^.data,code);
    if code=0 then
     PushB(lis, b)
    else writeln('Неправильный набор параметров');
end;
'popf':
begin
if s2 = '' then popf(lis)
    else writeln('Неправильный набор символов')
end;
'popb':
begin
if s2 = '' then popb(lis)
else writeln('Неправильный набор символов')
end;
 'delete':
  begin
   if s2 = '' then DeleteList(lis)
   else writeln('Неправильный набор символов')
  end;
 'size':
  begin
   if s2 = '' then writeln(size(lis))
   else writeln('Неправильный набор символов')
  end;
 'print':
  begin
   if s2 = '' then print(lis)
   else writeln('Неправильный набор символов')
  end;
 'clrscr': ClrScr();
 '': write();
 'exit': exit;
else writeln('Неизвестная команда');
end;
until (s = 'exit');
end.
