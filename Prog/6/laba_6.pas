uses cmd, Lists, List_String, crt;

var s : List;
  a : pElem;
  str, par_1, par_2 : string;
  numb, err : integer;
  temp : command;
  
begin
  SetWindowTitle('Командная строка');
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
        else if (par_2 <> '') or (par_1 = '') then writeln('Неверное число параметров функции') else
        writeln('Данный элемент нельзя занести в список');
      end;
      
    'pushb' :
      begin
        new(a);
        val(par_1, a^.Data, err);
        if (err = 0) and (par_2 = '') then PushB(s, a) 
        else if (par_2 <> '') or (par_1 = '') then writeln('Неверное число параметров функции') else
        writeln('Данный элемент нельзя занести в список');
      end;
    
    'popf' :
      begin
        if (PopF(s)) and (par_1 = '') and (par_2 = '') then writeln('Первый элемент списка удалён')
        else if (par_1 <> '') or (par_2 <> '') then writeln('Неверное число параметров функции') else
        writeln('Список пуст');
      end;
    
    'popb' :
      begin
        if (PopB(s)) and (par_1 = '') and (par_2 = '') then writeln('Последний элемент списка удалён')
        else if (par_1 <> '') or (par_2 <> '') then writeln('Неверное число параметров функции') else
        writeln('Список пуст');
      end;
      
    'delelem' :
      begin
        val(par_1, numb, err);
        if (err = 0) and (par_2 = '') then begin
          if (DelElem(s, numb)) then writeln('Элемент с номером ', numb,' удалён из списка')
            else writeln('Элемент с номером ', numb,' не найден');
        end
        else if (par_2 <> '') then writeln('Неверное число параметров функции') 
        else if (err <> 0) then writeln('Неверный формат элемента');
      end;
    
    'insertf' :
      begin
        val(par_1, numb, err);
        if (err <> 0) then begin writeln('Указан неверный номер элемента списка'); {continue;} end;
        new(a);
        val(par_2, a^.Data, err);
        if (err = 0) then InsertF(s, numb, a) else writeln('Данный элемент нельзя занести в список');
      end;
    
    'insertb' :
      begin
        val(par_1, numb, err);
        if (err <> 0) then begin writeln('Указан неверный номер элемента списка'); {continue;} end;
        new(a);
        val(par_2, a^.Data, err);
        if (err = 0) then InsertB(s, numb, a) else writeln('Данный элемент нельзя занести в список');
      end;
    
    'print' :
      begin
        if (par_1 <> '') or (par_2 <> '') then writeln('Неверное число параметров функции') 
        else begin
          write('Содержимое списка: ');
          Print(s);
        end;
      end;
    
    'delete' :
      begin
        if (par_1 <> '') or (par_2 <> '') then writeln('Неверное число параметров функции') 
        else DeleteList(s);
      end;
    
    'size' :
      begin
        if (par_1 <> '') or (par_2 <> '') then writeln('Неверное число параметров функции') 
        else writeln('Количество элементов в списке: ', Size(s));
      end;
    
    'clear' :
      begin
        if (par_1 <> '') or (par_2 <> '') then writeln('Неверное число параметров функции') 
        else clrscr();
      end;
    
    'help' :
      begin
        if (par_1 = '') and (par_2 = '') then begin
          writeln('1. Добавление элемента в начало списка: "PushF"');
          writeln('2. Добавление элемента в конец списка: "PushB"');
          writeln('3. Печать содержимого списка: "Print"');
          writeln('4. Удаление всех элементов списка: "Delete"');
          writeln('5. Удаление элемента с заданным номером из списка: "DelElem"');
          writeln('6. Добавление элемента перед заданным в список: "InsertF"');
          writeln('7. Добавление элемента после заданного в список: "InsertB"');
          writeln('8. Удаление первого элемента списка: "PopF"');
          writeln('9. Удаление последнего элемента списка: "PopB"');
          writeln('10. Количество элементов списка: "Size"');
          writeln('11. Выход из программы: "exit"');
          writeln('12. Очистка содержимого экрана: "clear"');
        end
        else if (par_1 <> '') and (par_2 = '') then begin
          par_1 := LowerCase(par_1);
          case par_1 of
            'pushf' : writeln('PushF <numb>(numb : integer)');
            'pushb' : writeln('PushB <numb>(numb : integer)');
            'print' : writeln('Print <non parametres>');
            'delete' : writeln('Delete <non parametres>');
            'delelem' : writeln('DelElem <номер_элемента>');
            'insertf' : writeln('InsertF <номер_элемента> <numb>(numb : integer)');
            'insertb' : writeln('InsertB <номер_элемента> <numb>(numb : integer)');
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
        writeln('Данная команда не входит в список доступных');
        writeln('Информацию о комадах можно узнать при вызове ключегого слова help');
      end;
  end;
  
  until (str = 'exit');
end.