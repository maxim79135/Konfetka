unit cmd;
interface
  uses crt, List_String;
  type command = record
    first, second, third : string;
  end;
  var d : char;
    s, test : string;
    pozy, poz, i, beginy, count : longint;
    final_string : command;
    command_str, pcurstr : pstr;
    plist_str : List_str;
  function ReadCommand() : command;

implementation
  function ReadCommand() : command;
  begin
  s := '';
  final_string.first := '';
  final_string.second := '';
  final_string.third := '';
  write('>:');
  beginy := wherey();
  repeat
    d := ReadKey();
    if (d = #0) then begin
      d := ReadKey();  
      if (d = #46) and (length(s) <> 0) then begin
        //if (length(s) = 1) or (length(s) = 0) then beginy := wherey();
        poz := wherex();
        pozy := wherey();
        GoToXY(1, length(s) div 120 + beginy);
        while (wherey() <> beginy) do begin
          ClearLine();
          GoToXY(1, wherey() - 1);
        end;
        //ClearLine();
        GoToXY(1, beginy);
        for var i := 1 to 120 do write(' ');
        GoToXY(1, beginy);
        s := copy(s, 1, (pozy - beginy) * 120 + poz - 1) + copy(s, (pozy - beginy) * 120 + poz + 1, length(s) - (pozy - beginy) * 120 + poz);
        write(s);
        GoToXY(poz, pozy);
      end;
      
      if (d = #38) then begin
        //if (length(s) = 1) or (length(s) = 0) or (s = '>:') then beginy := wherey();
        if (count < Size(plist_str)) then inc(count);
        poz := wherex();
        pozy := wherey();
        while (wherey() <> beginy) do begin
          ClearLine();
          GoToXY(1, wherey() - 1);
        end;
        ClearLine();
       pcurstr := NextCommand(plist_str, Size(plist_str) - count);
       if (pcurstr <> nil) then s := '>:' + pcurstr^.Data else s := '>:';
       write(s);
      end;
      
      if (d = #40) then begin
        //if (length(s) = 1) or (length(s) = 0) or (s = '>:') then beginy := wherey();
        if (count  > 1) then dec(count);
        poz := wherex();
        pozy := wherey();
        while (wherey() <> beginy) do begin
          ClearLine();
          GoToXY(1, wherey() - 1);
        end;
        ClearLine();
       pcurstr := NextCommand(plist_str, Size(plist_str) - count);
       if (pcurstr <> nil) then s := '>:' + pcurstr^.Data else s := '>:';
       write(s);
      end;
      
      if (d = #37) then begin
        //if (length(s) = 1) or (length(s) = 0) then beginy := wherey();
        if (wherex() = 1) and (wherey() > beginy) then GoToXY(120, wherey() - 1);
        if (wherey() > beginy) then GoToXY(wherex() - 1, wherey());
        if (wherey() = beginy) and (wherex() > 3) then GoToXY(wherex() - 1, wherey());
      end;
      
      if (d = #39) then begin
        //if (length(s) = 1) or (length(s) = 0) then beginy := wherey();
        if (wherex() + 120 * (wherey() - beginy) <= length(s)) then GoToXY(wherex() + 1, wherey());
        if (wherex() = 120) then GoToXY(1, wherey() + 1);
      end;
    end
    else if (d >= #32) and (d <= #126) then begin
      if (length(s) = 1) or (length(s) = 0) or (s = '>:') then beginy := wherey();
      poz := wherex();
      pozy := wherey();
      while (wherey() <> beginy) do begin
        ClearLine();
        GoToXY(1, wherey() - 1);
      end;
      ClearLine();
      s := '>:' + copy(s, 3, (pozy - beginy) * 120 + poz - 3) + d + copy(s, (pozy - beginy) * 120 + poz, length(s) - (pozy - beginy) * 120 + poz);
      write(s);
      if (poz = 120) then GoToXY(1, pozy + 1)
      else GoToXY(poz + 1, pozy);
    end
    else if (d = #8) then begin
      if (length(s) = 1) or (length(s) = 0) then beginy := wherey();
      poz := wherex();
      pozy := wherey();
      {while (wherey() <> beginy) do begin
        ClearLine();
        GoToXY(1, wherey() - 1);
      end;
      //ClearLine();}
      GoToXY(1, beginy);
      for var i := 1 to length(s) do write(' ');
      GoToXY(1, beginy);
      s := '>:' + copy(s, 3, (pozy - beginy) * 120 + poz - 4) + copy(s, (pozy - beginy) * 120 + poz, length(s) - (pozy - beginy) * 120 + poz);
      write(s);
      if (poz = 1) and (pozy <> beginy) then GoToXY(120, pozy - 1) else
      if (poz > 3) and (pozy = beginy) then GoToXY(poz - 1, pozy) else
      if (pozy > beginy) then GoToXY(poz - 1, pozy) else 
      if (poz = 3) and (pozy = beginy) then GoToXY(poz, pozy);
    end
    else if (d = #9) then begin
      test := s;
      //s := copy(s, 3, length(s) - 2);
      s := copy(s, 3, wherex() - 1);
      i := 1;
      while (length(s) <> 0) and (s[i] = ' ') do delete(s, i, 1);
      i := length(s);
      while (length(s) <> 0) and (s[i] = ' ') do begin delete(s, i, 1); dec(i); end;
      i := length(s);
      while (i > 0) and (s[i] <> ' ') do dec(i);
      s := copy(s, 1, wherex());
      s := LowerCase(s);
      if (s in 'print') and (s <> '') and (s <> 'in') then s := 'Print'
        else if (s = 'pu') or (s = 'pus') or (s = 'push') or (s = 'pushb') then s := 'PushF'
        else if (s = 'pushf') then s := 'PushB'
        else if (s = 'po') or (s = 'pop') or (s = 'popb') then s := 'PopF'
        else if (s = 'popf') then s := 'PopB'
        else if (s = 'de') or (s = 'del') or (s = 'dele') or (s = 'delet') or (s = 'delelem') then s := 'Delete'
        else if (s = 'delete') then s := 'DelElem'
        else if (s = 'in') or (s = 'ins') or (s = 'inse') or (s = 'inser') or (s = 'insert') or (s = 'insertb') then s := 'InsertF'
        else if (s = 'insertf') then s := 'InsertB'
        else if (s in 'size') and (s <> '') and (s <> 'e') then s := 'Size'
        else if (s in 'help') and (s <> '') and (s <> 'e') then s := 'help'
        else if (s in 'exit') and (s <> '') then s := 'exit'
        else if (s in 'clear') and (s <> '') and (s <> 'e') then s := 'clear';
      
      //if (length(s) = 1) or (length(s) = 0) or (s = '>:') then beginy := wherey();
      poz := wherex();
      pozy := wherey();
      while (wherey() <> beginy) do begin
        ClearLine();
        GoToXY(1, wherey() - 1);
      end;
      ClearLine();
      
      test := copy(test, 1, i + 2); 
      //s := test + s;
      s := '>:' + s;
      write(s);
    end;
  until d = #13;
  
  //Обработка строки, принятие достойного вида для неё
  s := copy(s, 3, length(s) - 2);
  if (s = '') then begin ReadCommand := final_string; end;
  i := 1;
  while (length(s) <> 0) and (s[i] = ' ') do delete(s, i, 1);
  if (pos(' ', s) = 0) then  begin
    final_string.first := s;
    delete(s, 1, length(s));
  end
  else begin
    final_string.first := copy(s, 1, pos(' ', s) - 1);
    delete(s, 1, pos(' ', s) - 1);
  end;
  
  if (s = '') then begin ReadCommand := final_string; end;
  i := 1;
  while (length(s) <> 0) and (s[i] = ' ') do delete(s, i, 1);
  if (pos(' ', s) = 0) then begin 
    final_string.second := s;
    delete(s, 1, length(s));
  end
  else begin
    final_string.second := copy(s, 1, pos(' ', s) - 1);
    delete(s, 1, pos(' ', s) - 1);
  end;
  
  if (s = '') then begin ReadCommand := final_string; end;
  i := 1;
  while (length(s) <> 0) and (s[i] = ' ') do delete(s, i, 1);
  if (pos(' ', s) = 0) then begin 
    final_string.third := s;
    delete(s, 1, length(s));
  end
  else begin
    final_string.third := copy(s, 1, pos(' ', s) - 1);
    delete(s, 1, pos(' ', s) - 1);
  end;
  
  new(command_str);
  if (final_string.second <> '') then begin
    if (final_string.third <> '') then
      command_str^.Data := final_string.first + ' ' + final_string.second + ' ' + final_string.third
    else
      command_str^.Data := final_string.first + ' ' + final_string.second;
  end 
    else 
      command_str^.Data := final_string.first;
  if (command_str^.Data <> '') then PushCommand(plist_str, command_str);
  count := 0;
  ReadCommand := final_string;
  end;
end.