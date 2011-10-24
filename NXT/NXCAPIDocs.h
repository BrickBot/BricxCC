/** \file NXCAPIDocs.h
 * \brief Additional documentation for the NXC API
 *
 * NXCAPIDocs.h contains additional documentation for the NXC API
 *
 * License:
 *
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * The Initial Developer of this code is John Hansen.
 * Portions created by John Hansen are Copyright (C) 2009-2011 John Hansen.
 * All Rights Reserved.
 *
 * ----------------------------------------------------------------------------
 *
 * \author John Hansen (bricxcc_at_comcast.net)
 * \date 2011-10-16
 * \version 22
 */
#ifndef NXCAPIDOCS_H
#define NXCAPIDOCS_H

/////////////////////////////////////////////////////////////////////////////
/////////////////////  NXC Programmer's Guide ///////////////////////////////
/////////////////////////////////////////////////////////////////////////////

/** @mainpage NXC Programmer's Guide
 * \brief
 *
 * <h2><center>October 10, 2011</center></h2>
 * <h2><center>by John Hansen</center></h2>
 * 
 * - @subpage intro
 * - @subpage lang
 *
 */

/** @page intro Introduction
 * \brief
 * 
 * NXC stands for Not eXactly C. It is a simple language for programming the
 * LEGO MINDSTORMS NXT product. The NXT has a bytecode interpreter (provided
 * by LEGO), which can be used to execute programs. The NXC compiler translates
 * a source program into NXT bytecodes, which can then be executed on the
 * target itself. Although the preprocessor and control structures of NXC are
 * very similar to C, NXC is not a general-purpose programming language - there
 * are many restrictions that stem from limitations of the NXT bytecode
 * interpreter.
 *
 * Logically, NXC is defined as two separate pieces. The NXC language describes
 * the syntax to be used in writing programs. The NXC Application Programming
 * Interface (API) describes the system functions, constants, and macros that
 * can be used by programs. This API is defined in a special file known as a
 * "header file" which is, by default, automatically included when compiling a
 * program.
 *
 * This document describes both the NXC language and the NXC API. In short, it
 * provides the information needed to write NXC programs. Since there are
 * different interfaces for NXC, this document does not describe how to use
 * any specific NXC implementation (such as the command-line compiler or Bricx
 * Command Center). Refer to the documentation provided with the NXC tool,
 * such as the NXC User Manual, for information specific to that implementation.
 *
 * For up-to-date information and documentation for NXC, visit the NXC website
 * at http://bricxcc.sourceforge.net/nxc/.
 */

/** @page lang The NXC Language
 * \brief
 *
 * This section describes the NXC language. This includes the lexical rules
 * used by the compiler, the structure of programs, statements and expressions,
 * and the operation of the preprocessor.
 *
 * NXC is a case-sensitive language, just like C and C++, which means the
 * identifier "xYz" is not the same identifier as "Xyz". Similarly, the "if"
 * statement begins with the keyword "if" but "iF", "If", or "IF" are all just
 * valid identifiers - not keywords.
 *
 * - @subpage lexrules
 * - @subpage progstruct
 * - @subpage statements
 * - @subpage expressions
 * - @subpage preproc
 *
 */

/** @page lexrules Lexical Rules
 * \brief
 *
 * The lexical rules describe how NXC breaks a source file into individual
 * tokens. This includes the way comments are written, the handling of
 * whitespace, and valid characters for identifiers.
 *
 * - @subpage cmts
 * - @subpage wspace
 * - @subpage consts
 * - @subpage strconst
 * - @subpage charconst
 * - @subpage idkey
 *
 */

/** @page progstruct Program Structure
 * \brief
 *
 * An NXC program is composed of code blocks and variables. There are two
 * distinct types of code blocks: tasks and functions. Each type of code block
 * has its own unique features, but they share a common structure. The maximum
 * number of code blocks of both tasks and functions combined is 256.
 *
 * - @subpage codeorder
 * - @subpage task
 * - @subpage func
 * - @subpage vars
 * - @subpage struct
 * - @subpage arrays
 *
 */

/** @page statements Statements
 * \brief
 * 
 * The body of a code block (task or function) is composed of statements.
 * Statements are terminated with a semi-colon (';'), as you have seen in the
 * example code above.
 *
 * - @subpage vardecl
 * - @subpage asgn
 * - @subpage ctrls
 * - @subpage asm
 * - @subpage otherst
 *
 */

/** @page expressions Expressions
 * \brief
 * 
 * Values are the most primitive type of expressions. More complicated
 * expressions are formed from values using various operators.
 *
 * Numerical constants in the NXT are represented as integers or floating point
 * values. The type depends on the value of the constant. NXC internally uses
 * 32 bit floating point math for constant expression evaluation. Numeric
 * constants are written as either decimal (e.g. 123, 3.14) or hexadecimal
 * (e.g. 0xABC). Presently, there is very little range checking on constants,
 * so using a value larger than expected may produce unusual results.
 *
 * Two special values are predefined: true and false. The value of false is
 * zero (0), while the value of true is one (1). The same values hold for
 * relational operators (e.g. <): when the relation is false the value is 0,
 * otherwise the value is 1.
 *
 * Values may be combined using operators. NXC operators are listed here in
 * order of precedence from highest to lowest.
 *
 * <center>
 * <table>
 * <tr><th>Operator</th><th>Description</th><th>Associativity</th><th>Restriction</th><th>Example</th></tr>
 * <tr><td>abs()</td><td>Absolute value</td><td>n/a</td><td>&nbsp;</td><td>abs(x)</td></tr>
 * <tr><td>sign()</td><td>Sign of operand</td><td>n/a</td><td>&nbsp;</td><td>sign(x)</td></tr>
 * <tr><td>++, --</td><td>Postfix increment/decrement</td><td>left</td><td>variables only</td><td>x++</td></tr>
 * <tr><td>++, --</td><td>Prefix increment/decrement</td><td>right</td><td>variables only</td><td>++x</td></tr>
 * <tr><td>-</td><td>Unary minus</td><td>right</td><td>&nbsp;</td><td>-x</td></tr>
 * <tr><td>~</td><td>Bitwise negation (unary)</td><td>right</td><td>&nbsp;</td><td>~123</td></tr>
 * <tr><td>!</td><td>Logical negation</td><td>right</td><td>&nbsp;</td><td>!x</td></tr>
 * <tr><td>*, /, %</td><td>Multiplication, division, modulus</td><td>left</td><td>&nbsp;</td><td>x * y</td></tr>
 * <tr><td>+, -</td><td>Addition, subtraction</td><td>left</td><td>&nbsp;</td><td>x + y</td></tr>
 * <tr><td><<, >></td><td>Bitwise shift left and right</td><td>left</td><td>&nbsp;</td><td>x << 4</td></tr>
 * <tr><td><, >, <=, >=</td><td>relational operators</td><td>left</td><td>&nbsp;</td><td>x < y</td></tr>
 * <tr><td>==, !=</td><td>equal to, not equal to</td><td>left</td><td>&nbsp;</td><td>x == 1</td></tr>
 * <tr><td>&</td><td>Bitwise AND</td><td>left</td><td>&nbsp;</td><td>x & y</td></tr>
 * <tr><td>^</td><td>Bitwise exclusive OR</td><td>left</td><td>&nbsp;</td><td>x ^  y</td></tr>
 * <tr><td>|</td><td>Bitwise inclusive OR</td><td>left</td><td>&nbsp;</td><td>x | y</td></tr>
 * <tr><td>&&</td><td>Logical AND</td><td>left</td><td>&nbsp;</td><td>x && y</td></tr>
 * <tr><td>||</td><td>Logical OR</td><td>left</td><td>&nbsp;</td><td>x || y</td></tr>
 * <tr><td>?:</td><td>Ternary conditional value</td><td>right</td><td>&nbsp;</td><td>x==1 ? y : z</td></tr>
 * </table>
 * </center>
 * <center>Table 5. Expression Operators</center>
 * Where needed, parentheses are used to change the order of evaluation:
 * \code
 * x = 2 + 3 * 4;	// set x to 14
 * y = (2 + 3) * 4;	// set y to 20
 * \endcode
 *
 * - @subpage condtn
 *
 */

/** @page preproc The Preprocessor
 * \brief
 *
 * NXC also includes a preprocessor that is modeled after the Standard C
 * preprocessor. The C preprocessor processes a source code file before the
 * compiler does. It handles such tasks as including code from other files,
 * conditionally including or excluding blocks of code, stripping comments,
 * defining simple and parameterized macros, and expanding macros wherever
 * they are encountered in the source code.
 *
 * The NXC preprocessor implements the following standard preprocessor directives:
 * \#include, \#define, \#ifdef, \#ifndef, \#endif, \#if, \#elif, \#undef, \#\#,
 * \#line, \#error, and \#pragma. It also supports two non-standard directives:
 * \#download and \#import. Its implementation is close to a standard C
 * preprocessor's, so most preprocessor directives should work as C programmers
 * expect in NXC. Any significant deviations are explained below.
 *
 * - @subpage include
 * - @subpage define
 * - @subpage concat
 * - @subpage condcomp
 * - @subpage import
 * - @subpage download
 *
 */

/** @page cmts Comments
 * \brief
 *
 * Two forms of comments are supported in NXC. The first are traditional C
 * comments. They begin with '/*' and end with '* /'. These comments are
 * allowed to span multiple lines, but they cannot be nested.
 * \code
 * /* this is a comment */
 *
 * /* this is a two
 *    line comment */
 *
 * /* another comment...
 *    /* trying to nest...
 *       ending the inner comment...*/
 *    this text is no longer a comment! */
 * \endcode
 * The second form of comments supported in NXC begins with '//' and continues
 * to the end of the current line. These are sometimes known as C++ style
 * comments.
 * \code
 * // a single line comment
 * \endcode
 * As you might guess, the compiler ignores comments. Their only purpose is to
 * allow the programmer to document the source code.
 * 
 */

/** @page wspace Whitespace
 * \brief
 * 
 * Whitespace consists of all spaces, tabs, and newlines. It is used to
 * separate tokens and to make a program more readable. As long as the tokens
 * are distinguishable, adding or subtracting whitespace has no effect on the
 * meaning of a program. For example, the following lines of code both have the
 * same meaning:
 * \code
 * x=2;
 * x   =  2  ;
 * \endcode
 * Some of the C++ operators consist of multiple characters. In order to
 * preserve these tokens, whitespace cannot appear within them. In the example
 * below, the first line uses a right shift operator ('>>'), but in the second
 * line the added space causes the '>' symbols to be interpreted as two
 * separate tokens and thus results in a compiler error.
 * \code
 * x = 1 >> 4; // set x to 1 right shifted by 4 bits
 * x = 1 > > 4; // error
 * \endcode
 * 
 */

/** @page consts Numerical Constants
 * \brief
 * 
 * Numerical constants may be written in either decimal or hexadecimal form.
 * Decimal constants consist of one or more decimal digits. Decimal constants
 * may optionally include a decimal point along with one or more decimal digits
 * following the decimal point. Hexadecimal constants start with 0x or 0X
 * followed by one or more hexadecimal digits.
 * \code
 * x = 10;  // set x to 10
 * x = 0x10; // set x to 16 (10 hex)
 * f = 10.5; // set f to 10.5
 * \endcode
 * 
 */

/** @page strconst String Constants
 * \brief
 *
 * String constants in NXC, just as in C, are delimited with double quote
 * characters. NXC has a string data type that makes strings easier to use
 * than in C. Behind the scenes, a string is automatically converted into an
 * array of bytes, with the last byte in the array being a zero. The final zero
 * byte is generally referred to as the null terminator.
 * \code
 * TextOut(0, LCD_LINE1, "testing");
 * \endcode
 */

/** @page charconst Character Constants
 * \brief
 * 
 * Character constants in NXC are delimited with single quote characters and
 * may contain a single ASCII character.  The value of a character constant is
 * the numeric ASCII value of the character.
 * \code
 * char ch = 'a'; // ch == 97
 * \endcode
 * 
 */

/** @page idkey Identifiers and Keywords
 * \brief
 * 
 * Identifiers are used for variable, task, function, and subroutine names.
 * The first character of an identifier must be an upper or lower case letter
 * or the underscore ('_'). Remaining characters may be letters, numbers, and
 * underscores.
 *
 * A number of tokens are reserved for use in the NXC language itself. These
 * are called keywords and may not be used as identifiers. A complete list of
 * keywords appears below:
 *
 * - \ref asm
 * - \ref bool
 * - \ref break
 * - \ref byte
 * - \ref case
 * - \ref char
 * - @subpage const
 * - \ref continue
 * - \ref default
 * - \ref do
 * - \ref else
 * - @subpage enum
 * - \ref false
 * - \ref float
 * - \ref for
 * - \ref goto
 * - \ref if
 * - \ref inline
 * - \ref int
 * - \ref long
 * - \ref mutex
 * - \ref priority
 * - \ref repeat
 * - \ref return
 * - \ref safecall
 * - \ref short
 * - \ref start
 * - @subpage static
 * - \ref stop
 * - \ref string
 * - \ref struct
 * - \ref sub
 * - \ref switch
 * - \ref task
 * - \ref true
 * - @subpage typedef
 * - \ref unsigned
 * - \ref until
 * - \ref void
 * - \ref while
 *
 */

/** @page const const
 * \brief
 *
 * The const keyword is used to alter a variable declaration so that the
 * variable cannot have its value changed after it is initialized.  The
 * initialization must occur at the point of the variable declaration.
 * \code
 * const int myConst = 23; // declare and initialize constant integer
 * task main() {
 *   int x = myConst; // this works fine
 *   myConst++; // compiler error - you cannot modify a constant's value
 * }
 * \endcode
 */

/** @page static static
 * \brief
 *
 * The static keyword is used to alter a variable declaration so that the
 * variable is allocated statically - the lifetime of the variable extends
 * across the entire run of the program - while having the same scope as
 * variables declared without the static keyword.
 *
 * Note that the initialization of automatic and static variables is quite
 * different. Automatic variables (local variables are automatic by default,
 * unless you explicitly use static keyword) are initialized during the
 * run-time, so the initialization will be executed whenever it is
 * encountered in the program. Static (and global) variables are initialized
 * during the compile-time, so the initial values will simply be embeded in
 * the executable file itself.
 * \code
 * void func() {
 *   static int x = 0; // x is initialized only once across three calls of func()
 *   NumOut(0, LCD_LINE1, x); // outputs the value of x
 *   x = x + 1;
 * }
 *
 * task main() {
 *   func(); // prints 0
 *   func(); // prints 1
 *   func(); // prints 2
 * }
 * \endcode
 */

/** @page enum enum
 * \brief
 *
 * The enum keyword is used to create an enumerated type named name. The
 * syntax is show below.
 * \code
 * enum [name] {name-list} var-list;
 * \endcode
 * The enumerated type consists of the elements in name-list. The var-list
 * argument is optional, and can be used to create instances of the type along
 * with the declaration. For example, the following code creates an enumerated
 * type for colors:
 * \code
 * enum ColorT {red, orange, yellow, green, blue, indigo, violet};
 * \endcode
 * In the above example, the effect of the enumeration is to introduce several
 * new constants named red, orange, yellow, etc. By default, these constants
 * are assigned consecutive integer values starting at zero. You can change
 * the values of those constants, as shown by the next example:
 * \code
 * enum ColorT { red = 10, blue = 15, green };
 * \endcode
 * In the above example, green has a value of 16.  Once you have defined an
 * enumerated type you can use it to declare variables just like you use
 * any native type.  Here are a few examples of using the enum keyword:
 * \code
 * // values start from 0 and increment upward by 1
 * enum { ONE, TWO, THREE };
 * // optional equal sign with constant expression for the value
 * enum { SMALL=10, MEDIUM=100, LARGE=1000 };
 * // names without equal sign increment by one from last name's value
 * enum { FRED=1, WILMA, BARNEY, BETTY };
 * // optional named type (like a typedef)
 * enum TheSeasons { SPRING, SUMMER, FALL, WINTER };
 * // optional variable at end
 * enum Days {
 *    saturday,            // saturday = 0 by default
 *    sunday = 0x0,          // sunday = 0 as well
 *    monday,              // monday = 1
 *    tuesday,             // tuesday = 2
 *    wednesday,           // etc.
 *    thursday,
 *    friday
 * } today;                // Variable today has type Days
 *
 * Days tomorrow;
 *
 * task main()
 * {
 *   TheSeasons test = FALL;
 *   today = monday;
 *   tomorrow = today+1;
 *   NumOut(0, LCD_LINE1, THREE);
 *   NumOut(0, LCD_LINE2, MEDIUM);
 *   NumOut(0, LCD_LINE3, FRED);
 *   NumOut(0, LCD_LINE4, SPRING);
 *   NumOut(0, LCD_LINE5, friday);
 *   NumOut(0, LCD_LINE6, today);
 *   NumOut(0, LCD_LINE7, test);
 *   NumOut(0, LCD_LINE8, tomorrow);
 *   Wait(SEC_5);
 * }
 * \endcode
 */

/** @page typedef typedef
 * \brief
 *
 * A typedef declaration introduces a name that, within its scope, becomes a
 * synonym for the type given by the type-declaration portion of the
 * declaration.
 * \code
 * typedef type-declaration synonym;
 * \endcode
 * You can use typedef declarations to construct shorter or more meaningful
 * names for types already defined by the language or for types that you have
 * declared. Typedef names allow you to encapsulate implementation details
 * that may change.
 *
 * A typedef declaration does not introduce a new type - it introduces a new
 * name for an existing type. Here are a few examples of how to use the
 * typedef keyword:
 *
 * \code
 * typedef char FlagType;
 * const FlagType x;
 * typedef char CHAR;          // Character type.
 * CHAR ch;
 * typedef unsigned long ulong;
 * ulong ul;     // Equivalent to "unsigned long ul;"
 * \endcode
 */

/** @page codeorder Code Order
 * \brief
 *
 * Code order has two aspects: the order in which the code appears in the
 * source code file and the order in which it is executed at runtime. The
 * first will be referred to as the lexical order and the second as the
 * runtime order.
 * 
 * The lexical order is important to the NXC compiler, but not to the NXT
 * brick. This means that the order in which you write your task and function
 * definitions has no effect on the runtime order. The rules controlling
 * runtime order are:
 * 
 * -# There must be a task called main and this task will always run first.
 * -# The time at which any other task will run is determined by the API
 * functions documented in \ref CommandModuleFunctions section.
 * -# A function will run whenever it is called from another block of code.
 * 
 * This last rule may seem trivial, but it has important consequences when
 * multiple tasks are running. If a task calls a function that is already in
 * the midst of running because it was called first by another task,
 * unpredictable behavior and results may ensue. Tasks can share functions by
 * treating them as shared resources and using mutexes to prevent one task from
 * calling the function while another task is using it. The \ref safecall keyword
 * (see \ref func) may be used to simplify the coding.
 * 
 * The rules for lexical ordering are:
 * 
 * -# Any identifier naming a task or function must be known to the compiler
 * before it is used in a code block.
 * -# A task or function definition makes its naming identifier known to the
 * compiler.
 * -# A task or function declaration also makes a naming identifier known to
 * the compiler.
 * -# Once a task or function is defined it cannot be redefined or declared.
 * -# Once a task or function is declared it cannot be redeclared.
 * 
 * Sometimes you will run into situations where is impossible or inconvenient
 * to order the task and function definitions so the compiler knows every task
 * or function name before it sees that name used in a code block. You can
 * work around this by inserting task or function declarations of the form
 *
 * <tt>
 *   <strong>task</strong> <em>name</em>();<br>
 *   <em>return_type name</em>(<em>argument_list</em>);
 * </tt>
 *
 * before the code block where the first usage occurs. The
 * <tt><em>argument_list</em></tt> must match the list of formal arguments
 * given later in the function's actual definition.
 *
 */

/** @page task Tasks
 * \brief
 * 
 * Since the NXT supports multi-threading, a task in NXC directly corresponds
 * to an NXT thread. Tasks are defined using the task keyword with the syntax
 * shown in the code sample below.
 * \code
 * task name()
 * {
 *   // the task's code is placed here
 * }
 * \endcode
 * The name of the task may be any legal identifier. A program must always
 * have at least one task - named "main" - which is started whenever the
 * program is run. The body of a task consists of a list of statements.
 * 
 * You can start and stop tasks with the start and stop statements, which are
 * discussed below. However, the primary mechanism for starting dependant tasks
 * is scheduling them with either the \ref Precedes or the \ref Follows API
 * function.
 * 
 * The \ref StopAllTasks API function stops all currently running tasks. You
 * can also stop all tasks using the \ref Stop function. A task can stop
 * itself via the \ref ExitTo function. Finally, a task will stop itself
 * simply by reaching the end of its body.
 * 
 * In the code sample below, the main task schedules a music task, a movement
 * task, and a controller task before exiting and allowing these three tasks
 * to start executing concurrently. The controller task waits ten seconds
 * before stopping the music task, and then waits another five seconds before
 * stopping all tasks to end the program.
 * \code
 * task music() {
 *   while (true) {
 *     PlayTone(TONE_A4, MS_500);
 *     Wait(MS_600);
 *   }
 * }
 * 
 * task movement() {
 *   while (true) {
 *     OnFwd(OUT_A, Random(100));
 *     Wait(Random(SEC_1));
 *   }
 * }
 * 
 * task controller() {
 *   Wait(SEC_10);
 *   stop music;
 *   Wait(SEC_5);
 *   StopAllTasks();
 * }
 * 
 * task main() {
 *   Precedes(music, movement, controller);
 * }
 * \endcode
 * 
 */

/** @page func Functions
 * \brief
 * 
 * It is often helpful to group a set of statements together into a single
 * function, which your code can then call as needed. NXC supports functions
 * with arguments and return values. Functions are defined using the syntax
 * below.
 * \code
 * [safecall] [inline] return_type name(argument_list)
 * {
 * 	// body of the function
 * }
 * \endcode
 * The return type is the type of data returned. In the C programming language,
 * functions must specify the type of data they return. Functions that do not
 * return data simply return void.
 *
 * Additional details about the keywords safecall, inline, and void can be
 * found below.
 *
 * - @subpage safecall
 * - @subpage inline
 * - @subpage void
 *
 * The argument list of a function may be empty, or may contain one or more
 * argument definitions. An argument is defined by a type followed by a name.
 * Commas separate multiple arguments. All values are represented as bool, char,
 * byte, int, short, long, unsigned int, unsigned long, float, string,
 * struct types, or arrays of any type.
 * 
 * NXC supports specifying a default value for function arguments that are not
 * struct or array types. Simply add an equal sign followed by the default
 * value. Specifying a default value makes the argument optional when you call
 * the function. All optional arguments must be at the end of the argument
 * list.
 * \code
 * int foo(int x, int y = 20)
 * {
 * 	return x*y;
 * }
 *
 * task main()
 * {
 * 	NumOut(0, LCD_LINE1, foo(10)); outputs 200
 * 	NumOut(0, LCD_LINE2, foo(10, 5)); outputs 50
 * 	Wait(SEC_10); // wait 10 seconds
 * }
 * \endcode
 * NXC also supports passing arguments by value, by constant value, by
 * reference, and by constant reference. These four modes for passing
 * parameters into a function are discussed below.
 * 
 * When arguments are passed by value from the calling function or task to the
 * called function the compiler must allocate a temporary variable to hold the
 * argument. There are no restrictions on the type of value that may be used.
 * However, since the function is working with a copy of the actual argument,
 * the caller will not see any changes the called function makes to the value.
 * In the example below, the function foo attempts to set the value of its
 * argument to 2. This is perfectly legal, but since foo is working on a copy
 * of the original argument, the variable y from the main task remains
 * unchanged.
 * \code
 * void foo(int x)
 * {
 * 	x = 2;
 * }
 * 
 * task main()
 * {
 * 	int y = 1;	// y is now equal to 1
 * 	foo(y);	// y is still equal to 1!
 * }
 * \endcode
 * The second type of argument, const arg_type, is also passed by value. If
 * the function is an inline function then arguments of this kind can sometimes
 * be treated by the compiler as true constant values and can be evaluated at
 * compile-time. If the function is not inline then the compiler treats the
 * argument as if it were a constant reference, allowing you to pass either
 * constants or variables. Being able to fully evaluate function arguments at
 * compile-time can be important since some NXC API functions only work with
 * true constant arguments.
 * \code
 * void foo(const int x)
 * {
 * 	PlayTone(x, MS_500);
 * 	x = 1;	// error - cannot modify argument
 * 	Wait(SEC_1);
 * }
 *
 * task main()
 * {
 * 	int x = TONE_A4;
 * 	foo(TONE_A5);	// ok
 * 	foo(4*TONE_A3);	// expression is still constant
 * 	foo(x);	// x is not a constant but is okay
 * }
 * \endcode
 * The third type, arg_type &, passes arguments by reference rather than by
 * value. This allows the called function to modify the value and have those
 * changes be available in the calling function after the called function
 * returns. However, only variables may be used when calling a function using
 * arg_type & arguments:
 * \code
 * void foo(int &x)
 * {
 * 	x = 2;
 * }
 * 
 * task main()
 * {
 * 	int y = 1;	// y is equal to 1
 * 
 * 	foo(y);	// y is now equal to 2
 * 	foo(2);	// error - only variables allowed
 * }
 * \endcode
 * The fourth type, const arg_type &, is interesting. It is also passed by
 * reference, but with the restriction that the called function is not allowed
 * to modify the value. Because of this restriction, the compiler is able to
 * pass anything, not just variables, to functions using this type of argument.
 * Due to NXT firmware restrictions, passing an argument by reference in NXC
 * is not as optimal as it is in C. A copy of the argument is still made but
 * the compiler will enforce the restriction that the value may not be modified
 * inside the called function.
 * 
 * Functions must be invoked with the correct number and type of arguments.
 * The code example below shows several different legal and illegal calls to
 * function foo.
 * \code
 * void foo(int bar, const int baz)
 * {
 * 	// do something here...
 * }
 * 
 * task main()
 * {
 * 	int x;	// declare variable x
 * 	foo(1, 2);	// ok
 * 	foo(x, 2);	// ok
 * 	foo(2);	// error - wrong number of arguments!
 * }
 * \endcode
 * 
 */

/** @page safecall The safecall keyword
 * \brief
 *
 * An optional keyword that can be specified prior to the return type of
 * a function is the safecall keyword. If a function is marked as safecall
 * then the compiler will synchronize the execution of this function across
 * multiple threads by wrapping each call to the function in Acquire and
 * Release calls. If a second thread tries to call a safecall function while
 * another thread is executing it the second thread will have to wait until
 * the function returns to the first thread.
 *
 * The code example below shows how you can use the safecall keyword to make
 * a function synchronize its execution when it is shared between multiple
 * threads.
 * \code
 * safecall void foo(unsigned int frequency)
 * {
 *   PlayTone(frequency, SEC_1);
 *   Wait(SEC_1);
 * }
 *
 * task task1()
 * {
 *   while(true) {
 *     foo(TONE_A4);
 *     Yield();
 *   }
 * }
 *
 * task task2()
 * {
 *   while(true) {
 *     foo(TONE_A5);
 *     Yield();
 * }
 *
 * task main()
 * {
 * 	Precedes(task1, task2);
 * }
 * \endcode
 *
 */

/** @page inline The inline keyword
 * \brief
 *
 * You can optionally mark NXC functions as inline functions. This means that
 * each call to the function will create another copy of the function's code.
 * Unless used judiciously, inline functions can lead to excessive code size.
 *
 * If a function is not marked as inline then an actual NXT subroutine is
 * created and the call to the function in NXC code will result in a subroutine
 * call to the NXT subroutine. The total number of non-inline functions (aka
 * subroutines) and tasks must not exceed 256.
 *
 * The code example below shows how you can use the inline keyword to make a
 * function emit its code at the point where it is called rather than
 * requiring a subroutine call.
 * \code
 * inline void foo(unsigned int frequency)
 * {
 *   PlayTone(frequency, SEC_1);
 *   Wait(SEC_1);
 * }
 *
 * task main()
 * {
 *   foo(TONE_A4);
 *   foo(TONE_B4);
 *   foo(TONE_C5);
 *   foo(TONE_D5);
 * }
 * \endcode
 *
 * In this case task main will contain 4 PlayTone calls and 4 Wait calls rather
 * than 4 calls to the foo subroutine since it was expanded inline.
 *
 */

/** @page void The void keyword
 * \brief
 *
 * The void keyword allows you to define a function that returns no data.
 * Functions that do not return any value are sometimes referred to as
 * procedures or subroutines.  The sub keyword is an alias for void.  Both of
 * these keywords can only be used when declaring or defining a function.
 * Unlike C you cannot use void when declaring a variable type.
 *
 * In NQC the void keyword was used to declare inline functions that could
 * have arguments but could not return a value.  In NXC void functions are
 * not automatically inline as they were in NQC.  To make a function inline
 * you have to use the inline keyword prior to the function return type as
 * described in the \ref func section above.
 *
 * - @subpage sub
 *
 */

/** @page sub The sub keyword
 * \brief
 *
 * The sub keyword allows you to define a function that returns no data.
 * Functions that do not return any value are sometimes referred to as
 * procedures or subroutines.  The sub keyword is an alias for void.  Both of
 * these keywords can only be used when declaring or defining a function.
 *
 * In NQC you used this keyword to define a true subroutine which could have
 * no arguments and return no value.  For the sake of C compatibility it is
 * preferrable to use the void keyword if you want to define a function that
 * does not return a value.
 *
 */

/** @page vars Variables
 * \brief
 *
 * All variables in NXC are defined using one of the types listed below:
 *
 * - @subpage bool
 * - @subpage byte
 * - @subpage char
 * - @subpage int
 * - @subpage short
 * - @subpage long
 * - @subpage unsigned
 * - @subpage float
 * - @subpage mutex
 * - @subpage string
 * - \ref struct
 * - \ref arrays
 *
 * Variables are declared using the keyword(s) for the desired type, followed
 * by a comma-separated list of variable names and terminated by a semicolon
 * (';'). Optionally, an initial value for each variable may be specified
 * using an equals sign ('=') after the variable name. Several examples appear
 * below:
 * \code
 * int x;  	// declare x
 * bool y,z;	// declare y and z
 * long a=1,b;	// declare a and b, initialize a to 1
 * float f=1.15, g; // declare f and g, initialize f
 * int data[10]; // an array of 10 zeros in data
 * bool flags[] = {true, true, false, false};
 * string msg = "hello world";
 * \endcode
 * Global variables are declared at the program scope (outside of any code
 * block). Once declared, they may be used within all tasks, functions, and
 * subroutines. Their scope begins at declaration and ends at the end of the
 * program.
 * 
 * Local variables may be declared within tasks and functions. Such variables
 * are only accessible within the code block in which they are defined.
 * Specifically, their scope begins with their declaration and ends at the end
 * of their code block. In the case of local variables, a compound statement
 * (a group of statements bracketed by '{' and '}') is considered a block:
 * \code
 * int x;  // x is global
 * 
 * task main()
 * {
 * 	int y;  // y is local to task main
 * 	x = y; // ok
 * 	{	// begin compound statement
 * 		int z;  // local z declared
 * 		y = z; // ok
 * 	}
 * 	y = z; // error - z no longer in scope
 * }
 * 
 * task foo()
 * {
 * 	x = 1; // ok
 * 	y = 2; // error - y is not global
 * }
 * \endcode
 * 
 *
 */

/** @page bool bool
 * \brief
 *
 * In NXC the bool type is an unsigned 8-bit value. Normally you would only
 * store a zero or one in a variable of this type but it can store values from
 * zero to \ref UCHAR_MAX.
 * \code
 *  bool flag=true;
 * \endcode
 */

/** @page byte byte
 * \brief
 *
 * In NXC the byte type is an unsigned 8-bit value. This type can store values
 * from zero to \ref UCHAR_MAX. You can also define an unsigned 8-bit
 * variable using the \ref unsigned keyword followed by the \ref char type.
 * \code
 *  byte x=12;
 *  unsigned char b = 0xE2;
 * \endcode
 */

/** @page char char
 * \brief
 *
 * In NXC the char type is a signed 8-bit value. This type can store values
 * from \ref SCHAR_MIN to \ref SCHAR_MAX.  The char type is often used to store
 * the ASCII value of a single character.  Use \ref charconst page has more
 * details about this usage.
 * \code
 *  char ch=12;
 *  char test = 'A';
 * \endcode
 */

/** @page int int
 * \brief
 *
 * In NXC the int type is a signed 16-bit value. This type can store values
 * from \ref INT_MIN to \ref INT_MAX. To declare an unsigned 16-bit value
 * you have to use the \ref unsigned keyword followed by the int type.  The
 * range of values that can be stored in an unsigned int variable is from
 * zero to \ref UINT_MAX.
 * \code
 *  int x = 0xfff;
 *  int y = -23;
 *  unsigned int z = 62043;
 * \endcode
 */

/** @page short short
 * \brief
 *
 * In NXC the short type is a signed 16-bit value. This type can store values
 * from \ref SHRT_MIN to \ref SHRT_MAX.  This is an alias for the int type.
 * \code
 *  short x = 0xfff;
 *  short y = -23;
 * \endcode
 */

/** @page long long
 * \brief
 *
 * In NXC the long type is a signed 32-bit value. This type can store values
 * from \ref LONG_MIN to \ref LONG_MAX.  To declare an unsigned 32-bit value
 * you have to use the \ref unsigned keyword followed by the long type.  The
 * range of values that can be stored in an unsigned long variable is from
 * zero to \ref ULONG_MAX.
 * \code
 *  long x = 2147000000;
 *  long y = -88235;
 *  unsigned long b = 0xdeadbeef;
 * \endcode
 */

/** @page unsigned unsigned
 * \brief
 *
 * The unsigned keyword is used to modify the char, int, and long types in
 * order to define unsigned versions of these types.  The unsigned types can
 * store the full 8-, 16-, and 32-bits of data without requiring that one
 * of the bits be used to represent the sign of the value.  This doubles
 * the range of positive values that can be stored in each of these variable
 * types.
 * \code
 *  unsigned char uc = 0xff;
 *  unsigned int ui = 0xffff;
 *  unsigned long ul = 0xffffffff;
 * \endcode
 */

/** @page float float
 * \brief
 *
 * In NXC the float type is a 32-bit IEEE 754 single precision floating point
 * representation. This is a binary format that occupies 32 bits (4 bytes) and
 * its significand has a precision of 24 bits (about 7 decimal digits).
 *
 * Floating point arithmetic will be slower than integer operations but if you
 * need to easily store decimal values the float type is your best option.
 * The standard NXT firmware provides the sqrt function which benefits from
 * the ability to use the float type.  In the enhanced NBC/NXC firmware there
 * are many more native opcodes from the standard C math library which are
 * designed to work with floats.
 * \code
 *  float pi = 3.14159;
 *  float e = 2.71828;
 *  float s2 = 1.4142;
 * \endcode
 */

/** @page mutex mutex
 * \brief
 *
 * In NXC the mutex type is a 32-bit value that is used to synchronize access
 * to resources shared across multiple threads.  For this reason there is
 * never a reason to declare a mutex variable inside a task or a function.  It
 * is designed for global variables that all tasks or functions can
 * \ref Acquire or \ref Release in order to obtain exclusive access to a
 * resource that other tasks or functions are also trying to use.
 * \code
 *  mutex motorMutex;
 *  task t1()
 *  {
 *     while (true) {
 *       Acquire(motorMutex);
 *       // use the motor(s) protected by this mutex.
 *       Release(motorMutex);
 *       Wait(MS_500);
 *     }
 *  }
 *  task t2()
 *  {
 *     while (true) {
 *       Acquire(motorMutex);
 *       // use the motor(s) protected by this mutex.
 *       Release(motorMutex);
 *       Wait(MS_200);
 *     }
 *  }
 *  task main()
 *  {
 *    Precedes(t1, t2);
 *  }
 * \endcode
 */

/** @page string string
 * \brief
 *
 * In NXC the string type is provided for easily defining and manipulating
 * strings which consist of an array of byte with a 0 or null value at the
 * end of the array. You can write strings to the NXC mailboxes, to files,
 * and to the LCD, for example. You can initialize string variables using
 * constant strings.  See \ref strconst for additional details.
 * \code
 *  string msg = "Testing";
 *  string ff = "Fred Flintstone";
 * \endcode
 */

/** @page struct Structures
 * \brief
 *
 * NXC supports user-defined aggregate types known as structs. These are
 * declared very much like you declare structs in a C program.
 * \code
 * struct car
 * {
 *   string car_type;
 *   int manu_year;
 * };
 * 
 * struct person
 * {
 *   string name;
 *   int age;
 *   car vehicle;
 * };
 * 
 * person myPerson;
 * \endcode
 * After you have defined the structure type you can use the new type to
 * declare a variable or nested within another structure type declaration.
 * Members (or fields) within the struct are accessed using a dot notation.
 * \code
 *   myPerson.age = 40;
 *   anotherPerson = myPerson;
 *   fooBar.car_type = "honda";
 *   fooBar.manu_year = anotherPerson.age;
 * \endcode
 * You can assign structs of the same type but the compiler will complain if
 * the types do not match.
 * 
 */

/** @page arrays Arrays
 * \brief
 * 
 * NXC also support arrays. Arrays are declared the same way as ordinary
 * variables, but with an open and close bracket following the variable name.
 * \code
 * int my_array[];  // declare an array with 0 elements
 * \endcode
 * To declare arrays with more than one dimension simply add more pairs of
 * square brackets. The maximum number of dimensions supported in NXC is 4.
 * \code
 * bool my_array[][];  // declare a 2-dimensional array
 * \endcode
 * Arrays of up to two dimensions may be initialized at the point of
 * declaration using the following syntax:
 * \code
 * int X[] = {1, 2, 3, 4}, Y[]={10, 10}; // 2 arrays
 * int matrix[][] = {{1, 2, 3}, {4, 5, 6}};
 * string cars[] = {"honda", "ford", "chevy"};
 * \endcode
 * The elements of an array are identified by their position within the array
 * (called an index). The first element has an index of 0, the second has
 * index 1, and so on. For example:
 * \code
 * my_array[0] = 123; // set first element to 123
 * my_array[1] = my_array[2]; // copy third into second
 * \endcode
 * You may also initialize local arrays or arrays with multiple dimensions
 * using the ArrayInit function. The following example shows how to initialize
 * a two-dimensional array using ArrayInit. It also demonstrates some of the
 * supported array API functions and expressions.
 * \code
 * task main()
 * {
 *   int myArray[][];
 *   int myVector[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
 *   byte fooArray[][][];
 * 
 *   ArrayInit(myArray, myVector, 10); // 10 vectors
 *   ArrayInit(fooArray, myArray, 2); // 2 myArrays
 * 
 *   fooArray[1] = myArray;
 *   myArray[1][4] = 34;
 * 
 *   int ax[], ay[];
 *   ArrayBuild(ax, 5, 7);
 *   ArrayBuild(ay, 2, 10, 6, 43);
 *   int axlen = ArrayLen(ax);
 *   ArraySubset(ax, ay, 1, 2); // ax = {10, 6}
 *   if (ax == ay) {  
 *     // compare two arrays
 *     NumOut(0, LCD_LINE1, myArray[1][4]);
 *   }
 * }
 * \endcode
 * NXC also supports specifying an initial size for both global and local
 * arrays. The compiler automatically generates the required code to correctly
 * initialize the array to zeros. If an array declaration includes both a size
 * and a set of initial values the size is ignored in favor of the specified
 * values.
 * \code
 * task main()
 * {
 *   int myArray[10][10];
 *   int myVector[10];
 * 
 *   //ArrayInit(myVector, 0, 10); // 10 zeros in myVector
 *   //ArrayInit(myArray, myVector, 10); // 10 vectors myArray
 * }
 * \endcode
 * The calls to ArrayInit are not required since we specified the initial
 * sizes in the preceding array declarations, which means the arrays were
 * already initialized to all zeros. In fact, the myVector array declaration
 * is not needed unless we have a use for myVector other than initializing
 * myArray.
 * 
 */

/** @page vardecl Variable Declaration
 * \brief
 * 
 * Variable declaration, which has already been discussed, is one type of
 * statement. Its purpose is to declare a local variable (with optional
 * initialization) for use within the code block. The syntax for a variable
 * declaration is shown below.
 * \code
 * arg_type variables;
 * \endcode
 * Here arg_type must be one of the types supported by NXC. Following the type
 * are variable names, which must be a comma-separated list of identifiers with
 * optional initial values as shown in the code fragment below.
 * \code
 * name[=expression]
 * \endcode
 * Arrays of variables may also be declared:
 * \code
 * int array[n][=initializer];
 * \endcode
 * You can also define variables using user-defined aggregate structure types.
 * \code
 * struct TPerson {
 *   int age;
 *   string name;
 * };
 * TPerson bob; // cannot be initialized at declaration
 * \endcode
 * 
 */

/** @page asgn Assignment
 * \brief
 * 
 * Once declared, variables may be assigned the value of an expression using
 * the syntax shown in the code sample below.
 * \code
 * variable assign_operator expression;
 * \endcode
 * There are thirteen different assignment operators. The most basic operator, '=', 
 * simply assigns the value of the expression to the variable. The other
 * operators modify the variable's value in some other way as shown in the
 * table below.
 * <center><table>
 * <tr><th>Operator</th><th>Action</th></tr>
 * <tr><td>=</td><td>Set variable to expression</td></tr>
 * <tr><td>+=</td><td>Add expression to variable</td></tr>
 * <tr><td>-=</td><td>Subtract expression from variable</td></tr>
 * <tr><td>*=</td><td>Multiple variable by expression</td></tr>
 * <tr><td>/=</td><td>Divide variable by expression</td></tr>
 * <tr><td>\%=</td><td>Set variable to remainder after dividing by expression</td></tr>
 * <tr><td>&amp;=</td><td>Bitwise AND expression into variable</td></tr>
 * <tr><td>|=</td><td>Bitwise OR expression into variable</td></tr>
 * <tr><td>^=</td><td>Bitwise exclusive OR into variable</td></tr>
 * <tr><td>||=</td><td>Set variable to absolute value of expression</td></tr>
 * <tr><td>+-=</td><td>Set variable to sign (-1,+1,0) of expression</td></tr>
 * <tr><td>&gt;&gt;=</td><td>Right shift variable by expression</td></tr>
 * <tr><td>&lt;&lt;=</td><td>Left shift variable by expression</td></tr>
 * </table>
 * </center>
 * <center>Table 3. Operators</center>
 * The code sample below shows a few of the different types of operators that
 * you can use in NXC expressions.
 * \code
 * x = 2;	// set x to 2
 * y = 7;	// set y to 7
 * x += y;	// x is 9, y is still 7
 * \endcode
 * 
 */

/** @page ctrls Control Structures
 * \brief
 *
 * An NXC task or function usually contains a collection of nested control
 * structures. There are several types described below.
 *
 * - @subpage compound
 * - @subpage if
 * - @subpage else
 * - @subpage while
 * - @subpage do
 * - @subpage for
 * - @subpage repeat
 * - @subpage switch
 * - @subpage goto
 * - @subpage until
 *
 */

/** @page compound The compound statement
 * \brief
 *
 * The simplest control structure is a compound statement. This is a list of
 * statements enclosed within curly braces ('{' and '}'):
 * \code
 * {
 * 	x = 1;
 * 	y = 2;
 * }
 * \endcode
 * Although this may not seem very significant, it plays a crucial role in
 * building more complicated control structures. Many control structures expect
 * a single statement as their body. By using a compound statement, the same
 * control structure can be used to control multiple statements.
 *
 */

/** @page if The if statement
 * \brief
 *
 * The if statement evaluates a condition. If the condition is true, it
 * executes one statement (the consequence). The value of a condition is
 * considered to be false only when it evaluates to zero. If it evaluates
 * to any non-zero value, it is true. The syntax for an if statement is shown
 * below.
 * \code
 * if (condition) consequence
 * \endcode
 * The condition of an if-statement must be enclosed in parentheses, as shown
 * in the code sample below. The compound statement in the last example allows
 * two statements to execute as a consequence of the condition being true.
 * \code
 * if (x==1) y = 2;
 * if (x==1) { y = 1; z = 2; }
 * \endcode
 *
 */

/** @page else The if-else statement
 * \brief
 *
 * The if-else statement evaluates a condition. If the condition is true, it
 * executes one statement (the consequence). A second statement (the
 * alternative), preceded by the keyword else, is executed if the condition is
 * false. The value of a condition is considered to be false only when it
 * evaluates to zero. If it evaluates to any non-zero value, it is true. The
 * syntax for an if-else statement is shown below.
 * \code
 * if (condition) consequence else alternative
 * \endcode
 * The condition of an if-statement must be enclosed in parentheses, as shown
 * in the code sample below. The compound statement in the last example allows
 * two statements to execute as a consequence of the condition being true as
 * well as two which execute when the condition is false.
 * \code
 * if (x==1)
 *   y = 3;
 * else
 *   y = 4;
 * if (x==1) {
 *   y = 1;
 *   z = 2;
 * }
 * else {
 *   y = 3;
 *   z = 5;
 * }
 * \endcode
 *
 */

/** @page while The while statement
 * \brief
 *
 * The while statement is used to construct a conditional loop. The condition
 * is evaluated, and if true the body of the loop is executed, then the
 * condition is tested again. This process continues until the condition
 * becomes false (or a break statement is executed). The syntax for a while
 * loop appears in the code fragment below.
 * \code
 * while (condition) body
 * \endcode
 * Because the body of a while statement must be a single statement, it is very
 * common to use a compound statement as the body. The sample below illustrates
 * this usage pattern.
 * \code
 * while(x < 10)
 * {
 * 	x = x+1;
 * 	y = y*2;
 * }
 * \endcode
 *
 */

/** @page do The do statement
 * \brief
 *
 * A variant of the while loop is the do-while loop. The syntax for this
 * control structure is shown below.
 * \code
 * do body while (condition)
 * \endcode
 * The difference between a while loop and a do-while loop is that the do-while
 * loop always executes the body at least once, whereas the while loop may not
 * execute it at all.
 *
 * \code
 * do
 * {
 * 	x = x+1;
 * 	y = y*2;
 * } while(x < 10);
 * \endcode
 *
 */

/** @page for The for statement
 * \brief
 *
 * Another kind of loop is the for loop. This type of loop allows automatic
 * initialization and incrmementation of a counter variable. It uses the syntax
 * shown below.
 * \code
 * for(statement1 ; condition ; statement2) body
 * \endcode
 * A for loop always executes statement1, and then it repeatedly checks the
 * condition. While the condition remains true, it executes the body followed
 * by statement2. The for loop is equivalent to the code shown below.
 * \code
 * statement1;
 * while(condition)
 * {
 * 	body
 * 	statement2;
 * }
 * \endcode
 * Frequently, statement1 sets a loop counter variable to its starting value.
 * The condition is generally a relational statement that checks the counter
 * variable against a termination value, and statement2 increments or
 * decrements the counter value.
 *
 * Here is an example of how to use the for loop:
 *
 * \code
 * for (int i=0; i<8; i++)
 * {
 * 	 NumOut(0, LCD_LINE1-i*8, i);
 * }
 * \endcode
 *
 */

/** @page repeat The repeat statement
 * \brief
 *
 * The repeat statement executes a loop a specified number of times. This
 * control structure is not included in the set of Standard C looping
 * constructs. NXC inherits this statement from NQC. The syntax is shown below.
 * \code
 * repeat (expression) body
 * \endcode
 * The expression determines how many times the body will be executed. Note:
 * the expression following the repeat keyword is evaluated a single time and
 * then the body is repeated that number of times. This is different from both
 * the while and do-while loops which evaluate their condition each time
 * through the loop.
 *
 * Here is an example of how to use the repeat loop:
 *
 * \code
 * int i=0;
 * repeat (8)
 * {
 * 	 NumOut(0, LCD_LINE1-i*8, i++);
 * }
 * \endcode
 *
 */

/** @page switch The switch statement
 * \brief
 *
 * A switch statement executes one of several different code sections depending
 * on the value of an expression. One or more case labels precede each code
 * section. Each case must be a constant and unique within the switch statement.
 * The switch statement evaluates the expression, and then looks for a matching
 * case label. It will execute any statements following the matching case until
 * either a break statement or the end of the switch is reached. A single
 * default label may also be used - it will match any value not already
 * appearing in a case label. A switch statement uses the syntax shown below.
 * \code
 * switch (expression) body
 * \endcode
 * Additional information about the case and default labels and the break
 * statement can be found below.
 *
 * - @subpage case
 * - @subpage default
 * - \ref break
 *
 * A typical switch statement might look like this:
 * \code
 * switch(x)
 * {
 * 	case 1:
 * 		// do something when x is 1
 * 		break;
 * 	case 2:
 * 	case 3:
 * 		// do something else when x is 2 or 3
 * 		break;
 * 	default:
 * 		// do this when x is not 1, 2, or 3
 * 		break;
 * }
 * \endcode
 * NXC also supports using string types in the switch expression and constant
 * strings in case labels.
 *
 */

/** @page case The case label
 * \brief
 *
 * The case label in a switch statement is not a statement in itself. It is a
 * label that precedes a list of statements.  Multiple case labels can
 * precede the same statement. The case label has the syntax shown below.
 * \code
 * case constant_expression :
 * \endcode
 *
 * \ref switch page contains an example of how to use the case label.
 *
 */

/** @page default The default label
 * \brief
 *
 * The default label in a switch statement is not a statement in itself.  It is
 * a label that precedes a list of statements.  There can be only one default
 * label within a switch statement.  The default label has the syntax shown
 * below.
 * \code
 * default :
 * \endcode
 *
 * \ref switch page contains an example of how to use the default label.
 *
 */

/** @page goto The goto statement
 * \brief
 *
 * The goto statement forces a program to jump to the specified location.
 * Statements in a program can be labeled by preceding them with an identifier
 * and a colon. A goto statement then specifies the label that the program
 * should jump to. You can only branch to a label within the current function
 * or task, not from one function or task to another.
 *
 * Here is an example of an infinite loop that increments a variable:
 * \code
 * my_loop:
 * 	x++;
 * 	goto my_loop;
 * \endcode
 * The goto statement should be used sparingly and cautiously. In almost
 * every case, control structures such as if, while, and switch make a program
 * much more readable and maintainable than using goto.
 *
 */

/** @page until The until statement
 * \brief
 *
 * NXC also defines an until macro for compatibility with NQC. This construct
 * provides a convenient alternative to the while loop. The actual definition
 * of until is shown below.
 * \code
 * #define until(c)	while(!(c))
 * \endcode
 * In other words, until will continue looping until the condition becomes
 * true. It is most often used in conjunction with an empty body statement or
 * a body which simply yields to other tasks:
 * \code
 * until(EVENT_OCCURS);	// wait for some event to occur
 * \endcode
 * 
 */

/** @page asm The asm statement
 * \brief
 * 
 * The asm statement is used to define many of the NXC API calls. The syntax of 
 * the statement is shown below.
 * \code
 * asm { 
 *  one or more lines of NBC assembly language
 * }
 * \endcode
 * The statement simply emits the body of the statement as NeXT Byte Codes
 * (NBC) code and passes it directly to the NBC compiler's backend. The asm
 * statement can often be used to optimize code so that it executes as fast
 * as possible on the NXT firmware. The following example shows an asm block
 * containing variable declarations, labels, and basic NBC statements as well
 * as comments.
 * \code
 * asm { 
 * //      jmp __lbl00D5
 *       dseg segment
 *         sl0000 slong
 *         sl0005 slong
 *         bGTTrue byte
 *       dseg ends
 *       mov	sl0000, 0x0
 *       mov	sl0005, sl0000
 *       mov	sl0000, 0x1
 *       cmp	GT, bGTTrue, sl0005, sl0000
 *       set bGTTrue, FALSE
 *       brtst	EQ, __lbl00D5, bGTTrue
 *   __lbl00D5:
 * }
 * \endcode
 * A few NXC keywords have meaning only within an asm statement. These keywords
 * provide a means for returning string or scalar values from asm statements
 * and for using temporary variables of byte, word, long, and float types.
 * <center>
 * <table>
 * <tr><th>ASM Keyword</th><th>Meaning</th></tr>
 * <tr><td>__RETURN__, __RETURNS__</td><td>Used to return a signed value other
 * than __RETVAL__ or __STRRETVAL__</td></tr>
 * <tr><td>__RETURNU__</td><td>Used to return an unsigned value.</td></tr>
 * <tr><td>__RETURNF__</td><td>Used to return a floating point value.</td></tr>
 * <tr><td>__RETVAL__</td><td>Writing to this 4-byte signed value returns it to
 * the calling program</td></tr>
 * <tr><td>__GENRETVAL__</td><td>Writing to this generic value returns it to
 * the calling program</td></tr>
 * <tr><td>__URETVAL__</td><td>Writing to this 4-byte unsigned value returns
 * it to the calling program</td></tr>
 * <tr><td>__STRRETVAL__</td><td>Writing to this string value returns it to
 * the calling program</td></tr>
 * <tr><td>__FLTRETVAL__</td><td>Writing to this 4-byte floating point value
 * returns it to the calling program</td></tr>
 * <tr><td>__STRBUFFER__</td><td>This is primary string buffer which can be
 * used to store intermediate string values.</td></tr>
 * <tr><td>__STRTMPBUFFER__</td><td>This is a secondary string buffer.</td></tr>
 * <tr><td>__TMPBYTE__</td><td>Use this temporary variable to write and return
 * single byte signed values</td></tr>
 * <tr><td>__TMPWORD__</td><td>Use this temporary variable to write and return
 * 2-byte signed values</td></tr>
 * <tr><td>__TMPLONG__</td><td>Use this temporary variable to write and return
 * 4-byte signed values</td></tr>
 * <tr><td>__TMPULONG__</td><td>Use this temporary variable to write and return
 * 4-byte unsigned values</td></tr>
 * <tr><td>__TMPFLOAT__</td><td>Use this temporary variable to write and return
 * 4-byte floating point values</td></tr>
 * <tr><td>__I__</td><td>A local counter variable</td></tr>
 * <tr><td>__J__</td><td>A second local counter variable</td></tr>
 * <tr><td>__IncI__</td><td>Increment the local counter variable named I</td></tr>
 * <tr><td>__IncJ__</td><td>Increment the local counter variable named J</td></tr>
 * <tr><td>__DecI__</td><td>Decrement the local counter variable named I</td></tr>
 * <tr><td>__DecJ__</td><td>Deccrement the local counter variable named J</td></tr>
 * <tr><td>__ResetI__</td><td>Reset the local counter variable named I to zero</td></tr>
 * <tr><td>__ResetJ__</td><td>Reset the local counter variable named J to zero</td></tr>
 * <tr><td>__THREADNAME__</td><td>The current thread name</td></tr>
 * <tr><td>__LINE__</td><td>The current line number</td></tr>
 * <tr><td>__FILE__</td><td>The current file name</td></tr>
 * <tr><td>__VER__</td><td>The product version number</td></tr>
 * </table>
 * </center>
 * <center>Table 4. ASM Keywords</center>
 * The asm block statement and these special ASM keywords are used throughout
 * the NXC API. You can have a look at the NXCDefs.h header file for several
 * examples of how they are used. To keep the main NXC code as "C-like" as
 * possible and for the sake of better readability NXC asm block statements
 * can be wrapped in preprocessor macros and placed in custom header files
 * which are included using \#include. The following example demonstrates using
 * a macro wrapper around an asm block.
 * \code
 * #define SetMotorSpeed(port, cc, thresh, fast, slow) \
 *   asm { \
 *   set theSpeed, fast \
 *   brcmp cc, EndIfOut__I__, SV, thresh \
 *   set theSpeed, slow \
 * EndIfOut__I__: \
 *   OnFwd(port, theSpeed) \
 *   __IncI__ \
 * }
 * \endcode
 *
 */

/** @page otherst Other NXC Statements
 * \brief
 *
 * NXC supports a few other statement types.  The other NXC statements
 * are described below.
 *
 * - @subpage funccall
 * - @subpage start
 * - @subpage stop
 * - @subpage priority
 * - @subpage break
 * - @subpage continue
 * - @subpage return
 *
 * Many expressions are not legal statements. A notable exception are
 * expressions using increment (++) or decrement (--) operators.
 * \code
 * x++;
 * \endcode
 *
 * The empty statement (just a bare semicolon) is also a legal statement.
 *
 */

/** @page funccall The function call statement
 * \brief
 *
 * A function call can also be a statement of the following form:
 * \code
 * name(arguments);
 * \endcode
 * The arguments list is a comma-separated list of expressions. The number and
 * type of arguments supplied must match the definition of the function itself.
 * Optionally, the return value may be assigned to a variable.
 *
 *
 */

/** @page start The start statement
 * \brief
 *
 * You can start a task with the start statement. This statement can be used
 * with both the standard and enhanced NBC/NXC firmwares.  The resulting
 * operation is a native opcode in the enhanced firmware but it requires
 * special compiler-generated subroutines in order to work with the standard
 * firmware.
 * \code
 * start task_name;
 * \endcode
 *
 */

/** @page stop The stop statement
 * \brief
 *
 * You can stop a task with the stop statement. The stop statement is only
 * supported if you are running the enhanced NBC/NXC firmware on your NXT.
 * \code
 * stop task_name;
 * \endcode
 *
 */

/** @page priority The priority statement
 * \brief
 *
 * You can adjust the priority of a task using the priority statement. Setting
 * task priorities also requires the enhanced NBC/NXC firmware. A task's
 * priority is simply the number of operations it will try to execute before
 * yielding to another task. This usually is 20 operations.
 * \code
 * priority task_name, new_priority;
 * \endcode
 *
 */

/** @page break The break statement
 * \brief
 *
 * Within loops (such as a while loop) you can use the break statement to exit
 * the loop immediately.  It only exits out of the innermost loop
 * \code
 * break;
 * \endcode
 * The break statement is also a critical component of most switch statements.
 * It prevents code in subsequent code sections from being executed, which is
 * usually a programmer's intent, by immediately exiting the switch statement.
 * Missing break statements in a switch are a frequent source of hard-to-find
 * bugs.
 *
 * Here is an example of how to use the break statement:
 *
 * \code
 * while (x<100) {
 *   x = get_new_x();
 *   if (button_pressed())
 *     break;
 *   process(x);
 * }
 * \endcode
 *
 */

/** @page continue The continue statement
 * \brief
 *
 * Within loops you can use the continue statement to skip to the top of the
 * next iteration of the loop without executing any of the code in the loop
 * that follows the continue statement.
 * \code
 * continue;
 * \endcode
 *
 * Here is an example of how to use the continue statement:
 *
 * \code
 * while (x<100) {
 *   ch = get_char();
 *   if (ch != 's')
 *     continue;
 *   process(ch);
 * }
 * \endcode
 *
 */

/** @page return The return statement
 * \brief
 *
 * If you want a function to return a value or to return before it reaches the
 * end of its code, use a return statement. An expression may optionally follow
 * the return keyword and, when present, is the value returned by the function.
 * The type of the expression must be compatible with the return type of the
 * function.
 * \code
 * return [expression];
 * \endcode
 *
 */

/** @page condtn Conditions
 * \brief
 *
 * Comparing two expressions forms a condition. A condition may be negated
 * with the logical negation operator, or two conditions combined with the
 * logical AND and logical OR operators. Like most modern computer languages,
 * NXC supports something called "short-circuit" evaluation of conditions. This
 * means that if the entire value of the conditional can be logically
 * determined by only evaluating the left hand term of the condition, then the
 * right hand term will not be evaluated.
 *
 * The table below summarizes the different types of conditions.
 * <center>
 * <table>
 * <tr><th>Condition</th><th>Meaning</th></tr>
 * <tr><td>Expr</td><td>true if expr is not equal to 0</td></tr>
 * <tr><td>Expr1 == expr2</td><td>true if expr1 equals expr2</td></tr>
 * <tr><td>Expr1 != expr2</td><td>true if expr1 is not equal to expr2</td></tr>
 * <tr><td>Expr1 &lt; expr2</td><td>true if one expr1 is less than expr2</td></tr>
 * <tr><td>Expr1 &lt;= expr2</td><td>true if expr1 is less than or equal to
 * expr2</td></tr>
 * <tr><td>Expr1 &gt; expr2</td><td>true if expr1 is greater than expr2</td></tr>
 * <tr><td>Expr1 &gt;= expr2</td><td>true if expr1 is greater than or equal to
 * expr2</td></tr>
 * <tr><td>! condition</td><td>logical negation of a condition - true if
 * condition is false</td></tr>
 * <tr><td>Cond1 &amp;&amp; cond2</td><td>logical AND of two conditions (true
 * if and only if both conditions are true)</td></tr>
 * <tr><td>Cond1 || cond2</td><td>logical OR of two conditions (true if and
 * only if at least one of the conditions are true)</td></tr>
 * </table>
 * </center>
 * <center>Table 6. Conditions</center>
 * There are also two special constant conditions which can be used anywhere
 * that the above conditions are allowed.  They are listed below.
 *
 * - @subpage true
 * - @subpage false
 *
 * You can use conditions in NXC control structures, such as the if-statement
 * and the while or until statements, to specify exactly how you want your
 * program to behave.
 *
 */

/** @page true The true condition
 * \brief
 *
 * The keyword true has a value of one.  It represents a condition that is
 * always true.
 *
 */

/** @page false The false condition
 * \brief
 *
 * The keyword false has a value of zero.  It represents a condition that is
 * always false.
 *
 */

/** @page include #include
 * \brief
 *
 * The \#include command works as in Standard C, with the caveat that the
 * filename must be enclosed in double quotes. There is no notion of a system
 * include path, so enclosing a filename in angle brackets is forbidden.
 * \code
 * #include "foo.h"  // ok
 * #include <foo.h> // error!
 * \endcode
 * NXC programs can begin with \#include "NXCDefs.h" but they don't need to.
 * This standard header file includes many important constants and macros,
 * which form the core NXC API. NXC no longer require that you manually include
 * the NXCDefs.h header file. Unless you specifically tell the compiler to
 * ignore the standard system files, this header file is included automatically.
 * 
 */

/** @page define #define
 * \brief
 *
 * The \#define command is used for macro substitution. Redefinition of a
 * macro will result in a compiler warning. Macros are normally restricted to
 * one line because the newline character at the end of the line acts as a
 * terminator. However, you can write multiline macros by instructing the
 * preprocessor to ignore the newline character. This is accomplished by
 * escaping the newline character with a backslash ('\\'). The backslash
 * character must be the very last character in the line or it will not extend
 * the macro definition to the next line. The code sample below shows how to
 * write a multi-line preprocessor macro.
 * \code
 * #define foo(x)  do { bar(x); \\
 *                      baz(x); } while(false)
 * \endcode
 * The \#undef directive may be used to remove a macro's definition.
 *
 */

/** @page concat ## (Concatenation)
 * \brief
 *
 * The \#\# directive works similar to the C preprocessor. It is replaced by
 * nothing, which causes tokens on either side to be concatenated together.
 * Because it acts as a separator initially, it can be used within macro
 * functions to produce identifiers via combination with parameter values.
 * \code
 * #define ELEMENT_OUT(n) \
 *   NumOut(0, LCD_LINE##n, b##n)
 *
 * bool b1 = false;
 * bool b2 = true;
 *
 * task main()
 * {
 *    ELEMENT_OUT(1);
 *    ELEMENT_OUT(2);
 *    Wait(SEC_2);
 * }
 * \endcode
 * This is the same as writing
 * \code
 * bool b1 = false;
 * bool b2 = true;
 *
 * task main()
 * {
 *    NumOut(0, LCD_LINE1, b1);
 *    NumOut(0, LCD_LINE2, b2);
 *    Wait(SEC_2);
 * }
 * \endcode
 *
 */

/** @page condcomp Conditional Compilation
 * \brief
 *
 * Conditional compilation works similar to the C preprocessor's conditional
 * compilation. The following preprocessor directives may be used:
 * <center>
 * <table>
 * <tr><th>Directive</th><th>Meaning</th></tr>
 * <tr><td>\#ifdef symbol</td><td>If symbol is defined then compile the
 * following code</td></tr>
 * <tr><td>\#ifndef symbol</td><td>If symbol is not defined then compile the
 * following code</td></tr>
 * <tr><td>\#else</td><td>Switch from compiling to not compiling and vice
 * versa</td></tr>
 * <tr><td>\#endif</td><td>Return to previous compiling state</td></tr>
 * <tr><td>\#if condition</td><td>If the condition evaluates to true then
 * compile the following code</td></tr>
 * <tr><td>\#elif</td><td>Same as \#else but used with \#if</td></tr>
 * </table>
 * </center>
 * <center>Table 7. Conditional compilation directives</center>
 *
 * See the NXTDefs.h and NXCDefs.h header files for many examples of how to
 * use conditional compilation.
 *
 */

/** @page import #import
 * \brief
 *
 * The \#import directive lets you define a global byte array variable in your
 * NXC program that contains the contents of the imported file. Like \#include,
 * this directive is followed by a filename enclosed in double quote
 * characters. Following the filename you may optionally include a format
 * string for constructing the name of the variable you want to define using
 * this directive.
 * \code
 * #import "myfile.txt" data
 * \endcode
 * By default, the format string is %s which means that the name of the file
 * without any file extension will be the name of the variable. For instance,
 * if the format string "data" were not specified in the example above, then
 * the name of the byte array variable would be "myfile". In this case the
 * name of the byte array variable will be "data".
 *
 * The \#import directive is often used in conjunction with the
 * \ref GraphicArrayOut and \ref GraphicArrayOutEx API functions.
 *
 */

/** @page download #download
 * \brief
 *
 * The \#download directive works in conjunction with the compiler's built-in
 * download capability. It lets you tell the compiler to download a specified
 * auxiliary file in addition to the .rxe file produced from your source code.
 * If the file extension matches a type of source code that the compiler knows
 * how to compile (such as .rs or .nbc) then the compiler will first compile
 * the source before downloading the resulting binary. The name of the file
 * to download (and optionally compile) is enclosed in double quote characters
 * immediately following this directive. If the compiler is only told to
 * compile the original source code then the \#download directive is ignored.
 * \code
 * #download "myfile.rs"
 * #download "mypicture.ric"
 * \endcode
 * 
 */

/////////////////////////////////////////////////////////////////////////////
////////////////////////  NXT MODULE DOCS  //////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

/** @defgroup NXTFirmwareModules NXT Firmware Modules
 * Documentation common to all NXT firmware modules.
 */

/** @defgroup InputModule Input module
 * Constants and functions related to the Input module.
 *
 * The NXT input module encompasses all sensor inputs except for digital
 * I2C (LowSpeed) sensors.
 *
 * There are four sensors, which internally are numbered 0, 1, 2, and 3.
 * This is potentially confusing since they are externally labeled on the NXT
 * as sensors 1, 2, 3, and 4. To help mitigate this confusion, the sensor port
 * names \ref S1, \ref S2, \ref S3, and \ref S4 have been defined.  See
 * \ref InPorts. These sensor names may be used in any function that requires
 * a sensor port as an argument. Alternatively, the NBC port name constants
 * \ref IN_1, \ref IN_2, \ref IN_3, and \ref IN_4 may also be used when
 * a sensor port is required, although this is not recommended. See
 * \ref NBCInputPortConstants. Sensor value names \ref SENSOR_1, \ref SENSOR_2,
 * \ref SENSOR_3, and \ref SENSOR_4 have also been defined. These names may
 * also be used whenever a program wishes to read the current value of the
 * analog sensor:
 * \code
 * x = SENSOR_1; // read sensor and store value in x
 * \endcode
 */

/** @defgroup InputModuleConstants Input module constants
 * Constants that are part of the NXT firmware's Input module.
 */

/** @defgroup InputModuleTypesAndModes Sensor types and modes
 * Constants that are used for defining sensor types and modes.
 * 
 * The sensor ports on the NXT are capable of interfacing to a variety of
 * different sensors. It is up to the program to tell the NXT what kind of
 * sensor is attached to each port. Calling \ref SetSensorType configures a
 * sensor's type. There are 16 sensor types, each corresponding to a specific
 * type of LEGO RCX or NXT sensor. Two of these types are for NXT I2C digital
 * sensors, either 9V powered or unpowered, and a third is used to configure
 * port S4 as a high-speed RS-485 serial port. A seventeenth type
 * (\ref SENSOR_TYPE_CUSTOM) is for use with custom analog sensors. And an
 * eighteenth type (\ref SENSOR_TYPE_NONE) is used to indicate that no sensor
 * has been configured, effectively turning off the specified port.
 * 
 * In general, a program should configure the type to match the actual sensor.
 * If a sensor port is configured as the wrong type, the NXT may not be able
 * to read it accurately. Use either the \ref SensorTypes or the
 * \ref NBCSensorTypeConstants.
 * 
 * The NXT allows a sensor to be configured in different modes. The sensor
 * mode determines how a sensor's raw value is processed. Some modes only
 * make sense for certain types of sensors, for example
 * \ref SENSOR_MODE_ROTATION is useful only with rotation sensors. Call
 * \ref SetSensorMode to set the sensor mode. The possible modes are shown
 * below. Use either the \ref SensorModes or the \ref NBCSensorModeConstants.
 * 
 * When using the NXT, it is common to set both the type and mode at the same
 * time. The \ref SetSensor function makes this process a little easier by
 * providing a single function to call and a set of standard type/mode
 * combinations. Use the \ref SensorTypeModes.
 * 
 * The NXT provides a boolean conversion for all sensors - not just touch
 * sensors. This boolean conversion is normally based on preset thresholds
 * for the raw value. A "low" value (less than 460) is a boolean value of 1.
 * A high value (greater than 562) is a boolean value of 0. This conversion
 * can be modified: a slope value between 0 and 31 may be added to a sensor's
 * mode when calling SetSensorMode. If the sensor's value changes more than
 * the slope value during a certain time (3ms), then the sensor's boolean
 * state will change. This allows the boolean state to reflect rapid changes
 * in the raw value. A rapid increase will result in a boolean value of 0, a
 * rapid decrease is a boolean value of 1.
 * 
 * Even when a sensor is configured for some other mode (i.e.
 * \ref SENSOR_MODE_PERCENT), the boolean conversion will still be carried out.
 */

/** @defgroup OutputModule Output module
 * Constants and functions related to the Output module.
 * 
 * The NXT output module encompasses all the motor outputs.
 * 
 * Nearly all of the NXC API functions dealing with outputs take either a
 * single output or a set of outputs as their first argument. Depending on the
 * function call, the output or set of outputs may be a constant or a variable
 * containing an appropriate output port value. The constants \ref OUT_A,
 * \ref OUT_B, and \ref OUT_C are used to identify the three outputs. Unlike
 * NQC, adding individual outputs together does not combine multiple outputs.
 * Instead, the NXC API provides predefined combinations of outputs:
 * \ref OUT_AB, \ref OUT_AC, \ref OUT_BC, and \ref OUT_ABC. Manually combining
 * outputs involves creating an array and adding two or more of the three
 * individual output constants to the array.
 * 
 * Output power levels can range 0 (lowest) to 100 (highest). Negative power
 * levels reverse the direction of rotation (i.e., forward at a power level of
 * -100 actually means reverse at a power level of 100).
 * 
 * The outputs each have several fields that define the current state of the
 * output port. These fields are defined in the \ref OutputFieldConstants
 * section.
 */

/** @defgroup OutputModuleConstants Output module constants
 * Constants that are part of the NXT firmware's Output module.
 */

/** @defgroup CommandModule Command module
 * Constants and functions related to the Command module.
 * 
 * The NXT command module encompasses support for the execution of user
 * programs via the NXT virtual machine. It also implements the direct command
 * protocol support that enables the NXT to respond to USB or Bluetooth
 * requests from other devices such as a PC or another NXT brick.
 */

/** @defgroup CommandModuleConstants Command module constants
 * Constants that are part of the NXT firmware's Command module.
 */

/** @defgroup CommModule Comm module
 * Constants and functions related to the Comm module.
 * 
 * The NXT comm module encompasses support for all forms of Bluetooth, USB, and 
 * HiSpeed communication.
 * 
 * You can use the Bluetooth communication methods to send information to other 
 * devices connected to the NXT brick. The NXT firmware also implements a
 * message queuing or mailbox system which you can access using these methods.
 * 
 * Communication via Bluetooth uses a master/slave connection system. One
 * device must be designated as the master device before you run a program
 * using Bluetooth. If the NXT is the master device then you can configure up
 * to three slave devices using connection 1, 2, and 3 on the NXT brick. If
 * your NXT is a slave device then connection 0 on the brick must be reserved
 * for the master device.
 * 
 * Programs running on the master NXT brick can send packets of data to any
 * connected slave devices using the BluetoothWrite method. Slave devices write
 * response packets to the message queuing system where they wait for the
 * master device to poll for the response.
 * 
 * Using the direct command protocol, a master device can send messages to
 * slave NXT bricks in the form of text strings addressed to a particular
 * mailbox. Each mailbox on the slave NXT brick is a circular message queue
 * holding up to five messages. Each message can be up to 58 bytes long.
 * 
 * To send messages from a master NXT brick to a slave brick, use
 * \ref BluetoothWrite on the master brick to send a MessageWrite direct
 * command packet to the slave. Then, you can use \ref ReceiveMessage on the
 * slave brick to read the message. The slave NXT brick must be running a
 * program when an incoming message packet is received. Otherwise, the slave
 * NXT brick ignores the message and the message is dropped.
 */

/** @defgroup ButtonModule Button module
 * Constants and functions related to the Button module.
 * 
 * The NXT button module encompasses support for the 4 buttons on the NXT brick.
 */

/** @defgroup IOCtrlModule IOCtrl module
 * Constants and functions related to the IOCtrl module.
 * 
 * The NXT ioctrl module encompasses low-level communication between the two 
 * processors that control the NXT. The NXC API exposes two functions that 
 * are part of this module.
 */

/** @defgroup LoaderModule Loader module
 * Constants and functions related to the Loader module.
 * 
 * The NXT loader module encompasses support for the NXT file system. The NXT
 * supports creating files, opening existing files, reading, writing, renaming,
 * and deleting files.
 *
 * Files in the NXT file system must adhere to the 15.3 naming convention for
 * a maximum filename length of 19 characters. While multiple files can be
 * opened simultaneously, a maximum of 4 files can be open for writing at any
 * given time.
 * 
 * When accessing files on the NXT, errors can occur. The NXC API defines
 * several constants that define possible result codes. They are listed in the
 * \ref LoaderErrors section.
 */

/** @defgroup SoundModule Sound module
 * Constants and functions related to the Sound module.
 * 
 * The NXT sound module encompasses all sound output features. The NXT provides
 * support for playing basic tones as well as two different types of files.
 * 
 * Sound files (.rso) are like .wav files. They contain thousands of sound
 * samples that digitally represent an analog waveform. With sounds files the
 * NXT can speak or play music or make just about any sound imaginable.
 * 
 * Melody files are like MIDI files. They contain multiple tones with each
 * tone being defined by a frequency and duration pair. When played on the
 * NXT a melody file sounds like a pure sine-wave tone generator playing back
 * a series of notes. While not as fancy as sound files, melody files are
 * usually much smaller than sound files.
 * 
 * When a sound or a file is played on the NXT, execution of the program does
 * not wait for the previous playback to complete. To play multiple tones or
 * files sequentially it is necessary to wait for the previous tone or file
 * playback to complete first. This can be done via the Wait API function or
 * by using the sound state value within a while loop.
 * 
 * The NXC API defines frequency and duration constants which may be used in
 * calls to \ref PlayTone or \ref PlayToneEx. Frequency constants start with
 * \ref TONE_A3 (the 'A' pitch in octave 3) and go to \ref TONE_B7 (the 'B'
 * pitch in octave 7). Duration constants start with \ref MS_1 (1 millisecond)
 * and go up to \ref MIN_1 (60000 milliseconds) with several constants in
 * between. See NBCCommon.h for the complete list.
 */

/** @defgroup UiModule Ui module
 * Constants and functions related to the Ui module.
 *
 * The NXT UI module encompasses support for various aspects of the user
 * interface for the NXT brick.
 */

/** @defgroup LowSpeedModule Low Speed module
 * Constants and functions related to the Low Speed module.
 * 
 * The NXT low speed module encompasses support for digital I2C sensor
 * communication.
 * 
 * Use the lowspeed (aka I2C) communication methods to access devices that use
 * the I2C protocol on the NXT brick's four input ports.
 * 
 * You must set the input port's Type property to \ref SENSOR_TYPE_LOWSPEED or 
 * \ref SENSOR_TYPE_LOWSPEED_9V on a given port before using an I2C device on
 * that port. Use \ref SENSOR_TYPE_LOWSPEED_9V if your device requires 9V power
 * from the NXT brick. Remember that you also need to set the input port's
 * \ref InvalidDataField property to true after setting \ref TypeField to a
 * new value, and then wait in a loop for the NXT firmware to set
 * \ref InvalidDataField back to false. This process ensures that the
 * firmware has time to properly initialize the port, including the
 * 9V power lines, if applicable. Some digital devices might
 * need additional time to initialize after power up.
 * 
 * The \ref SetSensorLowspeed API function sets the specified port to
 * \ref SENSOR_TYPE_LOWSPEED_9V and calls \ref ResetSensor to perform the
 * \ref InvalidDataField reset loop described above.
 * 
 * When communicating with I2C devices, the NXT firmware uses a master/slave
 * setup in which the NXT brick is always the master device. This means that
 * the firmware is responsible for controlling the write and read operations.
 * The NXT firmware maintains write and read buffers for each port, and the
 * three main Lowspeed (I2C) methods described below enable you to access these
 * buffers.
 * 
 * A call to \ref LowspeedWrite starts an asynchronous transaction between the
 * NXT brick and a digital I2C device. The program continues to run while the
 * firmware manages sending bytes from the write buffer and reading the
 * response bytes from the device. Because the NXT is the master device, you
 * must also specify the number of bytes to expect from the device in response
 * to each write operation. You can exchange up to 16 bytes in each direction
 * per transaction.
 * 
 * After you start a write transaction with \ref LowspeedWrite, use
 * \ref LowspeedStatus in a loop to check the status of the port. If
 * \ref LowspeedStatus returns a status code of 0 and a count of bytes
 * available in the read buffer, the system is ready for you to use
 * \ref LowspeedRead to copy the data from the read buffer into the buffer
 * you provide.
 * 
 * Note that any of these calls might return various status codes at any time.
 * A status code of 0 means the port is idle and the last transaction (if any)
 * did not result in any errors. Negative status codes and the positive status
 * code 32 indicate errors. There are a few possible errors per call.
 * 
 * Valid low speed return values include \ref NO_ERR as well as the error codes 
 * listed in the \ref CommandCommErrors section.
 */

/** @defgroup DisplayModule Display module
 * Constants and functions related to the Display module.
 * 
 * The NXT display module encompasses support for drawing to the NXT LCD. The
 * NXT supports drawing points, lines, rectangles, and circles on the LCD. It
 * supports drawing graphic icon files on the screen as well as text and
 * numbers. With the enhanced NBC/NXC firmware you can also draw ellipses and
 * polygons as well as text and numbers using custom RIC-based font files.
 * Also, all of the drawing operations have several drawing options for
 * how the shapes are drawn to the LCD.
 * 
 * The LCD screen has its origin (0, 0) at the bottom left-hand corner of the
 * screen with the positive Y-axis extending upward and the positive X-axis
 * extending toward the right. The NXC API provides constants for use in the
 * \ref NumOut and \ref TextOut functions which make it possible to specify
 * LCD line numbers between 1 and 8 with line 1 being at the top of the screen
 * and line 8 being at the bottom of the screen. These constants
 * (\ref LCD_LINE1, \ref LCD_LINE2, \ref LCD_LINE3, \ref LCD_LINE4,
 * \ref LCD_LINE5, \ref LCD_LINE6, \ref LCD_LINE7, \ref LCD_LINE8) should be
 * used as the Y coordinate in NumOut and TextOut calls. Values of Y other than
 * these constants will be adjusted so that text and numbers are on one of 8
 * fixed line positions.
 */

/** @defgroup HiTechnicAPI HiTechnic API Functions
 * Functions for accessing and modifying HiTechnic devices.
 */

/** @defgroup DacModeConstants SuperPro analog output mode constants
 * Constants for controlling the 2 analog output modes.
 * 
 * Two analog outputs, which can span 0 to 3.3 volts, can be programmed to
 * output a steady voltage or can be programmed to output a selection of
 * waveforms over a range of frequencies.
 *
 * In the DC output mode, the DAC0/DAC1 voltage fields control the voltage on
 * the two analog outputs in increments of ~3.2mV from 0 - 1023 giving
 * 0 - 3.3v.
 *
 * In waveform modes, the channel outputs will center on 1.65 volts
 * when generating waveforms. The DAC0/DAC1 voltage fields control the signal
 * levels of the waveforms by adjusting the peak to peak signal levels from
 * 0 - 3.3v.
 *
 * In PWFM voltage mode, the channel outputs will create a
 * variable mark:space ratio square wave at 3.3v signal level. The average
 * output voltage is set by the O0/O1 voltage fields.
 */

/** @defgroup LEDCtrlConstants SuperPro LED control constants
 * Constants for controlling the 2 onboard LEDs.
 */

/** @defgroup DigitalPinConstants SuperPro digital pin constants
 * Constants for controlling the 8 digital pins.
 *
 * The eight digital inputs are returned as a byte representing the state
 * of the eight inputs. The eight digital outputs are controlled by two bytes,
 * the first of which sets the state of any of the signals which have been
 * defined as outputs and the second of which controls the input/output
 * state of each signal.
 */

/** @defgroup StrobeCtrlConstants SuperPro Strobe control constants
 * Constants for manipulating the six digital strobe outputs.
 *
 * Six digital strobe outputs are available. One is pre-configured as a
 * read strobe, another is pre-configured as a write strobe while the
 * other four can be set to a high or low logic level. These strobe lines
 * enable external devices to synchronize with the digital data port and
 * multiplex the eight digital input/output bits to wider bit widths.
 *
 * The RD and WR bits set the inactive state of the read and write strobe
 * outputs. Thus, if these bits are set to 0, the strobe outputs will pulse
 * high.
 */

/** @defgroup MindSensorsAPI MindSensors API Functions
 * Functions for accessing and modifying MindSensors devices.
 */

/** @defgroup CodatexAPI Codatex API Functions
 * Functions for accessing and modifying Codatex devices.
 */

/** @defgroup DexterIndustriesAPI Dexter Industries API Functions
 * Functions for accessing and modifying Dexter Industries devices.
 */

/** @defgroup MicroinfinityAPI Microinfinity API Functions
 * Functions for accessing and modifying Microinfinity devices.
 */

/** @defgroup RICMacros RIC Macro Wrappers
 * Macro wrappers for use in defining RIC byte arrays.
 */

/** @defgroup ModuleNameConstants NXT firmware module names
 * Constant string names for all the NXT firmware modules.
 */
 
/** @defgroup ModuleIDConstants NXT firmware module IDs
 * Constant numeric IDs for all the NXT firmware modules.
 */

/** @defgroup MiscConstants Miscellaneous NBC/NXC constants
 * Miscellaneous constants for use in NBC and NXC.
 */

/** @defgroup ThirdPartyDevices Third-party NXT devices
 * Documentation for NXT devices made by companies other than LEGO such
 * as HiTechnic, mindsensors.com, and CodaTex.
 */

/** @defgroup StandardCAPIFunctions Standard-C API functions
 * Documentation for various Standard-C library routines.
 */

/** @defgroup GraphicsLibrary A simple 3D graphics library
 * Documentation for a simple 3D graphics library.  The library code was
 * written by Arno van der Vegt.
 */

/////////////////////////////////////////////////////////////////////////////
////////////////////////////  EXAMPLES  /////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

/**
 * \example ex_SetSensorType.nxc
 * This is an example of how to use the \ref SetSensorType function.
 *
 * \example ex_SetSensorMode.nxc
 * This is an example of how to use the \ref SetSensorMode function.
 *
 * \example ex_ClearSensor.nxc
 * This is an example of how to use the \ref ClearSensor function.
 *
 * \example ex_ResetSensor.nxc
 * This is an example of how to use the \ref ResetSensor function.
 *
 * \example ex_SetSensor.nxc
 * This is an example of how to use the \ref SetSensor function.
 *
 * \example ex_SetSensorTouch.nxc
 * This is an example of how to use the \ref SetSensorTouch function.
 *
 * \example ex_SetSensorLight.nxc
 * This is an example of how to use the \ref SetSensorLight function.
 *
 * \example ex_SetSensorSound.nxc
 * This is an example of how to use the \ref SetSensorSound function.
 *
 * \example ex_SetSensorLowspeed.nxc
 * This is an example of how to use the \ref SetSensorLowspeed function.
 *
 * \example ex_setsensorcolorfull.nxc
 * This is an example of how to use the \ref SetSensorColorFull function.
 *
 * \example ex_setsensorcolorred.nxc
 * This is an example of how to use the \ref SetSensorColorRed function.
 *
 * \example ex_setsensorcolorgreen.nxc
 * This is an example of how to use the \ref SetSensorColorGreen function.
 *
 * \example ex_setsensorcolorblue.nxc
 * This is an example of how to use the \ref SetSensorColorBlue function.
 *
 * \example ex_setsensorcolornone.nxc
 * This is an example of how to use the \ref SetSensorColorNone function.
 *
 * \example ex_GetInput.nxc
 * This is an example of how to use the \ref GetInput function.
 *
 * \example ex_SetInput.nxc
 * This is an example of how to use the \ref SetInput function.
 *
 * \example ex_Sensor.nxc
 * This is an example of how to use the \ref Sensor function.
 *
 * \example ex_SensorBoolean.nxc
 * This is an example of how to use the \ref SensorBoolean function.
 *
 * \example ex_SensorDigiPinsDirection.nxc
 * This is an example of how to use the \ref SensorDigiPinsDirection function.
 *
 * \example ex_SensorDigiPinsOutputLevel.nxc
 * This is an example of how to use the \ref SensorDigiPinsOutputLevel function.
 *
 * \example ex_SensorDigiPinsStatus.nxc
 * This is an example of how to use the \ref SensorDigiPinsStatus function.
 *
 * \example ex_SensorInvalid.nxc
 * This is an example of how to use the \ref SensorInvalid function.
 *
 * \example ex_SensorMode.nxc
 * This is an example of how to use the \ref SensorMode function.
 *
 * \example ex_SensorNormalized.nxc
 * This is an example of how to use the \ref SensorNormalized function.
 *
 * \example ex_SensorRaw.nxc
 * This is an example of how to use the \ref SensorRaw function.
 *
 * \example ex_SensorScaled.nxc
 * This is an example of how to use the \ref SensorScaled function.
 *
 * \example ex_SensorType.nxc
 * This is an example of how to use the \ref SensorType function.
 *
 * \example ex_SensorValue.nxc
 * This is an example of how to use the \ref SensorValue function.
 *
 * \example ex_SensorValueBool.nxc
 * This is an example of how to use the \ref SensorValueBool function.
 *
 * \example ex_SensorValueRaw.nxc
 * This is an example of how to use the \ref SensorValueRaw function.
 *
 * \example ex_CustomSensorActiveStatus.nxc
 * This is an example of how to use the \ref CustomSensorActiveStatus function.
 *
 * \example ex_CustomSensorPercentFullScale.nxc
 * This is an example of how to use the \ref CustomSensorPercentFullScale function.
 *
 * \example ex_CustomSensorZeroOffset.nxc
 * This is an example of how to use the \ref CustomSensorZeroOffset function.
 *
 * \example ex_SetCustomSensorActiveStatus.nxc
 * This is an example of how to use the \ref SetCustomSensorActiveStatus function.
 *
 * \example ex_SetCustomSensorPercentFullScale.nxc
 * This is an example of how to use the \ref SetCustomSensorPercentFullScale function.
 *
 * \example ex_SetCustomSensorZeroOffset.nxc
 * This is an example of how to use the \ref SetCustomSensorZeroOffset function.
 *
 * \example ex_setsensorboolean.nxc
 * This is an example of how to use the \ref SetSensorBoolean function.
 *
 * \example ex_SetSensorDigiPinsDirection.nxc
 * This is an example of how to use the \ref SetSensorDigiPinsDirection function.
 *
 * \example ex_SetSensorDigiPinsOutputLevel.nxc
 * This is an example of how to use the \ref SetSensorDigiPinsOutputLevel function.
 *
 * \example ex_SetSensorDigiPinsStatus.nxc
 * This is an example of how to use the \ref SetSensorDigiPinsStatus function.
 *
 * \example ex_SysColorSensorRead.nxc
 * This is an example of how to use the \ref SysColorSensorRead function.
 *
 * \example ex_ReadSensorColorEx.nxc
 * This is an example of how to use the \ref ReadSensorColorEx function.
 *
 * \example ex_ReadSensorColorRaw.nxc
 * This is an example of how to use the \ref ReadSensorColorRaw function.
 *
 * \example ex_ColorADRaw.nxc
 * This is an example of how to use the \ref ColorADRaw function.
 *
 * \example ex_ColorBoolean.nxc
 * This is an example of how to use the \ref ColorBoolean function.
 *
 * \example ex_ColorCalibration.nxc
 * This is an example of how to use the \ref ColorCalibration function.
 *
 * \example ex_ColorCalibrationState.nxc
 * This is an example of how to use the \ref ColorCalibrationState function.
 *
 * \example ex_ColorCalLimits.nxc
 * This is an example of how to use the \ref ColorCalLimits function.
 *
 * \example ex_ColorSensorRaw.nxc
 * This is an example of how to use the \ref ColorSensorRaw function.
 *
 * \example ex_ColorSensorValue.nxc
 * This is an example of how to use the \ref ColorSensorValue function.
 *
 * \example ex_SetMotorPwnFreq.nxc
 * This is an example of how to use the SetMotorPwnFreq function.
 *
 * \example ex_onfwdsyncpid.nxc
 * This is an example of how to use the OnFwdSyncPID function.
 *
 * \example ex_onfwdsyncexpid.nxc
 * This is an example of how to use the OnFwdSyncExPID function.
 *
 * \example ex_onrevsyncpid.nxc
 * This is an example of how to use the OnRevSyncPID function.
 *
 * \example ex_onrevsyncexpid.nxc
 * This is an example of how to use the OnRevSyncExPID function.
 *
 * \example ex_onfwdregpid.nxc
 * This is an example of how to use the OnFwdRegPID function.
 *
 * \example ex_onfwdregexpid.nxc
 * This is an example of how to use the OnFwdRegExPID function.
 *
 * \example ex_onrevregpid.nxc
 * This is an example of how to use the OnRevRegPID function.
 *
 * \example ex_onrevregexpid.nxc
 * This is an example of how to use the OnRevRegExPID function.
 *
 * \example ex_off.nxc
 * This is an example of how to use the \ref Off function.
 *
 * \example ex_offex.nxc
 * This is an example of how to use the \ref OffEx function.
 *
 * \example ex_coast.nxc
 * This is an example of how to use the \ref Coast function.
 *
 * \example ex_coastex.nxc
 * This is an example of how to use the \ref CoastEx function.
 *
 * \example ex_float.nxc
 * This is an example of how to use the \ref Float function.
 *
 * \example ex_onfwd.nxc
 * This is an example of how to use the \ref OnFwd function.
 *
 * \example ex_onfwdex.nxc
 * This is an example of how to use the \ref OnFwdEx function.
 *
 * \example ex_onrev.nxc
 * This is an example of how to use the \ref OnRev function.
 *
 * \example ex_onrevex.nxc
 * This is an example of how to use the \ref OnRevEx function.
 *
 * \example ex_onfwdreg.nxc
 * This is an example of how to use the \ref OnFwdReg function.
 *
 * \example ex_onfwdregex.nxc
 * This is an example of how to use the \ref OnFwdRegEx function.
 *
 * \example ex_onrevreg.nxc
 * This is an example of how to use the \ref OnRevReg function.
 *
 * \example ex_onrevregex.nxc
 * This is an example of how to use the \ref OnRevRegEx function.
 *
 * \example ex_onfwdsync.nxc
 * This is an example of how to use the \ref OnFwdSync function.
 *
 * \example ex_onfwdsyncex.nxc
 * This is an example of how to use the \ref OnFwdSyncEx function.
 *
 * \example ex_onrevsync.nxc
 * This is an example of how to use the \ref OnRevSync function.
 *
 * \example ex_onrevsyncex.nxc
 * This is an example of how to use the \ref OnRevSyncEx function.
 *
 * \example ex_rotatemotor.nxc
 * This is an example of how to use the \ref RotateMotor function.
 *
 * \example ex_rotatemotorpid.nxc
 * This is an example of how to use the \ref RotateMotorPID function.
 *
 * \example ex_rotatemotorex.nxc
 * This is an example of how to use the \ref RotateMotorEx function.
 *
 * \example ex_rotatemotorexpid.nxc
 * This is an example of how to use the \ref RotateMotorExPID function.
 *
 * \example ex_resettachocount.nxc
 * This is an example of how to use the \ref ResetTachoCount function.
 *
 * \example ex_resetblocktachocount.nxc
 * This is an example of how to use the \ref ResetBlockTachoCount function.
 *
 * \example ex_resetrotationcount.nxc
 * This is an example of how to use the \ref ResetRotationCount function.
 *
 * \example ex_resetalltachocounts.nxc
 * This is an example of how to use the \ref ResetAllTachoCounts function.
 *
 * \example ex_setoutput.nxc
 * This is an example of how to use the \ref SetOutput function.
 *
 * \example ex_getoutput.nxc
 * This is an example of how to use the \ref GetOutput function.
 *
 * \example ex_motormode.nxc
 * This is an example of how to use the \ref MotorMode function.
 *
 * \example ex_motorpower.nxc
 * This is an example of how to use the \ref MotorPower function.
 *
 * \example ex_motoractualspeed.nxc
 * This is an example of how to use the \ref MotorActualSpeed function.
 *
 * \example ex_motortachocount.nxc
 * This is an example of how to use the \ref MotorTachoCount function.
 *
 * \example ex_motortacholimit.nxc
 * This is an example of how to use the \ref MotorTachoLimit function.
 *
 * \example ex_motorrunstate.nxc
 * This is an example of how to use the \ref MotorRunState function.
 *
 * \example ex_motorturnratio.nxc
 * This is an example of how to use the \ref MotorTurnRatio function.
 *
 * \example ex_motorregulation.nxc
 * This is an example of how to use the \ref MotorRegulation function.
 *
 * \example ex_motoroverload.nxc
 * This is an example of how to use the \ref MotorOverload function.
 *
 * \example ex_motorregpvalue.nxc
 * This is an example of how to use the \ref MotorRegPValue function.
 *
 * \example ex_motorregivalue.nxc
 * This is an example of how to use the \ref MotorRegIValue function.
 *
 * \example ex_motorregdvalue.nxc
 * This is an example of how to use the \ref MotorRegDValue function.
 *
 * \example ex_motorblocktachocount.nxc
 * This is an example of how to use the \ref MotorBlockTachoCount function.
 *
 * \example ex_motorrotationcount.nxc
 * This is an example of how to use the \ref MotorRotationCount function.
 *
 * \example ex_motoroutputoptions.nxc
 * This is an example of how to use the \ref MotorOutputOptions function.
 *
 * \example ex_motorpwnfreq.nxc
 * This is an example of how to use the \ref MotorPwnFreq function.
 *
 * \example ex_ResetScreen.nxc
 * This is an example of how to use the \ref ResetScreen function.
 *
 * \example ex_CircleOut.nxc
 * This is an example of how to use the \ref CircleOut, \ref Random, and
 * \ref Wait functions.
 *
 * \example ex_LineOut.nxc
 * This is an example of how to use the \ref LineOut function.
 *
 * \example ex_PointOut.nxc
 * This is an example of how to use the \ref PointOut function.
 *
 * \example ex_RectOut.nxc
 * This is an example of how to use the \ref RectOut function.
 *
 * \example ex_TextOut.nxc
 * This is an example of how to use the \ref TextOut function.
 *
 * \example ex_NumOut.nxc
 * This is an example of how to use the \ref NumOut function.
 *
 * \example ex_EllipseOut.nxc
 * This is an example of how to use the \ref EllipseOut and \ref Random functions.
 *
 * \example ex_PolyOut.nxc
 * This is an example of how to use the \ref PolyOut function.
 *
 * \example ex_dispftout.nxc
 * This is an example of how to use the \ref FontTextOut, \ref SysDrawFont,
 * \ref Wait, and \ref ClearScreen functions.
 *
 * \example ex_dispfnout.nxc
 * This is an example of how to use the \ref FontNumOut function.
 *
 * \example ex_GraphicOut.nxc
 * This is an example of how to use the \ref GraphicOut function.
 *
 * \example ex_dispgout.nxc
 * This is an example of how to use the \ref GraphicOut, \ref SysCall,
 * \ref TextOut, \ref CurrentTick, \ref NumOut, \ref Wait, and
 * \ref ClearScreen functions. It also demonstrates how to use the
 * \ref DrawGraphicArrayType structure.
 *
 * \example ex_dispgaout.nxc
 * This is an example of how to use the \ref GraphicArrayOut, \ref NumOut, and
 * \ref Wait function. It also demonstrates how to use the \ref RICOpSprite,
 * \ref RICSpriteData, \ref RICOpCopyBits, \ref RICImgRect, and
 * \ref RICImgPoint macros.
 *
 * \example ex_GraphicOutEx.nxc
 * This is an example of how to use the \ref GraphicOutEx function.
 *
 * \example ex_dispgoutex.nxc
 * This is an example of how to use the \ref GraphicOutEx and \ref Wait functions.
 *
 * \example ex_dispgaoutex.nxc
 * This is an example of how to use the \ref GraphicArrayOutEx and \ref Wait functions.
 * It also demonstrates how to use the \ref RICOpDescription, \ref RICOpSprite,
 * \ref RICSpriteData, \ref RICOpCopyBits, \ref RICImgRect, and
 * \ref RICImgPoint macros.
 *
 * \example ex_GetDisplayNormal.nxc
 * This is an example of how to use the \ref GetDisplayNormal function.
 *
 * \example ex_SetDisplayNormal.nxc
 * This is an example of how to use the \ref SetDisplayNormal function.
 *
 * \example ex_GetDisplayPopup.nxc
 * This is an example of how to use the \ref GetDisplayPopup function.
 *
 * \example ex_SetDisplayPopup.nxc
 * This is an example of how to use the \ref SetDisplayPopup function.
 *
 * \example ex_DisplayEraseMask.nxc
 * This is an example of how to use the \ref DisplayEraseMask function.
 *
 * \example ex_dispmisc.nxc
 * This is an example of how to use the \ref DisplayEraseMask, \ref DisplayUpdateMask, \ref DisplayDisplay,
 * \ref DisplayFlags, \ref DisplayTextLinesCenterFlags functions,
 * \ref SetDisplayEraseMask, \ref SetDisplayUpdateMask, \ref SetDisplayDisplay,
 * \ref SetDisplayFlags, and \ref SetDisplayTextLinesCenterFlags functions,
 *
 * \example ex_DisplayUpdateMask.nxc
 * This is an example of how to use the \ref DisplayUpdateMask function.
 *
 * \example ex_displayfont.nxc
 * This is an example of how to use the \ref DisplayFont function.
 *
 * \example ex_DisplayDisplay.nxc
 * This is an example of how to use the \ref DisplayDisplay function.
 *
 * \example ex_DisplayFlags.nxc
 * This is an example of how to use the \ref DisplayFlags function.
 *
 * \example ex_DisplayTextLinesCenterFlags.nxc
 * This is an example of how to use the \ref DisplayTextLinesCenterFlags function.
 *
 * \example ex_sysdrawtext.nxc
 * This is an example of how to use the \ref SysDrawText function along with the
 * \ref DrawTextType structure.
 *
 * \example ex_sysdrawpoint.nxc
 * This is an example of how to use the \ref SysDrawPoint function along with the
 * \ref DrawPointType structure.
 *
 * \example ex_sysdrawline.nxc
 * This is an example of how to use the \ref SysDrawLine function along with the
 * \ref DrawLineType structure.
 *
 * \example ex_sysdrawcircle.nxc
 * This is an example of how to use the \ref SysDrawCircle function along with
 * the \ref DrawCircleType structure.
 *
 * \example ex_sysdrawrect.nxc
 * This is an example of how to use the \ref SysDrawRect function along with the
 * \ref DrawRectType structure.
 *
 * \example ex_sysdrawgraphic.nxc
 * This is an example of how to use the \ref SysDrawGraphic function along with the
 * \ref DrawGraphicType structure.
 *
 * \example ex_syssetscreenmode.nxc
 * This is an example of how to use the \ref SysSetScreenMode function along with
 * the \ref SetScreenModeType structure.
 *
 * \example ex_sysdisplayexecutefunction.nxc
 * This is an example of how to use the \ref SysDisplayExecuteFunction function
 * along with the \ref DisplayExecuteFunctionType structure.
 *
 * \example ex_dispfunc.nxc
 * This is an example of how to use the \ref SysDisplayExecuteFunction and \ref Wait functions
 * along with the \ref DisplayExecuteFunctionType structure.
 *
 * \example ex_contrast.nxc
 * This is an example of how to use the \ref DisplayContrast and \ref SetDisplayContrast functions.
 *
 * \example ex_sysdrawgraphicarray.nxc
 * This is an example of how to use the \ref SysDrawGraphicArray function along with the \ref DrawGraphicArrayType structure.
 *
 * \example ex_sysdrawpolygon.nxc
 * This is an example of how to use the \ref SysDrawPolygon function along
 * with the \ref DrawPolygonType structure.
 *
 * \example ex_SysDrawEllipse.nxc
 * This is an example of how to use the \ref SysDrawEllipse function along
 * with the \ref DrawEllipseType structure.
 *
 * \example ex_sysdrawfont.nxc
 * This is an example of how to use the \ref SysDrawFont function along
 * with the \ref DrawFontType structure.
 *
 * \example ex_ClearScreen.nxc
 * This is an example of how to use the \ref ClearScreen and \ref Wait functions.
 *
 * \example ex_clearline.nxc
 * This is an example of how to use the \ref TextOut, \ref ClearLine, and
 * \ref Wait functions.
 *
 * \example ex_setdisplayfont.nxc
 * This is an example of how to use the \ref SetDisplayFont function.
 *
 * \example ex_SetDisplayDisplay.nxc
 * This is an example of how to use the \ref SetDisplayDisplay function.
 *
 * \example ex_SetDisplayEraseMask.nxc
 * This is an example of how to use the \ref SetDisplayEraseMask function.
 *
 * \example ex_SetDisplayFlags.nxc
 * This is an example of how to use the \ref SetDisplayFlags function.
 *
 * \example ex_SetDisplayTextLinesCenterFlags.nxc
 * This is an example of how to use the \ref SetDisplayTextLinesCenterFlags function.
 *
 * \example ex_SetDisplayUpdateMask.nxc
 * This is an example of how to use the \ref SetDisplayUpdateMask function.
 *
 * \example ex_setdisplaycontrast.nxc
 * This is an example of how to use the \ref SetDisplayContrast function.
 *
 * \example ex_PlayFile.nxc
 * This is an example of how to use the \ref PlayFile function.
 *
 * \example ex_PlayFileEx.nxc
 * This is an example of how to use the \ref PlayFileEx function.
 *
 * \example ex_PlayTone.nxc
 * This is an example of how to use the \ref PlayTone function.
 *
 * \example ex_PlayToneEx.nxc
 * This is an example of how to use the \ref PlayToneEx function.
 *
 * \example ex_SoundState.nxc
 * This is an example of how to use the \ref SoundState function.
 *
 * \example ex_SoundFlags.nxc
 * This is an example of how to use the \ref SoundFlags function.
 *
 * \example ex_StopSound.nxc
 * This is an example of how to use the \ref StopSound function.
 *
 * \example ex_SoundFrequency.nxc
 * This is an example of how to use the \ref SoundFrequency function.
 *
 * \example ex_SoundDuration.nxc
 * This is an example of how to use the \ref SoundDuration function.
 *
 * \example ex_SoundSampleRate.nxc
 * This is an example of how to use the \ref SoundSampleRate function.
 *
 * \example ex_SoundMode.nxc
 * This is an example of how to use the \ref SoundMode function.
 *
 * \example ex_SoundVolume.nxc
 * This is an example of how to use the \ref SoundVolume function.
 *
 * \example ex_SetSoundDuration.nxc
 * This is an example of how to use the \ref SetSoundDuration function.
 *
 * \example ex_SetSoundFlags.nxc
 * This is an example of how to use the \ref SetSoundFlags function.
 *
 * \example ex_SetSoundFrequency.nxc
 * This is an example of how to use the \ref SetSoundFrequency function.
 *
 * \example ex_SetSoundMode.nxc
 * This is an example of how to use the \ref SetSoundMode function.
 *
 * \example ex_SetSoundModuleState.nxc
 * This is an example of how to use the \ref SetSoundModuleState function.
 *
 * \example ex_SetSoundSampleRate.nxc
 * This is an example of how to use the \ref SetSoundSampleRate function.
 *
 * \example ex_SetSoundVolume.nxc
 * This is an example of how to use the \ref SetSoundVolume function.
 *
 * \example ex_syssoundplayfile.nxc
 * This is an example of how to use the \ref SysSoundPlayFile function along with
 * the \ref SoundPlayFileType structure.
 *
 * \example ex_syssoundplaytone.nxc
 * This is an example of how to use the \ref SysSoundPlayTone function along with
 * the \ref SoundPlayToneType structure.
 *
 * \example ex_syssoundgetstate.nxc
 * This is an example of how to use the \ref SysSoundGetState function along with
 * the \ref SoundGetStateType structure.
 *
 * \example ex_syssoundsetstate.nxc
 * This is an example of how to use the \ref SysSoundSetState function along with
 * the \ref SoundSetStateType structure.
 *
 * \example ex_playsound.nxc
 * This is an example of how to use the \ref PlaySound function.
 *
 * \example ex_playtones.nxc
 * This is an example of how to use the \ref PlayTones function along with
 * the \ref Tone structure.
 *
 * \example ex_SensorUS.nxc
 * This is an example of how to use the \ref SensorUS function.
 *
 * \example ex_ReadSensorUSEx.nxc
 * This is an example of how to use the \ref ReadSensorUSEx function.
 *
 * \example ex_readi2cregister.nxc
 * This is an example of how to use the \ref ReadI2CRegister function.
 *
 * \example ex_writei2cregister.nxc
 * This is an example of how to use the \ref WriteI2CRegister function.
 *
 * \example ex_LowspeedStatus.nxc
 * This is an example of how to use the \ref LowspeedStatus function.
 *
 * \example ex_LowspeedCheckStatus.nxc
 * This is an example of how to use the \ref LowspeedCheckStatus function.
 *
 * \example ex_LowspeedBytesReady.nxc
 * This is an example of how to use the \ref LowspeedBytesReady function.
 *
 * \example ex_LowspeedWrite.nxc
 * This is an example of how to use the \ref LowspeedWrite function.
 *
 * \example ex_LowspeedRead.nxc
 * This is an example of how to use the \ref LowspeedRead function.
 *
 * \example ex_I2CStatus.nxc
 * This is an example of how to use the \ref I2CStatus function.
 *
 * \example ex_I2CCheckStatus.nxc
 * This is an example of how to use the \ref I2CCheckStatus function.
 *
 * \example ex_I2CBytesReady.nxc
 * This is an example of how to use the \ref I2CBytesReady function.
 *
 * \example ex_I2CWrite.nxc
 * This is an example of how to use the \ref I2CWrite function.
 *
 * \example ex_I2CRead.nxc
 * This is an example of how to use the \ref I2CRead function.
 *
 * \example ex_I2CBytes.nxc
 * This is an example of how to use the \ref I2CBytes function.
 *
 * \example ex_i2cdeviceinfo.nxc
 * This is an example of how to use the \ref I2CDeviceInfo function.
 *
 * \example ex_i2cversion.nxc
 * This is an example of how to use the \ref I2CVersion function.
 *
 * \example ex_i2cvendorid.nxc
 * This is an example of how to use the \ref I2CVendorId function.
 *
 * \example ex_i2cdeviceid.nxc
 * This is an example of how to use the \ref I2CDeviceId function.
 *
 * \example ex_I2CSendCommand.nxc
 * This is an example of how to use the \ref I2CSendCommand function.
 *
 * \example ex_GetLSInputBuffer.nxc
 * This is an example of how to use the \ref GetLSInputBuffer function.
 *
 * \example ex_GetLSOutputBuffer.nxc
 * This is an example of how to use the \ref GetLSOutputBuffer function.
 *
 * \example ex_LSInputBufferInPtr.nxc
 * This is an example of how to use the \ref LSInputBufferInPtr function.
 *
 * \example ex_LSInputBufferOutPtr.nxc
 * This is an example of how to use the \ref LSInputBufferOutPtr function.
 *
 * \example ex_LSInputBufferBytesToRx.nxc
 * This is an example of how to use the \ref LSInputBufferBytesToRx function.
 *
 * \example ex_LSOutputBufferInPtr.nxc
 * This is an example of how to use the \ref LSOutputBufferInPtr function.
 *
 * \example ex_LSOutputBufferOutPtr.nxc
 * This is an example of how to use the \ref LSOutputBufferOutPtr function.
 *
 * \example ex_LSOutputBufferBytesToRx.nxc
 * This is an example of how to use the \ref LSOutputBufferBytesToRx function.
 *
 * \example ex_LSMode.nxc
 * This is an example of how to use the \ref LSMode function.
 *
 * \example ex_LSChannelState.nxc
 * This is an example of how to use the \ref LSChannelState function.
 *
 * \example ex_LSErrorType.nxc
 * This is an example of how to use the \ref LSErrorType function.
 *
 * \example ex_LSState.nxc
 * This is an example of how to use the \ref LSState function.
 *
 * \example ex_LSSpeed.nxc
 * This is an example of how to use the \ref LSSpeed function.
 *
 * \example ex_LSNoRestartOnRead.nxc
 * This is an example of how to use the \ref LSNoRestartOnRead function.
 *
 * \example ex_syscommlswrite.nxc
 * This is an example of how to use the \ref SysCommLSWrite function along with the
 * \ref CommLSWriteType structure.
 *
 * \example ex_syscommlsread.nxc
 * This is an example of how to use the \ref SysCommLSRead function along with the
 * \ref CommLSReadType structure.
 *
 * \example ex_syscommlscheckstatus.nxc
 * This is an example of how to use the \ref SysCommLSCheckStatus function along
 * with the \ref CommLSCheckStatusType structure.
 *
 * \example ex_syscommlswriteex.nxc
 * This is an example of how to use the \ref SysCommLSWriteEx function along with the
 * \ref CommLSWriteExType structure.
 *
 * \example ex_PowerDown.nxc
 * This is an example of how to use the \ref PowerDown functions.
 *
 * \example ex_SleepNow.nxc
 * This is an example of how to use the \ref SleepNow functions.
 *
 * \example ex_RebootInFirmwareMode.nxc
 * This is an example of how to use the \ref RebootInFirmwareMode functions.
 *
 * \example ex_CurrentTick.nxc
 * This is an example of how to use the \ref CurrentTick function.
 *
 * \example util_rpm.nxc
 * This is an example of how to use the \ref CurrentTick and \ref MotorRotationCount functions.
 *
 * \example ex_FirstTick.nxc
 * This is an example of how to use the \ref FirstTick function.
 *
 * \example ex_ResetSleepTimer.nxc
 * This is an example of how to use the \ref ResetSleepTimer function.
 *
 * \example ex_syscall.nxc
 * This is an example of how to use the \ref SysCall function.
 *
 * \example ex_sysgetstarttick.nxc
 * This is an example of how to use the \ref SysGetStartTick function along with
 * the \ref GetStartTickType structure.
 *
 * \example ex_syskeepalive.nxc
 * This is an example of how to use the \ref SysKeepAlive function along with the
 * \ref KeepAliveType structure.
 *
 * \example ex_sysiomapread.nxc
 * This is an example of how to use the \ref SysIOMapRead function along with the
 * \ref IOMapReadType structure.
 *
 * \example ex_sysiomapwrite.nxc
 * This is an example of how to use the \ref SysIOMapWrite function along with the
 * \ref IOMapWriteType structure.
 *
 * \example ex_sysiomapreadbyid.nxc
 * This is an example of how to use the \ref SysIOMapReadByID function along with
 * the \ref IOMapReadByIDType structure.
 *
 * \example ex_sysiomapwritebyid.nxc
 * This is an example of how to use the \ref SysIOMapWriteByID function along with
 * the \ref IOMapWriteByIDType structure.
 *
 * \example ex_SysDatalogWrite.nxc
 * This is an example of how to use the \ref SysDatalogWrite function along
 * with the \ref DatalogWriteType structure.
 *
 * \example ex_sysdataloggettimes.nxc
 * This is an example of how to use the \ref SysDatalogGetTimes function along
 * with the \ref DatalogGetTimesType structure.
 *
 * \example ex_SysReadSemData.nxc
 * This is an example of how to use the \ref SysReadSemData function along with
 * the \ref ReadSemDataType structure.
 *
 * \example ex_SysWriteSemData.nxc
 * This is an example of how to use the \ref SysWriteSemData function along
 * with the \ref WriteSemDataType structure.
 *
 * \example ex_SysUpdateCalibCacheInfo.nxc
 * This is an example of how to use the \ref SysUpdateCalibCacheInfo function
 * along with the \ref UpdateCalibCacheInfoType structure.
 *
 * \example ex_SysComputeCalibValue.nxc
 * This is an example of how to use the \ref SysComputeCalibValue function
 * along with the \ref ComputeCalibValueType structure.
 *
 * \example ex_wait.nxc
 * This is an example of how to use the \ref Wait function.
 *
 * \example ex_yield.nxc
 * This is an example of how to use the \ref Yield function.
 *
 * \example ex_StopAllTasks.nxc
 * This is an example of how to use the \ref StopAllTasks function.
 *
 * \example ex_Stop.nxc
 * This is an example of how to use the \ref Stop function.
 *
 * \example alternating_tasks.nxc
 * This is an example of how to use the \ref ExitTo function.
 *
 * \example ex_Precedes.nxc
 * This is an example of how to use the \ref Precedes statement.
 *
 * \example ex_Follows.nxc
 * This is an example of how to use the \ref Follows statement.
 *
 * \example ex_Acquire.nxc
 * This is an example of how to use the \ref Acquire function.
 *
 * \example ex_Release.nxc
 * This is an example of how to use the \ref Release function.
 *
 * \example ex_StartTask.nxc
 * This is an example of how to use the \ref StartTask function.
 *
 * \example ex_StopTask.nxc
 * This is an example of how to use the \ref StopTask function.
 *
 * \example ex_ArrayBuild.nxc
 * This is an example of how to use the \ref ArrayBuild function.
 *
 * \example ex_ArrayLen.nxc
 * This is an example of how to use the \ref ArrayLen function.
 *
 * \example ex_ArrayInit.nxc
 * This is an example of how to use the \ref ArrayInit function.
 *
 * \example ex_ArraySubset.nxc
 * This is an example of how to use the \ref ArraySubset function.
 *
 * \example ex_ArraySum.nxc
 * This is an example of how to use the \ref ArraySum function.
 *
 * \example ex_ArrayMean.nxc
 * This is an example of how to use the \ref ArrayMean function.
 *
 * \example ex_ArraySumSqr.nxc
 * This is an example of how to use the \ref ArraySumSqr function.
 *
 * \example ex_ArrayStd.nxc
 * This is an example of how to use the \ref ArrayStd function.
 *
 * \example ex_ArrayMin.nxc
 * This is an example of how to use the \ref ArrayMin function.
 *
 * \example ex_ArrayMax.nxc
 * This is an example of how to use the \ref ArrayMax function.
 *
 * \example ex_ArraySort.nxc
 * This is an example of how to use the \ref ArraySort function.
 *
 * \example ex_ArrayOp.nxc
 * This is an example of how to use the \ref ArrayOp function.
 *
 * \example ex_joystickmsg.nxc
 * This is an example of how to use the \ref JoystickMessageRead function
 * along with the \ref JoystickMessageType structure.
 *
 * \example ex_SendMessage.nxc
 * This is an example of how to use the \ref SendMessage function.
 *
 * \example ex_ReceiveMessage.nxc
 * This is an example of how to use the \ref ReceiveMessage function.
 *
 * \example ex_BluetoothStatus.nxc
 * This is an example of how to use the \ref BluetoothStatus function.
 *
 * \example ex_BluetoothWrite.nxc
 * This is an example of how to use the \ref BluetoothWrite function.
 *
 * \example ex_SendRemoteBool.nxc
 * This is an example of how to use the \ref SendRemoteBool function.
 *
 * \example ex_SendRemoteNumber.nxc
 * This is an example of how to use the \ref SendRemoteNumber function.
 *
 * \example ex_SendRemoteString.nxc
 * This is an example of how to use the \ref SendRemoteString function.
 *
 * \example ex_SendResponseBool.nxc
 * This is an example of how to use the \ref SendResponseBool function.
 *
 * \example ex_SendResponseNumber.nxc
 * This is an example of how to use the \ref SendResponseNumber function.
 *
 * \example ex_SendResponseString.nxc
 * This is an example of how to use the \ref SendResponseString function.
 *
 * \example ex_ReceiveRemoteBool.nxc
 * This is an example of how to use the \ref ReceiveRemoteBool function.
 *
 * \example ex_ReceiveRemoteMessageEx.nxc
 * This is an example of how to use the \ref ReceiveRemoteMessageEx function.
 *
 * \example ex_ReceiveRemoteNumber.nxc
 * This is an example of how to use the \ref ReceiveRemoteNumber function.
 *
 * \example ex_ReceiveRemoteString.nxc
 * This is an example of how to use the \ref ReceiveRemoteString function.
 *
 * \example ex_RemoteKeepAlive.nxc
 * This is an example of how to use the \ref RemoteKeepAlive function.
 *
 * \example ex_RemoteMessageRead.nxc
 * This is an example of how to use the \ref RemoteMessageRead function.
 *
 * \example ex_RemoteMessageWrite.nxc
 * This is an example of how to use the \ref RemoteMessageWrite function.
 *
 * \example ex_RemotePlaySoundFile.nxc
 * This is an example of how to use the \ref RemotePlaySoundFile function.
 *
 * \example ex_RemotePlayTone.nxc
 * This is an example of how to use the \ref RemotePlayTone function.
 *
 * \example ex_RemoteResetMotorPosition.nxc
 * This is an example of how to use the \ref RemoteResetMotorPosition function.
 *
 * \example ex_RemoteResetScaledValue.nxc
 * This is an example of how to use the \ref RemoteResetScaledValue function.
 *
 * \example ex_RemoteSetInputMode.nxc
 * This is an example of how to use the \ref RemoteSetInputMode function.
 *
 * \example ex_RemoteSetOutputState.nxc
 * This is an example of how to use the \ref RemoteSetOutputState function.
 *
 * \example ex_RemoteStartProgram.nxc
 * This is an example of how to use the \ref RemoteStartProgram function.
 *
 * \example ex_RemoteStopProgram.nxc
 * This is an example of how to use the \ref RemoteStopProgram function.
 *
 * \example ex_RemoteStopSound.nxc
 * This is an example of how to use the \ref RemoteStopSound function.
 *
 * \example ex_RS485Send.nxc
 * This is an example of how to use the \ref RS485Control,
 * \ref RS485Disable, \ref RS485Initialize,
 * \ref RS485Enable, \ref UseRS485, \ref RS485Uart, \ref RS485Status,
 * \ref RS485Write, \ref RS485SendingData, \ref SendRS485String,
 * \ref SendRS485Bool, \ref SendRS485Number, \ref TextOut, and \ref Wait
 * functions.
 *
 * \example ex_RS485Receive.nxc
 * This is an example of how to use the \ref RS485Control,
 * \ref RS485DataAvailable, \ref RS485Disable, \ref RS485Initialize,
 * \ref RS485Enable, \ref UseRS485, \ref RS485Uart, \ref RS485Status,
 * \ref RS485Read, \ref RS485ReadEx, \ref TextOut, and \ref Wait functions.
 *
 * \example ex_GetBTInputBuffer.nxc
 * This is an example of how to use the \ref GetBTInputBuffer function.
 *
 * \example ex_GetBTOutputBuffer.nxc
 * This is an example of how to use the \ref GetBTOutputBuffer function.
 *
 * \example ex_GetHSInputBuffer.nxc
 * This is an example of how to use the \ref GetHSInputBuffer function.
 *
 * \example ex_GetHSOutputBuffer.nxc
 * This is an example of how to use the \ref GetHSOutputBuffer function.
 *
 * \example ex_GetUSBInputBuffer.nxc
 * This is an example of how to use the \ref GetUSBInputBuffer function.
 *
 * \example ex_GetUSBOutputBuffer.nxc
 * This is an example of how to use the \ref GetUSBOutputBuffer function.
 *
 * \example ex_GetUSBPollBuffer.nxc
 * This is an example of how to use the \ref GetUSBPollBuffer function.
 *
 * \example ex_BTDeviceName.nxc
 * This is an example of how to use the \ref BTDeviceName function.
 *
 * \example ex_BTConnectionName.nxc
 * This is an example of how to use the \ref BTConnectionName function.
 *
 * \example ex_BTConnectionPinCode.nxc
 * This is an example of how to use the \ref BTConnectionPinCode function.
 *
 * \example ex_BrickDataName.nxc
 * This is an example of how to use the \ref BrickDataName function.
 *
 * \example ex_GetBTDeviceAddress.nxc
 * This is an example of how to use the \ref GetBTDeviceAddress function.
 *
 * \example ex_GetBTConnectionAddress.nxc
 * This is an example of how to use the \ref GetBTConnectionAddress function.
 *
 * \example ex_GetBrickDataAddress.nxc
 * This is an example of how to use the \ref GetBrickDataAddress function.
 *
 * \example ex_BTDeviceClass.nxc
 * This is an example of how to use the \ref BTDeviceClass function.
 *
 * \example ex_BTDeviceStatus.nxc
 * This is an example of how to use the \ref BTDeviceStatus function.
 *
 * \example ex_BTConnectionClass.nxc
 * This is an example of how to use the \ref BTConnectionClass function.
 *
 * \example ex_BTConnectionHandleNum.nxc
 * This is an example of how to use the \ref BTConnectionHandleNum function.
 *
 * \example ex_BTConnectionStreamStatus.nxc
 * This is an example of how to use the \ref BTConnectionStreamStatus function.
 *
 * \example ex_BTConnectionLinkQuality.nxc
 * This is an example of how to use the \ref BTConnectionLinkQuality function.
 *
 * \example ex_BrickDataBluecoreVersion.nxc
 * This is an example of how to use the \ref BrickDataBluecoreVersion function.
 *
 * \example ex_BrickDataBtStateStatus.nxc
 * This is an example of how to use the \ref BrickDataBtStateStatus function.
 *
 * \example ex_BrickDataBtHardwareStatus.nxc
 * This is an example of how to use the \ref BrickDataBtHardwareStatus function.
 *
 * \example ex_BrickDataTimeoutValue.nxc
 * This is an example of how to use the \ref BrickDataTimeoutValue function.
 *
 * \example ex_BTInputBufferInPtr.nxc
 * This is an example of how to use the \ref BTInputBufferInPtr function.
 *
 * \example ex_BTInputBufferOutPtr.nxc
 * This is an example of how to use the \ref BTInputBufferOutPtr function.
 *
 * \example ex_BTOutputBufferInPtr.nxc
 * This is an example of how to use the \ref BTOutputBufferInPtr function.
 *
 * \example ex_BTOutputBufferOutPtr.nxc
 * This is an example of how to use the \ref BTOutputBufferOutPtr function.
 *
 * \example ex_HSInputBufferInPtr.nxc
 * This is an example of how to use the \ref HSInputBufferInPtr function.
 *
 * \example ex_HSInputBufferOutPtr.nxc
 * This is an example of how to use the \ref HSInputBufferOutPtr function.
 *
 * \example ex_HSOutputBufferInPtr.nxc
 * This is an example of how to use the \ref HSOutputBufferInPtr function.
 *
 * \example ex_HSOutputBufferOutPtr.nxc
 * This is an example of how to use the \ref HSOutputBufferOutPtr function.
 *
 * \example ex_USBInputBufferInPtr.nxc
 * This is an example of how to use the \ref USBInputBufferInPtr function.
 *
 * \example ex_USBInputBufferOutPtr.nxc
 * This is an example of how to use the \ref USBInputBufferOutPtr function.
 *
 * \example ex_USBOutputBufferInPtr.nxc
 * This is an example of how to use the \ref USBOutputBufferInPtr function.
 *
 * \example ex_USBOutputBufferOutPtr.nxc
 * This is an example of how to use the \ref USBOutputBufferOutPtr function.
 *
 * \example ex_USBPollBufferInPtr.nxc
 * This is an example of how to use the \ref USBPollBufferInPtr function.
 *
 * \example ex_USBPollBufferOutPtr.nxc
 * This is an example of how to use the \ref USBPollBufferOutPtr function.
 *
 * \example ex_BTDeviceCount.nxc
 * This is an example of how to use the \ref BTDeviceCount function.
 *
 * \example ex_BTDeviceNameCount.nxc
 * This is an example of how to use the \ref BTDeviceNameCount function.
 *
 * \example ex_HSFlags.nxc
 * This is an example of how to use the \ref HSFlags function.
 *
 * \example ex_HSSpeed.nxc
 * This is an example of how to use the \ref HSSpeed function.
 *
 * \example ex_HSState.nxc
 * This is an example of how to use the \ref HSState function.
 *
 * \example ex_HSMode.nxc
 * This is an example of how to use the \ref HSMode function.
 *
 * \example ex_UsbState.nxc
 * This is an example of how to use the \ref USBState function.
 *
 * \example ex_SetBTInputBuffer.nxc
 * This is an example of how to use the \ref SetBTInputBuffer function.
 *
 * \example ex_SetBTInputBufferInPtr.nxc
 * This is an example of how to use the \ref SetBTInputBufferInPtr function.
 *
 * \example ex_SetBTInputBufferOutPtr.nxc
 * This is an example of how to use the \ref SetBTInputBufferOutPtr function.
 *
 * \example ex_SetBTOutputBuffer.nxc
 * This is an example of how to use the \ref SetBTOutputBuffer function.
 *
 * \example ex_SetBTOutputBufferInPtr.nxc
 * This is an example of how to use the \ref SetBTOutputBufferInPtr function.
 *
 * \example ex_SetBTOutputBufferOutPtr.nxc
 * This is an example of how to use the \ref SetBTOutputBufferOutPtr function.
 *
 * \example ex_SetHSInputBuffer.nxc
 * This is an example of how to use the \ref SetHSInputBuffer function.
 *
 * \example ex_SetHSInputBufferInPtr.nxc
 * This is an example of how to use the \ref SetHSInputBufferInPtr function.
 *
 * \example ex_SetHSInputBufferOutPtr.nxc
 * This is an example of how to use the \ref SetHSInputBufferOutPtr function.
 *
 * \example ex_SetHSOutputBuffer.nxc
 * This is an example of how to use the \ref SetHSOutputBuffer function.
 *
 * \example ex_SetHSOutputBufferInPtr.nxc
 * This is an example of how to use the \ref SetHSOutputBufferInPtr function.
 *
 * \example ex_SetHSOutputBufferOutPtr.nxc
 * This is an example of how to use the \ref SetHSOutputBufferOutPtr function.
 *
 * \example ex_SetUSBInputBuffer.nxc
 * This is an example of how to use the \ref SetUSBInputBuffer function.
 *
 * \example ex_SetUSBInputBufferInPtr.nxc
 * This is an example of how to use the \ref SetUSBInputBufferInPtr function.
 *
 * \example ex_SetUSBInputBufferOutPtr.nxc
 * This is an example of how to use the \ref SetUSBInputBufferOutPtr function.
 *
 * \example ex_SetUSBOutputBuffer.nxc
 * This is an example of how to use the \ref SetUSBOutputBuffer function.
 *
 * \example ex_SetUSBOutputBufferInPtr.nxc
 * This is an example of how to use the \ref SetUSBOutputBufferInPtr function.
 *
 * \example ex_SetUSBOutputBufferOutPtr.nxc
 * This is an example of how to use the \ref SetUSBOutputBufferOutPtr function.
 *
 * \example ex_SetUSBPollBuffer.nxc
 * This is an example of how to use the \ref SetUSBPollBuffer function.
 *
 * \example ex_SetUSBPollBufferInPtr.nxc
 * This is an example of how to use the \ref SetUSBPollBufferInPtr function.
 *
 * \example ex_SetUSBPollBufferOutPtr.nxc
 * This is an example of how to use the \ref SetUSBPollBufferOutPtr function.
 *
 * \example ex_SetHSFlags.nxc
 * This is an example of how to use the \ref SetHSFlags function.
 *
 * \example ex_SetHSSpeed.nxc
 * This is an example of how to use the \ref SetHSSpeed function.
 *
 * \example ex_SetHSState.nxc
 * This is an example of how to use the \ref SetHSState function.
 *
 * \example ex_sethsmode.nxc
 * This is an example of how to use the \ref SetHSMode function.
 *
 * \example ex_SetUsbState.nxc
 * This is an example of how to use the \ref SetUSBState function.
 *
 * \example ex_sysmessagewrite.nxc
 * This is an example of how to use the \ref SysMessageWrite function along with
 * the \ref MessageWriteType structure.
 *
 * \example ex_sysmessageread.nxc
 * This is an example of how to use the \ref SysMessageRead function along with the
 * \ref MessageReadType structure.
 *
 * \example ex_syscommbtwrite.nxc
 * This is an example of how to use the \ref SysCommBTWrite function along with the
 * \ref CommBTWriteType structure.
 *
 * \example ex_syscommbtcheckstatus.nxc
 * This is an example of how to use the \ref SysCommBTCheckStatus function along
 * with the \ref CommBTCheckStatusType structure.
 *
 * \example ex_syscommexecutefunction.nxc
 * This is an example of how to use the \ref SysCommExecuteFunction function along
 * with the \ref CommExecuteFunctionType structure.
 *
 * \example ex_SysCommHSControl.nxc
 * This is an example of how to use the \ref SysCommHSControl function along
 * with the \ref CommHSControlType structure.
 *
 * \example ex_SysCommHSCheckStatus.nxc
 * This is an example of how to use the \ref SysCommHSCheckStatus function along
 * with the \ref CommHSCheckStatusType structure.
 *
 * \example ex_SysCommHSRead.nxc
 * This is an example of how to use the \ref SysCommHSRead function along
 * with the \ref CommHSReadWriteType structure.
 *
 * \example ex_SysCommHSWrite.nxc
 * This is an example of how to use the \ref SysCommHSWrite function along
 * with the \ref CommHSReadWriteType structure.
 *
 * \example ex_SysCommBTOnOff.nxc
 * This is an example of how to use the \ref SysCommBTOnOff function along
 * with the \ref CommBTOnOffType structure.
 *
 * \example ex_syscommbtconnection.nxc
 * This is an example of how to use the \ref SysCommBTConnection function along
 * with the \ref CommBTConnectionType structure.
 *
 * \example ex_buttonpressed.nxc
 * This is an example of how to use the \ref ButtonPressed function.
 *
 * \example ex_ButtonCount.nxc
 * This is an example of how to use the \ref ButtonCount function.
 *
 * \example ex_ReadButtonEx.nxc
 * This is an example of how to use the \ref ReadButtonEx function.
 *
 * \example ex_ButtonPressCount.nxc
 * This is an example of how to use the \ref ButtonPressCount function.
 *
 * \example ex_ButtonLongPressCount.nxc
 * This is an example of how to use the \ref ButtonLongPressCount function.
 *
 * \example ex_ButtonShortReleaseCount.nxc
 * This is an example of how to use the \ref ButtonShortReleaseCount function.
 *
 * \example ex_ButtonLongReleaseCount.nxc
 * This is an example of how to use the \ref ButtonLongReleaseCount function.
 *
 * \example ex_ButtonReleaseCount.nxc
 * This is an example of how to use the \ref ButtonReleaseCount function.
 *
 * \example ex_ButtonState.nxc
 * This is an example of how to use the \ref ButtonState function.
 *
 * \example ex_SetButtonLongPressCount.nxc
 * This is an example of how to use the \ref SetButtonLongPressCount function.
 *
 * \example ex_SetButtonLongReleaseCount.nxc
 * This is an example of how to use the \ref SetButtonLongReleaseCount function.
 *
 * \example ex_SetButtonPressCount.nxc
 * This is an example of how to use the \ref SetButtonPressCount function.
 *
 * \example ex_SetButtonReleaseCount.nxc
 * This is an example of how to use the \ref SetButtonReleaseCount function.
 *
 * \example ex_SetButtonShortReleaseCount.nxc
 * This is an example of how to use the \ref SetButtonShortReleaseCount function.
 *
 * \example ex_SetButtonState.nxc
 * This is an example of how to use the \ref SetButtonState function.
 *
 * \example ex_sysreadbutton.nxc
 * This is an example of how to use the \ref SysReadButton function along with the
 * \ref ReadButtonType structure.
 *
 * \example ex_CommandFlags.nxc
 * This is an example of how to use the \ref CommandFlags function.
 *
 * \example ex_UIState.nxc
 * This is an example of how to use the \ref UIState function.
 *
 * \example ex_UIButton.nxc
 * This is an example of how to use the \ref UIButton function.
 *
 * \example ex_VMRunState.nxc
 * This is an example of how to use the \ref VMRunState function.
 *
 * \example ex_BatteryState.nxc
 * This is an example of how to use the \ref BatteryState function.
 *
 * \example ex_BluetoothState.nxc
 * This is an example of how to use the \ref BluetoothState function.
 *
 * \example ex_UiUsbState.nxc
 * This is an example of how to use the \ref UsbState function.
 *
 * \example ex_SleepTimeout.nxc
 * This is an example of how to use the \ref SleepTimeout function.
 *
 * \example ex_sleeptime.nxc
 * This is an example of how to use the \ref SleepTime function.
 *
 * \example ex_SleepTimer.nxc
 * This is an example of how to use the \ref SleepTimer function.
 *
 * \example ex_RechargeableBattery.nxc
 * This is an example of how to use the \ref RechargeableBattery function.
 *
 * \example ex_Volume.nxc
 * This is an example of how to use the \ref Volume function.
 *
 * \example ex_OnBrickProgramPointer.nxc
 * This is an example of how to use the \ref OnBrickProgramPointer function.
 *
 * \example ex_AbortFlag.nxc
 * This is an example of how to use the \ref AbortFlag function.
 *
 * \example ex_LongAbort.nxc
 * This is an example of how to use the \ref LongAbort function.
 *
 * \example util_battery_1.nxc
 * This is an example of how to use the \ref BatteryLevel function.
 *
 * \example util_battery_2.nxc
 * This is an example of how to use the \ref BatteryLevel function.
 *
 * \example ex_SetCommandFlags.nxc
 * This is an example of how to use the \ref SetCommandFlags function.
 *
 * \example ex_SetUIButton.nxc
 * This is an example of how to use the \ref SetUIButton function.
 *
 * \example ex_SetUIState.nxc
 * This is an example of how to use the \ref SetUIState function.
 *
 * \example ex_SetVMRunState.nxc
 * This is an example of how to use the \ref SetVMRunState function.
 *
 * \example ex_SetBatteryState.nxc
 * This is an example of how to use the \ref SetBatteryState function.
 *
 * \example ex_SetBluetoothState.nxc
 * This is an example of how to use the \ref SetBluetoothState function.
 *
 * \example ex_SetSleepTimeout.nxc
 * This is an example of how to use the \ref SetSleepTimeout function.
 *
 * \example ex_setsleeptime.nxc
 * This is an example of how to use the \ref SetSleepTime function.
 *
 * \example ex_SetSleepTimer.nxc
 * This is an example of how to use the \ref SetSleepTimer function.
 *
 * \example ex_SetVolume.nxc
 * This is an example of how to use the \ref SetVolume function.
 *
 * \example ex_SetOnBrickProgramPointer.nxc
 * This is an example of how to use the \ref SetOnBrickProgramPointer function.
 *
 * \example ex_ForceOff.nxc
 * This is an example of how to use the \ref ForceOff function.
 *
 * \example ex_SetAbortFlag.nxc
 * This is an example of how to use the \ref SetAbortFlag function.
 *
 * \example ex_SetLongAbort.nxc
 * This is an example of how to use the \ref SetLongAbort function.
 *
 * \example ex_SysSetSleepTimeout.nxc
 * This is an example of how to use the \ref SysSetSleepTimeout function.
 *
 * \example ex_FreeMemory.nxc
 * This is an example of how to use the \ref FreeMemory function.
 *
 * \example ex_CreateFile.nxc
 * This is an example of how to use the \ref CreateFile function.
 *
 * \example ex_OpenFileAppend.nxc
 * This is an example of how to use the \ref OpenFileAppend function.
 *
 * \example ex_OpenFileRead.nxc
 * This is an example of how to use the \ref OpenFileRead function.
 *
 * \example ex_CloseFile.nxc
 * This is an example of how to use the \ref CloseFile function.
 *
 * \example ex_ResolveHandle.nxc
 * This is an example of how to use the \ref ResolveHandle function.
 *
 * \example ex_RenameFile.nxc
 * This is an example of how to use the \ref RenameFile function.
 *
 * \example ex_DeleteFile.nxc
 * This is an example of how to use the \ref DeleteFile function.
 *
 * \example ex_resizefile.nxc
 * This is an example of how to use the \ref ResizeFile function.
 *
 * \example ex_CreateFileLinear.nxc
 * This is an example of how to use the \ref CreateFileLinear function.
 *
 * \example ex_CreateFileNonLinear.nxc
 * This is an example of how to use the \ref CreateFileNonLinear function.
 *
 * \example ex_OpenFileReadLinear.nxc
 * This is an example of how to use the \ref OpenFileReadLinear function.
 *
 * \example ex_findfirstfile.nxc
 * This is an example of how to use the \ref FindFirstFile function.
 *
 * \example ex_findnextfile.nxc
 * This is an example of how to use the \ref FindNextFile function.
 *
 * \example ex_Read.nxc
 * This is an example of how to use the \ref Read function.
 *
 * \example ex_ReadLn.nxc
 * This is an example of how to use the \ref ReadLn function.
 *
 * \example ex_ReadBytes.nxc
 * This is an example of how to use the \ref ReadBytes function.
 *
 * \example ex_Write.nxc
 * This is an example of how to use the \ref Write function.
 *
 * \example ex_WriteBytes.nxc
 * This is an example of how to use the \ref WriteBytes function.
 *
 * \example ex_WriteBytesEx.nxc
 * This is an example of how to use the \ref WriteBytesEx function.
 *
 * \example ex_WriteLn.nxc
 * This is an example of how to use the \ref WriteLn function.
 *
 * \example ex_WriteLnString.nxc
 * This is an example of how to use the \ref WriteLnString function.
 *
 * \example ex_WriteString.nxc
 * This is an example of how to use the \ref WriteString function.
 *
 * \example ex_sysfileopenread.nxc
 * This is an example of how to use the \ref SysFileOpenRead function along with
 * the \ref FileOpenType structure.
 *
 * \example ex_sysfileopenwrite.nxc
 * This is an example of how to use the \ref SysFileOpenWrite function along with
 * the \ref FileOpenType structure.
 *
 * \example ex_sysfileopenappend.nxc
 * This is an example of how to use the \ref SysFileOpenAppend function along with
 * the \ref FileOpenType structure.
 *
 * \example ex_sysfileread.nxc
 * This is an example of how to use the \ref SysFileRead function along with the
 * \ref FileReadWriteType structure.
 *
 * \example ex_sysfilewrite.nxc
 * This is an example of how to use the \ref SysFileWrite function along with the
 * \ref FileReadWriteType structure.
 *
 * \example ex_sysfileclose.nxc
 * This is an example of how to use the \ref SysFileClose function along with the
 * \ref FileCloseType structure.
 *
 * \example ex_sysfileresolvehandle.nxc
 * This is an example of how to use the \ref SysFileResolveHandle function along
 * with the \ref FileResolveHandleType structure.
 *
 * \example ex_sysfilerename.nxc
 * This is an example of how to use the \ref SysFileRename function along with the
 * \ref FileRenameType structure.
 *
 * \example ex_sysfiledelete.nxc
 * This is an example of how to use the \ref SysFileDelete function along with the
 * \ref FileDeleteType structure.
 *
 * \example ex_sysloaderexecutefunction.nxc
 * This is an example of how to use the \ref SysLoaderExecuteFunction function
 * along with the \ref LoaderExecuteFunctionType structure.
 *
 * \example ex_sysfilefindfirst.nxc
 * This is an example of how to use the \ref SysFileFindFirst function along with
 * the \ref FileFindType structure.
 *
 * \example ex_sysfilefindnext.nxc
 * This is an example of how to use the \ref SysFileFindNext function along with
 * the \ref FileFindType structure.
 *
 * \example ex_sysfileopenwritelinear.nxc
 * This is an example of how to use the \ref SysFileOpenWriteLinear function along
 * with the \ref FileOpenType structure.
 *
 * \example ex_sysfileopenwritenonlinear.nxc
 * This is an example of how to use the \ref SysFileOpenWriteNonLinear function
 * along with the \ref FileOpenType structure.
 *
 * \example ex_sysfileopenreadlinear.nxc
 * This is an example of how to use the \ref SysFileOpenReadLinear function along
 * with the \ref FileOpenType structure.
 *
 * \example ex_sysfileseek.nxc
 * This is an example of how to use the \ref SysFileSeek function along
 * with the \ref FileSeekType structure.
 *
 * \example ex_sysfileresize.nxc
 * This is an example of how to use the \ref SysFileResize function along
 * with the \ref FileResizeType structure.
 *
 * \example ex_syslistfiles.nxc
 * This is an example of how to use the \ref SysListFiles function along
 * with the \ref ListFilesType structure.
 *
 * \example ex_SensorHTGyro.nxc
 * This is an example of how to use the \ref SensorHTGyro function.
 *
 * \example ex_SensorHTEOPD.nxc
 * This is an example of how to use the \ref SensorHTEOPD function.
 *
 * \example ex_setsensorhteopd.nxc
 * This is an example of how to use the \ref SetSensorHTEOPD function.
 *
 * \example ex_SetSensorHTGyro.nxc
 * This is an example of how to use the \ref SetSensorHTGyro function.
 *
 * \example ex_SensorHTColorNum.nxc
 * This is an example of how to use the \ref SensorHTColorNum function.
 *
 * \example ex_SensorHTCompass.nxc
 * This is an example of how to use the \ref SensorHTCompass function.
 *
 * \example ex_SensorHTIRSeekerDir.nxc
 * This is an example of how to use the \ref SensorHTIRSeekerDir function.
 *
 * \example ex_SensorHTIRSeeker2Addr.nxc
 * This is an example of how to use the \ref SensorHTIRSeeker2Addr function.
 *
 * \example ex_SensorHTIRSeeker2DCDir.nxc
 * This is an example of how to use the \ref SensorHTIRSeeker2DCDir function.
 *
 * \example ex_SensorHTIRSeeker2ACDir.nxc
 * This is an example of how to use the \ref SensorHTIRSeeker2ACDir function.
 *
 * \example ex_sethtcolor2mode.nxc
 * This is an example of how to use the \ref SetHTColor2Mode function.
 *
 * \example ex_sethtirseeker2mode.nxc
 * This is an example of how to use the \ref SetHTIRSeeker2Mode function.
 *
 * \example ex_ReadSensorHTAccel.nxc
 * This is an example of how to use the \ref ReadSensorHTAccel function.
 *
 * \example ex_ReadSensorHTBarometric.nxc
 * This is an example of how to use the \ref ReadSensorHTBarometric function.
 *
 * \example ex_ReadSensorHTColor.nxc
 * This is an example of how to use the \ref ReadSensorHTColor function.
 *
 * \example ex_ReadSensorHTIRSeeker.nxc
 * This is an example of how to use the \ref ReadSensorHTIRSeeker function.
 *
 * \example ex_ReadSensorHTNormalizedColor.nxc
 * This is an example of how to use the \ref ReadSensorHTNormalizedColor function.
 *
 * \example ex_ReadSensorHTRawColor.nxc
 * This is an example of how to use the \ref ReadSensorHTRawColor function.
 *
 * \example ex_ReadSensorHTColor2Active.nxc
 * This is an example of how to use the \ref ReadSensorHTColor2Active function.
 *
 * \example ex_ReadSensorHTNormalizedColor2Active.nxc
 * This is an example of how to use the \ref ReadSensorHTNormalizedColor2Active function.
 *
 * \example ex_ReadSensorHTRawColor2.nxc
 * This is an example of how to use the \ref ReadSensorHTRawColor2 function.
 *
 * \example ex_ReadSensorHTIRReceiver.nxc
 * This is an example of how to use the \ref ReadSensorHTIRReceiver function.
 *
 * \example ex_ReadSensorHTIRReceiverEx.nxc
 * This is an example of how to use the \ref ReadSensorHTIRReceiverEx function.
 *
 * \example ex_ReadSensorHTIRSeeker2AC.nxc
 * This is an example of how to use the \ref ReadSensorHTIRSeeker2AC function.
 *
 * \example ex_ReadSensorHTIRSeeker2DC.nxc
 * This is an example of how to use the \ref ReadSensorHTIRSeeker2DC function.
 *
 * \example ex_ReadSensorHTTouchMultiplexer.nxc
 * This is an example of how to use the \ref ReadSensorHTTouchMultiplexer function.
 *
 * \example ex_ReadSensorHTAngle.nxc
 * This is an example of how to use the \ref ReadSensorHTAngle function.
 *
 * \example ex_ResetSensorHTAngle.nxc
 * This is an example of how to use the \ref ResetSensorHTAngle function.
 *
 * \example ex_HTIRTrain.nxc
 * This is an example of how to use the \ref HTIRTrain function.
 *
 * \example ex_HTPFComboDirect.nxc
 * This is an example of how to use the \ref HTPFComboDirect function.
 *
 * \example ex_HTPFComboPWM.nxc
 * This is an example of how to use the \ref HTPFComboPWM function.
 *
 * \example ex_HTPFRawOutput.nxc
 * This is an example of how to use the \ref HTPFRawOutput function.
 *
 * \example ex_HTPFRepeat.nxc
 * This is an example of how to use the \ref HTPFRepeat function.
 *
 * \example ex_HTPFSingleOutputCST.nxc
 * This is an example of how to use the \ref HTPFSingleOutputCST function.
 *
 * \example ex_HTPFSingleOutputPWM.nxc
 * This is an example of how to use the \ref HTPFSingleOutputPWM function.
 *
 * \example ex_HTPFSinglePin.nxc
 * This is an example of how to use the \ref HTPFSinglePin function.
 *
 * \example ex_HTPFTrain.nxc
 * This is an example of how to use the \ref HTPFTrain function.
 *
 * \example ex_HTRCXSetIRLinkPort.nxc
 * This is an example of how to use the \ref HTRCXSetIRLinkPort function.
 *
 * \example ex_HTRCXBatteryLevel.nxc
 * This is an example of how to use the \ref HTRCXBatteryLevel function.
 *
 * \example ex_HTRCXPoll.nxc
 * This is an example of how to use the \ref HTRCXPoll function.
 *
 * \example ex_HTRCXPollMemory.nxc
 * This is an example of how to use the \ref HTRCXPollMemory function.
 *
 * \example ex_HTRCXAddToDatalog.nxc
 * This is an example of how to use the \ref HTRCXAddToDatalog function.
 *
 * \example ex_HTRCXClearAllEvents.nxc
 * This is an example of how to use the \ref HTRCXClearAllEvents function.
 *
 * \example ex_HTRCXClearCounter.nxc
 * This is an example of how to use the \ref HTRCXClearCounter function.
 *
 * \example ex_HTRCXClearMsg.nxc
 * This is an example of how to use the \ref HTRCXClearMsg function.
 *
 * \example ex_HTRCXClearSensor.nxc
 * This is an example of how to use the \ref HTRCXClearSensor function.
 *
 * \example ex_HTRCXClearSound.nxc
 * This is an example of how to use the \ref HTRCXClearSound function.
 *
 * \example ex_HTRCXClearTimer.nxc
 * This is an example of how to use the \ref HTRCXClearTimer function.
 *
 * \example ex_HTRCXCreateDatalog.nxc
 * This is an example of how to use the \ref HTRCXCreateDatalog function.
 *
 * \example ex_HTRCXDecCounter.nxc
 * This is an example of how to use the \ref HTRCXDecCounter function.
 *
 * \example ex_HTRCXDeleteSub.nxc
 * This is an example of how to use the \ref HTRCXDeleteSub function.
 *
 * \example ex_HTRCXDeleteSubs.nxc
 * This is an example of how to use the \ref HTRCXDeleteSubs function.
 *
 * \example ex_HTRCXDeleteTask.nxc
 * This is an example of how to use the \ref HTRCXDeleteTask function.
 *
 * \example ex_HTRCXDeleteTasks.nxc
 * This is an example of how to use the \ref HTRCXDeleteTasks function.
 *
 * \example ex_HTRCXDisableOutput.nxc
 * This is an example of how to use the \ref HTRCXDisableOutput function.
 *
 * \example ex_HTRCXEnableOutput.nxc
 * This is an example of how to use the \ref HTRCXEnableOutput function.
 *
 * \example ex_HTRCXEvent.nxc
 * This is an example of how to use the \ref HTRCXEvent function.
 *
 * \example ex_HTRCXFloat.nxc
 * This is an example of how to use the \ref HTRCXFloat function.
 *
 * \example ex_HTRCXFwd.nxc
 * This is an example of how to use the \ref HTRCXFwd function.
 *
 * \example ex_HTRCXIncCounter.nxc
 * This is an example of how to use the \ref HTRCXIncCounter function.
 *
 * \example ex_HTRCXInvertOutput.nxc
 * This is an example of how to use the \ref HTRCXInvertOutput function.
 *
 * \example ex_HTRCXMuteSound.nxc
 * This is an example of how to use the \ref HTRCXMuteSound function.
 *
 * \example ex_HTRCXObvertOutput.nxc
 * This is an example of how to use the \ref HTRCXObvertOutput function.
 *
 * \example ex_HTRCXOff.nxc
 * This is an example of how to use the \ref HTRCXOff function.
 *
 * \example ex_HTRCXOn.nxc
 * This is an example of how to use the \ref HTRCXOn function.
 *
 * \example ex_HTRCXOnFor.nxc
 * This is an example of how to use the \ref HTRCXOnFor function.
 *
 * \example ex_HTRCXOnFwd.nxc
 * This is an example of how to use the \ref HTRCXOnFwd function.
 *
 * \example ex_HTRCXOnRev.nxc
 * This is an example of how to use the \ref HTRCXOnRev function.
 *
 * \example ex_HTRCXPBTurnOff.nxc
 * This is an example of how to use the \ref HTRCXPBTurnOff function.
 *
 * \example ex_HTRCXPing.nxc
 * This is an example of how to use the \ref HTRCXPing function.
 *
 * \example ex_HTRCXPlaySound.nxc
 * This is an example of how to use the \ref HTRCXPlaySound function.
 *
 * \example ex_HTRCXPlayTone.nxc
 * This is an example of how to use the \ref HTRCXPlayTone function.
 *
 * \example ex_HTRCXPlayToneVar.nxc
 * This is an example of how to use the \ref HTRCXPlayToneVar function.
 *
 * \example ex_HTRCXRemote.nxc
 * This is an example of how to use the \ref HTRCXRemote function.
 *
 * \example ex_HTRCXRev.nxc
 * This is an example of how to use the \ref HTRCXRev function.
 *
 * \example ex_HTRCXSelectDisplay.nxc
 * This is an example of how to use the \ref HTRCXSelectDisplay function.
 *
 * \example ex_HTRCXSelectProgram.nxc
 * This is an example of how to use the \ref HTRCXSelectProgram function.
 *
 * \example ex_HTRCXSendSerial.nxc
 * This is an example of how to use the \ref HTRCXSendSerial function.
 *
 * \example ex_HTRCXSetDirection.nxc
 * This is an example of how to use the \ref HTRCXSetDirection function.
 *
 * \example ex_HTRCXSetEvent.nxc
 * This is an example of how to use the \ref HTRCXSetEvent function.
 *
 * \example ex_HTRCXSetGlobalDirection.nxc
 * This is an example of how to use the \ref HTRCXSetGlobalDirection function.
 *
 * \example ex_HTRCXSetGlobalOutput.nxc
 * This is an example of how to use the \ref HTRCXSetGlobalOutput function.
 *
 * \example ex_HTRCXSetMaxPower.nxc
 * This is an example of how to use the \ref HTRCXSetMaxPower function.
 *
 * \example ex_HTRCXSetMessage.nxc
 * This is an example of how to use the \ref HTRCXSetMessage function.
 *
 * \example ex_HTRCXSetOutput.nxc
 * This is an example of how to use the \ref HTRCXSetOutput function.
 *
 * \example ex_HTRCXSetPower.nxc
 * This is an example of how to use the \ref HTRCXSetPower function.
 *
 * \example ex_HTRCXSetPriority.nxc
 * This is an example of how to use the \ref HTRCXSetPriority function.
 *
 * \example ex_HTRCXSetSensorMode.nxc
 * This is an example of how to use the \ref HTRCXSetSensorMode function.
 *
 * \example ex_HTRCXSetSensorType.nxc
 * This is an example of how to use the \ref HTRCXSetSensorType function.
 *
 * \example ex_HTRCXSetSleepTime.nxc
 * This is an example of how to use the \ref HTRCXSetSleepTime function.
 *
 * \example ex_HTRCXSetTxPower.nxc
 * This is an example of how to use the \ref HTRCXSetTxPower function.
 *
 * \example ex_HTRCXSetWatch.nxc
 * This is an example of how to use the \ref HTRCXSetWatch function.
 *
 * \example ex_HTRCXStartTask.nxc
 * This is an example of how to use the \ref HTRCXStartTask function.
 *
 * \example ex_HTRCXStopAllTasks.nxc
 * This is an example of how to use the \ref HTRCXStopAllTasks function.
 *
 * \example ex_HTRCXStopTask.nxc
 * This is an example of how to use the \ref HTRCXStopTask function.
 *
 * \example ex_HTRCXToggle.nxc
 * This is an example of how to use the \ref HTRCXToggle function.
 *
 * \example ex_HTRCXUnmuteSound.nxc
 * This is an example of how to use the \ref HTRCXUnmuteSound function.
 *
 * \example ex_HTScoutCalibrateSensor.nxc
 * This is an example of how to use the \ref HTScoutCalibrateSensor function.
 *
 * \example ex_HTScoutMuteSound.nxc
 * This is an example of how to use the \ref HTScoutMuteSound function.
 *
 * \example ex_HTScoutSelectSounds.nxc
 * This is an example of how to use the \ref HTScoutSelectSounds function.
 *
 * \example ex_HTScoutSendVLL.nxc
 * This is an example of how to use the \ref HTScoutSendVLL function.
 *
 * \example ex_HTScoutSetEventFeedback.nxc
 * This is an example of how to use the \ref HTScoutSetEventFeedback function.
 *
 * \example ex_HTScoutSetLight.nxc
 * This is an example of how to use the \ref HTScoutSetLight function.
 *
 * \example ex_HTScoutSetScoutMode.nxc
 * This is an example of how to use the \ref HTScoutSetScoutMode function.
 *
 * \example ex_HTScoutSetSensorClickTime.nxc
 * This is an example of how to use the \ref HTScoutSetSensorClickTime function.
 *
 * \example ex_HTScoutSetSensorHysteresis.nxc
 * This is an example of how to use the \ref HTScoutSetSensorHysteresis function.
 *
 * \example ex_HTScoutSetSensorLowerLimit.nxc
 * This is an example of how to use the \ref HTScoutSetSensorLowerLimit function.
 *
 * \example ex_HTScoutSetSensorUpperLimit.nxc
 * This is an example of how to use the \ref HTScoutSetSensorUpperLimit function.
 *
 * \example ex_HTScoutUnmuteSound.nxc
 * This is an example of how to use the \ref HTScoutUnmuteSound function.
 *
 * \example ex_setsensormspressure.nxc
 * This is an example of how to use the \ref SetSensorMSPressure function.
 *
 * \example ex_setsensormsdrod.nxc
 * This is an example of how to use the \ref SetSensorMSDROD function.
 *
 * \example ex_SensorMSPressure.nxc
 * This is an example of how to use the \ref SensorMSPressure function.
 *
 * \example ex_SensorMSCompass.nxc
 * This is an example of how to use the \ref SensorMSCompass function.
 *
 * \example ex_SensorMSDROD.nxc
 * This is an example of how to use the \ref SensorMSDROD function.
 *
 * \example ex_SensorMSPressureRaw.nxc
 * This is an example of how to use the \ref SensorMSPressureRaw function.
 *
 * \example ex_ReadSensorMSAccel.nxc
 * This is an example of how to use the \ref ReadSensorMSAccel function.
 *
 * \example ex_ReadSensorMSPlayStation.nxc
 * This is an example of how to use the \ref ReadSensorMSPlayStation function.
 *
 * \example ex_ReadSensorMSTilt.nxc
 * This is an example of how to use the \ref ReadSensorMSTilt function.
 *
 * \example ex_ReadSensorMSRTClock.nxc
 * This is an example of how to use the \ref ReadSensorMSRTClock function.
 *
 * \example ex_MSReadValue.nxc
 * This is an example of how to use the \ref MSReadValue function.
 *
 * \example ex_MSEnergize.nxc
 * This is an example of how to use the \ref MSEnergize function.
 *
 * \example ex_MSDeenergize.nxc
 * This is an example of how to use the \ref MSDeenergize function.
 *
 * \example ex_MSADPAOn.nxc
 * This is an example of how to use the \ref MSADPAOn function.
 *
 * \example ex_MSADPAOff.nxc
 * This is an example of how to use the \ref MSADPAOff function.
 *
 * \example ex_DISTNxGP2D12.nxc
 * This is an example of how to use the \ref DISTNxGP2D12 function.
 *
 * \example ex_DISTNxGP2D120.nxc
 * This is an example of how to use the \ref DISTNxGP2D120 function.
 *
 * \example ex_DISTNxGP2YA02.nxc
 * This is an example of how to use the \ref DISTNxGP2YA02 function.
 *
 * \example ex_DISTNxGP2YA21.nxc
 * This is an example of how to use the \ref DISTNxGP2YA21 function.
 *
 * \example ex_DISTNxDistance.nxc
 * This is an example of how to use the \ref DISTNxDistance function.
 *
 * \example ex_DISTNxMaxDistance.nxc
 * This is an example of how to use the \ref DISTNxMaxDistance function.
 *
 * \example ex_DISTNxMinDistance.nxc
 * This is an example of how to use the \ref DISTNxMinDistance function.
 *
 * \example ex_DISTNxModuleType.nxc
 * This is an example of how to use the \ref DISTNxModuleType function.
 *
 * \example ex_DISTNxNumPoints.nxc
 * This is an example of how to use the \ref DISTNxNumPoints function.
 *
 * \example ex_DISTNxVoltage.nxc
 * This is an example of how to use the \ref DISTNxVoltage function.
 *
 * \example ex_ACCLNxCalibrateX.nxc
 * This is an example of how to use the \ref ACCLNxCalibrateX function.
 *
 * \example ex_ACCLNxCalibrateXEnd.nxc
 * This is an example of how to use the \ref ACCLNxCalibrateXEnd function.
 *
 * \example ex_ACCLNxCalibrateY.nxc
 * This is an example of how to use the \ref ACCLNxCalibrateY function.
 *
 * \example ex_ACCLNxCalibrateYEnd.nxc
 * This is an example of how to use the \ref ACCLNxCalibrateYEnd function.
 *
 * \example ex_ACCLNxCalibrateZ.nxc
 * This is an example of how to use the \ref ACCLNxCalibrateZ function.
 *
 * \example ex_ACCLNxCalibrateZEnd.nxc
 * This is an example of how to use the \ref ACCLNxCalibrateZEnd function.
 *
 * \example ex_ACCLNxResetCalibration.nxc
 * This is an example of how to use the \ref ACCLNxResetCalibration function.
 *
 * \example ex_SetACCLNxSensitivity.nxc
 * This is an example of how to use the \ref SetACCLNxSensitivity function.
 *
 * \example ex_ACCLNxSensitivity.nxc
 * This is an example of how to use the \ref ACCLNxSensitivity function.
 *
 * \example ex_ACCLNxXOffset.nxc
 * This is an example of how to use the \ref ACCLNxXOffset function.
 *
 * \example ex_ACCLNxXRange.nxc
 * This is an example of how to use the \ref ACCLNxXRange function.
 *
 * \example ex_ACCLNxYOffset.nxc
 * This is an example of how to use the \ref ACCLNxYOffset function.
 *
 * \example ex_ACCLNxYRange.nxc
 * This is an example of how to use the \ref ACCLNxYRange function.
 *
 * \example ex_ACCLNxZOffset.nxc
 * This is an example of how to use the \ref ACCLNxZOffset function.
 *
 * \example ex_ACCLNxZRange.nxc
 * This is an example of how to use the \ref ACCLNxZRange function.
 *
 * \example ex_PSPNxDigital.nxc
 * This is an example of how to use the \ref PSPNxDigital function.
 *
 * \example ex_PSPNxAnalog.nxc
 * This is an example of how to use the \ref PSPNxAnalog function.
 *
 * \example ex_NRLink2400.nxc
 * This is an example of how to use the \ref NRLink2400 function.
 *
 * \example ex_NRLink4800.nxc
 * This is an example of how to use the \ref NRLink4800 function.
 *
 * \example ex_NRLinkFlush.nxc
 * This is an example of how to use the \ref NRLinkFlush function.
 *
 * \example ex_NRLinkIRLong.nxc
 * This is an example of how to use the \ref NRLinkIRLong function.
 *
 * \example ex_NRLinkIRShort.nxc
 * This is an example of how to use the \ref NRLinkIRShort function.
 *
 * \example ex_NRLinkSetPF.nxc
 * This is an example of how to use the \ref NRLinkSetPF function.
 *
 * \example ex_NRLinkSetRCX.nxc
 * This is an example of how to use the \ref NRLinkSetRCX function.
 *
 * \example ex_NRLinkSetTrain.nxc
 * This is an example of how to use the \ref NRLinkSetTrain function.
 *
 * \example ex_NRLinkTxRaw.nxc
 * This is an example of how to use the \ref NRLinkTxRaw function.
 *
 * \example ex_NRLinkStatus.nxc
 * This is an example of how to use the \ref NRLinkStatus function.
 *
 * \example ex_RunNRLinkMacro.nxc
 * This is an example of how to use the \ref RunNRLinkMacro function.
 *
 * \example ex_writenrlinkbytes.nxc
 * This is an example of how to use the \ref WriteNRLinkBytes function.
 *
 * \example ex_ReadNRLinkBytes.nxc
 * This is an example of how to use the \ref ReadNRLinkBytes function.
 *
 * \example ex_MSIRTrain.nxc
 * This is an example of how to use the \ref MSIRTrain function.
 *
 * \example ex_MSPFComboDirect.nxc
 * This is an example of how to use the \ref MSPFComboDirect function.
 *
 * \example ex_MSPFComboPWM.nxc
 * This is an example of how to use the \ref MSPFComboPWM function.
 *
 * \example ex_MSPFRawOutput.nxc
 * This is an example of how to use the \ref MSPFRawOutput function.
 *
 * \example ex_MSPFRepeat.nxc
 * This is an example of how to use the \ref MSPFRepeat function.
 *
 * \example ex_MSPFSingleOutputCST.nxc
 * This is an example of how to use the \ref MSPFSingleOutputCST function.
 *
 * \example ex_MSPFSingleOutputPWM.nxc
 * This is an example of how to use the \ref MSPFSingleOutputPWM function.
 *
 * \example ex_MSPFSinglePin.nxc
 * This is an example of how to use the \ref MSPFSinglePin function.
 *
 * \example ex_MSPFTrain.nxc
 * This is an example of how to use the \ref MSPFTrain function.
 *
 * \example ex_MSRCXSetNRLinkPort.nxc
 * This is an example of how to use the \ref MSRCXSetNRLinkPort function.
 *
 * \example ex_MSRCXBatteryLevel.nxc
 * This is an example of how to use the \ref MSRCXBatteryLevel function.
 *
 * \example ex_MSRCXPoll.nxc
 * This is an example of how to use the \ref MSRCXPoll function.
 *
 * \example ex_MSRCXPollMemory.nxc
 * This is an example of how to use the \ref MSRCXPollMemory function.
 *
 * \example ex_MSRCXAbsVar.nxc
 * This is an example of how to use the \ref MSRCXAbsVar function.
 *
 * \example ex_MSRCXAddToDatalog.nxc
 * This is an example of how to use the \ref MSRCXAddToDatalog function.
 *
 * \example ex_MSRCXAndVar.nxc
 * This is an example of how to use the \ref MSRCXAndVar function.
 *
 * \example ex_MSRCXBoot.nxc
 * This is an example of how to use the \ref MSRCXBoot function.
 *
 * \example ex_MSRCXCalibrateEvent.nxc
 * This is an example of how to use the \ref MSRCXCalibrateEvent function.
 *
 * \example ex_MSRCXClearAllEvents.nxc
 * This is an example of how to use the \ref MSRCXClearAllEvents function.
 *
 * \example ex_MSRCXClearCounter.nxc
 * This is an example of how to use the \ref MSRCXClearCounter function.
 *
 * \example ex_MSRCXClearMsg.nxc
 * This is an example of how to use the \ref MSRCXClearMsg function.
 *
 * \example ex_MSRCXClearSensor.nxc
 * This is an example of how to use the \ref MSRCXClearSensor function.
 *
 * \example ex_MSRCXClearSound.nxc
 * This is an example of how to use the \ref MSRCXClearSound function.
 *
 * \example ex_MSRCXClearTimer.nxc
 * This is an example of how to use the \ref MSRCXClearTimer function.
 *
 * \example ex_MSRCXCreateDatalog.nxc
 * This is an example of how to use the \ref MSRCXCreateDatalog function.
 *
 * \example ex_MSRCXDecCounter.nxc
 * This is an example of how to use the \ref MSRCXDecCounter function.
 *
 * \example ex_MSRCXDeleteSub.nxc
 * This is an example of how to use the \ref MSRCXDeleteSub function.
 *
 * \example ex_MSRCXDeleteSubs.nxc
 * This is an example of how to use the \ref MSRCXDeleteSubs function.
 *
 * \example ex_MSRCXDeleteTask.nxc
 * This is an example of how to use the \ref MSRCXDeleteTask function.
 *
 * \example ex_MSRCXDeleteTasks.nxc
 * This is an example of how to use the \ref MSRCXDeleteTasks function.
 *
 * \example ex_MSRCXDisableOutput.nxc
 * This is an example of how to use the \ref MSRCXDisableOutput function.
 *
 * \example ex_MSRCXDivVar.nxc
 * This is an example of how to use the \ref MSRCXDivVar function.
 *
 * \example ex_MSRCXEnableOutput.nxc
 * This is an example of how to use the \ref MSRCXEnableOutput function.
 *
 * \example ex_MSRCXEvent.nxc
 * This is an example of how to use the \ref MSRCXEvent function.
 *
 * \example ex_MSRCXFloat.nxc
 * This is an example of how to use the \ref MSRCXFloat function.
 *
 * \example ex_MSRCXFwd.nxc
 * This is an example of how to use the \ref MSRCXFwd function.
 *
 * \example ex_MSRCXIncCounter.nxc
 * This is an example of how to use the \ref MSRCXIncCounter function.
 *
 * \example ex_MSRCXInvertOutput.nxc
 * This is an example of how to use the \ref MSRCXInvertOutput function.
 *
 * \example ex_MSRCXMulVar.nxc
 * This is an example of how to use the \ref MSRCXMulVar function.
 *
 * \example ex_MSRCXMuteSound.nxc
 * This is an example of how to use the \ref MSRCXMuteSound function.
 *
 * \example ex_MSRCXObvertOutput.nxc
 * This is an example of how to use the \ref MSRCXObvertOutput function.
 *
 * \example ex_MSRCXOff.nxc
 * This is an example of how to use the \ref MSRCXOff function.
 *
 * \example ex_MSRCXOn.nxc
 * This is an example of how to use the \ref MSRCXOn function.
 *
 * \example ex_MSRCXOnFor.nxc
 * This is an example of how to use the \ref MSRCXOnFor function.
 *
 * \example ex_MSRCXOnFwd.nxc
 * This is an example of how to use the \ref MSRCXOnFwd function.
 *
 * \example ex_MSRCXOnRev.nxc
 * This is an example of how to use the \ref MSRCXOnRev function.
 *
 * \example ex_MSRCXOrVar.nxc
 * This is an example of how to use the \ref MSRCXOrVar function.
 *
 * \example ex_MSRCXPBTurnOff.nxc
 * This is an example of how to use the \ref MSRCXPBTurnOff function.
 *
 * \example ex_MSRCXPing.nxc
 * This is an example of how to use the \ref MSRCXPing function.
 *
 * \example ex_MSRCXPlaySound.nxc
 * This is an example of how to use the \ref MSRCXPlaySound function.
 *
 * \example ex_MSRCXPlayTone.nxc
 * This is an example of how to use the \ref MSRCXPlayTone function.
 *
 * \example ex_MSRCXPlayToneVar.nxc
 * This is an example of how to use the \ref MSRCXPlayToneVar function.
 *
 * \example ex_MSRCXRemote.nxc
 * This is an example of how to use the \ref MSRCXRemote function.
 *
 * \example ex_MSRCXReset.nxc
 * This is an example of how to use the \ref MSRCXReset function.
 *
 * \example ex_MSRCXRev.nxc
 * This is an example of how to use the \ref MSRCXRev function.
 *
 * \example ex_MSRCXSelectDisplay.nxc
 * This is an example of how to use the \ref MSRCXSelectDisplay function.
 *
 * \example ex_MSRCXSelectProgram.nxc
 * This is an example of how to use the \ref MSRCXSelectProgram function.
 *
 * \example ex_MSRCXSendSerial.nxc
 * This is an example of how to use the \ref MSRCXSendSerial function.
 *
 * \example ex_MSRCXSet.nxc
 * This is an example of how to use the \ref MSRCXSet function.
 *
 * \example ex_MSRCXSetDirection.nxc
 * This is an example of how to use the \ref MSRCXSetDirection function.
 *
 * \example ex_MSRCXSetEvent.nxc
 * This is an example of how to use the \ref MSRCXSetEvent function.
 *
 * \example ex_MSRCXSetGlobalDirection.nxc
 * This is an example of how to use the \ref MSRCXSetGlobalDirection function.
 *
 * \example ex_MSRCXSetGlobalOutput.nxc
 * This is an example of how to use the \ref MSRCXSetGlobalOutput function.
 *
 * \example ex_MSRCXSetMaxPower.nxc
 * This is an example of how to use the \ref MSRCXSetMaxPower function.
 *
 * \example ex_MSRCXSetMessage.nxc
 * This is an example of how to use the \ref MSRCXSetMessage function.
 *
 * \example ex_MSRCXSetOutput.nxc
 * This is an example of how to use the \ref MSRCXSetOutput function.
 *
 * \example ex_MSRCXSetPower.nxc
 * This is an example of how to use the \ref MSRCXSetPower function.
 *
 * \example ex_MSRCXSetPriority.nxc
 * This is an example of how to use the \ref MSRCXSetPriority function.
 *
 * \example ex_MSRCXSetSensorMode.nxc
 * This is an example of how to use the \ref MSRCXSetSensorMode function.
 *
 * \example ex_MSRCXSetSensorType.nxc
 * This is an example of how to use the \ref MSRCXSetSensorType function.
 *
 * \example ex_MSRCXSetSleepTime.nxc
 * This is an example of how to use the \ref MSRCXSetSleepTime function.
 *
 * \example ex_MSRCXSetTxPower.nxc
 * This is an example of how to use the \ref MSRCXSetTxPower function.
 *
 * \example ex_MSRCXSetUserDisplay.nxc
 * This is an example of how to use the \ref MSRCXSetUserDisplay function.
 *
 * \example ex_MSRCXSetVar.nxc
 * This is an example of how to use the \ref MSRCXSetVar function.
 *
 * \example ex_MSRCXSetWatch.nxc
 * This is an example of how to use the \ref MSRCXSetWatch function.
 *
 * \example ex_MSRCXSgnVar.nxc
 * This is an example of how to use the \ref MSRCXSgnVar function.
 *
 * \example ex_MSRCXStartTask.nxc
 * This is an example of how to use the \ref MSRCXStartTask function.
 *
 * \example ex_MSRCXStopAllTasks.nxc
 * This is an example of how to use the \ref MSRCXStopAllTasks function.
 *
 * \example ex_MSRCXStopTask.nxc
 * This is an example of how to use the \ref MSRCXStopTask function.
 *
 * \example ex_MSRCXSubVar.nxc
 * This is an example of how to use the \ref MSRCXSubVar function.
 *
 * \example ex_MSRCXSumVar.nxc
 * This is an example of how to use the \ref MSRCXSumVar function.
 *
 * \example ex_MSRCXToggle.nxc
 * This is an example of how to use the \ref MSRCXToggle function.
 *
 * \example ex_MSRCXUnlock.nxc
 * This is an example of how to use the \ref MSRCXUnlock function.
 *
 * \example ex_MSRCXUnmuteSound.nxc
 * This is an example of how to use the \ref MSRCXUnmuteSound function.
 *
 * \example ex_MSScoutCalibrateSensor.nxc
 * This is an example of how to use the \ref MSScoutCalibrateSensor function.
 *
 * \example ex_MSScoutMuteSound.nxc
 * This is an example of how to use the \ref MSScoutMuteSound function.
 *
 * \example ex_MSScoutSelectSounds.nxc
 * This is an example of how to use the \ref MSScoutSelectSounds function.
 *
 * \example ex_MSScoutSendVLL.nxc
 * This is an example of how to use the \ref MSScoutSendVLL function.
 *
 * \example ex_MSScoutSetCounterLimit.nxc
 * This is an example of how to use the \ref MSScoutSetCounterLimit function.
 *
 * \example ex_MSScoutSetEventFeedback.nxc
 * This is an example of how to use the \ref MSScoutSetEventFeedback function.
 *
 * \example ex_MSScoutSetLight.nxc
 * This is an example of how to use the \ref MSScoutSetLight function.
 *
 * \example ex_MSScoutSetScoutMode.nxc
 * This is an example of how to use the \ref MSScoutSetScoutMode function.
 *
 * \example ex_MSScoutSetScoutRules.nxc
 * This is an example of how to use the \ref MSScoutSetScoutRules function.
 *
 * \example ex_MSScoutSetSensorClickTime.nxc
 * This is an example of how to use the \ref MSScoutSetSensorClickTime function.
 *
 * \example ex_MSScoutSetSensorHysteresis.nxc
 * This is an example of how to use the \ref MSScoutSetSensorHysteresis function.
 *
 * \example ex_MSScoutSetSensorLowerLimit.nxc
 * This is an example of how to use the \ref MSScoutSetSensorLowerLimit function.
 *
 * \example ex_MSScoutSetSensorUpperLimit.nxc
 * This is an example of how to use the \ref MSScoutSetSensorUpperLimit function.
 *
 * \example ex_MSScoutSetTimerLimit.nxc
 * This is an example of how to use the \ref MSScoutSetTimerLimit function.
 *
 * \example ex_MSScoutUnmuteSound.nxc
 * This is an example of how to use the \ref MSScoutUnmuteSound function.
 *
 * \example ex_sqrt.nxc
 * This is an example of how to use the \ref sqrt function.
 *
 * \example ex_sin_cos.nxc
 * This is an example of how to use the \ref cos and the \ref sin functions.
 *
 * \example ex_tan.nxc
 * This is an example of how to use the \ref tan function.
 *
 * \example ex_acos.nxc
 * This is an example of how to use the \ref acos function.
 *
 * \example ex_asin.nxc
 * This is an example of how to use the \ref asin function.
 *
 * \example ex_atan.nxc
 * This is an example of how to use the \ref atan function.
 *
 * \example ex_atan2.nxc
 * This is an example of how to use the \ref atan2 function.
 *
 * \example ex_cosh.nxc
 * This is an example of how to use the \ref cosh function.
 *
 * \example ex_sinh.nxc
 * This is an example of how to use the \ref sinh function.
 *
 * \example ex_tanh.nxc
 * This is an example of how to use the \ref tanh function.
 *
 * \example ex_exp.nxc
 * This is an example of how to use the \ref exp function.
 *
 * \example ex_log.nxc
 * This is an example of how to use the \ref log function.
 *
 * \example ex_log10.nxc
 * This is an example of how to use the \ref log10 function.
 *
 * \example ex_trunc.nxc
 * This is an example of how to use the \ref trunc function.
 *
 * \example ex_frac.nxc
 * This is an example of how to use the \ref frac function.
 *
 * \example ex_pow.nxc
 * This is an example of how to use the \ref pow function.
 *
 * \example ex_ceil.nxc
 * This is an example of how to use the \ref ceil function.
 *
 * \example ex_floor.nxc
 * This is an example of how to use the \ref floor function.
 *
 * \example ex_muldiv32.nxc
 * This is an example of how to use the \ref muldiv32 function.
 *
 * \example ex_sind_cosd.nxc
 * This is an example of how to use the \ref cosd and \ref sind functions.
 *
 * \example ex_tand.nxc
 * This is an example of how to use the \ref tand function.
 *
 * \example ex_acosd.nxc
 * This is an example of how to use the \ref acosd function.
 *
 * \example ex_asind.nxc
 * This is an example of how to use the \ref asind function.
 *
 * \example ex_atand.nxc
 * This is an example of how to use the \ref atand function.
 *
 * \example ex_atan2d.nxc
 * This is an example of how to use the \ref atan2d function.
 *
 * \example ex_bcd2dec.nxc
 * This is an example of how to use the \ref bcd2dec function.
 *
 * \example ex_isnan.nxc
 * This is an example of how to use the \ref isNAN function.
 *
 * \example ex_sign.nxc
 * This is an example of how to use the \ref sign function.
 *
 * \example ex_fclose.nxc
 * This is an example of how to use the \ref fclose function.
 *
 * \example ex_remove.nxc
 * This is an example of how to use the \ref remove function.
 *
 * \example ex_rename.nxc
 * This is an example of how to use the \ref rename function.
 *
 * \example ex_fgetc.nxc
 * This is an example of how to use the \ref fgetc function.
 *
 * \example ex_getc.nxc
 * This is an example of how to use the \ref getc function.
 *
 * \example ex_fgets.nxc
 * This is an example of how to use the \ref fgets function.
 *
 * \example ex_feof.nxc
 * This is an example of how to use the \ref feof function.
 *
 * \example ex_fopen.nxc
 * This is an example of how to use the \ref fopen function.
 *
 * \example ex_fflush.nxc
 * This is an example of how to use the \ref fflush function.
 *
 * \example ex_ftell.nxc
 * This is an example of how to use the \ref ftell function.
 *
 * \example ex_fputc.nxc
 * This is an example of how to use the \ref fputc function.
 *
 * \example ex_putc.nxc
 * This is an example of how to use the \ref putc function.
 *
 * \example ex_fputs.nxc
 * This is an example of how to use the \ref fputs function.
 *
 * \example ex_printf.nxc
 * This is an example of how to use the \ref printf function.
 *
 * \example ex_fprintf.nxc
 * This is an example of how to use the \ref fprintf function.
 *
 * \example ex_sprintf.nxc
 * This is an example of how to use the \ref sprintf function.
 *
 * \example ex_fseek.nxc
 * This is an example of how to use the \ref fseek function.
 *
 * \example ex_rewind.nxc
 * This is an example of how to use the \ref rewind function.
 *
 * \example ex_getchar.nxc
 * This is an example of how to use the \ref getchar function.
 *
 * \example ex_cstdio.nxc
 * This is an example of how to use the cstdio API functions: \ref fopen, \ref fprintf, \ref fputc,
 * \ref fputs, \ref fseek, \ref ftell, \ref fclose, \ref feof, \ref fflush,
 * \ref fgetc, \ref fgets, \ref getc, \ref putc, \ref rewind,
 * \ref printf, \ref sprintf, \ref rename, and \ref remove.
 *
 * \example ex_abort.nxc
 * This is an example of how to use the \ref abort function.
 *
 * \example ex_abs.nxc
 * This is an example of how to use the \ref abs function.
 *
 * \example ex_rand.nxc
 * This is an example of how to use the \ref rand function.
 *
 * \example ex_srand.nxc
 * This is an example of how to use the \ref srand function.
 *
 * \example ex_Random.nxc
 * This is an example of how to use the \ref Random function.
 *
 * \example ex_sysrandomnumber.nxc
 * This is an example of how to use the \ref SysRandomNumber function along with
 * the \ref RandomNumberType structure.
 *
 * \example ex_sysrandomex.nxc
 * This is an example of how to use the \ref SysRandomEx function along with
 * the \ref RandomExType structure.
 *
 * \example ex_sysinputpinfunction.nxc
 * This is an example of how to use the \ref SysInputPinFunction function along with
 * the \ref InputPinFunctionType structure.
 *
 * \example ex_atoi.nxc
 * This is an example of how to use the \ref atoi function.
 *
 * \example ex_atol.nxc
 * This is an example of how to use the \ref atol function.
 *
 * \example ex_labs.nxc
 * This is an example of how to use the \ref labs function.
 *
 * \example ex_atof.nxc
 * This is an example of how to use the \ref atof function.
 *
 * \example ex_strtod.nxc
 * This is an example of how to use the \ref strtod function.
 *
 * \example ex_strtol.nxc
 * This is an example of how to use the \ref strtol function.
 *
 * \example ex_strtoul.nxc
 * This is an example of how to use the \ref strtoul function.
 *
 * \example ex_div.nxc
 * This is an example of how to use the \ref div function.
 *
 * \example ex_ldiv.nxc
 * This is an example of how to use the \ref ldiv function.
 *
 * \example ex_StrToNum.nxc
 * This is an example of how to use the \ref StrToNum function.
 *
 * \example ex_StrLenOld.nxc
 * This is an example of how to use the \ref StrLen function.
 *
 * \example ex_StrIndex.nxc
 * This is an example of how to use the \ref StrIndex function.
 *
 * \example ex_NumToStr.nxc
 * This is an example of how to use the \ref NumToStr function.
 *
 * \example ex_StrCatOld.nxc
 * This is an example of how to use the \ref StrCat function.
 *
 * \example ex_SubStr.nxc
 * This is an example of how to use the \ref SubStr function.
 *
 * \example ex_Flatten.nxc
 * This is an example of how to use the \ref Flatten function.
 *
 * \example ex_StrReplace.nxc
 * This is an example of how to use the \ref StrReplace function.
 *
 * \example ex_FormatNum.nxc
 * This is an example of how to use the \ref FormatNum function.
 *
 * \example ex_FlattenVar.nxc
 * This is an example of how to use the \ref FlattenVar function.
 *
 * \example ex_UnflattenVar.nxc
 * This is an example of how to use the \ref UnflattenVar function.
 *
 * \example ex_ByteArrayToStr.nxc
 * This is an example of how to use the \ref ByteArrayToStr function.
 *
 * \example ex_ByteArrayToStrEx.nxc
 * This is an example of how to use the \ref ByteArrayToStrEx function.
 *
 * \example ex_StrToByteArray.nxc
 * This is an example of how to use the \ref StrToByteArray function.
 *
 * \example ex_copy.nxc
 * This is an example of how to use the \ref Copy function.
 *
 * \example ex_midstr.nxc
 * This is an example of how to use the \ref MidStr function.
 *
 * \example ex_rightstr.nxc
 * This is an example of how to use the \ref RightStr function.
 *
 * \example ex_leftstr.nxc
 * This is an example of how to use the \ref LeftStr function.
 *
 * \example ex_StrLen.nxc
 * This is an example of how to use the \ref strlen function.
 *
 * \example ex_StrCat.nxc
 * This is an example of how to use the \ref strcat function.
 *
 * \example ex_strncat.nxc
 * This is an example of how to use the \ref strncat function.
 *
 * \example ex_strcpy.nxc
 * This is an example of how to use the \ref strcpy function.
 *
 * \example ex_strncpy.nxc
 * This is an example of how to use the \ref strncpy function.
 *
 * \example ex_strcmp.nxc
 * This is an example of how to use the \ref strcmp function.
 *
 * \example ex_strncmp.nxc
 * This is an example of how to use the \ref strncmp function.
 *
 * \example ex_memcpy.nxc
 * This is an example of how to use the \ref memcpy function.
 *
 * \example ex_memmove.nxc
 * This is an example of how to use the \ref memmove function.
 *
 * \example ex_memcmp.nxc
 * This is an example of how to use the \ref memcmp function.
 *
 * \example ex_addressof.nxc
 * This is an example of how to use the \ref addressOf function.
 *
 * \example ex_reladdressof.nxc
 * This is an example of how to use the \ref reladdressOf function.
 *
 * \example ex_addressofex.nxc
 * This is an example of how to use the \ref addressOfEx function.
 *
 * \example ex_string.nxc
 * This is an example of how to use the string API functions: \ref StrToNum, \ref StrLen,
 * \ref StrIndex, \ref NumToStr, \ref StrCat, \ref SubStr, \ref Flatten,
 * \ref StrReplace, \ref FormatNum, \ref FlattenVar, \ref UnflattenVar,
 * \ref ByteArrayToStr, \ref ByteArrayToStrEx, and \ref StrToByteArray.
 *
 * \example ex_cstring.nxc
 * This is an example of how to use the cstring API functions: \ref strcat, \ref strcmp, \ref strcpy,
 * \ref strlen, \ref strncat, \ref strncmp, \ref strncpy, \ref memcpy,
 * \ref memmove, and \ref memcmp.
 *
 * \example ex_isupper.nxc
 * This is an example of how to use the \ref isupper function.
 *
 * \example ex_islower.nxc
 * This is an example of how to use the \ref islower function.
 *
 * \example ex_isalpha.nxc
 * This is an example of how to use the \ref isalpha function.
 *
 * \example ex_isdigit.nxc
 * This is an example of how to use the \ref isdigit function.
 *
 * \example ex_isalnum.nxc
 * This is an example of how to use the \ref isalnum function.
 *
 * \example ex_isspace.nxc
 * This is an example of how to use the \ref isspace function.
 *
 * \example ex_iscntrl.nxc
 * This is an example of how to use the \ref iscntrl function.
 *
 * \example ex_isprint.nxc
 * This is an example of how to use the \ref isprint function.
 *
 * \example ex_isgraph.nxc
 * This is an example of how to use the \ref isgraph function.
 *
 * \example ex_ispunct.nxc
 * This is an example of how to use the \ref ispunct function.
 *
 * \example ex_isxdigit.nxc
 * This is an example of how to use the \ref isxdigit function.
 *
 * \example ex_toupper.nxc
 * This is an example of how to use the \ref toupper function.
 *
 * \example ex_tolower.nxc
 * This is an example of how to use the \ref tolower function.
 *
 * \example ex_ctype.nxc
 * This is an example of how to use the ctype API functions: \ref isupper, \ref islower, \ref isalpha,
 * \ref isdigit, \ref isalnum, \ref isspace, \ref iscntrl, \ref isprint,
 * \ref isgraph, \ref ispunct, \ref isxdigit, \ref toupper, and \ref tolower.
 *
 * \example glTranslateDemo.nxc
 * This is an example of how to use the \ref glInit, \ref glBox,
 * \ref glSetAngleX, \ref glAddToAngleY, \ref glBeginRender, \ref glSet,
 * \ref glCallObject, \ref glObjectAction, and \ref glFinishRender functions.
 *
 * \example glScaleDemo.nxc
 * This is an example of how to use the \ref glInit, \ref glBox,
 * \ref glSetAngleX, \ref glAddToAngleY, \ref glBeginRender,
 * \ref glCallObject, \ref glObjectAction, and \ref glFinishRender functions.
 *
 * \example glRotateDemo.nxc
 * This is an example of how to use the \ref glInit, \ref glBox,
 * \ref glSetAngleX, \ref glBeginRender,
 * \ref glCallObject, \ref glObjectAction, and \ref glFinishRender functions.
 *
 * \example glCircleDemo.nxc
 * This is an example of how to use the \ref glInit, \ref glBox,
 * \ref glSetAngleX, \ref glBeginRender, \ref glAddToAngleY, \ref glAddToAngleX
 * \ref glCallObject, \ref glSet, and \ref glFinishRender functions.
 *
 * \example glBoxDemo.nxc
 * This is an example of how to use the \ref glInit, \ref glBeginObject,
 * \ref glBegin, \ref glAddVertex, \ref glEnd, \ref glEndObject,
 * \ref glSetAngleX, \ref glBeginRender, \ref glAddToAngleY,
 * \ref glCallObject, and \ref glFinishRender functions.
 *
 * \example ex_file_system.nxc
 * This is an example of how to use the \ref PlayTone, \ref Wait, \ref Stop,
 * \ref TextOut, \ref OpenFileAppend, \ref CloseFile, \ref OpenFileRead, \ref FormatNum,
 * \ref Write, \ref Read, and \ref CircleOut functions.
 * This program is intended to serve as an introduction to data files on the 
 * NXT. It focuses on handling the codes returned by the file system's API 
 * calls, which is an important aspect of the API that is all too often 
 * neglected by programmers.
 * The program deals with a data file describing circles. On each run, it adds 
 * a new circle record to the data file. Then it reads in the whole data file
 * and displays all the circles on NXT screen. It creates the data file if 
 * doesn't already exist. If you run it several times in seccession, you will 
 * fill the data file and get a file-is-full exception.
 * The data flie created by this program is not visible on the NXT. To delete 
 * the file, circles.dat, you can use the NeXT Explorer or the example program 
 * \ref ex_delete_data_file.nxc.
 *
 * \example ex_delete_data_file.nxc
 * This is an example of how to use the \ref DeleteFile, \ref TextOut,
 * \ref FormatNum, and \ref Wait functions.
 * It is useful for deleting the circles.dat file created by the program described
 * in the \ref ex_file_system.nxc example.
 *
 * \example ex_sysmemorymanager.nxc
 * This is an example of how to use the \ref SysMemoryManager function along
 * with the \ref MemoryManagerType structure.
 *
 * \example ex_getmemoryinfo.nxc
 * This is an example of how to use the \ref GetMemoryInfo function.
 *
 * \example ex_HTGyroTest.nxc
 * This is an example of how to use the \ref SetSensorHTGyro, \ref SensorHTGyro,
 * \ref Wait, \ref TextOut, \ref NumOut, and \ref ButtonPressed functions.
 *
 * \example ex_NXTSumoEyes.nxc
 * This is an example of how to use the \ref SetSensorNXTSumoEyes,
 * \ref SensorNXTSumoEyes, \ref SensorNXTSumoEyesRaw, \ref NumOut, and
 * \ref Wait functions.
 *
 * \example ex_PFMate.nxc
 * This is an example of how to use the \ref PFMateSend, \ref PFMateSendRaw,
 * \ref SetSensorLowspeed, and \ref Wait functions.
 *
 * \example ex_NXTServo.nxc
 * This is an example of how to use the \ref NXTServoPosition,
 * \ref NXTServoSpeed, \ref NXTServoBatteryVoltage, \ref SetNXTServoSpeed,
 * \ref SetNXTServoQuickPosition, \ref SetNXTServoPosition,
 * \ref NXTServoReset, \ref NXTServoHaltMacro, \ref NXTServoResumeMacro,
 * \ref NXTServoPauseMacro, \ref NXTServoInit, \ref NXTServoGotoMacroAddress,
 * \ref NXTServoEditMacro, \ref NXTServoQuitEdit, \ref SetSensorLowspeed,
 * \ref NumOut, and \ref Wait functions.
 *
 * \example ex_NXTHID.nxc
 * This is an example of how to use the \ref NXTHIDAsciiMode,
 * \ref NXTHIDDirectMode, \ref NXTHIDTransmit, \ref NXTHIDLoadCharacter,
 * \ref SetSensorLowspeed, and \ref Wait functions.
 *
 * \example ex_NXTPowerMeter.nxc
 * This is an example of how to use the \ref NXTPowerMeterResetCounters,
 * \ref NXTPowerMeterPresentCurrent, \ref NXTPowerMeterPresentVoltage,
 * \ref NXTPowerMeterCapacityUsed, \ref NXTPowerMeterPresentPower,
 * \ref NXTPowerMeterTotalPowerConsumed, \ref NXTPowerMeterMaxCurrent,
 * \ref NXTPowerMeterMinCurrent, \ref NXTPowerMeterMaxVoltage,
 * \ref NXTPowerMeterMinVoltage, \ref NXTPowerMeterElapsedTime,
 * \ref NXTPowerMeterErrorCount, \ref SetSensorLowspeed, \ref NumOut,
 * and \ref Wait functions.
 *
 * \example ex_NXTLineLeader.nxc
 * This is an example of how to use the \ref NXTLineLeaderSteering,
 * \ref NXTLineLeaderAverage, \ref NXTLineLeaderResult,
 * \ref NXTLineLeaderPowerDown, \ref NXTLineLeaderPowerUp,
 * \ref NXTLineLeaderInvert, \ref NXTLineLeaderReset,
 * \ref NXTLineLeaderSnapshot, \ref NXTLineLeaderCalibrateWhite,
 * \ref NXTLineLeaderCalibrateBlack, \ref SetNXTLineLeaderSetpoint,
 * \ref SetNXTLineLeaderKpValue, \ref SetNXTLineLeaderKiValue,
 * \ref SetNXTLineLeaderKpValue, \ref SetNXTLineLeaderKpFactor,
 * \ref SetNXTLineLeaderKiFactor, \ref SetNXTLineLeaderKdFactor,
 * \ref SetSensorLowspeed, \ref NumOut, and \ref Wait functions.
 *
 * \example ex_DataMode.nxc
 * This is an example of how to use the \ref HSDataMode, \ref BTDataMode,
 * \ref SetHSDataMode, \ref SetBTDataMode, \ref TextOut, and \ref Wait functions.
 *
 * \example ex_LowLevelModuleRoutines.nxc
 * This is an example of how to use the \ref SetIOMapBytes, \ref SetIOMapValue,
 * \ref GetIOMapBytes, \ref GetIOMapValue, \ref GetLowSpeedModuleBytes,
 * \ref GetDisplayModuleBytes, \ref GetCommModuleBytes, \ref GetCommandModuleBytes,
 * \ref SetLowSpeedModuleBytes, \ref SetDisplayModuleBytes, \ref SetCommModuleBytes,
 * \ref SetCommandModuleBytes, ref SetIOMapBytesByID, \ref SetIOMapValueByID,
 * \ref GetIOMapBytesByID, \ref GetIOMapValueByID, \ref SetCommandModuleValue,
 * \ref SetIOCtrlModuleValue, \ref SetLoaderModuleValue, \ref SetUIModuleValue,
 * \ref SetSoundModuleValue, \ref SetButtonModuleValue, \ref SetInputModuleValue,
 * \ref SetOutputModuleValue, \ref SetLowSpeedModuleValue, \ref SetDisplayModuleValue,
 * \ref SetCommModuleValue, \ref GetCommandModuleValue,
 * \ref GetLoaderModuleValue, \ref GetUIModuleValue, \ref GetSoundModuleValue,
 * \ref GetButtonModuleValue, \ref GetInputModuleValue, \ref GetOutputModuleValue,
 * \ref GetLowSpeedModuleValue, \ref GetDisplayModuleValue, \ref GetCommModuleValue,
 *
 * \example ex_RemoteConnectionIdle.nxc
 * This is an example of how to use the \ref RemoteConnectionIdle function.
 *
 * \example ex_RemoteConnectionWrite.nxc
 * This is an example of how to use the \ref RemoteConnectionWrite function.
 *
 * \example ex_RemoteGetBatteryLevel.nxc
 * This is an example of how to use the \ref RemoteGetBatteryLevel function.
 *
 * \example ex_RemoteLowspeedGetStatus.nxc
 * This is an example of how to use the \ref RemoteLowspeedGetStatus function.
 *
 * \example ex_RemoteGetCurrentProgramName.nxc
 * This is an example of how to use the \ref RemoteGetCurrentProgramName function.
 *
 * \example ex_RemoteGetContactCount.nxc
 * This is an example of how to use the \ref RemoteGetContactCount function.
 *
 * \example ex_RemoteGetConnectionCount.nxc
 * This is an example of how to use the \ref RemoteGetConnectionCount function.
 *
 * \example ex_RemoteGetOutputState.nxc
 * This is an example of how to use the \ref RemoteGetOutputState function.
 *
 * \example ex_RemoteGetInputValues.nxc
 * This is an example of how to use the \ref RemoteGetInputValues function.
 *
 * \example ex_RemoteLowspeedRead.nxc
 * This is an example of how to use the \ref RemoteLowspeedRead function.
 *
 * \example ex_RemoteGetProperty.nxc
 * This is an example of how to use the \ref RemoteGetProperty function.
 *
 * \example ex_RemoteDatalogRead.nxc
 * This is an example of how to use the \ref RemoteDatalogRead function.
 *
 * \example ex_RemoteGetContactName.nxc
 * This is an example of how to use the \ref RemoteGetContactName function.
 *
 * \example ex_RemoteGetConnectionName.nxc
 * This is an example of how to use the \ref RemoteGetConnectionName function.
 *
 * \example ex_RemoteResetTachoCount.nxc
 * This is an example of how to use the \ref RemoteResetTachoCount function.
 *
 * \example ex_RemoteDatalogSetTimes.nxc
 * This is an example of how to use the \ref RemoteDatalogSetTimes function.
 *
 * \example ex_RemoteSetProperty.nxc
 * This is an example of how to use the \ref RemoteSetProperty function.
 *
 * \example ex_RemoteLowspeedWrite.nxc
 * This is an example of how to use the \ref RemoteLowspeedWrite function.
 *
 * \example ex_RemoteOpenRead.nxc
 * This is an example of how to use the \ref RemoteOpenRead function.
 *
 * \example ex_RemoteOpenAppendData.nxc
 * This is an example of how to use the \ref RemoteOpenAppendData function.
 *
 * \example ex_RemoteDeleteFile.nxc
 * This is an example of how to use the \ref RemoteDeleteFile function.
 *
 * \example ex_RemoteFindFirstFile.nxc
 * This is an example of how to use the \ref RemoteFindFirstFile function.
 *
 * \example ex_RemoteGetFirmwareVersion.nxc
 * This is an example of how to use the \ref RemoteGetFirmwareVersion function.
 *
 * \example ex_RemoteGetBluetoothAddress.nxc
 * This is an example of how to use the \ref RemoteGetBluetoothAddress function.
 *
 * \example ex_RemoteGetDeviceInfo.nxc
 * This is an example of how to use the \ref RemoteGetDeviceInfo function.
 *
 * \example ex_RemoteDeleteUserFlash.nxc
 * This is an example of how to use the \ref RemoteDeleteUserFlash function.
 *
 * \example ex_RemoteBluetoothFactoryReset.nxc
 * This is an example of how to use the \ref RemoteBluetoothFactoryReset function.
 *
 * \example ex_RemoteOpenWrite.nxc
 * This is an example of how to use the \ref RemoteOpenWrite function.
 *
 * \example ex_RemoteOpenWriteLinear.nxc
 * This is an example of how to use the \ref RemoteOpenWriteLinear function.
 *
 * \example ex_RemoteOpenWriteData.nxc
 * This is an example of how to use the \ref RemoteOpenWriteData function.
 *
 * \example ex_RemoteCloseFile.nxc
 * This is an example of how to use the \ref RemoteCloseFile function.
 *
 * \example ex_RemoteFindNextFile.nxc
 * This is an example of how to use the \ref RemoteFindNextFile function.
 *
 * \example ex_RemotePollCommandLength.nxc
 * This is an example of how to use the \ref RemotePollCommandLength function.
 *
 * \example ex_RemoteWrite.nxc
 * This is an example of how to use the \ref RemoteWrite function.
 *
 * \example ex_RemoteRead.nxc
 * This is an example of how to use the \ref RemoteRead function.
 *
 * \example ex_RemoteIOMapRead.nxc
 * This is an example of how to use the \ref RemoteIOMapRead function.
 *
 * \example ex_RemoteIOMapWriteValue.nxc
 * This is an example of how to use the \ref RemoteIOMapWriteValue function.
 *
 * \example ex_RemoteIOMapWriteBytes.nxc
 * This is an example of how to use the \ref RemoteIOMapWriteBytes function.
 *
 * \example ex_RemoteSetBrickName.nxc
 * This is an example of how to use the \ref RemoteSetBrickName function.
 *
 * \example ex_RemoteRenameFile.nxc
 * This is an example of how to use the \ref RemoteRenameFile function.
 *
 * \example ex_RemotePollCommand.nxc
 * This is an example of how to use the \ref RemotePollCommand function.
 *
 * \example ex_GetLastResponseInfo.nxc
 * This is an example of how to use the \ref GetLastResponseInfo function.
 *
 * \example ex_SysReadLastResponse.nxc
 * This is an example of how to use the \ref SysReadLastResponse function.
 *
 * \example ex_SetSensorEMeter.nxc
 * This is an example of how to use the \ref SetSensorEMeter function.
 *
 * \example ex_SetSensorUltrasonic.nxc
 * This is an example of how to use the \ref SetSensorUltrasonic function.
 *
 * \example ex_SetSensorTemperature.nxc
 * This is an example of how to use the \ref SetSensorTemperature function.
 *
 * \example ex_ReadSensorEMeter.nxc
 * This is an example of how to use the \ref ReadSensorEMeter function.
 *
 * \example ex_ConfigureTemperatureSensor.nxc
 * This is an example of how to use the \ref ConfigureTemperatureSensor function.
 *
 * \example ex_SensorTemperature.nxc
 * This is an example of how to use the \ref SensorTemperature function.
 *
 * \example ex_SetSensorHTMagnet.nxc
 * This is an example of how to use the \ref SetSensorHTMagnet function.
 *
 * \example ex_SensorHTMagnet.nxc
 * This is an example of how to use the \ref SensorHTMagnet function.
 *
 * \example ex_RFIDInit.nxc
 * This is an example of how to use the \ref RFIDInit function.
 *
 * \example ex_RFIDMode.nxc
 * This is an example of how to use the \ref RFIDMode function.
 *
 * \example ex_RFIDStatus.nxc
 * This is an example of how to use the \ref RFIDStatus function.
 *
 * \example ex_RFIDRead.nxc
 * This is an example of how to use the \ref RFIDRead function.
 *
 * \example ex_RFIDStop.nxc
 * This is an example of how to use the \ref RFIDStop function.
 *
 * \example ex_RFIDReadSingle.nxc
 * This is an example of how to use the \ref RFIDReadSingle function.
 *
 * \example ex_RFIDReadContinuous.nxc
 * This is an example of how to use the \ref RFIDReadContinuous function.
 *
 * \example ex_SizeOf.nxc
 * This is an example of how to use the \ref SizeOf and \ref NumOut functions.
 *
 * \example ex_Pos.nxc
 * This is an example of how to use the \ref Pos and \ref NumOut functions.
 *
 * \example ex_PosReg.nxc
 * This is an example of how to use the \ref PosRegEnable, \ref PosRegSetAngle,
 * \ref PosRegAddAngle, \ref PosRegSetMax, \ref SetMotorRegulationTime, 
 * \ref SetMotorRegulationOptions, \ref MotorRegulationTime, 
 * \ref MotorRegulationOptions, \ref MotorMaxSpeed, and
 * \ref MotorMaxAcceleration functions.
 *
 * \example ex_digps.nxc
 * This is an example of how to use the \ref SetSensorDIGPSWaypoint,
 * \ref SensorDIGPSStatus,
 * \ref SensorDIGPSTime, \ref SensorDIGPSLatitude, \ref SensorDIGPSLongitude,
 * \ref SensorDIGPSVelocity, \ref SensorDIGPSHeading,
 * \ref SensorDIGPSDistanceToWaypoint, \ref SensorDIGPSHeadingToWaypoint, and
 * \ref SensorDIGPSRelativeHeading functions.
 *
 * \example ex_nbcopt.nxc
 * This is an example of how to use the \ref ArrayIndex, \ref ArrayReplace,
 * \ref BranchComp, and \ref BranchTest functions.
 *
 * \example ex_xg1300.nxc
 * This is an example of how to use the \ref ResetMIXG1300L,
 * \ref SetSensorMIXG1300LScale, \ref SensorMIXG1300LScale, and
 * \ref ReadSensorMIXG1300L functions.
 *
 * \example ex_proto.nxc
 * This is an example of how to use the \ref SensorHTProtoAnalog,
 * \ref ReadSensorHTProtoAllAnalog, \ref SetSensorHTProtoDigitalControl,
 * \ref SetSensorHTProtoDigital, \ref SensorHTProtoDigital, and
 * \ref SensorHTProtoDigitalControl functions.
 *
 * \example ex_superpro.nxc
 * This is an example of how to use the \ref SensorHTSuperProAnalog,
 * \ref ReadSensorHTSuperProAllAnalog, \ref SetSensorHTSuperProDigitalControl,
 * \ref SetSensorHTSuperProDigital, \ref SensorHTSuperProDigital,
 * \ref SetSensorHTSuperProAnalogOut, \ref SensorHTSuperProLED,
 * \ref SensorHTSuperProStrobe, \ref SensorHTSuperProProgramControl,
 * \ref SetSensorHTSuperProLED, \ref SetSensorHTSuperProStrobe,
 * \ref SetSensorHTSuperProProgramControl, \ref ReadSensorHTSuperProAnalogOut,
 * and  \ref SensorHTSuperProDigitalControl functions.
 *
 * \example ex_digyro.nxc
 * This is an example of how to use the \ref SetSensorDIGyro,
 * \ref SetSensorDIGyroEx, \ref SensorDIGyroTemperature,
 * \ref SensorDIGyroStatus, \ref ReadSensorDIGyroRaw, and
 * \ref ReadSensorDIGyro functions.
 *
 * \example ex_diaccl.nxc
 * This is an example of how to use the \ref SetSensorDIAccl,
 * \ref SetSensorDIAcclEx, \ref SetSensorDIAcclDrift, \ref ReadSensorDIAcclDrift,
 * \ref SensorDIAcclStatus, \ref ReadSensorDIAccl8Raw, \ref ReadSensorDIAccl8,
 * \ref ReadSensorDIAcclRaw, and \ref ReadSensorDIAccl functions.
 *
 *
*/

/*
*/

#include "NXCDefs.h"

#endif // NXCAPIDOCS_H
