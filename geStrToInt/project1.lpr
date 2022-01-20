program project1;

{$APPTYPE CONSOLE}
uses
  {SysUtils,}{$IfDef UNIX}UnixType,{$EndIf} {$IfDef Windows} Windows,{$EndIf}ge_external_Utils;

const
  MAX_TEST = 100000;
  Max_T_DIV10 = 10000;

var
//  myS: string[20] = '-30493104565373';
  Count, Error: Integer;
  timeStart, timeEnd, timerStart: Double;
  {$IfDef UNIX}{$IfNDef MAC_COCOA}
  timerTimeVal: TimeVal;
  {$Else}
  timerTimebaseInfo: mach_timebase_info_t;
  {$ENDIF}
  {$ENDIF}
  {$IFDEF WINDOWS}
  timerFrequency: Int64;
  {$ENDIF}
  timeOld, timeOld2, timeNew, timeNew2: Double;
  myS: array[0..MAX_TEST] of String[20];
  myNumb: array[0..MAX_TEST] of Integer;
  nnnn: Int64;
  mmmm: QWord;
  mn: Byte;

  {$IfDef UNIX}{$IfNDef MAC_COCOA}
  function fpGetTimeOfDay(val: PTimeVal; tzp: Pointer): Integer; cdecl; external 'libc' name 'gettimeofday';
  {$Else}
  type
    mach_timebase_info_t = record
      numer: LongWord;
      denom: LongWord;
    end;

    function mach_timebase_info(var info: mach_timebase_info_t): Integer; cdecl; external 'libc';
    function mach_absolute_time: QWORD; cdecl; external 'libc';
  {$ENDIF}{$EndIf}

// запрос таймера, оставляю для всех систем
function timer_GetTicks: Double;
{$IFDEF WINDOWS}
var
  t: int64;
  m: LongWord;
{$EndIf}
begin
  {$IfDef UNIX}{$IfNDef MAC_COCOA}
  fpGetTimeOfDay(@timerTimeVal, nil);
  {$Q-}
  // FIXME: почему-то overflow вылетает с флагом -Co
  Result := timerTimeVal.tv_sec * 1000 + timerTimeVal.tv_usec / 1000 - timerStart;
  {$Q+}
{$Else}
  Result := mach_absolute_time() * timerTimebaseInfo.numer / timerTimebaseInfo.denom / 1000000 - timerStart;
{$ENDIF}{$EndIf}
{$IFDEF WINDOWS}
  m := SetThreadAffinityMask(GetCurrentThread(), 1);
  QueryPerformanceCounter(t);
  Result := 1000 * t / timerFrequency - timerStart;
  SetThreadAffinityMask(GetCurrentThread(), m);
{$ENDIF}
end;

function u_StrToInt(const Value: UTF8String): Integer;
  var
    e: Integer;
begin
  Val(Value, Result, e);
  if e <> 0 Then
    Result := 0;
end;

function u_IntToStr(Value: Integer): String;
begin
  Str(Value, Result);
end;

// создаём массив чисел
procedure CreateArrayNumb;
var
  i: Integer;
begin
  Randomize;
  for i := 0 to Max_T_DIV10 - 1 do
  begin
    myNumb[i * 10] := random(High(Integer));
    myNumb[i * 10 + 1] := - myNumb[i * 10];
    myNumb[i * 10 + 2] := myNumb[i * 10] mod 10;
    myNumb[i * 10 + 3] := myNumb[i * 10] div 10;
    myNumb[i * 10 + 4] := myNumb[i * 10] mod 100;
    myNumb[i * 10 + 5] := myNumb[i * 10] div 100;
    myNumb[i * 10 + 6] := - myNumb[i * 10 + 2];
    myNumb[i * 10 + 7] := - myNumb[i * 10 + 3];
    myNumb[i * 10 + 8] := - myNumb[i * 10 + 4];
    myNumb[i * 10 + 9] := - myNumb[i * 10 + 5];
    myS[i * 10] := u_IntToStr(myNumb[i * 10]);
    myS[i * 10 + 1] := u_IntToStr(myNumb[i * 10 + 1]);
    myS[i * 10 + 2] := u_IntToStr(myNumb[i * 10 + 2]);
    myS[i * 10 + 3] := u_IntToStr(myNumb[i * 10 + 3]);
    myS[i * 10 + 4] := u_IntToStr(myNumb[i * 10 + 4]);
    myS[i * 10 + 5] := u_IntToStr(myNumb[i * 10 + 5]);
    myS[i * 10 + 6] := u_IntToStr(myNumb[i * 10 + 6]);
    myS[i * 10 + 7] := u_IntToStr(myNumb[i * 10 + 7]);
    myS[i * 10 + 8] := u_IntToStr(myNumb[i * 10 + 8]);
    myS[i * 10 + 9] := u_IntToStr(myNumb[i * 10 + 9]);
  end;
end;

begin
{$IFDEF WINDOWS}
  SetThreadAffinityMask(GetCurrentThread(), 1);
  QueryPerformanceFrequency(timerFrequency);
{$ENDIF}
{$IFDEF MAC_COCOA}
  mach_timebase_info(timerTimebaseInfo);
{$ENDIF}
  timerStart := timer_GetTicks();
  timeOld := 0;
  timeNew := 0;
  timeOld2 := 0;
  timeNew2 := 0;
  CreateArrayNumb;

  // В первые секунды и при первом запуске, выводится неправильное значение. С чем это связано?
  // In the first seconds and at the first start, an incorrect value is displayed. What is the reason for this?
   // ----------------------------------------------
  writeln('Wait...');
  timeStart := timer_GetTicks;
  for Count := 0 to MAX_TEST * 100 do
  begin
    geStrToInt(myS[1], nnnn);
  end;
  timeEnd := timer_GetTicks - timeStart;

  timeStart := timer_GetTicks;
  for Count := 0 to MAX_TEST * 10 do
  begin
    u_StrToInt(myS[1]);
  end;
  timeEnd := timer_GetTicks - timeStart;
  Writeln;

  Writeln('Test begin.');
  // Сделаем цикл, для проверки
  for Error := 0 to 100 do
  begin
    // ----------------------------------------------
    timeStart := timer_GetTicks;
    for Count := 0 to MAX_TEST do
    begin
      nnnn := u_StrToInt(myS[Count]);
//      mmmm := u_StrToInt('$FFFFffff');
    end;
    timeEnd := timer_GetTicks - timeStart;
    timeOld := timeOld + timeEnd;

    // ----------------------------------------------
    timeStart := timer_GetTicks;
    for Count := 0 to MAX_TEST do
    begin
      geStrToInt(myS[Count], nnnn);
//      geHOBStrToUInt('$FFFFffff', mmmm);
    end;
    timeEnd := timer_GetTicks - timeStart;
    timeNew := timeNew + timeEnd;
  end;
  Write('StrToInt standard    ');
  Writeln(timeOld / 101);

  Write('StrToInt made by me ');
  Writeln(timeNew / 101);

  Writeln('Test end.');

  WriteLn;
  WriteLn(nnnn);

  WriteLn;
  WriteLn('Numbers:');
  for Count := 0 to 17 do
  begin
    geStrToInt(myS[Count], nnnn);
    WriteLn(nnnn);
  end;
  
(* Rus: блок примеров для использования трёх основных функций.
 * Eng: a block of examples for using the three main functions.
 *)

  // Rus: здесь примеры использования с разными флагами.
  // Eng: here are examples of use with different flags.
  // !!! geStrToUInt <> geStrToInt !!!
  WriteLn;
  Writeln('Examples');
  WriteLn('QWord');
  geStrToUInt('18446744073709551615', mmmm, isQWord);
  WriteLn(mmmm);

  Writeln;
  WriteLn('Int64');
  geStrToInt('-9223372036854775808', nnnn, isInt64);
  WriteLn(nnnn);

  Writeln;
  WriteLn('Byte');
  // Rus: пример использования байта. Если вы задаёте флаг байта, то из resQWord вы должны прочитать байт.
  //      Это так же работает и для Word и для LongWord.
  //      Если ваши данные это ShortInt, SmallInt или Integer вы должны будете читать данные из resInt64 в соответствующем размере.
  //      данные не будут превышены, максимально заданного значения. Смотрите флаги в ge_external_Utils.
  // Eng: an example of using a byte. If you set the byte flag, then you must read the byte from resQWord.
  //      This works the same for Word and LongWord.
  //      If your data is ShortInt, SmallInt or Integer you will need to read the data from resInt64 at the appropriate size.
  //      data will not exceed the maximum specified value. See flags at ge_external_Utils.
  if geStrToInt('$250', nnnn, isShortInt) then
    WriteLn(nnnn)
  // will throw an error if the value is greater than the byte value
  else
    WriteLn('Error');
  if geStrToUInt('250', mmmm, isByte) then
    WriteLn(mmmm)
  // will throw an error if the value is greater than the byte value
  else
    WriteLn('Error');

  WriteLn();
  // Rus: здесь работаем с шестнадцатеричными, двоичными и восьмеричными значениями.
  //      для шестнадцатеричных значений могут использоваться как '$' так и '0X'
  //      или '0x'; для восьмеричных значений могут использоваться как '&' так и '0'
  //      (одиночный нуль); для двоичных значений могут использоваться как '%' так
  //      и '0B' или '0b'.
  // Eng: here we work with hexadecimal, binary and octal values. for hexadecimal
  //      values either '$' or '0X' or '0x' can be used; for octal values both '&'
  //      and '0' (single zero) can be used; for binary values either '%' or '0B'
  //      or '0b' can be used.
  if geHOBStrToUInt('$10', mmmm, isByte) then
    WriteLn(mmmm)
  else
    WriteLn('Error');

(* Rus: блок примеров для использования пользовательских функций.
 * Eng: a block of examples for using custom functions.
 *)   
  
  mn := s_StrToByte('0xff');
  WriteLn(mn);

  if sc_StrToQWord('$1ffffffffffffffff', mmmm) then       // remove 1 at the beginning
    WriteLn(mmmm)
  // will throw an error if the value is greater than the byte value
  else
    WriteLn('Error');

  Readln;
end.
