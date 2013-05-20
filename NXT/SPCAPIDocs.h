/** \file SPCAPIDocs.h
 * \brief Additional documentation for the SPC API
 *
 * SPCAPIDocs.h contains additional documentation for the SPC API
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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 * ----------------------------------------------------------------------------
 *
 * \author John Hansen (bricxcc_at_comcast.net)
 * \date 2013-02-20
 * \version 4
 */
#ifndef SPCAPIDOCS_H
#define SPCAPIDOCS_H

/////////////////////////////////////////////////////////////////////////////
/////////////////////  SPC Programmer's Guide ///////////////////////////////
/////////////////////////////////////////////////////////////////////////////

/** @mainpage SPC Programmer's Guide
 * \brief
 *
 * <h2><center>February 20, 2013</center></h2>
 * <h2><center>by John Hansen</center></h2>
 *
 * - @subpage intro
 * - @subpage lang
 *
 */

/** @page intro Introduction
 * \brief
 *
 * SPC stands for SuperPro C. It is a simple language for programming the
 * HiTechnic SuperPro prototyping sensor board. The SuperPro has a bytecode
 * interpreter which can be used to execute programs. The SPC compiler translates
 * a source program into SuperPro bytecodes, which can then be executed on the
 * target itself. Although the preprocessor and control structures of SPC are
 * very similar to C, SPC is not a general-purpose programming language - there
 * are many restrictions that stem from limitations of the SuperPro bytecode
 * interpreter.
 *
 * Logically, SPC is defined as two separate pieces. The SPC language describes
 * the syntax to be used in writing programs. The SPC Application Programming
 * Interface (API) describes the system functions, constants, and macros that
 * can be used by programs. This API is defined in a special file known as a
 * "header file" which is, by default, automatically included when compiling a
 * program.
 *
 * This document describes both the SPC language and the SPC API. In short, it
 * provides the information needed to write SPC programs. Since there are
 * different interfaces for SPC, this document does not describe how to use
 * any specific SPC implementation (such as the command-line compiler or Bricx
 * Command Center). Refer to the documentation provided with the SPC tool,
 * such as the SPC User Manual, for information specific to that implementation.
 *
 * For up-to-date information and documentation for SPC, visit the SPC website
 * at http://bricxcc.sourceforge.net/spc/.
 */

/** @page lang The SPC Language
 * \brief
 *
 * This section describes the SPC language. This includes the lexical rules
 * used by the compiler, the structure of programs, statements and expressions,
 * and the operation of the preprocessor.
 *
 * SPC is a case-sensitive language, just like C and C++, which means the
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
 * The lexical rules describe how SPC breaks a source file into individual
 * tokens. This includes the way comments are written, the handling of
 * whitespace, and valid characters for identifiers.
 *
 * - @subpage cmts
 * - @subpage wspace
 * - @subpage consts
 * - @subpage strconst
 * - @subpage charconst
 * - @subpage sysconst
 * - @subpage idkey
 *
 */

/** @page progstruct Program Structure
 * \brief
 *
 * An SPC program is composed of code blocks and variables. There are two
 * distinct types of code blocks: tasks and functions. Each type of code block
 * has its own unique features, but they share a common structure.
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
 * Numerical constants in the SuperPro are represented as integer
 * values. SPC internally uses
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
 * Values may be combined using operators. SPC operators are listed here in
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
 * <center>Expression Operators</center>
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
 * SPC also includes a preprocessor that is modeled after the Standard C
 * preprocessor. The C preprocessor processes a source code file before the
 * compiler does. It handles such tasks as including code from other files,
 * conditionally including or excluding blocks of code, stripping comments,
 * defining simple and parameterized macros, and expanding macros wherever
 * they are encountered in the source code.
 *
 * The SPC preprocessor implements the following standard preprocessor directives:
 * \#include, \#define, \#ifdef, \#ifndef, \#endif, \#if, \#elif, \#undef, \#\#,
 * \#line, \#error, and \#pragma. Its implementation is close to a standard C
 * preprocessor's, so most preprocessor directives should work as C programmers
 * expect in SPC. Any significant deviations are explained below.
 *
 * - @subpage include
 * - @subpage define
 * - @subpage concat
 * - @subpage condcomp
 * - @subpage pragma
 *
 */

/** @page cmts Comments
 * \brief
 *
 * Two forms of comments are supported in SPC. The first are traditional C
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
 * The second form of comments supported in SPC begins with '//' and continues
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
 * String constants in SPC, just as in C, are delimited with double quote
 * characters. String constants can only be used in a few API functions that
 * require a const char * input parameter.
 * \code
 * puts("testing\n");
 * printf("testing %d\n", value);
 * \endcode
 */

/** @page charconst Character Constants
 * \brief
 * 
 * Character constants in SPC are delimited with single quote characters and
 * may contain a single ASCII character.  The value of a character constant is
 * the numeric ASCII value of the character.
 * \code
 * char ch = 'a'; // ch == 97
 * \endcode
 *
 */

/** @page sysconst System Constants
 * \brief
 *
 * In SPC you can define special system memory address constants that are treated
 * like a variable with an absolute memory address.  A system address is simply
 * a numeric constant preceded by the '@' symbol.
 *
 * \code
 * int volt = @0x00; // read the voltage from analog input A0.
 * @0x0C = 1000; // set countdown timer 0 to 1000.
 * \endcode
 *
 * System constants can also be used to read and write to an area of shared
 * memory that can be accessed via I2C from a device such as the NXT.
 * The shared memory area from 0x20 - 0x3F is mapped to the byte addressed
 * I2C 0x80 - 0xFF memory address range. This permits data to be exchanged
 * between an attached NXT and the user program. See the \ref sharedmem page
 * for predefined constants to use this area of memory.
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
 * A number of tokens are reserved for use in the SPC language itself. These
 * are called keywords and may not be used as identifiers. A complete list of
 * keywords appears below:
 *
 * - \ref asm
 * - \ref bool
 * - \ref break
 * - \ref case
 * - \ref char
 * - @subpage const
 * - \ref continue
 * - \ref default
 * - \ref do
 * - \ref else
 * - @subpage enum
 * - \ref false
 * - \ref for
 * - \ref goto
 * - \ref if
 * - \ref inline
 * - \ref int
 * - \ref long
 * - \ref repeat
 * - \ref return
 * - \ref start
 * - @subpage static
 * - \ref struct
 * - \ref sub
 * - \ref switch
 * - \ref task
 * - \ref true
 * - @subpage typedef
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
 *   printf("%d\n", THREE);
 *   printf("%d\n", MEDIUM);
 *   printf("%d\n", FRED);
 *   printf("%d\n", SPRING);
 *   printf("%d\n", friday);
 *   printf("%d\n", today);
 *   printf("%d\n", test);
 *   printf("%d\n", tomorrow);
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
 * The lexical order is important to the SPC compiler, but not to the SuperPro
 * brick. This means that the order in which you write your task and function
 * definitions has no effect on the runtime order. The rules controlling
 * runtime order are:
 * 
 * -# There must be a task called main and this task will always run first.
 * -# The time at which any other task will run is determined by the placement
 * of API functions and keywords that start other tasks.
 * -# A function will run whenever it is called from another block of code.
 *
 * This last rule may seem trivial, but it has important consequences when
 * multiple tasks are running. If a task calls a function that is already in
 * the midst of running because it was called first by another task,
 * unpredictable behavior and results may ensue. Tasks can share functions by
 * treating them as shared resources and using code to prevent one task from
 * calling the function while another task is using it.
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
 * Since the SuperPro supports multi-threading, a task in SPC directly corresponds
 * to a SuperPro thread or process. Tasks are defined using the task keyword with the syntax
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
 * You can start tasks with the start statement, which is
 * discussed below.
 *
 * The \ref StopAllTasks API function stops all currently running tasks. You
 * can also stop all tasks using the \ref Stop function. A task can stop
 * itself via the \ref ExitTo function. Finally, a task will stop itself
 * simply by reaching the end of its body.
 *
 */

/** @page func Functions
 * \brief
 *
 * It is often helpful to group a set of statements together into a single
 * function, which your code can then call as needed. SPC supports functions
 * with arguments and return values. Functions are defined using the syntax
 * below.
 * \code
 * [inline] return_type name(argument_list)
 * {
 * 	// body of the function
 * }
 * \endcode
 * The return type is the type of data returned. In the C programming language,
 * functions must specify the type of data they return. Functions that do not
 * return data simply return void.
 *
 * Additional details about the keywords inline, and void can be
 * found below.
 *
 * - @subpage inline
 * - @subpage void
 *
 * The argument list of a function may be empty, or may contain one or more
 * argument definitions. An argument is defined by a type followed by a name.
 * Commas separate multiple arguments. All values are represented as bool, char,
 * int, long, struct types, or arrays of any type.
 *
 * SPC supports specifying a default value for function arguments that are not
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
 * 	printf("%d\n", foo(10)); outputs 200
 * 	printf("%d\n", foo(10, 5)); outputs 50
 * 	Wait(SEC_10); // wait 10 seconds
 * }
 * \endcode
 * SPC also supports passing arguments by value, by constant value, by
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
 * compile-time can be important since some SPC API functions only work with
 * true constant arguments.
 * \code
 * void foo(const int x)
 * {
 * 	x = 1;	// error - cannot modify argument
 * 	Wait(SEC_1);
 * }
 *
 * task main()
 * {
 * 	int x = 5;
 * 	foo(5);	// ok
 * 	foo(4*5);	// expression is still constant
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
 * Currently, passing an argument by reference in SPC
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

/** @page inline The inline keyword
 * \brief
 *
 * You can optionally mark SPC functions as inline functions. This means that
 * each call to the function will create another copy of the function's code.
 * Unless used judiciously, inline functions can lead to excessive code size.
 *
 * If a function is not marked as inline then an actual SuperPro subroutine is
 * created and the call to the function in SPC code will result in a subroutine
 * call to the SuperPro subroutine. The total number of non-inline functions (aka
 * subroutines) and tasks must not exceed 256.
 *
 * The code example below shows how you can use the inline keyword to make a
 * function emit its code at the point where it is called rather than
 * requiring a subroutine call.
 * \code
 * inline void foo(int value)
 * {
 *   Wait(value);
 * }
 *
 * task main()
 * {
 *   foo(MS_100);
 *   foo(MS_10);
 *   foo(SEC_1);
 *   foo(MS_50);
 * }
 * \endcode
 *
 * In this case task main will contain 4 Wait calls rather
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
 * have arguments but could not return a value.  In SPC void functions are
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
 * All variables in SPC are defined using one of the types listed below:
 *
 * - @subpage bool
 * - @subpage char
 * - @subpage int
 * - @subpage long
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
 * int data[10]; // an array of 10 zeros in data
 * bool flags[] = {true, true, false, false};
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
 * In SPC the bool type is a signed 32-bit value. Normally you would only
 * store a zero or one in a variable of this type.
 * \code
 *  bool flag=true;
 * \endcode
 */

/** @page char char
 * \brief
 *
 * In SPC the char type is a signed 32-bit value. The char type is often used to store
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
 * In SPC the int type is a signed 32-bit value. This type can store values
 * from \ref INT_MIN to \ref INT_MAX.
 * \code
 *  int x = 0xfff;
 *  int y = -23;
 * \endcode
 */

/** @page long long
 * \brief
 *
 * In SPC the long type is a signed 32-bit value. This type can store values
 * from \ref LONG_MIN to \ref LONG_MAX.
 * \code
 *  long x = 2147000000;
 *  long y = -88235;
 * \endcode
 */

/** @page struct Structures
 * \brief
 *
 * SPC supports user-defined aggregate types known as structs. These are
 * declared very much like you declare structs in a C program.
 * \code
 * struct car
 * {
 *   int car_type;
 *   int manu_year;
 * };
 *
 * struct person
 * {
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
 *   fooBar.car_type = honda;
 *   fooBar.manu_year = anotherPerson.age;
 * \endcode
 * You can assign structs of the same type but the compiler will complain if
 * the types do not match.
 *
 */

/** @page arrays Arrays
 * \brief
 *
 * SPC also support arrays. Arrays are declared the same way as ordinary
 * variables, but with an open and close bracket following the variable name.
 * Arrays must either have a non-empty size declaration or an initializer
 * following the declaration.
 * \code
 * int my_array[3];  // declare an array with 3 elements
 * \endcode
 * To declare arrays with more than one dimension simply add more pairs of
 * square brackets. The maximum number of dimensions supported in SPC is 4.
 * \code
 * bool my_array[3][3];  // declare a 2-dimensional array
 * \endcode
 * Arrays of up to two dimensions may be initialized at the point of
 * declaration using the following syntax:
 * \code
 * int X[] = {1, 2, 3, 4}, Y[]={10, 10}; // 2 arrays
 * int matrix[][] = {{1, 2, 3}, {4, 5, 6}};
 * \endcode
 * The elements of an array are identified by their position within the array
 * (called an index). The first element has an index of 0, the second has
 * index 1, and so on. For example:
 * \code
 * my_array[0] = 123; // set first element to 123
 * my_array[1] = my_array[2]; // copy third into second
 * \endcode
 * SPC also supports specifying an initial size for both global and local
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
 * }
 * \endcode
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
 * Here arg_type must be one of the types supported by SPC. Following the type
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
 * There are eleven different assignment operators. The most basic operator, '=', 
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
 * <tr><td>&gt;&gt;=</td><td>Right shift variable by expression</td></tr>
 * <tr><td>&lt;&lt;=</td><td>Left shift variable by expression</td></tr>
 * </table>
 * </center>
 * <center>Operators</center>
 * The code sample below shows a few of the different types of operators that
 * you can use in SPC expressions.
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
 * An SPC task or function usually contains a collection of nested control
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
 * constructs. SPC inherits this statement from NQC. The syntax is shown below.
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
 * 	 printf("%d\n", i++);
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
 * SPC also defines an until macro for compatibility with NQC. This construct
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
 * The asm statement is used to define many of the SPC API calls. The syntax of 
 * the statement is shown below.
 * \code
 * asm { 
 *  one or more lines of SPRO assembly language
 * }
 * \endcode
 * The statement simply emits the body of the statement as SuperPro
 * ASM code and passes it directly to the compiler's backend. The asm
 * statement can often be used to optimize code so that it executes as fast
 * as possible on the SuperPro firmware. The following example shows an asm block
 * containing variable declarations, labels, and basic SPRO ASM statements as well
 * as comments.
 * \code
 * asm { 
 *       MVI WORK2, 12
 *       MOV PTR, WORK2
 *       MOV (PTR), WORK1
 *       INC PTR
 * }
 * \endcode
 * The asm block statement and these special ASM keywords are used throughout
 * the SPC API. You can have a look at the SPCDefs.h header file for several
 * examples of how they are used. To keep the main SPC code as "C-like" as
 * possible and for the sake of better readability SPC asm block statements
 * can be wrapped in preprocessor macros and placed in custom header files
 * which are included using \#include.
 *
 */

/** @page otherst Other SPC Statements
 * \brief
 *
 * SPC supports a few other statement types.  The other SPC statements
 * are described below.
 *
 * - @subpage funccall
 * - @subpage start
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
 * with both the standard and enhanced NBC/SPC firmwares.  The resulting
 * operation is a native opcode in the enhanced firmware but it requires
 * special compiler-generated subroutines in order to work with the standard
 * firmware.
 * \code
 * start task_name;
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
 * SPC supports something called "short-circuit" evaluation of conditions. This
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
 * <center>Conditions</center>
 * There are also two special constant conditions which can be used anywhere
 * that the above conditions are allowed.  They are listed below.
 *
 * - @subpage true
 * - @subpage false
 *
 * You can use conditions in SPC control structures, such as the if-statement
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
 * SPC programs can begin with \#include "NXCDefs.h" but they don't need to.
 * This standard header file includes many important constants and macros,
 * which form the core SPC API. SPC no longer require that you manually include
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
 * <center>Conditional compilation directives</center>
 *
 * See the SPCDefs.h header files for many examples of how to
 * use conditional compilation.
 *
 */

/** @page pragma Pragmas
 * \brief
 *
 * The '#pragma' directive is the method specified by the C standard for
 * providing additional information to the compiler, beyond what is conveyed
 * in the language itself. A C compiler is free to attach any meaning it
 * likes to pragmas.
 *
 * In SuperPro C the only pragma that has any significant meaning is 'autostart'.
 *
 * \code
 * #pragma autostart
 * \endcode
 *
 * The autostart instruction tells the compiler to modify the generated 
 * executable so that it automatically starts running whenever the SuperPro is
 * powered on.
 *
 */

/** @page presysconst Pre-defined system constants
 * Pre-defined system constants for directly interacting with the SuperPro hardware.
 *
 * The spmem.h header file uses system constants to define names for the
 * I/O mapped memory addresses of the SuperPro board you are targetting.
 * A complete list of these system constants appears below:
 *
 * - @subpage adchannels
 * - @subpage din
 * - @subpage dout
 * - @subpage dctrl
 * - @subpage sctrl
 * - @subpage timers
 * - @subpage sincnt
 * - @subpage sinbyte
 * - @subpage soutcnt
 * - @subpage soutbyte
 * - @subpage dacmode
 * - @subpage dacfreq
 * - @subpage dacvolt
 * - @subpage ledctrl
 * - @subpage sysclk
 * - @subpage sharedmem
 *
 */

/** @page adchannels ADChannel0/1/2/3
 * \brief
 *
 * These variables return the voltage on pins A0/1/2/3 as a value in the range
 * 0 - 1023. This range of values represents a voltage range of 0 - 3.3 volts,
 * or ~3.222 mV per step.
 *
 * \code
 * //convert channel 0 reading to millivolts
 * int voltage = ( ADChannel0 * 3222 ) / 1000 ;
 * \endcode
 *
 */

/** @page din DigitalIn
 * \brief
 *
 * This variable returns the current state of the 8 digital lines, B0 - B7.
 * This includes the state of any of the lines which are configured as outputs.
 *
 * \code
 * if ( DigitalIn & DIGI_PIN7 == DIGI_PIN7 )  //check if bit 7 set
 * {
 *   // do something here
 * }
 * \endcode
 *
 */

/** @page dout DigitalOut
 * \brief
 *
 * This variable sets the current state of any of the 8 digital lines, B0 - B7
 * which are set as outputs. See \ref DigitalPinConstants.
 *
 * \code
 * DigitalOut = DIGI_PIN0 ;   //set B0
 * \endcode
 *
 */

/** @page dctrl DigitalControl
 * \brief
 *
 * This variable defines which of the 8 digital lines, B0 - B7, are set as
 * outputs. If the corresponding bit in 1, the line is configured as an
 * output, else it will be an input.  See \ref DigitalPinConstants.
 *
 * \code
 * DigitalControl = 0x0F ;   //set DIGI_PIN0 - DIGI_PIN3 as outputs
 * \endcode
 *
 */

/** @page sctrl StrobeControl
 * \brief
 *
 * This variable allows control over the 6 strobe lines. See \ref
 * StrobeCtrlConstants.
 *
 * <center>
 * <table>
 * <tr><th>D31-D6</th><th>D5</th><th>D4</th><th>D3</th><th>D2</th><th>D1</th><th>D0</th></tr>
 * <tr><td>-</td><td>WR</td><td>RD</td><td>S3</td><td>S2</td><td>S1</td><td>S0</td></tr>
 * </table>
 * </center>
 * <center>Strobe Lines</center>
 *
 * There are 4 general purpose outputs, S0 - S3. These 4 lines may be used as
 * digital outputs. There are 2 special purpose outputs, RD and WR. These lines
 * are automatically activated when DigitalIn is read or DigitalOut is written.
 * When DigitalIn is read, the RD output will pulse for about 10 S. If the
 * StrobeControl RD bit is 0, the RD output will pulse high, if the bit is 1,
 * the output will pulse low.
 *
 * \image html strobe1.png
 * \image rtf strobe1.png
 * \image latex strobe1.png
 *
 * The timing for a read.
 * An external device which is relying on the RD strobe output for
 * synchronizing with the SuperPro hardware may use the leading edge of the
 * RD strobe to present data on B0 - B7. The device must have the data ready
 * within 9 microseconds of the start (leading edge) of the RD strobe.
 * The timing for a write.
 *
 * \image html strobe2.png
 * \image rtf strobe2.png
 * \image latex strobe2.png
 *
 * An external device which is relying on the WR strobe output for
 * synchronizing with the SuperPro hardware may use the leading edge of the WR
 * strobe as either an edge type clock or a latch type due to the data being
 * presented on B0 - B7 at least 1 microsecond before the strobe is active
 * until 1 microsecond after.
 *
 * \code
 * DigitalControl = 0xFF ;   //set B0 - B7 as outputs
 * DigitalOut = outputbyte ;
 * DigitalControl = 0x00 ;   //reset B0 - B7 to inputs
 * \endcode
 *
 * \image html strobe3.png
 * \image rtf strobe3.png
 * \image latex strobe3.png
 *
 * In a typical example of using the strobes to use the B0-7 bus
 * bi-directionally:
 *
 * \code
 * StrobeControl = 0x10 ; //set RD active low and WR active high
 * DigitalControl = 0x00 ;   //ensure outputs are inactive
 * // ...
 * datain = DigitalIn ; //read DATAIN byte
 * // ...
 * DigitalControl = 0xFF ;   //set B0 - B7 as outputs
 * DigitalOut = dataout ;    //write DATAOUT byte
 * DigitalControl = 0x00 ;   //reset B0 - B7 to inputs
 * \endcode
 *
 */

/** @page timers Timer0/1/2/3
 * \brief
 *
 * The timers are count-down and halt at zero types. They count down at the
 * rate of 1000 counts per second, i.e., one count per millisecond.
 *
 * \code
 * Timer1 = 1000 ;  //set timer1 to run for 1 second
 * while ( Timer1 != 0 ) ;   /wait for timer1 to expire
 * \endcode
 *
 */

/** @page sincnt SerialInCount
 * \brief
 *
 * The SerialInCount returns the number of characters waiting in an input
 * FIFO (First In, First Out) buffer of up to 255 entries. Characters can be
 * transferred from the host PC to the SuperPro via a terminal emulation
 * program running at 115200bps, 8 bits, no parity. A program can wait for a
 * character to become available using this value.
 *
 * \code
 * while ( SerialInCount == 0 ) ; //wait for a character
 * \endcode
 *
 */

/** @page sinbyte SerialInByte
 * \brief
 *
 * The SerialInByte returns the character waiting in the input FIFO receive
 * queue. A program should wait for a character to become available before
 * performing a read from SerialInByte. The result of reading from an empty
 * FIFO receive queue is unpredictable.
 *
 * \code
 * while ( SerialInCount == 0 ) ; //wait for a character
 * kbchar = SerialInByte ;  //get it
 * \endcode
 *
 */

/** @page soutcnt SerialOutCount
 * \brief
 *
 * The SerialOutCount returns the number of characters waiting in an output
 * FIFO send queue of 255 entries. Characters from the output FIFO are
 * transferred to the host PC at approximately 10,000 per second. If the
 * program is generating characters at a rate greater than this, the output
 * FIFO will start to fill up. This state can be checked by the program by
 * comparing the count with SERIAL_BUFFER_SIZE. In the event that this check
 * is not performed, no data will be lost since the program will stall
 * waiting for space to become available in the FIFO.
 *
 * \code
 * while ( SerialOutCount > 254 ) ; //wait for space for a character
 * \endcode
 *
 */

/** @page soutbyte SerialOutByte
 * \brief
 *
 * The SerialOutByte sends a character to the output FIFO send queue. The result
 * of writing to a full FIFO send queue is to cause the program to stall. The
 * send queue can hold up to 255 bytes.
 *
 * \code
 * while ( SerialOutCount > 254 ) ; //wait for space for a character
 * SerialOutByte = 'C' ;  //send a byte
 * \endcode
 *
 */

/** @page dacmode DAC0Mode/DAC1Mode
 * \brief
 *
 * The DACnMode controls the operation of the analog output pins O0/O1.
 * The following modes are available for use:
 * <center>
 * <table>
 * <tr><th>Mode</th><th>Value</th><th>Function</th></tr>
 * <tr><td>DAC_MODE_DCOUT</td><td>0</td><td>Steady (DC) voltage output</td></tr>
 * <tr><td>DAC_MODE_SINEWAVE</td><td>1</td><td>Sine wave output</td></tr>
 * <tr><td>DAC_MODE_SQUAREWAVE</td><td>2</td><td>Square wave output</td></tr>
 * <tr><td>DAC_MODE_SAWPOSWAVE</td><td>3</td><td>Positive going sawtooth output</td></tr>
 * <tr><td>DAC_MODE_SAWNEGWAVE</td><td>4</td><td>Negative going sawtooth output</td></tr>
 * <tr><td>DAC_MODE_TRIANGLEWAVE</td><td>5</td><td>Triangle wave output</td></tr>
 * <tr><td>DAC_MODE_PWMVOLTAGE</td><td>6</td><td>PWM square wave output</td></tr>
 * <tr><td>DAC_MODE_RESTART_MASK</td><td>0x80</td><td>Restart waveform mask</td></tr>
 * </table>
 * </center>
 * <center>Analog Output Modes</center>
 *
 * Mode DAC_MODE_DCOUT uses the DACnVoltage to control the output voltage
 * between 0 and 3.3 volts in steps of 3.222 mV.
 *
 * The waveforms associated with modes DAC_MODE_SINEWAVE, DAC_MODE_SQUAREWAVE,
 * DAC_MODE_SAWPOSWAVE, DAC_MODE_SAWNEGWAVE, and DAC_MODE_TRIANGLEWAVE are
 * centered around a DC offset of 1.65 volts. The DACnVoltage controls the
 * amplitude from +/- 0 to +/- 1.65 volts.
 *
 * The waveform associated with mode DAC_MODE_PWMVOLTAGE is a rectangular
 * waveform switching between 0 and 3.3 volts. The DACnVoltage controls the
 * mark to space ratio between 0% and 100%. The average DC value of this
 * waveform thus varies from 0 to 3.3 volts.
 *
 * \code
 * DAC0Mode = DAC_MODE_PWMVOLTAGE; // use PWM output
 * DAC0Frequency = 4000; // 4khz frequency.
 * DAC0Voltage = 512; // mark/space ratio = 50%
 * \endcode
 *
 * As of firmware version 2.3 the waveform generator has been improved to
 * provide:
 *
 * - Seamless change in output frequency if the generator is already running.
 * - Start of waveform generation will start from the beginning of the wave
 * table. When the DAC0/DAC1 Mode bytes are changed from 0x00 to a non zero
 * number, the waveform generation will start from the start of the wave
 * table.
 * - A frequency value of zero is interpreted as a DC output of 1.65v, the
 * center offset value used for waveform output.
 * - Addition of bit 7 of the DAC0/DAC1 Mode bytes to signify force waveform
 * generation from the beginning of the wave table. If the Mode byte is
 * written with bit 7 set, i.e., 0x81 for a sine wave, then the wave table
 * pointer will reset to the start of the table. Once this reset has been
 * performed, the 7 bit will be cleared.
 * - Immediate cessation of waveform generation when the DAC0/DAC1 Mode bytes
 * are set to 0x00. The previous firmware version would inadvertently insert
 * a 0 - 4mS dead time when the DAC0/DAC1 Mode bytes were changed to 0x00.
 * The reaction is now a few microseconds instead.
 *
 */

/** @page dacfreq DAC0Frequency/DAC1Frequency
 * \brief
 *
 * The DACnFrequency controls the generator frequency for the analog output
 * pins O0/O1 for DACnModes DAC_MODE_SINEWAVE, DAC_MODE_SQUAREWAVE,
 * DAC_MODE_SAWPOSWAVE, DAC_MODE_SAWNEGWAVE, DAC_MODE_TRIANGLEWAVE, and
 * DAC_MODE_PWMVOLTAGE. The available frequency range is 1 - 8000 Hz.
 *
 * \code
 * DAC0Mode = DAC_MODE_SINEWAVE; // use sine wave output
 * DAC0Frequency = 4000; // 4khz frequency.
 * DAC0Voltage = 1024; // full range amplitude
 * \endcode
 *
 */

/** @page dacvolt DAC0Voltage/DAC1Voltage
 * \brief
 *
 * The DACnVoltage controls the output voltage levels for the analog output
 * pins O0/O1.
 *
 * DACnMode DAC_MODE_DCOUT uses the DACnVoltage to control the output voltage
 * between 0 and 3.3 volts in steps of 3.222 mV.
 *
 * For DACnModes DAC_MODE_SINEWAVE, DAC_MODE_SQUAREWAVE, DAC_MODE_SAWPOSWAVE,
 * DAC_MODE_SAWNEGWAVE, and DAC_MODE_TRIANGLEWAVE, the DACnVoltage controls the
 * amplitude from +/- 0 to +/- 1.65 volts.
 *
 * For DACnMode DAC_MODE_PWMVOLTAGE, DACnVoltage controls the mark to space
 * ratio between 0% and 100%. The average DC value of this waveform thus varies
 * from 0 to 3.3 volts.
 *
 * \code
 * DAC0Mode = DAC_MODE_DCOUT; // DC ouput voltage
 * DAC0Voltage = 500; // set voltage level of O0 to 500*3.222 mV
 * \endcode
 *
 */

/** @page ledctrl LEDControl
 * \brief
 *
 * The LEDControl location can be used to turn two on-board LEDs on and off.
 * Bit 0 controls the state of a red LED, while bit 1 controls a blue LED.
 *
 * \code
 * LEDControl = LED_BLUE | LED_RED; // turn on both the blue and red LEDs
 * \endcode
 *
 */

/** @page sysclk SystemClock
 * \brief
 *
 * The SystemClock returns the number of milliseconds since power was
 * applied to the SuperPro board.
 *
 * \code
 * long x = SystemClock;
 * \endcode
 *
 */

/** @page sharedmem Shared Memory
 * \brief
 *
 * There are 32 shared memory locations on the SuperPro board which can be
 * accessed remotely via I2C using a device like the NXT. They are named
 * \ref SharedMem01 through \ref SharedMem32. If you write 4 bytes to I2C
 * address 0x80 these bytes can be read as a signed long value in SuperPro C
 * at address 0x20 (SharedMem01).  
 *
 * \code
 * long x = SharedMem01;
 * SharedMem32 = ADChannel0;
 * \endcode
 *
 */

/** @defgroup MiscConstants Miscellaneous constants
 * Miscellaneous constants for use in SPC.
 *
 */

/** @defgroup presysconstgrp Pre-defined System constants
 * Pre-defined system constants for use in SuperPro C to read or
 * read/write all of the SuperPro hardware capabilities.
 *
 */

/** @defgroup sharedmemgrp Pre-defined shared memory constants
 * Pre-defined shared memory constants for use in SuperPro C to
 * read/write addresses in SuperPro memory that are shared with the
 * I2C address space. This allows for an external device to send data to or
 * receive data from a SuperPro program while it is executing using the
 * I2C communication layer.
 *
 */

/** @defgroup DacModeConstants Analog output mode constants
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
 *
 * \sa DAC0Mode, DAC1Mode
 */

/** @defgroup LEDCtrlConstants LED control constants
 * Constants for controlling the 2 onboard LEDs.
 *
 * \sa LEDControl
 */

/** @defgroup DigitalPinConstants Digital pin constants
 * Constants for controlling the 8 digital pins.
 *
 * The eight digital inputs are returned as a byte representing the state
 * of the eight inputs. The eight digital outputs are controlled by two bytes,
 * the first of which sets the state of any of the signals which have been
 * defined as outputs and the second of which controls the input/output
 * state of each signal.
 *
 * \sa DigitalControl
 */

/** @defgroup StrobeCtrlConstants Strobe control constants
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
 *
 * \sa StrobeControl
 */

/////////////////////////////////////////////////////////////////////////////
////////////////////////////  EXAMPLES  /////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

/**
 * \example ex_CurrentTick.spc
 * This is an example of how to use the \ref CurrentTick function.
 *
 * \example ex_wait.spc
 * This is an example of how to use the \ref Wait function.
 *
 * \example ex_yield.spc
 * This is an example of how to use the \ref Yield function.
 *
 * \example ex_StopAllTasks.spc
 * This is an example of how to use the \ref StopAllTasks function.
 *
 * \example ex_Stop.spc
 * This is an example of how to use the \ref Stop function.
 *
 * \example ex_exitto.spc
 * This is an example of how to use the \ref ExitTo function.
 *
 * \example ex_StartTask.spc
 * This is an example of how to use the \ref StartTask function.
 *
 * \example ex_read.spc
 * This is an example of how to use the \ref read function.
 *
 * \example ex_write.spc
 * This is an example of how to use the \ref write function.
 *
 * \example ex_sqrt.spc
 * This is an example of how to use the \ref sqrt function.
 *
 * \example ex_sign.spc
 * This is an example of how to use the \ref sign function.
 *
 * \example ex_close.spc
 * This is an example of how to use the \ref close function.
 *
 * \example ex_open.spc
 * This is an example of how to use the \ref open function.
 *
 * \example ex_putchar.spc
 * This is an example of how to use the \ref putchar function.
 *
 * \example ex_puts.spc
 * This is an example of how to use the \ref puts function.
 *
 * \example ex_printf.spc
 * This is an example of how to use the \ref printf function.
 *
 * \example ex_abort.spc
 * This is an example of how to use the \ref abort function.
 *
 * \example ex_abs.spc
 * This is an example of how to use the \ref abs function.
 *
 * \example ex_isupper.spc
 * This is an example of how to use the \ref isupper function.
 *
 * \example ex_islower.spc
 * This is an example of how to use the \ref islower function.
 *
 * \example ex_isalpha.spc
 * This is an example of how to use the \ref isalpha function.
 *
 * \example ex_isdigit.spc
 * This is an example of how to use the \ref isdigit function.
 *
 * \example ex_isalnum.spc
 * This is an example of how to use the \ref isalnum function.
 *
 * \example ex_isspace.spc
 * This is an example of how to use the \ref isspace function.
 *
 * \example ex_iscntrl.spc
 * This is an example of how to use the \ref iscntrl function.
 *
 * \example ex_isprint.spc
 * This is an example of how to use the \ref isprint function.
 *
 * \example ex_isgraph.spc
 * This is an example of how to use the \ref isgraph function.
 *
 * \example ex_ispunct.spc
 * This is an example of how to use the \ref ispunct function.
 *
 * \example ex_isxdigit.spc
 * This is an example of how to use the \ref isxdigit function.
 *
 * \example ex_toupper.spc
 * This is an example of how to use the \ref toupper function.
 *
 * \example ex_tolower.spc
 * This is an example of how to use the \ref tolower function.
 *
 * \example ex_ctype.spc
 * This is an example of how to use the ctype API functions: \ref isupper, \ref islower, \ref isalpha,
 * \ref isdigit, \ref isalnum, \ref isspace, \ref iscntrl, \ref isprint,
 * \ref isgraph, \ref ispunct, \ref isxdigit, \ref toupper, and \ref tolower.
 *
 * \example ex_SizeOf.spc
 * This is an example of how to use the \ref SizeOf function.
 *
 * \example ex_pushpop.spc
 * This is an example of how to use the \ref push and \ref pop functions.
 *
 * \example ex_rotate.spc
 * This is an example of how to use the \ref RotateLeft and \ref RotateRight
 * functions.
 *
 * \example ex_run.spc
 * This is an example of how to use the \ref Run function.
 *
 * \example ex_stat.spc
 * This is an example of how to use the \ref stat function.
 *
 * \example ex_StopProcesses.spc
 * This is an example of how to use the \ref StopProcesses function.
 *
 * \example ex_systemclock.spc
 * This is an example of how to use the \ref SystemClock system constant
 * as well as the \ref Wait and \ref printf functions.
 *
 * \example ex_ledcontrol.spc
 * This is an example of how to use the \ref LEDControl system constant
 * as well as the \ref Wait function.
 *
 * \example ex_serialout.spc
 * This is an example of how to use the \ref SerialOutCount and
 * \ref SerialOutByte system constants as well as the \ref Wait and
 * \ref printf functions.
 *
 * \example ex_DAC0ToA3.spc
 * This is an example of how to use the \ref DAC0Mode, \ref DAC0Frequency,
 * \ref DAC0Voltage, and \ref ADChannel3 system constants as well as the
 * \ref Wait and \ref printf functions.
 *
 * \example ex_timer.spc
 * This is an example of how to use the \ref Timer0, \ref Timer1, \ref Timer2,
 * and \ref Timer3 system constants. It also is an example of how to use the
 * \ref Wait and \ref printf functions.
 *
 * \example ex_arrays.spc
 * This is an example of how to use the \ref Wait and \ref printf functions.
 *
 * \example t1.spc
 * This is an example of how to use the \ref puts and \ref Wait functions.
 *
 * \example ex_TwinkleL.spc
 * This is an example of how to use the \ref DAC1Mode, \ref DAC1Frequency,
 * \ref DAC1Voltage, and \ref SharedMem01 system constants. It is also an
 * example of how to use the \ref Wait function.
 *
 * \example ex_Twinkle.spc
 * This is an example of how to use the \ref DAC1Mode, \ref DAC1Frequency,
 * and \ref DAC1Voltage system constants. It is also an
 * example of how to use the \ref Wait function.
 *
 * \example ex_digiserial.spc
 * This is an example of how to use the \ref DigitalControl, \ref DigitalOut,
 * \ref Timer0, \ref ADChannel0, \ref ADChannel1, \ref SerialInCount,
 * and \ref SerialInByte system constants. It is also an example of how to use
 * the \ref printf, \ref puts, and \ref Wait functions.
 *
 * \example ex_ledtest.spc
 * This is an example of how to use the \ref DigitalControl, \ref DigitalOut,
 * \ref Timer0, \ref ADChannel0, and \ref ADChannel1 system constants.
 *
 * \example ref_params.spc
 * This is an example of using reference parameter types.
 *
 * \example if_test.spc
 * This is a test of boolean and logic.
 *
 * \example arrays.spc
 * This is a test of structures and arrays.
 *
 */

/*
*/

#include "SPCDefs.h"

#endif // SPCAPIDOCS_H
