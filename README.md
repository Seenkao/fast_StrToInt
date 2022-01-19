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

**License**
- __Zlib__.

In my opinion, the Val function is quite outdated and needs to be updated, I just provide code that works a little better. Val was created when I was young.
But I must admit that it is good enough to this day.

**pluses (+)**
- faster work speed.
- should be suitable for any platform, as it is made on pure pascal.
- when the numbers are too large or when translating "junk" does not terminate the program, but gives an error that the number has not been translated.

**minuses (-)**
- please report any problems you encounter.
- not tested on Delphi and other compilers... :( I only tested on FPC.

The __ge_external_utils.pas__ module provides three main functions:
- function __geStrToInt__(const Str: String; out Value: maxIntVal; Size: LongWord = isInteger): Boolean; - for signed decimal numbers.
- function __geStrToUInt__(const Str: String; out Value: maxUIntVal; Size: LongWord = isLongWord): Boolean; - for unsigned decimal numbers.
- function __geHOBStrToUInt__(const Str: String; out Value: maxUIntVal; Size: LongWord = isQWord): Boolean; - for work with hexadecimal, octal and binary values.

and 16 user-defined functions to convert strings to numbers. Their use will be easier for most. Functions are marked with a prefix:
* s_ - functions return a result (if the operation was unsuccessful, the result will be zero, but you will not know that the operation was unsuccessful).
* sc_ - the result of the functions was a successful or unsuccessful operation. Read the final numerical result in Value.

Eight signed (decimal only) functions that cannot use hexadecimal, octal, or binary numbers:
- function __sc_StrToShortInt__(const Str: String; out Value: ShortInt): Boolean;    // byte
- function __s_StrToShortInt__(const Str: String): ShortInt;                         // byte
- function __sc_StrToSmallInt__(const Str: String; out Value: SmallInt): Boolean;    // word
- function __s_StrToSmallInt__(const Str: String): SmallInt;                         // word
- function __sc_StrToInt__(const Str: String; out Value: Integer): Boolean;
- function __s_StrToInt__(const Str: String): Integer;
- function __sc_StrToInt64__(const Str: String; out Value: Int64): Boolean;
- function __s_StrToInt64__(const Str: String): Int64;

Eight functions for unsigned numbers. These functions can use decimal, hexadecimal, octal and binary numbers:
- function __sc_StrToByte__(const Str: String; out Value: Byte): Boolean;
- function __s_StrToByte__(const Str: String): Byte;
- function __sc_StrToWord__(const Str: String; out Value: Word): Boolean;
- function __s_StrToWord__(const Str: String): Word;
- function __sc_StrToLongWord__(const Str: String; out Value: LongWord): Boolean;
- function __s_StrToLongWord__(const Str: String): LongWord;
- function __sc_StrToQWord__(const Str: String; out Value: QWord): Boolean;
- function __s_StrToQWord__(const Str: String): QWord;

The module has been edited for different architectures. It was checked only on a 64-bit system, on a 32-bit one it should not cause problems. For 16 and 8 bit
it is necessary to check.
In the module, you can raise the level of the current architecture (UP_CPU at the beginning of the module). But you should know that both the compiler and the
system under which you are doing this allow it (mostly it depends on the compiler). For a 64-bit system, it is impossible to raise the level at the moment.
With a strong desire (if you so desire), you can declare your data and work with it. Procedures should not depend on the bitness of the system at all, so you
can raise it even to infinity.

I express my deep gratitude to everyone who supported! And also to everyone who put sticks in the wheels, you also helped a lot! )))

Communication: M12Mirrel@yandex.ru
You can also contact me on the Lazarus forums and express your wishes and shortcomings.

If this project was useful to you, you can support me. Sberbank:
2202200951985520

<a name="Russian"></a>Rus:
-------------

**fast StrToInt** - библиотека которая предоставляет обновлённые функции для перевода строки в число. В данном репозитории выложен проект, который идёт как
демо версия с примерами использования. В проект включён основной модуль __ge_external_utils.pas__ и файл конфигурации.

**ge_external_utils.pas** - модуль предоставляющий все функции по переводу строк в число. Основная информация с комментариями содержится в модуле.

**Лицензия**
- __Zlib__.

По моему мнению функция Val достаточно устарела, и требуется её обновление, я лишь привожу код, который работает немного лучше. Val была создана ещё во
времена моей молодости. Но я должен признать, что она достаточно хороша и по сей день.

**плюсы (+)**
- быстрее скорость работы.
- должна подойти для любой платформы, так как сделано на чистом паскале.
- при слишком больших числах не завершает работу программы, а выдаёт ошибку, что число не было переведено.

**минусы (-)**
- просьба сообщить о всех проявившихся проблемах.
- не проверено на Delphi и других компиляторах... :( Я проверял только на FPC.

Модуль __ge_external_utils.pas__ предоставляет три основных функции:
- function __geStrToInt__(const Str: String; out Value: maxIntVal; Size: LongWord = isInteger): Boolean; - для десятичных чисел со знаком.
- function __geStrToUInt__(const Str: String; out Value: maxUIntVal; Size: LongWord = isLongWord): Boolean; - для десятичных чисел без знака.
- function __geHOBStrToUInt__(const Str: String; out Value: maxUIntVal; Size: LongWord = isQWord): Boolean; - для работы с шестнадцатеричными, восьмеричными
и двоичными значениями.

и 16 пользовательских функций, для перевода строк в число. Их использование будет проще для большинства. Функции отмечены префиксом:
* s_ - функции возвращают результат (если операция была неудачной, то в результате вернётся ноль, но вы не узнаете, что операция была неудачной).
* sc_ - результат функций удачная или не удачная была операция. Сам конечный числовой результат считывайте в Value.

Восемь функций для чисел со знаком (только десятичные), в которых нельзя использовать шестнадцатеричные, восьмеричные и двоичные числа:
- function __sc_StrToShortInt__(const Str: String; out Value: ShortInt): Boolean;    // byte
- function __s_StrToShortInt__(const Str: String): ShortInt;                         // byte
- function __sc_StrToSmallInt__(const Str: String; out Value: SmallInt): Boolean;    // word
- function __s_StrToSmallInt__(const Str: String): SmallInt;                         // word
- function __sc_StrToInt__(const Str: String; out Value: Integer): Boolean;
- function __s_StrToInt__(const Str: String): Integer;
- function __sc_StrToInt64__(const Str: String; out Value: Int64): Boolean;
- function __s_StrToInt64__(const Str: String): Int64;

Восемь функций для чисел без знака. Эти функции можно использовать десятичные, шестнадцатеричные, восьмеричные и двоичные числа:
- function __sc_StrToByte__(const Str: String; out Value: Byte): Boolean;
- function __s_StrToByte__(const Str: String): Byte;
- function __sc_StrToWord__(const Str: String; out Value: Word): Boolean;
- function __s_StrToWord__(const Str: String): Word;
- function __sc_StrToLongWord__(const Str: String; out Value: LongWord): Boolean;
- function __s_StrToLongWord__(const Str: String): LongWord;
- function __sc_StrToQWord__(const Str: String; out Value: QWord): Boolean;
- function __s_StrToQWord__(const Str: String): QWord;

Модуль редактирован для разных архитектур. Проверялось только на 64-х битной системе, на 32-х битной не должно вызвать проблем. Для 16-ти и 8-ми битных надо
проверять.

В модуле можно поднять уровень текущей архитектуры (UP_CPU в начале модуля). Но вы должны знать, что это позволяет и компилятор и система под которую вы это
делаете (в основном от компилятора зависит). Для 64-х битной системы поднять уровень нельзя на данный момент. При сильном желании (если так хотите) можно,
объявите свои данные и работайте с ними. Процедуры вообще не должны зависеть от разрядности системы, поэтому можно поднимать хоть до бесконечности.

Выражаю огромную благодарность всем, кто поддержал! А так же всем, кто вставлял палки в колёса, вы тоже сильно помогли! )))

Связь: M12Mirrel@yandex.ru
Так же можно связаться со мной на форумах Lazarus и высказать пожелания и недоработки.

Если вам пригодился данный проект вы можете поддержать меня. Сбербанк:
2202200951985520