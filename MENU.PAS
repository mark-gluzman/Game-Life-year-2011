unit menu;
interface

   const V2=2;
         V5=5;
         V3=3;
         V7=7;
         V8=8;

   type st2=array[1..V2] of string[20];
        st5=array[1..V5] of string[20];
        st3=array[1..V3] of string[20];
        st7=array[1..V7] of string[20];
        st8=array[1..V8] of string[20];
        s20=string[20];
        fnm=file of s20;
   function menug (x1,y1,x2,y2,r:word; s:st2):byte;
   function menuv5 (x1,y1,x2,y2,r:word; s:st5):byte;
   function menuv2 (x1,y1,x2,y2,r:word; s:st2):byte;
   function menuv3 (x1,y1,x2,y2,r:word; s:st3):byte;
   function menuv7 (x1,y1,x2,y2,r:word; s:st7):byte;
   function menuv8 (x1,y1,x2,y2,r:word; s:st8):byte;
   function menuf(x1,y1,x2,y2,r:word):string;

implementation

uses graph, crt, mouse;


procedure knopka(s1:string; x1,y1,x2,y2:word; t:boolean);
 begin
  if t then
    setcolor(4)
       else
    setcolor(5);
  moveto(x1,trunc((y1+y2)/2));
  outtext(s1);
  end;

function menug (x1,y1,x2,y2,r:word; s:st2):byte;
var
 i:integer;
 x,z:integer;
 gr:array[1..V2,1..2] of integer;
 but:byte;
 x11,y11,x12,y12:word;
 ch:char;
begin
  knopka(s[1],x1,y1,x2,y2,true);
  gr[1,1]:=x1; gr[1,2]:=x2+r;
  for i:=2 to V2 do
    begin
      gr[i,1]:=x2+(i-1)*r+(i-2)*(x2-x1);
      gr[i,2]:=x2+(i-1)*(r+x2-x1)+r;
      knopka(s[i],gr[i,1],y1,gr[i,2]-r,y2,false);
    end;
    x:=1; z:=1; but:=4;
    while but<>0 do
     get_mouse_status(but,x11,y11);
    mouse_gotoxy(x1,y2);

    repeat
    SHOW_MOUSe;
      repeat
       get_mouse_status(but,x11,y11);
      until (x11<>x12) or (y11<>y12) or (but<>0) or keypressed;
  
  if keypressed then
       begin
        ch := ReadKey;
        if ch = char(0) then
          begin
           ch := ReadKey;
           if ch=#75 then z:=x-1;
           if ch=#77 then z:=x+1;
          end;
        end else
          begin
            x12:=x11;
            y12:=y11;
            if (y11>=y1-10) and (y11<y1+150) and (x11>=x1) then
              begin
                i:=0;
                repeat
                  i:=i+1;
                until ((gr[i,1]<=x11) and (gr[i,2]>=x11)) or (i=V2);
              end;
            z:=i;
          end;
        if (z<>x) then
          begin
            z:=z mod V2;
            if z=0 then z:=V2;
            hide_mouse;
            knopka(s[z],x2+(z-1)*r+(z-2)*(x2-x1),y1,x2+(z-1)*(r+x2-x1),y2,true);
            knopka(s[x],x2+(x-1)*r+(x-2)*(x2-x1),y1,x2+(x-1)*(r+x2-x1),y2,false);
            x:=z;
          end;
    until (but<>0) or (ch=#13);
    menug:=x;
    hide_mouse;
end;

function menuv2 (x1,y1,x2,y2,r:word; s:st2):byte;
var
 i:integer;
 x,z:integer;
 gr:array[1..V2,1..2] of integer;
 but:byte;
 x11,y11,x12,y12:word;
 ch:char;
begin
  knopka(s[1],x1,y1,x2,y2,true);
  gr[1,1]:=y1; gr[1,2]:=y2+r;
  for i:=2 to V2 do
    begin
      gr[i,1]:=y2+(i-1)*r+(i-2)*(y2-y1);
      gr[i,2]:=y2+(i-1)*(r+y2-y1)+r;
      knopka(s[i],x1,gr[i,1],x2,gr[i,2]-r,false);
    end;
    x:=1; z:=1; but:=4;
    while but<>0 do
     get_mouse_status(but,x11,y11);
    mouse_gotoxy(x1,y2);
    repeat

    SHOW_MOUSe;
      repeat

       get_mouse_status(but,x11,y11);
      until (x11<>x12) or (y11<>y12) or (but<>0) or keypressed;
      if keypressed then
       begin
       ch := ReadKey;
       if ch = char(0) then
       begin
        ch := ReadKey;
        if ch=#72 then z:=x-1;
        if ch=#80 then z:=x+1;
       end;
      end else
    begin
     x12:=x11;
     y12:=y11;
     if (x11>=x1-10) and (x11<x1+150) and (y11>=y1) then
      begin
        i:=0;
        repeat
         i:=i+1;
        until ((gr[i,1]<=y11) and (gr[i,2]>=y11)) or (i=V2);
      end;
      z:=i;
    end;
     if (z<>x) then
      begin
        z:=z mod V2;
        if z=0 then z:=V2;
        hide_mouse;
        knopka(s[z],x1,y2+(z-1)*r+(z-2)*(y2-y1),x2,y2+(z-1)*(r+y2-y1),true);
        knopka(s[x],x1,y2+(x-1)*r+(x-2)*(y2-y1),x2,y2+(x-1)*(r+y2-y1),false);
        x:=z;
      end;
    until (but<>0) or (ch=#13);
   menuv2:=x;
   hide_mouse;
 end;

function menuv3 (x1,y1,x2,y2,r:word; s:st3):byte;
var
 i:integer;
 x,z:integer;
 gr:array[1..V3,1..2] of integer;
 but:byte;
 x11,y11,x12,y12:word;
 ch:char;
begin
  knopka(s[1],x1,y1,x2,y2,true);
  gr[1,1]:=y1; gr[1,2]:=y2+r;
  for i:=2 to V3 do
    begin
      gr[i,1]:=y2+(i-1)*r+(i-2)*(y2-y1);
      gr[i,2]:=y2+(i-1)*(r+y2-y1)+r;
      knopka(s[i],x1,gr[i,1],x2,gr[i,2]-r,false);
    end;
    x:=1; z:=1; but:=4;
    while but<>0 do
     get_mouse_status(but,x11,y11);
    mouse_gotoxy(x1,y2);
    repeat

    SHOW_MOUSe;
      repeat

       get_mouse_status(but,x11,y11);
      until (x11<>x12) or (y11<>y12) or (but<>0) or keypressed;
      if keypressed then
       begin
       ch := ReadKey;
       if ch = char(0) then
       begin
        ch := ReadKey;
        if ch=#72 then z:=x-1;
        if ch=#80 then z:=x+1;
       end;
      end else
    begin
     x12:=x11;
     y12:=y11;
     if (x11>=x1-10) and (x11<x1+150) and (y11>=y1) then
      begin
        i:=0;
        repeat
         i:=i+1;
        until ((gr[i,1]<=y11) and (gr[i,2]>=y11)) or (i=V3);
      end;
      z:=i;
    end;
     if (z<>x) then
      begin
        z:=z mod V3;
        if z=0 then z:=V3;
        hide_mouse;
        knopka(s[z],x1,y2+(z-1)*r+(z-2)*(y2-y1),x2,y2+(z-1)*(r+y2-y1),true);
        knopka(s[x],x1,y2+(x-1)*r+(x-2)*(y2-y1),x2,y2+(x-1)*(r+y2-y1),false);
        x:=z;
      end;
    until (but<>0) or (ch=#13);
   menuv3:=x;
   hide_mouse;
 end;


function menuv5 (x1,y1,x2,y2,r:word; s:st5):byte;
var
 i:integer;
 x,z:integer;
 gr:array[1..V5,1..2] of integer;
 but:byte;
 x11,y11,x12,y12:word;
 ch:char;
begin
  knopka(s[1],x1,y1,x2,y2,true);
  gr[1,1]:=y1; gr[1,2]:=y2+r;
  for i:=2 to V5 do
    begin
      gr[i,1]:=y2+(i-1)*r+(i-2)*(y2-y1);
      gr[i,2]:=y2+(i-1)*(r+y2-y1)+r;
      knopka(s[i],x1,gr[i,1],x2,gr[i,2]-r,false);
    end;
    x:=1; z:=1; but:=4;
    while but<>0 do
     get_mouse_status(but,x11,y11);
    mouse_gotoxy(x1,y2);
    repeat

    SHOW_MOUSe;
      repeat

       get_mouse_status(but,x11,y11);
      until (x11<>x12) or (y11<>y12) or (but<>0) or keypressed;
      if keypressed then
       begin
       ch := ReadKey;
       if ch = char(0) then
       begin
        ch := ReadKey;
        if ch=#72 then z:=x-1;
        if ch=#80 then z:=x+1;
       end;
      end else
    begin
     x12:=x11;
     y12:=y11;
     if (x11>=x1-10) and (x11<x1+150) and (y11>=y1) then
      begin
        i:=0;
        repeat
         i:=i+1;
        until ((gr[i,1]<=y11) and (gr[i,2]>=y11)) or (i=V5);
      end;
      z:=i;
    end;
     if (z<>x) then
      begin
        z:=z mod V5;
        if z=0 then z:=V5;
        hide_mouse;
        knopka(s[z],x1,y2+(z-1)*r+(z-2)*(y2-y1),x2,y2+(z-1)*(r+y2-y1),true);
        knopka(s[x],x1,y2+(x-1)*r+(x-2)*(y2-y1),x2,y2+(x-1)*(r+y2-y1),false);
        x:=z;
      end;
    until (but<>0) or (ch=#13);
   menuv5:=x;
   hide_mouse;
 end;

 function menuv7 (x1,y1,x2,y2,r:word; s:st7):byte;
var
 i:integer;
 x,z:integer;
 gr:array[1..V7,1..2] of integer;
 but:byte;
 x11,y11,x12,y12:word;
 ch:char;
begin
  knopka(s[1],x1,y1,x2,y2,true);
  gr[1,1]:=y1; gr[1,2]:=y2+r;
  for i:=2 to V7 do
    begin
      gr[i,1]:=y2+(i-1)*r+(i-2)*(y2-y1);
      gr[i,2]:=y2+(i-1)*(r+y2-y1)+r;
      knopka(s[i],x1,gr[i,1],x2,gr[i,2]-r,false);
    end;
    x:=1; z:=1; but:=4;
    while but<>0 do
     get_mouse_status(but,x11,y11);
    mouse_gotoxy(x1,y2);
    repeat

    SHOW_MOUSe;
      repeat

       get_mouse_status(but,x11,y11);
      until (x11<>x12) or (y11<>y12) or (but<>0) or keypressed;
      if keypressed then
       begin
       ch := ReadKey;
       if ch = char(0) then
       begin
        ch := ReadKey;
        if ch=#72 then z:=x-1;
        if ch=#80 then z:=x+1;
       end;
      end else
    begin
     x12:=x11;
     y12:=y11;
     if (x11>=x1-10) and (x11<x1+150) and (y11>=y1) then
      begin
        i:=0;
        repeat
         i:=i+1;
        until ((gr[i,1]<=y11) and (gr[i,2]>=y11)) or (i=V7);
      end;
      z:=i;
    end;
     if (z<>x) then
      begin
        z:=z mod V7;
        if z=0 then z:=V7;
        hide_mouse;
        knopka(s[z],x1,y2+(z-1)*r+(z-2)*(y2-y1),x2,y2+(z-1)*(r+y2-y1),true);
        knopka(s[x],x1,y2+(x-1)*r+(x-2)*(y2-y1),x2,y2+(x-1)*(r+y2-y1),false);
        x:=z;
      end;
    until (but<>0) or (ch=#13);
   menuv7:=x;
   hide_mouse;
 end;



 function menuv8 (x1,y1,x2,y2,r:word; s:st8):byte;
var
 i:integer;
 x,z:integer;
 gr:array[1..V8,1..2] of integer;
 but:byte;
 x11,y11,x12,y12:word;
 ch:char;
begin
  knopka(s[1],x1,y1,x2,y2,true);
  gr[1,1]:=y1; gr[1,2]:=y2+r;
  for i:=2 to V8 do
    begin
      gr[i,1]:=y2+(i-1)*r+(i-2)*(y2-y1);
      gr[i,2]:=y2+(i-1)*(r+y2-y1)+r;
      knopka(s[i],x1,gr[i,1],x2,gr[i,2]-r,false);
    end;
    x:=1; z:=1; but:=4;
    while but<>0 do
     get_mouse_status(but,x11,y11);

    mouse_gotoxy(x1,y2);
    repeat

    while keypressed do
      ch:=readkey;

    SHOW_MOUSe;
      repeat

       get_mouse_status(but,x11,y11);
      until (x11<>x12) or (y11<>y12) or (but<>0) or keypressed;
      if keypressed then
       begin
       ch := ReadKey;
       if ch = char(0) then
       begin
        ch := ReadKey;
        if ch=#72 then z:=x-1;
        if ch=#80 then z:=x+1;
       end;
      end else
    begin
     x12:=x11;
     y12:=y11;
     if (x11>=x1-10) and (x11<x1+150) and (y11>=y1) then
      begin
        i:=0;
        repeat
         i:=i+1;
        until ((gr[i,1]<=y11) and (gr[i,2]>=y11)) or (i=V8);
      end;
      z:=i;
    end;
     if (z<>x) then
      begin
        z:=z mod V8;
        if z=0 then z:=V8;
        hide_mouse;
        knopka(s[z],x1,y2+(z-1)*r+(z-2)*(y2-y1),x2,y2+(z-1)*(r+y2-y1),true);
        knopka(s[x],x1,y2+(x-1)*r+(x-2)*(y2-y1),x2,y2+(x-1)*(r+y2-y1),false);
        x:=z;
      end;
    until (but<>0) or (ch=#13);
   menuv8:=x;
   hide_mouse;
 end;

function menuf(x1,y1,x2,y2,r:word):string;
var
 gr:array[1..20,1..2] of word;
 s1:s20;
 fn:fnm;
 n1,i,x,z,but:byte;
 ch:char;
 x11,y11,x12,y12:word;
 s:array [1..20] of string[25];
 o:word;
begin
  assign(fn,'figname');
   {$I-}
    reset(fn);
    o:=ioresult;
    if o<>0 then
       begin
         setcolor(1);
         moveto(trunc((getmaxx*0.7))+20,trunc(getmaxy*0.4));
         outtext('file not found');
         menuf:='';
         readln;
       end  {$i+}
  else
  begin
  n1:=filesize(fn);

  for i:=1 to n1 do
   begin
    seek(fn,i-1);
    read(fn,s1);
    s[i]:=s1;
   end;
  close(fn);

   knopka(s[1],x1,y1,x2,y2,true);
  gr[1,1]:=y1; gr[1,2]:=y2+r;
  for i:=2 to n1 do
    begin
      gr[i,1]:=y2+(i-1)*r+(i-2)*(y2-y1);
      gr[i,2]:=y2+(i-1)*(r+y2-y1)+r;
      knopka(s[i],x1,gr[i,1],x2,gr[i,2]-r,false);
    end;
    x:=1; z:=1; but:=4;
    while but<>0 do
     get_mouse_status(but,x11,y11);

    mouse_gotoxy(x1,y2);
    repeat

    while keypressed do
      ch:=readkey;

    SHOW_MOUSe;
      repeat

       get_mouse_status(but,x11,y11);
      until (x11<>x12) or (y11<>y12) or (but<>0) or keypressed;
      if keypressed then
       begin
       ch := ReadKey;
       if ch = char(0) then
       begin
        ch := ReadKey;
        if ch=#72 then z:=x-1;
        if ch=#80 then z:=x+1;
       end;
      end else
    begin
     x12:=x11;
     y12:=y11;
     if (x11>=x1-10) and (x11<x1+150) and (y11>=y1) then
      begin
        i:=0;
        repeat
         i:=i+1;
        until ((gr[i,1]<=y11) and (gr[i,2]>=y11)) or (i=n1);
      end;
      z:=i;
    end;
     if (z<>x) then
      begin
        z:=z mod n1;
        if z=0 then z:=n1;
        hide_mouse;
        knopka(s[z],x1,y2+(z-1)*r+(z-2)*(y2-y1),x2,y2+(z-1)*(r+y2-y1),true);
        knopka(s[x],x1,y2+(x-1)*r+(x-2)*(y2-y1),x2,y2+(x-1)*(r+y2-y1),false);
        x:=z;
      end;
    until (but<>0) or (ch=#13);
   menuf:=s[x];
   hide_mouse;
 end;

end;

end.