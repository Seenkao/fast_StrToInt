# fast_StrToInt

[Eng](#English)  
[Rus](#Russian)

<a name="English"></a>Eng:
-------------

**fast StrToInt** - a library that provides updated functions for converting a string to a number. This repository contains a project that comes as a demo
version with usage examples. The project includes the main module __ge_external_utils.pas__ and the configuration file, they can be used separately from the
project.

**ge_external_utils.pas** - a module that provides all the functions for translating strings into numbers. The main information with comments is contained
in the module.

**Attention!** This library is aimed at the speed of translating strings into numbers! For compatibility with different architectures. And also to minimize the final code. :) But it only handles numbers, "-" sign (minus) and prefixes for hexadecimal, octal and binary systems. All other characters will be ignored, in which case all functions will give incorrect results (even if you just put a space before the number).

**License**
- __Zlib__.

In my opinion, the Val function is quite outdated and needs to be updated, I just provide code that works a little better. Val was created when I was young.
But I must admit that it is good enough to this day.

**Note! Hexadecimal, octal and binary numbers are treated as unsigned!!! And therefore they are processed by functions that work with unsigned numbers.**

***

**pluses (+)**
- faster work speed.
- should be suitable for any platform, as it is made on pure pascal.
- when the numbers are too large or when translating "junk" does not terminate the program, but gives an error that the number has not been translated.

**minuses (-)**
- please report any problems you encounter.
- not tested on Delphi and other compilers... :( I only tested on FPC.

***

The __ge_external_utils.pas__ module provides six main functions, three in common:
- function __geCharToInt__(const aStr: array of Char; out Value: maxIntVal; Size: maxIntVal = maxSize): Boolean; - for signed decimal numbers.
- function __geCharToUInt__(const aStr: array of Char; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean; - for unsigned decimal numbers.
- function __geHOBCharToUInt__(const aStr: array of Char; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean; - for work with hexadecimal, octal and binary values.

three for unicode (WideChar):
- function __geWCharToInt__(const aStr: array of WideChar; out Value: maxIntVal; Size: maxIntVal = maxSize): Boolean; - for signed decimal numbers.
- function __geWCharToUInt__(const aStr: array of WideChar; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean; - for unsigned decimal numbers.
- function __geHOBWCharToUInt__(const aStr: array of WideChar; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean; - for work with hexadecimal, octal and binary values.

***

38 user-defined functions to convert strings to numbers.
Six for direct indication  
__are common__:
- function __geStrToInt__(const Str: useString; out Value: maxIntVal; Size: LongWord = isInteger): Boolean; - for signed decimal numbers.
- function __geStrToUInt__(const Str: useString; out Value: maxUIntVal; Size: LongWord = isLongWord): Boolean; - for unsigned decimal numbers.
- function __geHOBStrToUInt__(const Str: useString; out Value: maxUIntVal; Size: LongWord = isQWord): Boolean; - for work with hexadecimal, octal and binary values.

__unicode__:
- function __geStrToInt__(const Str: UnicodeString; out Value: maxIntVal; Size: LongWord = isInteger): Boolean; - for signed decimal numbers.
- function __geStrToUInt__(const Str: UnicodeString; out Value: maxUIntVal; Size: LongWord = isLongWord): Boolean; - for unsigned decimal numbers.
- function __geHOBStrToUInt__(const Str: UnicodeString; out Value: maxUIntVal; Size: LongWord = isQWord): Boolean; - for work with hexadecimal, octal and binary values.

***

features that will be easier for most to use. Functions are marked with a prefix:
* s_ - functions return a result (if the operation was unsuccessful, the result will be zero, but you will not know that the operation was unsuccessful).
* sc_ - the result of the functions was a successful or unsuccessful operation. Read the final numerical result in Value.

Sixteen signed (decimal only) functions that cannot use hexadecimal, octal, or binary numbers:  
__are common__:
- function __sc_StrToShortInt__(const Str: useString; out Value: ShortInt): Boolean;    // byte
- function __s_StrToShortInt__(const Str: useString): ShortInt;                         // byte
- function __sc_StrToSmallInt__(const Str: useString; out Value: SmallInt): Boolean;    // word
- function __s_StrToSmallInt__(const Str: useString): SmallInt;                         // word
- function __sc_StrToInt__(const Str: useString; out Value: Integer): Boolean;
- function __s_StrToInt__(const Str: useString): Integer;
- function __sc_StrToInt64__(const Str: useString; out Value: Int64): Boolean;
- function __s_StrToInt64__(const Str: useString): Int64;

__unicode__:
- function __sc_StrToShortInt__(const Str: UnicodeString; out Value: ShortInt): Boolean;    // byte
- function __s_StrToShortInt__(const Str: UnicodeString): ShortInt;                         // byte
- function __sc_StrToSmallInt__(const Str: UnicodeString; out Value: SmallInt): Boolean;    // word
- function __s_StrToSmallInt__(const Str: UnicodeString): SmallInt;                         // word
- function __sc_StrToInt__(const Str: UnicodeString; out Value: Integer): Boolean;
- function __s_StrToInt__(const Str: UnicodeString): Integer;
- function __sc_StrToInt64__(const Str: UnicodeString; out Value: Int64): Boolean;
- function __s_StrToInt64__(const Str: UnicodeString): Int64;

Sixteen functions for unsigned numbers. These functions can use decimal, hexadecimal, octal and binary numbers. These functions must not contain leading zeros for the decimal number system:  
__are common__:
- function __sc_StrToByte__(const Str: useString; out Value: Byte): Boolean;
- function __s_StrToByte__(const Str: useString): Byte;
- function __sc_StrToWord__(const Str: useString; out Value: Word): Boolean;
- function __s_StrToWord__(const Str: useString): Word;
- function __sc_StrToLongWord__(const Str: useString; out Value: LongWord): Boolean;
- function __s_StrToLongWord__(const Str: useString): LongWord;
- function __sc_StrToQWord__(const Str: useString; out Value: QWord): Boolean;
- function __s_StrToQWord__(const Str: useString): QWord;

__unicode__:
- function __sc_StrToByte__(const Str: UnicodeString; out Value: Byte): Boolean;
- function __s_StrToByte__(const Str: UnicodeString): Byte;
- function __sc_StrToWord__(const Str: UnicodeString; out Value: Word): Boolean;
- function __s_StrToWord__(const Str: UnicodeString): Word;
- function __sc_StrToLongWord__(const Str: UnicodeString; out Value: LongWord): Boolean;
- function __s_StrToLongWord__(const Str: UnicodeString): LongWord;
- function __sc_StrToQWord__(const Str: UnicodeString; out Value: QWord): Boolean;
- function __s_StrToQWord__(const Str: UnicodeString): QWord;

***

The module has been edited for different architectures. It was checked only on a 64-bit system, on a 32-bit one it should not cause problems. For 16 and 8 bit
it is necessary to check.
In the module, you can raise the level of the current architecture (UP_CPU at the beginning of the module). But you should know that both the compiler and the
system under which you are doing this allow it (mostly it depends on the compiler). For a 64-bit system, it is impossible to raise the level at the moment.
With a strong desire (if you so desire), you can declare your data and work with it. Procedures should not depend on the bitness of the system at all, so you
can raise it even to infinity.

The ability to select the type of strings you are working with has been added to the configuration file (in order not to lose speed when translating one type of strings into others):
- {$DEFINE USE_STRING} - String
- {$DEFINE USE_ANSISTRING} - AnsiString
- {$DEFINE USE_UTF8STRING} - UTF8String

Define priority from top to bottom. If the upstream define is enabled, then the downstream ones are disabled.

You can turn off some features if you don't use them.
If you include {$DEFINE USE_UNICODESTRING} and {$DEFINE UNICODESTRING_ONLI}, then only unicode can be used. If you turn off the first define, this will disable the use of functions based on __WideChar__ (unicode), only functions based on __Char__ will be used.

***

I express my deep gratitude to everyone who supported! And also to everyone who put sticks in the wheels, you also helped a lot! )))

Communication: M12Mirrel@yandex.ru
You can also contact me on the Lazarus forums and express your wishes and shortcomings.

If this project was useful to you, you can support me. Sberbank:
2202200951985520

***
***

<a name="Russian"></a>Rus:
-------------

**fast StrToInt** - библиотека которая предоставляет обновлённые функции для перевода строки в число. В данном репозитории выложен проект, который идёт как
демо версия с примерами использования. В проект включён основной модуль __ge_external_utils.pas__ и файл конфигурации.

**ge_external_utils.pas** - модуль предоставляющий все функции по переводу строк в число. Основная информация с комментариями содержится в модуле.

**Внимание!** Данная библиотека нацелена на скорость перевода строк в число! На совместимость с разными архитектурами. А так же для минимизации конечного кода. :) Но обрабатывает она только числа, знак "-" (минус) и префиксы для шестнадцатеричной, восмеричной и двоичной систем. Все остальные символы будут игнорированы и в этом случае все функции будут выдавать не верный результат (даже если вы просто поставите пробел перед числом).

**Лицензия**
- __Zlib__.

По моему мнению функция Val достаточно устарела, и требуется её обновление, я лишь привожу код, который работает немного лучше. Val была создана ещё во
времена моей молодости. Но я должен признать, что она достаточно хороша и по сей день.

**Обратите внимание! Шестнадцатеричные, восьмеричные и двоичные числа рассматриваются как беззнаковые!!! И потому обрабатываются функциями, которые работают с числами без знака.**

***

**плюсы (+)**
- быстрее скорость работы.
- должна подойти для любой платформы, так как сделано на чистом паскале.
- при слишком больших числах не завершает работу программы, а выдаёт ошибку, что число не было переведено.

**минусы (-)**
- просьба сообщить о всех проявившихся проблемах.
- не проверено на Delphi и других компиляторах... :( Я проверял только на FPC.

***

Модуль __ge_external_utils.pas__ предоставляет шесть основных функции, три общие:
- function __geCharToInt__(const aStr: array of Char; out Value: maxIntVal; Size: maxIntVal = maxSize): Boolean; - для десятичных чисел со знаком.
- function __geCharToUInt__(const aStr: array of Char; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean; - для десятичных чисел без знака.
- function __geHOBCharToUInt__(const aStr: array of Char; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean; - для работы с шестнадцатеричными, восьмеричными и двоичными значениями.

три для юникода (WideChar):
- function __geWCharToInt__(const aStr: array of WideChar; out Value: maxIntVal; Size: maxIntVal = maxSize): Boolean; - для десятичных чисел со знаком.
- function __geWCharToUInt__(const aStr: array of WideChar; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean; - для десятичных чисел без знака.
- function __geHOBWCharToUInt__(const aStr: array of WideChar; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean; - для работы с шестнадцатеричными, восьмеричными и двоичными значениями.

***

38 пользовательских функций, для перевода строк в число.
Шесть для прямого указания  
__общие__:
- function __geStrToInt__(const Str: useString; out Value: maxIntVal; Size: LongWord = isInteger): Boolean; - для десятичных чисел со знаком.
- function __geStrToUInt__(const Str: useString; out Value: maxUIntVal; Size: LongWord = isLongWord): Boolean; - для десятичных чисел без знака.
- function __geHOBStrToUInt__(const Str: useString; out Value: maxUIntVal; Size: LongWord = isQWord): Boolean; - для работы с шестнадцатеричными, восьмеричными
и двоичными значениями.

__юникод__:
- function __geStrToInt__(const Str: UnicodeString; out Value: maxIntVal; Size: LongWord = isInteger): Boolean; - для десятичных чисел со знаком.
- function __geStrToUInt__(const Str: UnicodeString; out Value: maxUIntVal; Size: LongWord = isLongWord): Boolean; - для десятичных чисел без знака.
- function __geHOBStrToUInt__(const Str: UnicodeString; out Value: maxUIntVal; Size: LongWord = isQWord): Boolean; - для работы с шестнадцатеричными, восьмеричными и двоичными значениями.

***

функции использование которых будет проще для большинства. Функции отмечены префиксом:
* s_ - функции возвращают результат (если операция была неудачной, то в результате вернётся ноль, но вы не узнаете, что операция была неудачной).
* sc_ - результат функций удачная или не удачная была операция. Сам конечный числовой результат считывайте в Value.

Шестнадцать функций для чисел со знаком (только десятичные), в которых нельзя использовать шестнадцатеричные, восьмеричные и двоичные числа:

__общие__
- function __sc_StrToShortInt__(const Str: useString; out Value: ShortInt): Boolean;    // byte
- function __s_StrToShortInt__(const Str: useString): ShortInt;                         // byte
- function __sc_StrToSmallInt__(const Str: useString; out Value: SmallInt): Boolean;    // word
- function __s_StrToSmallInt__(const Str: useString): SmallInt;                         // word
- function __sc_StrToInt__(const Str: useString; out Value: Integer): Boolean;
- function __s_StrToInt__(const Str: useString): Integer;
- function __sc_StrToInt64__(const Str: useString; out Value: Int64): Boolean;
- function __s_StrToInt64__(const Str: useString): Int64;

__юникод__
- function __sc_StrToShortInt__(const Str: UnicodeString; out Value: ShortInt): Boolean;    // byte
- function __s_StrToShortInt__(const Str: UnicodeString): ShortInt;                         // byte
- function __sc_StrToSmallInt__(const Str: UnicodeString; out Value: SmallInt): Boolean;    // word
- function __s_StrToSmallInt__(const Str: UnicodeString): SmallInt;                         // word
- function __sc_StrToInt__(const Str: UnicodeString; out Value: Integer): Boolean;
- function __s_StrToInt__(const Str: UnicodeString): Integer;
- function __sc_StrToInt64__(const Str: UnicodeString; out Value: Int64): Boolean;
- function __s_StrToInt64__(const Str: UnicodeString): Int64;

Шестнадцать функций для чисел без знака. Эти функции можно использовать десятичные, шестнадцатеричные, восьмеричные и двоичные числа. Данные функции не должны содержать ведущие нули для десятеричной системы счисления:

__общие__
- function __sc_StrToByte__(const Str: useString; out Value: Byte): Boolean;
- function __s_StrToByte__(const Str: useString): Byte;
- function __sc_StrToWord__(const Str: useString; out Value: Word): Boolean;
- function __s_StrToWord__(const Str: useString): Word;
- function __sc_StrToLongWord__(const Str: useString; out Value: LongWord): Boolean;
- function __s_StrToLongWord__(const Str: useString): LongWord;
- function __sc_StrToQWord__(const Str: useString; out Value: QWord): Boolean;
- function __s_StrToQWord__(const Str: useString): QWord;
- 
__юникод__
- function __sc_StrToByte__(const Str: UnicodeString; out Value: Byte): Boolean;
- function __s_StrToByte__(const Str: UnicodeString): Byte;
- function __sc_StrToWord__(const Str: UnicodeString; out Value: Word): Boolean;
- function __s_StrToWord__(const Str: UnicodeString): Word;
- function __sc_StrToLongWord__(const Str: UnicodeString; out Value: LongWord): Boolean;
- function __s_StrToLongWord__(const Str: UnicodeString): LongWord;
- function __sc_StrToQWord__(const Str: UnicodeString; out Value: QWord): Boolean;
- function __s_StrToQWord__(const Str: UnicodeString): QWord;

***

Модуль редактирован для разных архитектур. Проверялось только на 64-х битной системе, на 32-х битной не должно вызвать проблем. Для 16-ти и 8-ми битных надо
проверять.

В модуле можно поднять уровень текущей архитектуры (UP_CPU в начале модуля). Но вы должны знать, что это позволяет и компилятор и система под которую вы это
делаете (в основном от компилятора зависит). Для 64-х битной системы поднять уровень нельзя на данный момент. При сильном желании (если так хотите) можно,
объявите свои данные и работайте с ними. Процедуры вообще не должны зависеть от разрядности системы, поэтому можно поднимать хоть до бесконечности.

В файл конфигурации добавлена возможность выбора вида строк с которыми работаете (для того чтоб не потерять в скорости при переводе одного вида строк в другие):
- {$DEFINE USE_STRING} - String
- {$DEFINE USE_ANSISTRING} - AnsiString
- {$DEFINE USE_UTF8STRING} - UTF8String

Приоритет дефайнов сверху вниз. Если вышестоящий дефайн включен, то нижестоящие отключаться.

Можно отключать часть функций, если вы их не используете.
Если включить {$DEFINE USE_UNICODESTRING} и {$DEFINE UNICODESTRING_ONLI}, то можно будет использовать только юникод. Если вылючить первый дефайн, то это отключит использование функций на основе __WideChar__ (юникод), будут использоватьсятолько функции на основе __Char__.

***

Выражаю огромную благодарность всем, кто поддержал! А так же всем, кто вставлял палки в колёса, вы тоже сильно помогли! )))

Связь: M12Mirrel@yandex.ru
Так же можно связаться со мной на форумах Lazarus и высказать пожелания и недоработки.

Если вам пригодился данный проект вы можете поддержать меня. Сбербанк:
2202200951985520
