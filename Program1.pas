var
    a: real;
 
procedure p(a: real);
    begin
        a := 10 * a;
    end;
 
begin
    a := 2.0;
    p(a);
    writeln(' a = ', a);
end.

