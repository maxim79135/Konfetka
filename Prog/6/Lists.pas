unit Lists;

interface
  type pElem = ^Elem;
  Elem = record
    Data : integer;
    pnext : pElem;
    pprev : pElem;
  end;

  List = record
    pfirst : pElem;
    plast : pElem;
  end;

  procedure PushF(var s : List; const pnumber : pElem);
  procedure PushB(var s : List; const pnumber : pElem);
  procedure Print(var s : List);
  procedure DeleteList(var s : List);
  function Size(var s : List) : integer;
  function PopF(var s : List) : boolean;
  function PopB(var s : List) : boolean;

implementation
  procedure PushF(var s : List; const pnumber : pElem);
  begin
    if (pnumber = nil) then exit;

    pnumber^.pnext := nil;
    pnumber^.pprev := nil;

    if (s.pfirst = nil) then begin
      s.pfirst := pnumber;
      s.plast := pnumber;
    end else begin
      pnumber^.pnext := s.pfirst;
      s.pfirst^.pprev := pnumber;
      s.pfirst := pnumber;
    end;
  end;

  procedure PushB(var s : List; const pnumber : pElem);
  begin
    if (pnumber = nil) then exit;

    pnumber^.pnext := nil;
    pnumber^.pprev := nil;

    if (s.pfirst = nil) then begin
      s.pfirst := pnumber;
      s.plast := pnumber;
    end else begin
      s.plast^.pnext := pnumber;
      pnumber^.pprev := s.plast;
      s.plast := pnumber;
    end;
  end;

  procedure Print(var s : List);
  var x : pElem;
    i : integer;
  begin
    x := s.pfirst;
    write('(');
    i := 0;
    while (x <> nil) do begin
      inc(i);
      if (i > 1) then write(', ');
      write(x^.Data);
      x := x^.pnext;
    end;
    writeln(')');
  end;

  procedure DeleteList(var s : List);
  var next, del : pElem;
  begin
    if (s.pfirst = nil) then exit;

    next := s.pfirst;
    while (next <> nil) do begin
      del := next;
      next := next^.pnext;
      dispose(del);
    end;

    s.pfirst := nil;
    s.plast := nil;
  end;

  function GetElem(var s : List; const number : integer) : pElem;
  var i : integer;
    next, res : pElem;
  begin
    res := nil;

    i := 1;
    next := s.pfirst;
    while (i <= number) and (next <> nil) do begin
      if (i = number) then begin
        res := next;
        break;
      end;
      inc(i);
      next := next^.pnext;
    end;

    GetElem := res;
  end;

  function DelByPoint(var s : List; var pElement : pElem) : boolean;
  begin
    DelByPoint := false;

    if (pElement = nil) then exit;

    if (pElement = s.pfirst) then begin
      s.pfirst := pElement^.pnext;
      if (s.pfirst = nil) then
        s.plast := nil
      else
        s.pfirst^.pprev := nil;
     end else if (pElement = s.plast) then begin
      s.plast := pElement^.pprev;
      if (s.plast = nil) then
        s.pfirst := nil
      else
        s.plast^.pnext := nil;
     end else begin
      pElement^.pprev^.pnext := pElement^.pnext;
      pElement^.pnext^.pprev := pElement^.pprev;
     end;

     dispose(pElement);
     pElement := nil;
     DelByPoint := true;
  end;

  function PopF(var s : List) : boolean;
  var x : pElem;
  begin
    x := s.pfirst;
    PopF := DelByPoint(s, x);
  end;

  function PopB(var s : List) : boolean;
  var x : pElem;
  begin
    x := s.plast;
    PopB := DelByPoint(s, x);
  end;

  function Size(var s : List) : integer;
  var count : integer;
    pElement : pElem;
  begin
    count := 0;
    pElement := s.pfirst;
    while (pElement <> nil) do begin
      inc(count);
      pElement := pElement^.pnext;
    end;
    Size := count;
  end;

end.
