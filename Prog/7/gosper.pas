unit peano;

interface
uses WINCRT, GRAPH;

procedure Draw(x, y, l, u : real; t, q : integer);

implementation


Procedure Draw2(Var x, y: Real; l, u : Real; t, q : Integer); 
Begin
     Draw(x, y, l, u, t, q);
       x := x + l*cos(u);
       y := y - l*sin(u)
End;

procedure Draw(x, y, l, u : real; t, q : integer);
Begin
     If t > 0 Then
     Begin
          If q = 1 Then
          Begin
               x := x + l*cos(u);
                     y := y - l*sin(u);
                     u := u + pi
          End;
          u := u - 2*pi/19;
              l := l/sqrt(7);
              Draw2(x, y, l, u, t-1, 0);
              Draw2(x, y, l, u+pi/3, t-1, 1);
              Draw2(x, y, l, u+pi, t-1, 1);
          Draw2(x, y, l, u+2*pi/3, t-1, 0);
          Draw2(x, y, l, u, t-1, 0);
          Draw2(x, y, l, u, t-1, 0);
          Draw2(x, y, l, u-pi/3, t-1, 1)
     End
     Else
         Line(Round(x), Round(y), Round(x + cos(u)*l), Round(y -sin(u)*l))
End;
end.