(*
* Fire by koalka/bbsl/karzelki
*)

program Fire;

uses atari;

const
  screen  = $6400;
  charset = $6000;
  dl: array [0..25] of byte = (
    $42,lo(screen),hi(screen),
    2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,
    $41,lo(word(@dl)),hi(word(@dl))
  );

var
  b0i    : byte absolute $e0;
  b1i    : byte absolute $e1;
  tmp    : byte absolute $e2;

  p0     : PByte absolute $e3;
  p1     : PByte absolute $e5;
  p2     : PByte absolute $e7;

begin
  color4 := $20; tmp := 0;
  sdlstl := word(@dl); chbas := hi(charset);
  gprior := $40; sdmctl := $21;

  for b0i := 0 to $f do begin
    for b1i := 0 to 7 do poke(charset + b1i + b0i * 8, tmp);
    inc(tmp,$11);
  end;

  FillChar(pointer(screen), $400, 0);

 while true do begin
    p0 := pointer(screen - 31);
    p1 := pointer(screen - 31 + $100);
    p2 := pointer(screen - 31 + $200);

    for b0i := 0 to 255 do begin
      tmp := p0[30];
      inc(tmp,p0[31]); inc(tmp,p0[32]); inc(tmp,p0[63]);
      tmp := tmp shr 2;
      p0^ := tmp;

      tmp := p1[30];
      inc(tmp,p1[31]); inc(tmp,p1[32]); inc(tmp,p1[63]);
      tmp := tmp shr 2;
      p1^ := tmp;

      tmp := p2[30];
      inc(tmp,p2[31]); inc(tmp,p2[32]); inc(tmp,p2[63]);
      tmp := tmp shr 2;
      p2^ := tmp;

      inc(p0); inc(p1); inc(p2);
    end;
    //colbk := 10; pause;

    p0 := pointer(screen + $2e0);
    for b0i := $1f downto 0 do p0[b0i] := rnd and 15;
  end;
end.