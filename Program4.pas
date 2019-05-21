var a,b:array[1..1000000] of longint;
    n,i,j,k:longint;
    t, f : text;
begin
assign(f, 'input.txt');
reset(f);
readln(f, n);
writeln;
for i:=1 to n do begin
  read(f, a[i]);
  b[i]:=-1;
end;

for i:=1 to n do
 begin
  k:=0;
  for j:=1 to n do k:=k+1;//if a[j]<a[i] then k:=k+1;
  b[k+1]:=a[i];
 end;

//for i:=2 to n do
//if b[i]=-1 then b[i]:=b[i-1];

assign(t, 'output.txt');
rewrite(t);
for i:=1 to n do
write(t, b[i],' ');

close(f);
close(t);
end.
