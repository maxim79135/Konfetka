uses cmd, Lists, List_String, crt;

var s : List;
  a : pElem;
  str, par_1, par_2 : string;
  numb, err : integer;
  temp : command;
  
begin
  SetWindowTitle('��������� ������');
  repeat
  temp := ReadCommand();
  str := LowerCase(temp.first);
  par_1 := temp.second;
  par_2 := temp.third;
  writeln();
  case str of
    'pushf' :
      begin
        new(a);
        val(par_1, a^.Data, err);
        if (err = 0) and (par_2 = '') then PushF(s, a) 
        else if (par_2 <> '') or (par_1 = '') then writeln('�������� ����� ���������� �������') else
        writeln('������ ������� ������ ������� � ������');
      end;
      
    'pushb' :
      begin
        new(a);
        val(par_1, a^.Data, err);
        if (err = 0) and (par_2 = '') then PushB(s, a) 
        else if (par_2 <> '') or (par_1 = '') then writeln('�������� ����� ���������� �������') else
        writeln('������ ������� ������ ������� � ������');
      end;
    
    'popf' :
      begin
        if (PopF(s)) and (par_1 = '') and (par_2 = '') then writeln('������ ������� ������ �����')
        else if (par_1 <> '') or (par_2 <> '') then writeln('�������� ����� ���������� �������') else
        writeln('������ ����');
      end;
    
    'popb' :
      begin
        if (PopB(s)) and (par_1 = '') and (par_2 = '') then writeln('��������� ������� ������ �����')
        else if (par_1 <> '') or (par_2 <> '') then writeln('�������� ����� ���������� �������') else
        writeln('������ ����');
      end;
      
    'delelem' :
      begin
        val(par_1, numb, err);
        if (err = 0) and (par_2 = '') then begin
          if (DelElem(s, numb)) then writeln('������� � ������� ', numb,' ����� �� ������')
            else writeln('������� � ������� ', numb,' �� ������');
        end
        else if (par_2 <> '') then writeln('�������� ����� ���������� �������') 
        else if (err <> 0) then writeln('�������� ������ ��������');
      end;
    
    'insertf' :
      begin
        val(par_1, numb, err);
        if (err <> 0) then begin writeln('������ �������� ����� �������� ������'); {continue;} end;
        new(a);
        val(par_2, a^.Data, err);
        if (err = 0) then InsertF(s, numb, a) else writeln('������ ������� ������ ������� � ������');
      end;
    
    'insertb' :
      begin
        val(par_1, numb, err);
        if (err <> 0) then begin writeln('������ �������� ����� �������� ������'); {continue;} end;
        new(a);
        val(par_2, a^.Data, err);
        if (err = 0) then InsertB(s, numb, a) else writeln('������ ������� ������ ������� � ������');
      end;
    
    'print' :
      begin
        if (par_1 <> '') or (par_2 <> '') then writeln('�������� ����� ���������� �������') 
        else begin
          write('���������� ������: ');
          Print(s);
        end;
      end;
    
    'delete' :
      begin
        if (par_1 <> '') or (par_2 <> '') then writeln('�������� ����� ���������� �������') 
        else DeleteList(s);
      end;
    
    'size' :
      begin
        if (par_1 <> '') or (par_2 <> '') then writeln('�������� ����� ���������� �������') 
        else writeln('���������� ��������� � ������: ', Size(s));
      end;
    
    'clear' :
      begin
        if (par_1 <> '') or (par_2 <> '') then writeln('�������� ����� ���������� �������') 
        else clrscr();
      end;
    
    'help' :
      begin
        if (par_1 = '') and (par_2 = '') then begin
          writeln('1. ���������� �������� � ������ ������: "PushF"');
          writeln('2. ���������� �������� � ����� ������: "PushB"');
          writeln('3. ������ ����������� ������: "Print"');
          writeln('4. �������� ���� ��������� ������: "Delete"');
          writeln('5. �������� �������� � �������� ������� �� ������: "DelElem"');
          writeln('6. ���������� �������� ����� �������� � ������: "InsertF"');
          writeln('7. ���������� �������� ����� ��������� � ������: "InsertB"');
          writeln('8. �������� ������� �������� ������: "PopF"');
          writeln('9. �������� ���������� �������� ������: "PopB"');
          writeln('10. ���������� ��������� ������: "Size"');
          writeln('11. ����� �� ���������: "exit"');
          writeln('12. ������� ����������� ������: "clear"');
        end
        else if (par_1 <> '') and (par_2 = '') then begin
          par_1 := LowerCase(par_1);
          case par_1 of
            'pushf' : writeln('PushF <numb>(numb : integer)');
            'pushb' : writeln('PushB <numb>(numb : integer)');
            'print' : writeln('Print <non parametres>');
            'delete' : writeln('Delete <non parametres>');
            'delelem' : writeln('DelElem <�����_��������>');
            'insertf' : writeln('InsertF <�����_��������> <numb>(numb : integer)');
            'insertb' : writeln('InsertB <�����_��������> <numb>(numb : integer)');
            'popf' : writeln('PopF <non parametres>');
            'popb' : writeln('PopB <non parametres>');
            'size' : writeln('Size <non parametres>');
            'clear' : writeln('clear <non parametres>');
            'exit' : writeln('exit <non parametres>');
          end;
        end;
      end;
      
    '' :
      begin
      
      end;
      
    'exit' :
      begin
      
      end
      else begin
        writeln('������ ������� �� ������ � ������ ���������');
        writeln('���������� � ������� ����� ������ ��� ������ ��������� ����� help');
      end;
  end;
  
  until (str = 'exit');
end.