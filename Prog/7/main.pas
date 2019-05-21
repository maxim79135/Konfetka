uses peano, WINCRT, GRAPH;

type
 num = integer;

var
 Gdrr, Gmrr: num;
 x, y, depth, MAX_X, MAX_Y : integer;
 k : real;
 key: char;

begin
	Gdrr:=Detect;
	Gmrr:=GetMaxMode;
	InitGraph(Gdrr, Gmrr, '');
	SetBkColor (15);
	SetColor (1);
	SetFillStyle (1,1);
  ClearViewPort();

	MAX_X := GetMaxX; MAX_Y := GetMaxY;
	x := 500; y := 400; depth := 3; k := 1.0;
	Draw(x, y, 400, 0, depth, 0);
	OutTextXY (10,10, 'Arrows: moving');
 	OutTextXY (10,20, 'Pg Up, Pg Dn: scaling');
 	OutTextXY (10,30, 'Home, End: recursion depth');
	repeat
  key:=WINcrt.ReadKey();
  if key=#0 then
  	begin
  		key:=WINcrt.ReadKey();
			case key of
			 #72: //up
				begin
					if y >= 20 then
					begin
						ClearViewPort;
						y:=y-20;
						Draw(x, y, 400 * k, 0, depth, 0);
					end;
				end;

				#80: //down
				begin
					if y <= MAX_Y - 20 then
					begin
						ClearViewPort;
						y:=y+20;
						Draw(x, y, 400 * k, 0, depth, 0);
					end;
				end;

				#75: //left
				begin
					if x >= 20 then
					begin
						ClearViewPort;
						x:=x-20;
						Draw(x, y, 400 * k, 0, depth, 0);
					end;
				end;

				#77: //up
				begin
					if x <= MAX_X - 20 then
					begin
						ClearViewPort;
						x:=x+20;
						Draw(x, y, 400 * k, 0, depth, 0);
					end;
				end;

				#71: //home
				begin
					if depth <= 5 then
					begin
						ClearViewPort;
						depth:=depth+1;
						Draw(x, y, 400 * k, 0, depth, 0);
					end;
				end;

				#79: //end
				begin
					if depth >= 1 then
					begin
						ClearViewPort;
						depth:=depth-1;
						Draw(x, y, 400 * k, 0, depth, 0);
					end;
				end;

				#73: //pg up
				begin
					if k < 2 then
					begin
						ClearViewPort;
						k := k * 1.1;
						Draw(x, y, 400 * k, 0, depth, 0);
					end;
				end;

				#81: //pg down
				begin
					if k > 0.5 then
					begin
						ClearViewPort;
						k := k / 1.1;
						Draw(x, y, 400*k, 0, depth, 0);
					end;
				end;
			end;
			OutTextXY (10,10, 'Arrows: moving');
 			OutTextXY (10,20, 'Pg Up, Pg Dn: scaling');
 			OutTextXY (10,30, 'Home, End: recursion depth');
		end;
 	until key=#27;
 end.