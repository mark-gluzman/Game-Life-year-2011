USES crt, dos, inter, menu, graph, mouse;

TYPE

ft=file of tchk;
s20=string[20];


function getlongintTime:longint;

 var Hour,minute,second,sec100: word;
 var k,r:longint;
begin
 GetTime (Hour, minute, second, sec100);
  k:=Hour; r:=k*360000;
 k:=minute; Inc (r,k*6000);
 k:=second; Inc(r,k*100);
 Inc(r,sec100); getlongintTime:=r;
end;

procedure Delay (ms:word);

var endTime,curTime : longint;
    cor:boolean;
begin
 cor:=false;
 endTime:=getlongintTime + ms div 10;
 if endTime>8639994 then cor:=true;
 repeat
  curTime:=getlongintTime;
  if cor=true then begin
   if curTime<360000 then
    Inc (curTime,8639994);
  end;
 until curTime>endTime;
end;


procedure cosp (x,y,n:byte; var mat:matr; w:boolean; t:boolean);
 var q:shortint;

 begin
     if w then q:=1 else q:=-1;
     mat[x,y].log:=w;
     if x>1 then
          mat[x-1,y].cos:=mat[x-1,y].cos+q else
        if t then
            mat[n,y].cos:=mat[n,y].cos+q;
        if x<n then
           mat[x+1,y].cos:=mat[x+1,y].cos+q
         else
        if t then mat[1,y].cos:=mat[1,y].cos+q;
     if y>1 then mat[x,y-1].cos:=mat[x,y-1].cos+q else
        if t then mat[x,n].cos:=mat[x,n].cos+q;
     if y<n then mat[x,y+1].cos:=mat[x,y+1].cos+q else
        if t then mat[x,1].cos:=mat[x,1].cos+q;

     if (x>1) and (y>1) then mat[x-1,y-1].cos:=mat[x-1,y-1].cos+q else
        if t then
          if x>1 then mat[x-1,n].cos:=mat[x-1,n].cos+q else
             if y>1 then mat[n,y-1].cos:=mat[n,y-1].cos+q else
               mat[n,n].cos:=mat[n,n].cos+q;

     if (x>1) and (y<n) then mat[x-1,y+1].cos:=mat[x-1,y+1].cos+q else
      if t then
          if x>1 then mat[x-1,1].cos:=mat[x-1,1].cos+q else
             if y<n then mat[n,y+1].cos:=mat[n,y+1].cos+q else
               mat[n,1].cos:=mat[n,1].cos+q;

     if (x<n) and (y>1) then mat[x+1,y-1].cos:=mat[x+1,y-1].cos+q else
        if t then
          if x<n then mat[x+1,n].cos:=mat[x+1,n].cos+q else

             if y>1 then mat[1,y-1].cos:=mat[1,y-1].cos+q else
               mat[1,n].cos:=mat[1,n].cos+q;

     if (x<n) and (y<n) then mat[x+1,y+1].cos:=mat[x+1,y+1].cos+q else
        if t then
          if x<n then mat[x+1,1].cos:=mat[x+1,1].cos+q else
             if y<n then mat[1,y+1].cos:=mat[1,y+1].cos+q else
               mat[1,1].cos:=mat[1,1].cos+q;
 end;


procedure poiskkoor(n:byte; var x,y:word);
 var
  i,x11,y11,x12,y12,x1,y1,pl,dn:word;
  gr:array[1..60,1..2] of word;
  but:byte;
  ch:char;
 begin
    delay(200);
    x:=1;
    y:=1;
    x1:=1;
    y1:=1;
    pl:=pole(n);
    dn:=trunc((pl-10)/n);
    gr[1,1]:=10;
    gr[1,2]:=10+dn;

    kvad(n,x,y,true);

    for i:=2 to n do
     begin
      gr[i,1]:=gr[i-1,2];
      gr[i,2]:=gr[i,1]+dn;
     end;

     repeat
      while keypressed do
      ch:=readkey;
      while but<>0 do
      get_mouse_status(but,x11,y11);

        repeat
          get_mouse_status(but,x11,y11);
        until (x11<>x12) or (y11<>y12) or (but<>0) or keypressed;

      if keypressed then
       begin
        ch := ReadKey;
        if ch = char(0) then
         begin
          ch := ReadKey;
          if ch=#72 then y1:=y-1;
          if ch=#80 then y1:=y+1;
          if ch=#75 then x1:=x-1;
          if ch=#77 then x1:=x+1;
         end;
       end else
    begin
     x12:=x11;
     y12:=y11;
     if (x11>=10) and (x11<=pl) and (y11>=10) and (y11<=pl) then
      begin
        i:=0;
        repeat
         i:=i+1;
        until ((gr[i,1]<=x11) and (gr[i,2]>=x11)) or (i=n);
        x1:=i;
      end;
     if (x11>=10) and (x11<=pl) and (y11>=10) and (y11<=pl) then
      begin
       i:=0;
       repeat
        i:=i+1;
       until ((gr[i,1]<=y11) and (gr[i,2]>=y11)) or (i=n);
       y1:=i;
      end;
     end;

     if (x1<>x) or (y<>y1) then
      begin
       x1:=x1 mod n;
       if x1=0 then x1:=n;
       y1:=y1 mod n;
       if y1=0 then y1:=n;
       kvad(n,x,y,false);
       kvad(n,x1,y1,true);
       x:=x1;
       y:=y1;
      end;

     until (but<>0) or (ch=#13) or (ch=#32);
 end;

procedure vvodfig (n:byte; var mat:matr; t:boolean; var p:integer; var tt:tch; namef:s20; u:boolean);
  var
  x,y:byte;
  x2,y2,pl:word;
  fil:ft;
  tc:tchk;
  s1:string;
  o,o1,o2,nad:word;
  ch:char;
 begin
    assign(fil,namef);
    {$I-}
    reset(fil);
    o:=ioresult;
    if o<>0 then
       begin
         setcolor(1);
         if u then
         moveto(trunc((getmaxx*0.7))+20,trunc(getmaxy*0.48))
              else
         begin
           moveto(trunc((getmaxx*0.7))+20,trunc(getmaxy*0.8));

           bar(177,nad-5,210,getmaxy);
         end;
         outtext('file not found');
         repeat ch:=readkey until ch=#13;
        end  {$i+}
    else
 begin
      mouse_gotoxy(15,15);
      poiskkoor(n,x2,y2);

      kvad(n,x2,y2,false);
      while not eof(fil) do
        begin
          read(fil,tc);
          x:=tc.xt+x2-1;
          y:=tc.yt+y2-1;
          x:=x mod n; if x=0 then x:=n;
          y:=y mod n; if y=0 then y:=n;
          if mat[x,y].log=false then
            begin
             tt[x,y]:=true;
             cosp(x,y,n,mat,true,t);
             p:=p+1;
                tochka(x,y,n,14);
                str(p,s1);
                setfillstyle(3,0);
                nad:=trunc(getmaxy-(getmaxy-10-pole(n))/2)-5;
                moveto(10,nad);
                bar(290,nad-5,320,nad+10);
                setcolor(1);
                outtext('The number of cells that are alive-'+s1);
             end;
        end;
     end;
    if o=0 then
      close(fil);
 end;

procedure vvodfigp (n:byte; var mat:matr; t:boolean; var p:integer; var tt:tch);
 var
  namef:s20;
  begin
    moveto(trunc(getmaxx*0.73+1),trunc(getmaxy*0.4));
    window(trunc((lo(windmax)+1)*0.75),trunc(hi(windmax)*0.6),lo(windmax)+1,hi(windmax)+1);
    outtext('Enter the figure');
    gotoxy(1,1);
    write('>');
    readln(namef);
    vvodfig(n,mat,t,p,tt,namef,true);
  end;




procedure vvodpf (n:byte; var mat:matr; t:boolean; var p:integer; var tc:tch);
 var
  x,y,nad,dn:word;
  ch:char;
  s1:string;
  but:byte;
  i,x11,y11,x12,y12,x1,y1,pl:word;
  gr:array[1..60,1..2] of word;
 begin
    x:=1;
    y:=1;
    x1:=1;
    y1:=1;
    pl:=pole(n);
    dn:=trunc((pl-10)/n);
    gr[1,1]:=10;
    gr[1,2]:=10+dn;
    mouse_gotoxy(10+dn,10+dn);
    but:=4;
    kvad(n,x,y,true);
    for i:=2 to n do
     begin
      gr[i,1]:=gr[i-1,2];
      gr[i,2]:=gr[i,1]+dn;
     end;
    repeat
     repeat
      while keypressed do
      ch:=readkey;
      while but<>0 do
      get_mouse_status(but,x11,y11);

        repeat
          get_mouse_status(but,x11,y11);
        until (x11<>x12) or (y11<>y12) or (but<>0) or keypressed;

      if keypressed then
       begin
        ch := ReadKey;
        if ch = char(0) then
         begin
          ch := ReadKey;
          if ch=#72 then y1:=y-1;
          if ch=#80 then y1:=y+1;
          if ch=#75 then x1:=x-1;
          if ch=#77 then x1:=x+1;
         end;
       end else
    begin
     x12:=x11;
     y12:=y11;
     if (x11>=10) and (x11<=pl) and (y11>=10) and (y11<=pl) then
      begin
        i:=0;
        repeat
         i:=i+1;
        until ((gr[i,1]<=x11) and (gr[i,2]>=x11)) or (i=n);
        x1:=i;
      end;
     if (x11>=10) and (x11<=pl) and (y11>=10) and (y11<=pl) then
      begin
       i:=0;
       repeat
        i:=i+1;
       until ((gr[i,1]<=y11) and (gr[i,2]>=y11)) or (i=n);
       y1:=i;
      end;
     end;

     if (x1<>x) or (y<>y1) then
      begin
       x1:=x1 mod n;
       if x1=0 then x1:=n;
       y1:=y1 mod n;
       if y1=0 then y1:=n;
       kvad(n,x,y,false);
       kvad(n,x1,y1,true);
       x:=x1;
       y:=y1;
      end;

     until (but<>0) or (ch=#13) or (ch=#32);

    if (ch=#13) or (but<>0) then
         begin
          ch:='a';
          tc[x,y]:=true;
          cosp(x,y,n,mat,(not mat[x,y].log),t);
          if mat[x,y].log then  p:=p+1
              else p:=p-1;

           str(p, s1);
           nad:=trunc(getmaxy-(getmaxy-10-pole(n))/2)-5;
           setfillstyle(3,0);
           moveto(10,nad);
           bar(290,nad-5,320,nad+10);
           setcolor(blue);
           outtext('The number of cells that are alive-'+s1);
           if not mat[x,y].log then
            tochka(x,y,n,7) else tochka(x,y,n,14);
         end;
         if but<>0 then
         delay(200);

  until (ch=#32);

  kvad(n,x,y,false);
 end;


procedure vvod (n:byte; var mat:matr; t:boolean; var p:integer; q2:byte; var tc:tch);
 var
   x,y,q:byte;
   s:st2;
 begin
   p:=0;
   for x:=1 to n do
    for y:=1 to n do
      begin
        mat[x,y].log:=false;
        mat[x,y].cos:=0;
        tc[x,y]:=false;
      end;

       if q2=1 then
         begin
           randomize;
            for x:=1 to n do
             for y:=1 to n do
               if random(2)=1 then
                begin
                 tc[x,y]:=true;
                 cosp(x,y,n,mat,true,t);
                 p:=p+1;
                end;
         end;
 end;

procedure save (n:byte; mat:matr);
 var
  f:ft;
  s:string;
  k:tchk;
  x,y:byte;
 begin
  setcolor(1);
  moveto(trunc((getmaxx*0.7))+20,trunc(getmaxy*0.37));
  outtext('Enter the file name');
  window(trunc((lo(windmax)+1)*0.75),trunc(hi(windmax)*0.5+1),lo(windmax)+1,hi(windmax)+1);
  write('>');
  readln(s);
  assign(f,s);

  rewrite(f);
  for x:=1 to n do
   for y:=1 to n do
    if mat[x,y].log then
     begin
       k.xt:=x;
       k.yt:=y;
       write(f,k);
     end;
  close (f);
 end;

procedure shag (var mat:matr; n:byte; t:boolean; var p:integer; var tc:tch);
var
  x,y:byte;
  mat1:matr;
 begin
    mat1:=mat;
    for x:=1 to n do
     for y:=1 to n do
           begin
             tc[x,y]:=false;
             if (mat[x,y].log=false) and (mat[x,y].cos=3) then
                begin
                  cosp(x,y,n,mat1,true,t);
                  p:=p+1;
                  tc[x,y]:=true;
                  end;
             if (mat[x,y].log) and ((mat[x,y].cos<2) or (mat[x,y].cos>3)) then
                begin
                  cosp(x,y,n,mat1,false,t);
                  tc[x,y]:=true;
                  p:=p-1;
                end;
           end;
      mat:=mat1;
  end;

procedure nepr(n:byte; var mat:matr; t:boolean; var p:integer; q:real; var  tc:tch; var poc:integer; var qq:integer);
    var ch,c:char;
        w:integer;

     begin
       while keypressed do ch:=readkey;
     if qq<>0 then
       begin
         w:=0;
         While (w<>((qq div 200)*200)) and (keypressed=false) do
         begin
           delay(200);
           w:=w+200;
         end;
         delay(qq mod 200);
         if keypressed=false then
         begin
           shag(mat,n,t,p,tc);
           poc:=poc+1;
           vvivodnaecran(n,mat,p,poc,tc);
         end;
       end;

      if not keypressed then
      qq:=trunc(q*1000);

       while not keypressed do
       begin
         w:=0;
         While (w<>((qq div 200)*200)) and (keypressed=false) do
         begin
           delay(200);
           w:=w+200;
         end;
         if keypressed=false then
         begin
           shag(mat,n,t,p,tc);
           poc:=poc+1;
           vvivodnaecran(n,mat,p,poc,tc);
         end;
       end;

       c:=readkey;
       while keypressed do ch:=readkey;
       if c<>#32 then
       begin
         qq:=qq-w;
         nepr(n,mat,t,p,q,tc,poc,qq);
       end;
    end;

procedure vvivod (n:byte; var mat:matr; t:boolean; var q1:byte; var p:integer; q:real; tc:tch);
VAR
  s1:s20;
  poc,qq:integer;
  o,xm:word;
  b:boolean;
  s8:st8;
  s2:st2;
  s3:st3;
  q2,x,y:byte;
  ch:char;
BeGIN
    poc:=1;
    b:=false;
    q1:=q1+1;
    q2:=q1;
 repeat
    q1:=q2;
    if b then
       begin
        s8[1]:='Back';
        s8[2]:='Run continuously';
        s8[3]:='Run by step';
        s8[4]:='Add/remove cells';
        s8[5]:='Clear field';
        s8[6]:='Save field';
        s8[7]:='Back to the menu';
        s8[8]:='Exit';
        setfillstyle(3,0);
        bar(trunc((getmaxx*0.7))+20,20,getmaxx,getmaxy);
        xm:=trunc((getmaxx*0.7))+25;
        q2:=menuv8(xm,trunc(getmaxy*0.1),xm+120,trunc(getmaxy*0.1)+10,5,s8);
       end
         else if q2=2 then
          begin
            grpol(n);
            vvivodnaecran(n,mat,p,poc,tc);
          end;

   if q2=1 then q2:=q1;

   case q2 of
     2: begin
          if b then
           begin
            setcolor(1);
            moveto(trunc((getmaxx*0.7))+20,trunc(getmaxy*0.36));
            outtext('Enter the speed');
            moveto(trunc((getmaxx*0.7))+20,trunc(getmaxy*0.36+10));
            outtext('in second');
            window(trunc((lo(windmax)+1)*0.75),trunc(hi(windmax)*0.5+1),lo(windmax)+1,hi(windmax)+1);
            repeat
             if wherey>12 then
                 begin
                  bar(trunc((getmaxx*0.7))+20,trunc(getmaxy*0.4),getmaxx,getmaxy);
                  gotoxy(1,1);
                 end;
              write('>');
              readln(s1);
              val(s1,q,o);
            until (o=0) and (q<=30) and (q>=0);
           end;
           bar(trunc((getmaxx*0.7))+20,20,getmaxx,getmaxy);
           qq:=0;
           nepr(n,mat,t,p,q,tc,poc,qq);
          end;

   3: begin
       if not b then
        begin
          grpol(n);
          vvivodnaecran(n,mat,p,poc,tc);
          repeat
            ch := ReadKey;
            if ch = char(0) then
              ch := ReadKey;
          until (ch=#13) or (ch=#32);
        end;


        bar(trunc((getmaxx*0.7))+20,20,getmaxx,getmaxy);
        if b or (ch=#13) then
         repeat
           while keypressed do
           ch:=readkey;

            ch := ReadKey;
            if ch=#13 then
             begin

               while keypressed do
               ch:=readkey;

               shag(mat,n,t,p,tc);
               poc:=poc+1;
               vvivodnaecran(n,mat,p,poc,tc);
             end;

         until (ch=#32);
     end;

   4:begin
       bar(trunc((getmaxx*0.7))+20,trunc((getmaxy*0.23)),getmaxx,trunc(getmaxy*0.5));
       s3[1]:='Add random';
       s3[2]:='Add figure';
       s3[3]:='Add/remove by cursor';
       q1:=menuv3(trunc((getmaxx*0.7))+20,trunc((getmaxy*0.23)),trunc((getmaxx*0.7))+20,trunc(getmaxy*0.25),5,s3);

       case q1 of

            1:begin
               randomize;
               for x:=1 to n do
                for y:=1 to n do
                 if (random(3)=1) and (mat[x,y].log=false) then
                   begin
                    tc[x,y]:=true;
                    cosp(x,y,n,mat,true,t);
                    p:=p+1;
                   end;
               vvivodnaecran(n,mat,p,poc,tc);
              end;

            2:begin
               s2[1]:='Choose from the list';
               s2[2]:='Enter the name';
               q1:=menuv2(trunc(getmaxx*0.74),trunc(getmaxy*0.33),trunc(getmaxx*0.74),trunc(getmaxy*0.35),5,s2);
               case q1 of
                 1:begin
                    s1:=menuf(trunc((getmaxx*0.7))+20,trunc(getmaxy*0.4),trunc((getmaxx*0.7))+20,trunc(getmaxy*0.4),10);
                    if s1<>'' then
                    vvodfig(n,mat,true,p,tc,s1,false);
                   end;
                 2:vvodfigp(n,mat,true,p,tc);
               end;
              end;
            3:vvodpf (n,mat,t,p,tc);

           end;
      end;

   5: begin
       p:=0;
        for x:=1 to n do
         for y:=1 to n do
          begin
           mat[x,y].log:=false;
           mat[x,y].cos:=0;
           tc[x,y]:=true;
          end;
       vvivodnaecran(n,mat,p,poc,tc);
      end;

   6: save(n,mat);


 end;
    b:=true;
  until (q2=8) or (q2=7);
  q1:=q2;
 end;


VAR
n,q1,q2:byte;
mat:matr;
t:boolean;
p:integer;
q:real;
tc:tch;
x,y:word;
button:byte;
m:boolean;
BEGIN
   directvideo:=false;
   reg;
   repeat
      nachalo(n,t,q1,q2,q);
      vvod(n,mat,t,p,q2,tc);
      vvivod(n,mat,t,q1,p,q,tc);
   until q1=8;
   closegraph;
END.
