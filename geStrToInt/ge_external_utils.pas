(*
 *  Copyright (c) 2021-2022 Serg Shutkin
 *
 *  This software is provided 'as-is', without any express or
 *  implied warranty. In no event will the authors be held
 *  liable for any damages arising from the use of this software.
 *
 *  Permission is granted to anyone to use this software for any purpose,
 *  including commercial applications, and to alter it and redistribute
 *  it freely, subject to the following restrictions:
 *
 *  1. The origin of this software must not be misrepresented;
 *     you must not claim that you wrote the original software.
 *     If you use this software in a product, an acknowledgment
 *     in the product documentation would be appreciated but
 *     is not required.
 *
 *  2. Altered source versions must be plainly marked as such,
 *     and must not be misrepresented as being the original software.
 *
 *  3. This notice may not be removed or altered from any
 *     source distribution.
 *)

// Rus: требуется проверка при работе с флагами переполнения. На данный момент
//      проблем не возникало.
// Eng: validation is required when dealing with overflow flags. At the moment
//      there have been no problems.

unit ge_external_Utils;
// Rus: этот дефайн UP_CPU повышает уровень используемых значений. Точнее для
//      CPU16 вы сможете использовать 32-х битные значения. Вы должны знать
//      может система (компилятор) использовать эти значения или нет.
//      Для 64-х битных систем не будет работать на данное время.
// Eng: this UP_CPU define raises the level of values used. More precisely, for
//      CPU16 you can use 32-bit values. You need to know whether the system
//      (compiler) can use these values or not.
//      Will not work for 64-bit systems at this time.

{.$Define UP_CPU}
{$I def_stringtovalue.cfg}

interface

const
  // Rus: константы задаваемые при вызове geStrToInt
  // Eng: constants set when calling geStrToInt
  isByte      = 0;
  isShortInt  = 0;
  {$IfDef USE_CPU16}
  isWord      = 1;
  isSmallInt  = 1;
  {$EndIf}
  {$IfDef USE_CPU32}
  isLongWord  = 2;
  isInteger   = 2;
  {$EndIf}
  {$IfDef USE_CPU64}
  isQWord     = 3;
  isInt64      = 3;
  {$EndIf}
  {$IfDef CPU8}
  maxSize     = 0;
  {$EndIf}
  {$IfDef CPU16}
  maxSize     = 1;
  {$EndIf}
  {$IfDef CPU32}
  maxSize     = 2;
  {$EndIf}
  {$IfDef CPU64}
  maxSize     = 3;
  {$EndIf}

type
  {$IfDef CPU8}
  maxIntVal = {$IfNDef UP_CPU}ShortInt{$Else}SmallInt{$EndIf};
  maxUIntVal = {$IfNDef UP_CPU}Byte{$Else}Word{$EndIf};
  {$EndIf}
  {$IfDef CPU16}
  maxIntVal = {$IfNDef UP_CPU}SmallInt{$Else}Integer{$EndIf};
  maxUIntVal = {$IfNDef UP_CPU}Word{$Else}LongWord{$EndIf};
  {$EndIf}
  {$IfDef CPU32}
  maxIntVal = {$IfNDef UP_CPU}Int64{$Else}Integer{$EndIf};
  maxUIntVal = {$IfNDef UP_CPU}LongWord{$Else}QWord{$EndIf};
  {$EndIf}
  {$IfDef CPU64}
  maxIntVal = Int64;
  maxUIntVal = QWord;
  {$EndIf}

// Rus: эта функция для десятичных чисел со знаком.
// Eng: this function is for signed decimal numbers.
function geStrToInt(const Str: String; out Value: maxIntVal; Size: LongWord = isInteger): Boolean;
// Rus: эта функция только для десятичных чисел без знака!!!
// Eng: this function is only for unsigned decimal numbers!!!
function geStrToUInt(const Str: String; out Value: maxUIntVal; Size: LongWord = isLongWord): Boolean;
// Rus: для работы с шестнадцатеричными, восьмеричными и двоичными данными.
// Eng: for working with hexadecimal, octal and binary data.
function geHOBStrToUInt(const Str: String; out Value: maxUIntVal; Size: LongWord = isQWord): Boolean;

(* Rus: Ниже реализованы стандартные функции для перевода строк в число. Их
 *      использование будет проще для большинства. Функции отмечены префиксом.
 *      s_ - функции возвращают результат (если операция была неудачной, то
 *      в результате вернётся ноль, но вы не узнаете, что операция была неудачной).
 *      sc_ - результат функций удачная или не удачная была операция. Сам
 *      конечный числовой результат считывайте в Value.
 * Eng: The standard functions for converting strings to numbers are implemented
 *      below. Their use will be easier for most. Functions are marked with a prefix.
 *      s_ - functions return a result (if the operation was unsuccessful, the result
 *      will be zero, but you will not know that the operation was unsuccessful).
 *      sc_ - the result of the functions - the operation was successful or
 *      unsuccessful. Read the final numerical result in Value.
 *)
// sc_ - speed + check
// s_ - speed (not check)

// Rus: Числа со знаком. Здесь нельзя использовать шестнадцатеричные, восьмеричные
//      и двоичные числа.
// Eng: Signed numbers. Hexadecimal, octal and binary numbers cannot be used here.
function sc_StrToShortInt(const Str: String; out Value: ShortInt): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}   // byte
function s_StrToShortInt(const Str: String): ShortInt; {$IfDef ADD_FAST}inline;{$EndIf}                        // byte
{$IfDef USE_CPU16}
function sc_StrToSmallInt(const Str: String; out Value: SmallInt): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}   // word
function s_StrToSmallInt(const Str: String): SmallInt; {$IfDef ADD_FAST}inline;{$EndIf}                        // word
{$EndIf}
{$IfDef USE_CPU32}
function sc_StrToInt(const Str: String; out Value: Integer): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
function s_StrToInt(const Str: String): Integer; {$IfDef ADD_FAST}inline;{$EndIf}
{$EndIf}
{$IfDef USE_CPU64}
function sc_StrToInt64(const Str: String; out Value: Int64): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
function s_StrToInt64(const Str: String): Int64; {$IfDef ADD_FAST}inline;{$EndIf}
{$EndIf}

// Rus: Числа без знака. Эти функции могут использоваться и для шестнадцатеричныи
//      и восьмеричных и двоичных чисел.
// Eng: Numbers without a sign. These functions can be used for hexadecimal, octal
//      and binary numbers as well.
function sc_StrToByte(const Str: String; out Value: Byte): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
function s_StrToByte(const Str: String): Byte; {$IfDef ADD_FAST}inline;{$EndIf}
{$IfDef USE_CPU16}
function sc_StrToWord(const Str: String; out Value: Word): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
function s_StrToWord(const Str: String): Word; {$IfDef ADD_FAST}inline;{$EndIf}
{$EndIf}
{$IfDef USE_CPU32}
function sc_StrToLongWord(const Str: String; out Value: LongWord): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
function s_StrToLongWord(const Str: String): LongWord; {$IfDef ADD_FAST}inline;{$EndIf}
{$EndIf}
{$IfDef USE_CPU64}
function sc_StrToQWord(const Str: String; out Value: QWord): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
function s_StrToQWord(const Str: String): QWord; {$IfDef ADD_FAST}inline;{$EndIf}
{$EndIf}

implementation

type
  PgeUseParametr = ^geUseParametr;
  geUseParametr = record
    maxLen: LongWord;
    maxNumDiv10: maxUIntVal;
    maxNumeric: maxUIntVal;
  end;

  PgeHOBParameter = ^geHOBParameter;
  geHOBParameter = record
    maxLen16, maxLen8, maxLen2: maxUIntVal;
  end;
  
var
  allIntParametr, allUIntParametr: array[0..7] of geUseParametr;
  allHOBParametr: array[0..3] of geHOBParameter;

// Rus: выставляем необходимые параметры. Иначе geStrToInt работать не будет.
//      В блоке инициализации.
// Eng: set the required parameters. Otherwise geStrToInt won't work.
//      in the initialization block.
procedure SetNumberParametr;
begin
  allUIntParametr[isByte].maxLen := 3;
  allUIntParametr[isByte].maxNumeric := 255;
  allUIntParametr[isByte].maxNumDiv10 := 25;
  allIntParametr[isShortInt].maxLen := 4;
  allIntParametr[isShortInt].maxNumeric := 127;
  allIntParametr[isShortInt].maxNumDiv10 := 12;
  {$IfDef USE_CPU16}
  allUIntParametr[isWord].maxLen := 5;
  allUIntParametr[isWord].maxNumeric := 65535;
  allUIntParametr[isWord].maxNumDiv10 := 6553;
  allIntParametr[isSmallInt].maxLen := 6;
  allIntParametr[isSmallInt].maxNumeric := 32767;
  allIntParametr[isSmallInt].maxNumDiv10 := 3276;
  {$EndIf}
  {$IfDef USE_CPU32}
  allUIntParametr[isLongWord].maxLen := 10;
  allUIntParametr[isLongWord].maxNumeric := 4294967295;
  allUIntParametr[isLongWord].maxNumDiv10 := 429496729;
  allIntParametr[isInteger].maxLen := 11;
  allIntParametr[isInteger].maxNumeric := 2147483647;
  allIntParametr[isInteger].maxNumDiv10 := 214748364;
  {$EndIf}
  {$IfDef USE_CPU64}
  allUIntParametr[isQWord].maxLen := 20;
  allUIntParametr[isQWord].maxNumeric := 18446744073709551615;
  allUIntParametr[isQWord].maxNumDiv10 := 1844674407370955161;
  allIntParametr[isInt64].maxLen := 20;
  allIntParametr[isInt64].maxNumeric := 9223372036854775807;
  allIntParametr[isInt64].maxNumDiv10 := 922337203685477580;
  {$EndIf}

  allHOBParametr[isByte].maxLen16 := 3;
  allHOBParametr[isByte].maxLen8 := 4;
  allHOBParametr[isByte].maxLen2 := 9;
  {$IfDef USE_CPU16}
  allHOBParametr[isWord].maxLen16 := 5;
  allHOBParametr[isWord].maxLen8 := 7;
  allHOBParametr[isWord].maxLen2 := 17;
  {$EndIf}
  {$IfDef USE_CPU32}
  allHOBParametr[isLongWord].maxLen16 := 9;
  allHOBParametr[isLongWord].maxLen8 := 12;
  allHOBParametr[isLongWord].maxLen2 := 33;
  {$EndIf}
  {$IfDef USE_CPU64}
  allHOBParametr[isQWord].maxLen16 := 17;
  allHOBParametr[isQWord].maxLen8 := 23;
  allHOBParametr[isQWord].maxLen2 := 65;
  {$EndIf}
end;

function sc_StrToShortInt(const Str: String; out Value: ShortInt): Boolean;
var
  n: maxIntVal;
begin
  Result := geStrToInt(Str, n, isShortInt);
  Value := n;
end;

function s_StrToShortInt(const Str: String): ShortInt;
var
  n: maxIntVal;
begin
  geStrToInt(Str, n, isShortInt);
  Result := n;
end;

{$IfDef USE_CPU16}
function sc_StrToSmallInt(const Str: String; out Value: SmallInt): Boolean;
var
  n: maxIntVal;
begin
  Result := geStrToInt(Str, n, isSmallInt);
  Value := n;
end;

function s_StrToSmallInt(const Str: String): SmallInt;
var
  n: maxIntVal;
begin
  geStrToInt(Str, n, isSmallInt);
  Result := n;
end;
{$EndIf}

{$IfDef USE_CPU32}
function sc_StrToInt(const Str: String; out Value: Integer): Boolean;
var
  n: maxIntVal;
begin
  Result := geStrToInt(Str, n, isInteger);
  Value := n;
end;

function s_StrToInt(const Str: String): Integer;
var
  n: maxIntVal;
begin
  geStrToInt(Str, n, isInteger);
  Result := n;
end;
{$EndIf}

{$IfDef USE_CPU64}
function sc_StrToInt64(const Str: String; out Value: Int64): Boolean;
begin
  Result := geStrToInt(Str, Value, isInt64);
end;

function s_StrToInt64(const Str: String): Int64;
begin
  geStrToInt(Str, Result, isInt64);
end;

{$EndIf}

function sc_StrToByte(const Str: String; out Value: Byte): Boolean;
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    Result := geHOBStrToUInt(str, n, isByte)
  else
    Result := geStrToUInt(Str, n, isByte);
  Value := n;
end;

function s_StrToByte(const Str: String): Byte;
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    geHOBStrToUInt(str, n, isByte)
  else
    geStrToUInt(Str, n, isByte);
  Result := n;
end;

{$IfDef USE_CPU16}
function sc_StrToWord(const Str: String; out Value: Word): Boolean;
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    Result := geHOBStrToUInt(str, n, isWord)
  else
    Result := geStrToUInt(Str, n, isWord);
  Value := n;
end;

function s_StrToWord(const Str: String): Word;
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    geHOBStrToUInt(str, n, isWord)
  else
    geStrToUInt(Str, n, isWord);
  Result := n;
end;
{$EndIf}

{$IfDef USE_CPU32}
function sc_StrToLongWord(const Str: String; out Value: LongWord): Boolean;
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    Result := geHOBStrToUInt(str, n, isLongWord)
  else
    Result := geStrToUInt(Str, n, isLongWord);
  Value := n;
end;

function s_StrToLongWord(const Str: String): LongWord;
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    geHOBStrToUInt(str, n, isLongWord)
  else
    geStrToUInt(Str, n, isLongWord);
  Result := n;
end;
{$EndIf}

{$IfDef USE_CPU64}
function sc_StrToQWord(const Str: String; out Value: QWord): Boolean;
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    Result := geHOBStrToUInt(str, Value, isQWord)
  else
    Result := geStrToUInt(Str, Value, isQWord);
end;

function s_StrToQWord(const Str: String): QWord;
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    geHOBStrToUInt(str, Result, isQWord)
  else
    geStrToUInt(Str, Result, isQWord);
end;
{$EndIf}

function geStrToUInt(const Str: String; out Value: maxUIntVal; Size: LongWord = isLongWord): Boolean;
var
  lenStr, i: maxUIntVal;
  m, n, z: maxUIntVal;
  useParametr: PgeUseParametr;
begin
  {$push}
  {$Q-}{$R-}
  // Rus: значение нуль, результат функции - False.
  // Eng: the value is zero, the result of the function is False.
  Result := False;
  Value := 0;
  if Size > maxSize then
    Exit;
  lenStr := Length(Str);
  if lenStr = 0 then
    exit;
  m := Byte(Str[1]) - 48;
  // Rus: если значение не входит в пределы 0..9 - выходим
  // Eng: if the value is outside the range 0..9 - exit
  if m > 9 then
    exit;
  if (lenStr = 1) and (m = 0) then
  begin
    Result := True;
    exit;
  end;

  useParametr := @allUIntParametr[Size];
  if lenStr > useParametr^.maxLen then
    Exit;
  i := 2;
  while i < lenStr do
  begin
    n := (Byte(Str[i]) - 48);
    if n > 9 then
      Exit;
    m := m * 10 + n;
    inc(i);
  end;
  // Rus: Если уже превысили значение, то выходим
  // Eng: If you have already exceeded the value, then exit
  if m > useParametr^.maxNumDiv10 then
    exit;
  m := m * 10;
  z := Byte(Str[i]) - 48;
  if z > 9 then
    exit;
  n := useParametr^.maxNumeric - m;
  if z > n then
    exit;
  Value := m + z;
  Result := true;
  {$pop}
end;

function geHOBStrToUInt(const Str: String; out Value: maxUIntVal; Size: LongWord = isQWord): Boolean;
var
  lenStr, i: maxUIntVal;
  m, n, nshl, z: maxUIntVal;
  correct: maxUIntVal = 0;
  useParametr: PgeHOBParameter;
begin
  {$push}
  {$Q-}{$R-}
  Result := False;
  Value := 0;
  if Size > maxSize then
    exit;
  lenStr := Length(Str);
  if lenStr = 0 then
    exit;

  // первые значения влияют на рабочий код. Потому что здесь будут использоваться
  // и шестнадцатеричные и восьмеричные и двоичные значения.
  // Числа надо обрабатывать соответственно $(0x) - шестнадцатеричный,
  // %(0b) - двоичный, &(0, 0o) - восьмеричный
  // Так же учитываем при работе с не десятичными числами, что перед ними идут
  // дополнительные значения, а значит длина их должна быть больше на 1 или 2.
  // Выставляю на 1 больше, что означает, что при первом нуле, вероятно надо
  // будет указать ещё дополнительную длину.

  // Rus: здесь обработка первого символа, который указывает на систему счисления.
  // Eng: here processing the first character, which indicates the number system.
  m := Byte(Str[1]);
  n := Byte(Str[2]);
  i := 2;
  if m = 48 then
  begin
    if n > 97 then
      n := n - 32;
    m := 38;
    if (n = 66) or (n = 88) or (n = 79) then
    begin
      correct := 1;
      i := 3;
      if n = 66 then
      begin
        m := 37;
      end
      else
        if n = 88 then
          m := 36
        else
          n := Byte(Str[3]);
    end;
  end;

  useParametr := @allHOBParametr[Size];
  // Rus: проверим предел для восьмеричной системы.
  // Eng: check the limit for the octal system.
  if m = 38 then
  begin
    n := n - 48;
    if (lenStr - correct) > useParametr^.maxLen8 then
      exit;
    if useParametr^.maxLen8 = (lenStr - correct) then       // предельная длина
      if (Size = isByte) or (Size = isLongWord) then
      begin
        if n > 3 then                                   // max 3
          exit;
      end
      else
        if n > 1 then                                   // max 1
          exit;
    nshl := 3;
    z := 7;
  end
  else
    if m = 37 then
    begin
      // Rus: для двоичной системы.
      // Eng: for a binary system.
      if (lenStr - correct) > useParametr^.maxLen2 then
        exit;
      nshl := 1;
      z := 1;
    end;
  // Rus: вычисляем шестнадцатеричное число.
  // Eng: calculate a hexadecimal number.
  if m = 36 then
  begin
    if (lenStr - correct) > useParametr^.maxLen16 then
      exit;
    m := 0;
    while i <= lenStr do
    begin
      m := m shl 4;       // возможно ли что это место выдаст когда-нибудь ошибку?
      n := Byte(Str[i]);
      case n of
          48..57: m := m + n - 48;
          65..70: m := m + n - 55;
          97..102: m := m + n - 87;
        else
          exit;
      end;
      inc(i);
    end;
  end
  // Rus: вычисляем двоичное или восьмеричное число.
  // Eng: calculate a binary or octal number.
  else begin
    m := Byte(Str[i]) - 48;
    if m > z then
      exit;
    inc(i);
    while i <= lenStr do
    begin
      m := m shl nshl;
      n := Byte(Str[i]) - 48;
      if n > z then
        exit;
      m := m + n;
      inc(i);
    end;
  end;
  Value := m;
  Result := true;
  {$pop}
end;

function geStrToInt(const Str: String; out Value: maxIntVal; Size: LongWord = isInteger): Boolean;
var
  lenStr, i: maxUIntVal;
  m, n, z: maxUIntVal;
  useParametr: PgeUseParametr;
  IntMinus: Boolean;
label
  jmpEndStr;
begin
  {$push}
  {$Q-}{$R-}
  // Rus: значение нуль, результат функции - False.
  // Eng: the value is zero, the result of the function is False.
  Result := False;
  Value := 0;
  if Size > maxSize then
    Exit;
  // Rus: флаг изначально указан, что не действителен.
  // Eng: the flag is initially specified, which is not valid.
  IntMinus := False;
  lenStr := Length(Str);
  if lenStr = 0 then
    exit;
  i := 1;
  m := Byte(Str[i]);

  if (lenStr = 1) and (m = 48) then
  begin
    Result := True;
    exit;
  end;
  // Rus: если рассматриваем отридцательные тоже, то проверяем знак
  // Eng: if we consider negative ones too, then we check the sign
  if m = 45 then
  begin
    if lenStr = 1 then
      exit;
    IntMinus := True;
    inc(i);
    m := Byte(Str[2]);
  end;

  inc(i);
  m := m - 48;
  // Rus: если значение не входит в пределы 0..9 - выходим
  // Eng: if the value is outside the range 0..9 - exit
  if m > 9 then
    exit;

  useParametr := @allIntParametr[Size];
  // Rus: момент, когда длина на один символ (символ + знак)
  // Eng: moment when the length is one character (symbol + sign)
  if i > lenStr then
  begin
    z := 0;
    goto jmpEndStr;
  end;
  // Rus: проверяем длину для данной размерности.
  // Eng: check the length for a given dimension.
  if lenStr > useParametr^.maxLen then
    Exit;
  while i < lenStr do
  begin
    n := (Byte(Str[i]) - 48);
    if n > 9 then
      Exit;
    m := m * 10 + n;
    inc(i);
  end;

  // Rus: Если уже превысили значение, то выходим
  // Eng: If you have already exceeded the value, then exit
  if m > useParametr^.maxNumDiv10 then
    exit;
  m := m * 10;
  z := Byte(Str[i]) - 48;
  if z > 9 then
    exit;

jmpEndStr:
  if IntMinus then
    n := useParametr^.maxNumeric + 1 - m
  else
    n := useParametr^.maxNumeric - m;
  if z > n then
    exit;

  if IntMinus then
    Value := - m - z
  else
    Value := m + z;
  Result := true;
  {$pop}
end;

initialization

  SetNumberParametr;

end.

