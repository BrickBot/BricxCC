/** \file NBCAPIDocs.h
 * \brief Additional documentation for the NBC API
 *
 * NBCAPIDocs.h contains additional documentation for the NBC API
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
 * Portions created by John Hansen are Copyright (C) 2009-2010 John Hansen.
 * All Rights Reserved.
 *
 * ----------------------------------------------------------------------------
 *
 * \author John Hansen (bricxcc_at_comcast.net)
 * \date 2010-05-29
 * \version 1
 */
#ifndef NBCAPIDOCS_H
#define NBCAPIDOCS_H

/** @mainpage NBC Programmer's Guide
 * \brief
 * 
 * <h2><center>May 29, 2010</center></h2>
 * <h2><center>by John Hansen</center></h2>
 * 
 * - @subpage intro
 * - @subpage lang
 *
 */

/** @page intro Introduction
 * \brief Introduction
 * 
 * NBC stands for NeXT Byte Codes. It is a simple language for programming the
 * LEGO MINDSTORMS NXT product. The NXT has a byte-code interpreter (provided
 * by LEGO), which can be used to execute programs. The NBC compiler translates
 * a source program into LEGO NXT byte-codes, which can then be executed on the
 * NXT itself. Although the preprocessor and format of NBC programs are similar
 * to assembly, NBC is not a general-purpose assembly language - there are many
 * restrictions that stem from limitations of the LEGO byte-code interpreter.
 * 
 * Logically, NBC is defined as two separate pieces. The NBC language describes
 * the syntax to be used in writing programs. The NBC Application Programming
 * Interface (API) describes the system functions, constants, and macros that
 * can be used by programs. This API is defined in a special file known as a
 * "header file" which is automatically included at the beginning of any NBC
 * program.
 *
 * This document describes both the NBC language and the NBC API. In short, it
 * provides the information needed to write NBC programs. Since there are
 * different interfaces for NBC, this document does not describe how to use any
 * specific NBC implementation (such as the command-line compiler or Bricx
 * Command Center). Refer to the documentation provided with the NBC tool, such
 * as the NBC User Manual, for information specific to that implementation.
 *
 * For up-to-date information and documentation for NBC, visit the NBC website
 * at http://bricxcc.sourceforge.net/nbc/.
 *
 */

/** @page lang The NBC Language
 * \brief The NBC Language
 * 
 * This section describes the NBC language itself. This includes the lexical
 * rules used by the compiler, the structure programs, statements, and
 * expressions, and the operation of the preprocessor.
 * 
 * Unlike some assembly languages, NBC is a case-sensitive language.  That
 * means that the identifier "xYz" is not the same identifier as "Xyz".
 * Similarly, the subtract statement begins with the keyword "sub" but "suB",
 * "Sub", or "SUB" are all just valid identifiers - not keywords.
 * 
 * - @subpage lexrules
 * - @subpage progstruct
 * - @subpage preproc
 * - @subpage comptok
 * - @subpage expreval
 * - @subpage statements
 *
 */

/** @page lexrules Lexical Rules
 * \brief Lexical Rules
 * 
 * The lexical rules describe how NBC breaks a source file into individual
 * tokens. This includes the way comments are written, then handling of
 * whitespace, and valid characters for identifiers.
 * 
 * - @subpage cmts
 * - @subpage wspace
 * - @subpage consts
 * - @subpage strch
 * - @subpage idkey
 *
 */

/** @page cmts Comments
 * \brief Comments
 * 
 * Three forms of comments are supported in NBC. The first form (traditional
 * C comments) begin with '/*' and end with '* /'. These comments are allowed
 * to span multiple lines, but they cannot be nested.
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
 * The second form of comments supported in NXBC begins with '//' and
 * continues to the end of the current line. These are sometimes known as
 * C++ style comments.
 * \code
 * // a single line comment
 * \endcode
 * The third form of comments begins with ; and ends with a newline. This form
 * is the traditional assembly language style comments.
 * \code
 * ; another single line comment
 * \endcode
 * As you might guess, the compiler ignores comments. Their only purpose is to
 * allow the programmer to document the source code.
 * 
 */

/** @page wspace Whitespace
 * \brief Whitespace
 * 
 * Whitespace consists of all spaces, tabs, and newlines. It is used to
 * separate tokens and to make a program more readable. As long as the tokens
 * are distinguishable, adding or subtracting whitespace has no effect on the
 * meaning of a program. For example, the following lines of code both have the
 * same meaning:
 * \code
 * set x,2
 * set   x,   2
 * \endcode
 * Generally, whitespace is ignored outside of string constants and constant
 * numeric expressions. However, unlike in C, NBC statements may not span
 * multiple lines.  Aside from pre-processor macros invocations, each statement
 * in an NBC program must begin and end on the same line.
 * \code
 * add x, x, 2 // okay
 * add x,      // error
 *     x, 2    // error
 * 
 * set x, (2*2)+43-12 // okay
 * set x, 2 * 2 // error (constant expression contains whitespace)
 * \endcode
 * The exception to this rule is if you end a line with the '\' character which
 * makes the NBC parser continue the current statement on the next line just
 * like with preprocessor macros.
 * \code
 * add x, \
 *     x, 2 // okay
 * \endcode
 *
 */

/** @page consts Numerical Constants
 * \brief Numerical Constants
 *
 * Numerical constants may be written in either decimal or hexadecimal form.
 * Decimal constants consist of one or more decimal digits. Decimal constants
 * may optionally include a decimal point along with one or more decimal digits
 * following the decimal point. Hexadecimal constants start with 0x or 0X
 * followed by one or more hexadecimal digits.
 * \code
 * set x, 10 // set x to 10
 * set x, 0x10 // set x to 16 (10 hex)
 * mov f, 1.5 // set f to 1.5
 * \endcode
 *
 */

/** @page strch String Constants
 * \brief String Constants
 * 
 * String constants in NBC are delimited with either single or double quote
 * characters. NBC represents a string as an array of bytes, with the last
 * byte in the array being a zero. The final zero byte is generally referred
 * to as the null terminator.
 * \code
 * TextOut(0, LCD_LINE1, 'testing')
 * \endcode
 *
 */

/** @page idkey Identifiers and Keywords
 * \brief Identifiers and Keywords
 *
 * Identifiers are used for variable, task, function, and subroutine names.
 * The first character of an identifier must be an upper or lower case letter
 * or the underscore ('_'). Remaining characters may be letters, numbers, and
 * underscores.
 *
 * A number of tokens are reserved for use in the NBC language itself. These
 * are called keywords and may not be used as identifiers. A complete list of
 * keywords appears below:
 *
 * <center>
 * <table>
 * <tr><td>add</td><td>sub</td><td>neg</td><td>mul</td></tr>
 * <tr><td>div</td><td>mod</td><td>and</td><td>or</td></tr>
 * <tr><td>xor</td><td>not</td><td>cmp</td><td>tst</td></tr>
 * <tr><td>index</td><td>replace</td><td>arrsize</td><td>arrbuild</td></tr>
 * <tr><td>arrsubset</td><td>arrinit</td><td>mov</td><td>set</td></tr>
 * <tr><td>flatten</td><td>unflatten</td><td>numtostr</td><td>strtonum</td></tr>
 * <tr><td>strcat</td><td>strsubset</td><td>strtoarr</td><td>arrtostr</td></tr>
 * <tr><td>jmp</td><td>brcmp</td><td>brtst</td><td>syscall</td></tr>
 * <tr><td>stop</td><td>exit</td><td>exitto</td><td>acquire</td></tr>
 * <tr><td>release</td><td>subcall</td><td>subret</td><td>setin</td></tr>
 * <tr><td>setout</td><td>getin</td><td>getout</td><td>wait</td></tr>
 * <tr><td>gettick</td><td>thread</td><td>\ref endt</td><td>subroutine</td></tr>
 * <tr><td>follows</td><td>precedes</td><td>segment</td><td>\ref ends</td></tr>
 * <tr><td>typedef</td><td>struct</td><td>db</td><td>byte</td></tr>
 * <tr><td>sbyte</td><td>ubyte</td><td>dw</td><td>word</td></tr>
 * <tr><td>sword</td><td>uword</td><td>dd</td><td>dword</td></tr>
 * <tr><td>sdword</td><td>udword</td><td>long</td><td>slong</td></tr>
 * <tr><td>ulong</td><td>void</td><td>mutex</td><td>waitv</td></tr>
 * <tr><td>call</td><td>return</td><td>abs</td><td>sign</td></tr>
 * <tr><td>strindex</td><td>strreplace</td><td>strlen</td><td>shl</td></tr>
 * <tr><td>shr</td><td>sizeof</td><td>compchk</td><td>compif</td></tr>
 * <tr><td>compelse</td><td>compend</td><td>&nbsp;</td><td>isconst</td></tr>
 * <tr><td>asl</td><td>asr</td><td>lsl</td><td>lsr</td></tr>
 * <tr><td>rotl</td><td>rotr</td><td>start</td><td>stopthread</td></tr>
 * <tr><td>priority</td><td>cmnt</td><td>fmtnum</td><td>compchktype</td></tr>
 * <tr><td>float</td><td>wait2</td><td>sqrt</td><td>waitv</td></tr>
 * <tr><td>arrop</td><td>acos</td><td>asin</td><td>atan</td></tr>
 * <tr><td>ceil</td><td>exp</td><td>floor</td><td>tan</td></tr>
 * <tr><td>tanh</td><td>cos</td><td>cosh</td><td>log</td></tr>
 * <tr><td>log10</td><td>sin</td><td>sinh</td><td>trunc</td></tr>
 * <tr><td>frac</td><td>atan2</td><td>pow</td><td>muldiv</td></tr>
 * <tr><td>acosd</td><td>asind</td><td>atand</td><td>tand</td></tr>
 * <tr><td>tanhd</td><td>cosd</td><td>coshd</td><td>sind</td></tr>
 * <tr><td>sinhd</td><td>atan2d</td><td>addrof</td><td>&nbsp;</td></tr>
 * </table>
 * </center>
 * 
 */

/** @page progstruct Program Structure
 * \brief Program Structure
 * 
 * An NBC program is composed of code blocks and global variables in data
 * segments. There are two primary types of code blocks: thread and
 * subroutines. Each of these types of code blocks has its own unique features
 * and restrictions, but they share a common structure.
 *
 * A third type of code block is the preprocessor macro function.  This code
 * block type is used throughout the NBC API.  Macro functions are the only
 * type of code block, which use a parameter passing syntax similar to what
 * you might see in a language like C or Pascal.
 *
 * Data segment blocks are used to define types and to declare variables.  An
 * NBC program can have zero or more data segments, which can be placed either
 * outside of a code block or within a code block.  Regardless of the location
 * of the data segment, all variables in an NBC program are global.
 * 
 * - @subpage thread
 * - @subpage subroutine
 * - @subpage macfunc
 * - @subpage dseg
 *
 */

/** @page thread Threads
 * \brief Threads
 * 
 * The NXT implicitly supports multi-threading, thus an NBC thread directly
 * corresponds to an NXT thread. Threads are defined using the thread keyword
 * with the following syntax:
 * \code
 * thread name
 *   // the thread's code is placed here
 * endt
 * \endcode
 * The name of the thread may be any legal identifier. A program must always
 * have at least one thread. If there is a thread named "main" then that thread
 * will be the thread that is started whenever the program is run. If none of
 * the threads are named "main" then the very first thread that the compiler
 * encounters in the source code will be the main thread. The maximum number of
 * threads supported by the NXT is 256.
 *
 * The body of a thread consists of a list of statements and optional data
 * segments. Threads may be started by scheduling dependant threads using the
 * \ref precedes or \ref follows statements. You may also start a thread using
 * the \ref start statement.  With the standard NXT firmware threads cannot be
 * stopped by another thread.  The only way to stop a thread is by stopping
 * all threads using the \ref stop statement or by a thread stopping on its own
 * via the \ref exit and \ref exitto statements. Using the NBC/NBC enhanced
 * firmware you can also stop another thread using the \ref stopthread
 * statement.
 * \code
 * thread main
 *   precedes waiter, worker
 *   // thread body goes here
 *   // finalize this thread and schedule the threads in the
 *   // specified range to execute
 *   exit // all dependants are automatically scheduled
 * endt
 *
 * thread waiter
 *   // thread body goes here
 * //  exit
 *   // exit is optional due to smart compiler finalization
 * endt
 *
 * thread worker
 *   precedes waiter
 *   // thread body goes here
 *   exit // only one dependent – schedule it to execute
 * endt
 * \endcode
 *
 */

/** @page subroutine Subroutines
 * \brief Subroutines
 *
 * Subroutines allow a single copy of some code to be shared between several
 * different callers. This makes subroutines much more space efficient than
 * macro functions. Subroutines are defined using the subroutine keyword with
 * the following syntax:
 * \code
 * subroutine name
 *   // body of subroutine
 *   return // subroutines must end with a return statement
 * ends
 * \endcode
 * A subroutine is just a special type of thread that is designed to be called
 * explicitly by other threads or subroutines.  Its name can be any legal
 * identifier.  Subroutines are not scheduled to run via the same mechanism
 * that is used with threads.  Instead, subroutines and threads execute other
 * subroutines by using the \ref call statement (described in the
 * \ref statements section).
 * \code
 * thread main
 *   // body of main thread goes here
 *   call mySub // compiler handles subroutine return address
 *   exit // finalize execution (details handled by the compiler)
 * endt
 *
 * subroutine mySub
 *   // body of subroutine goes here 
 *   return // compiler handles the subroutine return address
 * ends
 * \endcode
 * You can pass arguments into and out of subroutines using global variables.
 * If a subroutine is designed to be used by concurrently executing threads
 * then calls to the subroutine must be protected by acquiring a mutex prior
 * to the subroutine call and releasing the mutex after the call.
 *
 * You can also call a thread as a subroutine using a slightly different
 * syntax.  This technique is required if you want to call a subroutine which
 * executes two threads simultaneously.  The \ref subcall and \ref subret
 * statements must be used instead of \ref call and \ref return.  You also must
 * provide a global variable to store the return address as shown in the sample
 * code below.
 * \code
 * thread main
 *   // thread body goes here
 *   acquire ssMutex
 *   call SharedSub // automatic return address
 *   release ssMutex
 *   // calling a thread as a subroutine
 *   subcall AnotherSub, anothersub_returnaddress
 *   exit
 * endt
 *
 * subroutine SharedSub
 *   // subroutine body goes here
 *   return // return is required as the last operation
 * ends
 *
 * thread AnotherSub
 *   // threads can be subroutines too
 *   subret anothersub_returnaddress // manual return address
 * endt
 * \endcode
 * After the subroutine completes executing, it returns back to the calling
 * routine and program execution continues with the next statement following
 * the subroutine call. The maximum number of threads and subroutines supported
 * by the NXT firmware is 256.
 *
 */

/** @page macfunc Macro Functions
 * \brief Macro Functions
 *
 * It is often helpful to group a set of statements together into a single
 * function, which can then be called as needed. NBC supports macro functions
 * with arguments. Values may be returned from a macro function by changing the
 * value of one or more of the arguments within the body of the macro function.
 *
 * Macro functions are defined using the following syntax:
 * \code
 * #define name(argument_list) \
 *   // body of the macro function \
 *   // last line in macro function body has no '\' at the end
 * \endcode
 *
 * Please note that the newline escape character ('\') must be the very last
 * character on the line.  If it is followed by any whitespace or comments then
 * the macro body is terminated at that point and the next line is not
 * considered to be part of the macro definition.
 *
 * The argument list may be empty, or it may contain one or more argument
 * definitions. An argument to a macro function has no type. Each argument is
 * simply defined by its name. Multiple arguments are separated by commas.
 * Arguments to a macro function can either be inputs (constants or variables)
 * for the code in the body of the function to process or they can be outputs
 * (variables only) for the code to modify and return. The following sample
 * shows how to define a macro function to simplify the process of drawing text
 * on the NXT LCD screen:
 * \code
 * #define MyMacro(x, y, berase, msg) \
 *   mov dtArgs.Location.X, x \
 *   mov dtArgs.Location.Y, y \
 *   mov dtArgs.Options, berase \
 *   mov dtArgs.Text, msg \
 *   syscall DrawText, dtArgs
 *
 * MyMacro(0, 0, TRUE, 'testing')
 * MyMacro(10, 20, FALSE, 'Please Work')
 * \endcode
 *
 * NBC macro functions are always expanded inline by the NBC preprocessor. This
 * means that each call to a macro function results in another copy of the
 * function's code being included in the program. Unless used judiciously,
 * inline macro functions can lead to excessive code size.
 *
 */

/** @page dseg Data Segments
 * \brief Data Segments
 *
 * Data segments contain all type definitions and variable declarations. Data
 * segments are defined using the following syntax:
 * \code
 * dseg segment
 *   // type definitions and variable declarations go here
 * dseg ends
 *
 * thread main
 *   dseg segment
 *     // or here - still global, though
 *   dseg ends
 * endt
 * \endcode
 *
 * You can have multiple data segments in an NBC program. All variables are
 * global regardless of where they are declared. Once declared, they may be
 * used within all threads, subroutines, and macro functions. Their scope
 * begins at the declaration and ends at the end of the program.
 *
 * - @subpage typedef
 * - @subpage struct
 * - @subpage vardecl
 *
 */

/** @page typedef Type Definitions
 * \brief Type Definitions
 *
 * Type definitions must be contained within a data segment. They are used to
 * define new type aliases or new aggregate types (i.e., structures). A type
 * alias is defined using the typedef keyword with the following syntax:
 * \code
 * type_alias typedef existing_type
 * \endcode
 *
 * The new alias name may be any valid identifier.  The existing type must be
 * some type already known by the compiler.  It can be a native type or a
 * user-defined type. Once a type alias has been defined it can be used in
 * subsequent variable declarations and aggregate type definitions. The
 * following is an example of a simple type alias definition:
 * \code
 * big typedef dword // big is now an alias for the dword type
 * \endcode
 *
 */

/** @page struct Structure Definitions
 * \brief Structure Definitions
 *
 * Structure definitions must also be contained within a data segment. They are
 * used to define a type which aggregates or contains other native or
 * user-defined types. A structure definition is defined using the struct and
 * ends keywords with the following syntax:
 * \code
 * TypeName struct
 *   x byte
 *   y byte
 * TypeName ends
 * \endcode
 *
 * Structure definitions allow you to manage related data in a single combined
 * type. They can be as simple or complex as the needs of your program dictate.
 * The following is an example of a fairly complex structure:
 * \code
 * MyPoint struct
 *   x byte
 *   y byte
 * MyPoint ends
 * ComplexStrut struct
 *   value1 big            // using a type alias
 *   value2 sdword
 *   buffer byte[]         // array of byte
 *   blen word
 *   extrastuff MyPoint[]  // array of structs
 *   pt_1 MyPoint          // struct contains struct instances
 *   pt_2 MyPoint
 * ComplexStruct ends
 * \endcode
 *
 */

/** @page vardecl Variable Declarations
 * \brief Variable Declarations
 *
 * All variable declarations must be contained within a data segment. They
 * are used to declare variables for use in a code block such as a thread,
 * subroutine, or macro function. A variable is declared using the
 * following syntax:
 * \code
 * var_name type_name optional_initialization
 * \endcode
 *
 * The variable name may be any valid identifier. The type name must be a type
 * or type alias already known by the compiler. The optional initialization
 * format depends on the variable type, but for non-aggregate (scalar) types
 * the format is simply a constant integer or constant expression (which may
 * not contain whitespace).  See the examples later in this section.
 *
 * The NXT firmware supports several different types of variables which are
 * grouped into two categories: scalar types and aggregate types. Scalar types
 * are a single integer value which may be signed or unsigned and occupy one,
 * two, or four bytes of memory. The keywords for declaring variables of a
 * scalar type are listed in the following table:
 *
 * <center>
 * <table>
 * <tr><th>Type Name</th><th>Information</th></tr>
 * <tr><td>@subpage byte, @subpage ubyte, @subpage db</td><td>8 bit unsigned</td></tr>
 * <tr><td>@subpage sbyte</td><td>8 bit signed</td></tr>
 * <tr><td>@subpage word, @subpage uword, @subpage dw</td><td>16 bit unsigned</td></tr>
 * <tr><td>@subpage sword</td><td>16 bit signed</td></tr>
 * <tr><td>@subpage dword, @subpage udword, @subpage dd</td><td>32 bit unsigned</td></tr>
 * <tr><td>@subpage sdword</td><td>32 bit signed</td></tr>
 * <tr><td>@subpage long, @subpage ulong</td><td>32 bit unsigned (alias for dword, udword)</td></tr>
 * <tr><td>@subpage slong</td><td>32 bit signed (alias for sdword)</td></tr>
 * <tr><td>@subpage float</td><td>32 bit IEEE 754 floating point type</td></tr>
 * <tr><td>@subpage mutex</td><td>Special type used for exclusive subroutine access</td></tr>
 * </table>
 * </center>
 * <center>Table 1. Scalar Types</center>
 *
 * Examples of scalar variable declarations are as follow:
 * \code
 * dseg segment
 *   x byte            // initialized to zero by default
 *   y byte 12         // initialize to 12
 *   z sword -2048     // a signed value
 *   myVar big 0x12345 // use a type alias
 *   var1 dword 0xFF   // value is 255
 *   myMutex mutex     // mutexes ignore initialization, if present
 *   bTrue byte 1      // byte variables can be used as booleans
 * dseg ends
 * \endcode
 *
 * Aggregate variables are either structures or arrays of some other type
 * (either scalar or aggregate). Once a user-defined struct type has been
 * defined it may be used to declare a variable of that type. Similarly,
 * user-defined struct types can be used in array declarations.  Arrays and
 * structs may be nested (i.e., contained in other arrays or structures) as
 * deeply as the needs of your program dictate, but nesting deeper than 2 or 3
 * levels may lead to slower program execution due to NXT firmware memory
 * constraints.
 *
 * Examples of aggregate variable declarations are as follow:
 * \code
 * dseg segment
 *   buffer byte[] // starts off empty
 *   msg byte[] 'Testing'
 *   // msg is an array of byte =
 *   // (0x54, 0x65, 0x73, 0x74, 0x69, 0x6e, 0x67, 0x00)
 *   data long[] {0xabcde, 0xfade0} // two values in the array
 *   myStruct ComplexStruct // declare an instance of a struct
 *   Points MyPoint[] // declare an array of a structs
 *   msgs byte[][] // an array of an array of byte
 * dseg ends
 * \endcode
 *
 * Byte arrays may be initialized either by using braces containing a list of
 * numeric values ({val1, val2, ..., valN}) or by using a string constant
 * delimited with single-quote characters ('Testing'). Embedded single quote
 * characters must be escaped using the '\' character.  The '\' character can
 * be part of the string by using two forward slashes: '\\'.
 * Arrays of any scalar type other than byte
 * should be initialized using braces. Arrays of struct and nested arrays
 * cannot be initialized.
 *
 */

/** @page byte byte
 * \brief The byte type
 *
 * In NBC the byte type is an unsigned 8-bit value. This type can store values
 * from zero to \ref UCHAR_MAX. You can also define an unsigned 8-bit
 * variable using the \ref ubyte or \ref db keywords.
 * \code
 *  dseg segment
 *    x byte 12
 *    b ubyte 0xE2
 *    test db 0xa0
 *  dseg ends
 * \endcode
 */

/** @page ubyte ubyte
 * \brief The ubyte type
 *
 * In NBC the ubyte type is an unsigned 8-bit value. This type can store values
 * from zero to \ref UCHAR_MAX. You can also define an unsigned 8-bit
 * variable using the \ref byte or \ref db keywords.
 * \code
 *  dseg segment
 *    x byte 12
 *    b ubyte 0xE2
 *    test db 0xa0
 *  dseg ends
 * \endcode
 */

/** @page db db
 * \brief The db type
 *
 * In NBC the db type is an unsigned 8-bit value. This type can store values
 * from zero to \ref UCHAR_MAX. You can also define an unsigned 8-bit
 * variable using the \ref ubyte or \ref byte keywords.
 * \code
 *  dseg segment
 *    x byte 12
 *    b ubyte 0xE2
 *    test db 0xa0
 *  dseg ends
 * \endcode
 */

/** @page sbyte sbyte
 * \brief The sbyte type
 *
 * In NBC the sbyte type is a signed 8-bit value. This type can store values
 * from \ref SCHAR_MIN to \ref SCHAR_MAX.  The sbyte type is often used to store
 * the ASCII value of a single character.
 * \code
 *  dseg segment
 *    ch sbyte 12
 *  dseg ends
 * \endcode
 */

/** @page sword sword
 * \brief The sword type
 *
 * In NBC the sword type is a signed 16-bit value. This type can store values
 * from \ref INT_MIN to \ref INT_MAX.
 * \code
 *  dseg segment
 *    x sword 0xfff
 *    y sword -23
 *  dseg ends
 * \endcode
 */

/** @page word word
 * \brief The word type
 *
 * In NBC the word type is an unsigned 16-bit value. This type can store values
 * from zero to \ref UINT_MAX. You can also define an unsigned 16-bit
 * variable using the \ref uword or \ref dw keywords.
 * \code
 *  dseg segment
 *    x word  0xfff0
 *    y uword 62450
 *    z dw    48500
 *  dseg ends
 * \endcode
 */

/** @page uword uword
 * \brief The uword type
 *
 * In NBC the uword type is an unsigned 16-bit value. This type can store values
 * from zero to \ref UINT_MAX. You can also define an unsigned 16-bit
 * variable using the \ref word or \ref dw keywords.
 * \code
 *  dseg segment
 *    x word  0xfff0
 *    y uword 62450
 *    z dw    48500
 *  dseg ends
 * \endcode
 */

/** @page dw dw
 * \brief The dw type
 *
 * In NBC the dw type is an unsigned 16-bit value. This type can store values
 * from zero to \ref UINT_MAX. You can also define an unsigned 16-bit
 * variable using the \ref uword or \ref word keywords.
 * \code
 *  dseg segment
 *    x word  0xfff0
 *    y uword 62450
 *    z dw    48500
 *  dseg ends
 * \endcode
 */

/** @page slong slong
 * \brief The slong type
 *
 * In NBC the slong type is a signed 32-bit value. This type can store values
 * from \ref LONG_MIN to \ref LONG_MAX. You can also define a signed 32-bit
 * variable using the \ref sdword keywords.
 * \code
 *  dseg segment
 *    x slong 2147000000
 *    y sdword -88235
 *  dseg ends
 * \endcode
 */

/** @page sdword sdword
 * \brief The sdword type
 *
 * In NBC the sdword type is a signed 32-bit value. This type can store values
 * from \ref LONG_MIN to \ref LONG_MAX. You can also define a signed 32-bit
 * variable using the \ref slong keywords.
 * \code
 *  dseg segment
 *    x slong 2147000000
 *    y sdword -88235
 *  dseg ends
 * \endcode
 */

/** @page ulong ulong
 * \brief The ulong type
 *
 * In NBC the ulong type is an unsigned 32-bit value. The
 * range of values that can be stored in a ulong variable is from
 * zero to \ref ULONG_MAX. You can also define an unsigned 32-bit
 * variable using the \ref long, \ref dword, \ref udword, or \ref dd keywords.
 * \code
 *  dseg segment
 *    a ulong  0xdeadbeef
 *    b long   80000
 *    c dword  150000
 *    d udword 200000
 *    e dd     400000
 *  dseg ends
 * \endcode
 */

/** @page long long
 * \brief The long type
 *
 * In NBC the long type is an unsigned 32-bit value. The
 * range of values that can be stored in a ulong variable is from
 * zero to \ref ULONG_MAX.
 * \code
 *  dseg segment
 *    a ulong  0xdeadbeef
 *    b long   80000
 *    c dword  150000
 *    d udword 200000
 *    e dd     400000
 *  dseg ends
 * \endcode
 */

/** @page dword dword
 * \brief The dword type
 *
 * In NBC the dword type is an unsigned 32-bit value. The
 * range of values that can be stored in a ulong variable is from
 * zero to \ref ULONG_MAX.
 * \code
 *  dseg segment
 *    a ulong  0xdeadbeef
 *    b long   80000
 *    c dword  150000
 *    d udword 200000
 *    e dd     400000
 *  dseg ends
 * \endcode
 */

/** @page udword udword
 * \brief The udword type
 *
 * In NBC the udword type is an unsigned 32-bit value. The
 * range of values that can be stored in a ulong variable is from
 * zero to \ref ULONG_MAX.
 * \code
 *  dseg segment
 *    a ulong  0xdeadbeef
 *    b long   80000
 *    c dword  150000
 *    d udword 200000
 *    e dd     400000
 *  dseg ends
 * \endcode
 */

/** @page dd dd
 * \brief The dd type
 *
 * In NBC the dd type is an unsigned 32-bit value. The
 * range of values that can be stored in a ulong variable is from
 * zero to \ref ULONG_MAX.
 * \code
 *  dseg segment
 *    a ulong  0xdeadbeef
 *    b long   80000
 *    c dword  150000
 *    d udword 200000
 *    e dd     400000
 *  dseg ends
 * \endcode
 */

/** @page float float
 * \brief The float type
 *
 * In NBC the float type is a 32-bit IEEE 754 single precision floating point
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
 *  dseg segment
 *    pi float 3.14159
 *    e  float 2.71828
 *    s2 float 1.4142
 *  dseg ends
 * \endcode
 */

/** @page mutex mutex
 * \brief The mutex type
 *
 * In NBC the mutex type is a 32-bit value that is used to synchronize access
 * to resources shared across multiple threads.  For this reason there is
 * never a reason to declare a mutex variable inside a task or a subroutine.  It
 * is designed for global variables that all tasks or functions can
 * \ref acquire or \ref release in order to obtain exclusive access to a
 * resource that other tasks or functions are also trying to use.
 * \code
 *  dseg segment
 *    motorMutex mutex
 *  dseg ends
 *
 *  thread main
 *    acquire motorMutex
 *    // use the motor(s) protected by this mutex.
 *    release motorMutex
 *    wait MS_500
 *  endt
 * \endcode
 */

/** @page preproc The Preprocessor
 * \brief The Preprocessor
 *
 * NBC also includes a preprocessor that is modeled after the Standard C
 * preprocessor. The C preprocessor processes a source code file before the
 * compiler does. It handles such tasks as including code from other files,
 * conditionally including or excluding blocks of code, stripping comments,
 * defining simple and parameterized macros, and expanding macros wherever they
 * are encountered in the source code.
 *
 * The NBC preprocessor implements the following standard preprocessor
 * directives: \#include, \#define, \#ifdef, \#ifndef, \#endif, \#if, \#elif,
 * \#undef, \#\#, \#line, \#error, and \#pragma. It also supports two
 * non-standard directives: \#download and \#import. Its implementation is
 * close to a standard C preprocessor's, so most preprocessor directives should
 * work as C programmers expect in NBC. Any significant deviations are
 * explained below.
 *
 * - @subpage include
 * - @subpage define
 * - @subpage concat
 * - @subpage condcomp
 * - @subpage import
 * - @subpage download
 *
 */

/** @page include #include
 * \brief include
 *
 * The \#include command works as in Standard C, with the caveat that the
 * filename must be enclosed in double quotes. There is no notion of a system
 * include path, so enclosing a filename in angle brackets is forbidden.
 * \code
 * #include "foo.h"  // ok
 * #include <foo.h> // error!
 * \endcode
 * NBC programs can begin with \#include "NXTDefs.h" but they don't need to.
 * This standard header file includes many important constants and macros,
 * which form the core NBC API. NBC no longer requires that you manually
 * include the NXTDefs.h header file. Unless you specifically tell the compiler
 * to ignore the standard system files, this header file is included
 * automatically.
 *
 */

/** @page define #define
 * \brief define
 *
 * The \#define command is used for macro substitution. Redefinition of a macro
 * will result in a compiler warning.
 * \code
 * #define TurnTime 3000 // 3 seconds
 * \endcode
 * Macros are normally restricted to one line because the newline character at
 * the end of the line acts as a terminator. However, you can write multiline
 * macros by instructing the preprocessor to ignore the newline character. This
 * is accomplished by escaping the newline character with a backslash ('\\').
 * The backslash character must be the very last character in the line or it
 * will not extend the macro definition to the next line. The code sample below
 * shows how to write a multi-line preprocessor macro.
 * \code
 * #define square(x, result) \
 *   mul result, x, x 
 * \endcode
 * The \#undef directive may be used to remove a macro's definition.
 * 
 */

/** @page concat ## (Concatenation)
 * \brief Concatenation
 * 
 * The \#\# directive works similar to the C preprocessor. It is replaced by
 * nothing, which causes tokens on either side to be concatenated together.
 * Because it acts as a separator initially, it can be used within macro
 * functions to produce identifiers via combination with parameter values.
 * \code
 * #define ELEMENT_OUT(n) \
 *   NumOut(0, LCD_LINE##n, b##n)
 * 
 * dseg segment
 *   b1 byte
 *   b2 byte 1
 * dseg ends
 * 
 * thread main
 *   ELEMENT_OUT(1)
 *   ELEMENT_OUT(2)
 *   wait SEC_2
 * endt
 * \endcode
 * This is the same as writing
 * \code
 * dseg segment
 *   b1 byte
 *   b2 byte 1
 * dseg ends
 * 
 * thread main
 *   NumOut(0, LCD_LINE1, b1)
 *   NumOut(0, LCD_LINE2, b2)
 *   wait SEC_2
 * endt
 * \endcode
 * 
 */

/** @page condcomp Conditional Compilation
 * \brief Conditional Compilation
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
 * See the NXTDefs.h header files for many examples of how to use conditional
 * compilation.
 *
 */

/** @page import #import
 * \brief import
 *
 * The \#import directive lets you define a global byte array variable in your
 * NBC program that contains the contents of the imported file. Like \#include,
 * this directive is followed by a filename enclosed in double quote characters.
 * Following the filename you may optionally include a format string for
 * constructing the name of the variable you want to define using this
 * directive.
 * \code
 * #import "myfile.txt" data
 * \endcode
 * By default, the format string is %s which means that the name of the file
 * without any file extension will be the name of the variable. For instance,
 * if the format string "data" were not specified in the example above, then
 * the name of the byte array variable would be "myfile". In this case the name
 * of the byte array variable will be "data".
 *
 * The \#import directive is often used in conjunction with the
 * \ref GraphicArrayOut and \ref GraphicArrayOutEx API functions.
 * 
 */

/** @page download #download
 * \brief download
 * 
 * The \#download directive works in conjunction with the compiler's built-in
 * download capability. It lets you tell the compiler to download a specified
 * auxiliary file in addition to the .rxe file produced from your source code.
 * If the file extension matches a type of source code that the compiler knows
 * how to compile (such as .rs or .nbc) then the compiler will first compile
 * the source before downloading the resulting binary. The name of the file to
 * download (and optionally compile) is enclosed in double quote characters
 * immediately following this directive. If the compiler is only told to
 * compile the original source code then the \#download directive is ignored.
 * \code
 * #download "myfile.rs"
 * #download "mypicture.ric"
 * \endcode
 * 
 */

/** @page comptok Compiler Tokens
 * \brief Compiler Tokens
 * 
 * NBC supports special tokens, which it replaces on compilation. The tokens
 * are similar to preprocessor \#define macros but they are actually handled
 * directly by the compiler rather than the preprocessor.  The supported tokens
 * are as follows:
 * <center>
 * <table>
 * <tr><th>Token</th><th>Usage</th></tr>
 * <tr><td>__FILE__</td><td>This token is replaced with the currently active
 * filename (no path)</td></tr>
 * <tr><td>__LINE__</td><td>This token is replaced with the current line number</td></tr>
 * <tr><td>__VER__</td><td>This token is replaced with the compiler version number</td></tr>
 * <tr><td>__THREADNAME__</td><td>This token is replaced with the current thread name</td></tr>
 * <tr><td>__I__, __J__</td><td>These tokens are replaced with the current
 * value of I or J.  They are both initialized to zero at the start of each
 * thread or subroutine.</td></tr>
 * <tr><td>__ResetI__, __ResetJ__</td><td>These tokens are replaced with
 * nothing.  As a side effect the value of I or J is reset to zero.</td></tr>
 * <tr><td>__IncI__, __IncJ__</td><td>These tokens are replaced with nothing.
 * As a side effect the value of I or J is incremented by one.</td></tr>
 * <tr><td>__DecI__, __DecJ__</td><td>These tokens are replaced with nothing.
 * As a side effect the value of I or J is decremented by one.</td></tr>
 * </table>
 * </center>
 * <center>Table 2. Compiler Tokens</center>
 *
 * The \#\# preprocessor directive can help make the use of compiler tokens
 * more readable. __THREADNAME__\#\#_\#\#__I__:  would become something like
 * main_1:.  Without the \#\# directive it would much harder to read the
 * mixture of compiler tokens and underscores.
 *
 */

/** @page expreval Expression Evaluator
 * \brief Expression Evaluator
 *
 * Constant expressions are supported by NBC for many statement arguments as
 * well as variable initialization. Expressions are evaluated by the compiler
 * when the program is compiled, not at run time. The compiler will return an
 * error if it encounters an expression that contains whitespace. "4+4" is a
 * valid constant expression but "4 + 4" is not.
 *
 * The expression evaluator supports the following operators:
 *
 * <center>
 * <table>
 * <tr><td>+</td><td>addition</td></tr>
 * <tr><td>-</td><td>subtraction</td></tr>
 * <tr><td>*</td><td>multiplication</td></tr>
 * <tr><td>/</td><td>division</td></tr>
 * <tr><td>^</td><td>exponent</td></tr>
 * <tr><td>% </td><td>modulo (remainder)</td></tr>
 * <tr><td>&</td><td>bitwise and</td></tr>
 * <tr><td>|</td><td>bitwise or</td></tr>
 * <tr><td>~</td><td>bitwise xor</td></tr>
 * <tr><td><<</td><td>shift left</td></tr>
 * <tr><td>>></td><td>shift right</td></tr>
 * <tr><td>()</td><td>grouping subexpressions</td></tr>
 * <tr><td>PI</td><td>constant value</td></tr>
 * </table>
 * </center>
 * <center>Table 3. Constant Expression Operators</center>
 *
 * The expression evaluator also supports the following compile-time functions:
 * \code
 * tan(x), sin(x), cos(x)
 * sinh(x), cosh(x)
 * arctan(x), cotan(x)
 * arg(x)
 * exp(x), ln(x), log10(x), log2(x), logn(x, n)
 * sqr(x), sqrt(x)
 * trunc(x), int(x), ceil(x), floor(x), heav(x)
 * abs(x), sign(x), zero(x), ph(x)
 * rnd(x), random(x)
 * max(x, y), min(x, y)
 * power(x, exp), intpower(x, exp)
 * \endcode
 * <center>Table 4. Constant Expression Functions</center>
 *
 * The following example demonstrates how to use a constant expression:
 * \code
 * // expression value will be truncated to an integer
 * set val, 3+(PI*2)-sqrt(30)
 * \endcode
 *
 */

/** @page statements Statements
 * \brief Statements
 *
 * The body of a code block (thread, subroutine, or macro function) is composed
 * of statements. All statements are terminated with the newline character.
 *
 * - @subpage asgn
 * - @subpage math
 * - @subpage logic
 * - @subpage bitman
 * - @subpage cmpstmnt
 * - @subpage ctrlstmnt
 * - @subpage syscall
 * - @subpage timing
 * - @subpage arrayst
 * - @subpage stringst
 * - @subpage schedst
 * - @subpage inputst
 * - @subpage outputst
 * - @subpage compst
 *
 */

/** @page asgn Assignment Statements
 * \brief Assignment Statements
 *
 * Assignment statements enable you to copy values from one variable to another
 * or to simply set the value of a variable.  In NBC there are two ways to assign
 * a new value to a variable.
 *
 * - @subpage mov
 * - @subpage set
 * - @subpage addrof
 *
 */

/** @page mov mov
 * \brief The mov statement
 *
 * The mov statement assigns the value of its second argument to its first argument.
 * The first argument must be the name of a variable.  It can be of any valid
 * variable type except mutex.  The second argument can be a variable or a numeric
 * or string constant.  If a constant is used, the compiler creates a variable
 * behind the scenes and initializes it to the specified constant value.
 *
 * Both arguments to the mov statement must be of compatible types.  A scalar
 * value can be assigned to another scalar variable, regardless of type, structs
 * can be assigned to struct variables if the structure types are the same, and
 * arrays can be assigned to an array variable provided that the type contained
 * in the arrays are the same. The syntax of the mov statement is shown below.
 * \code
 * mov x, y     // set x equal to y
 * \endcode
 *
 */

/** @page set set
 * \brief The set statement
 *
 * The set statement also assigns its first argument to have the value of
 * its second argument.  The first argument must be the name of a variable.
 * It must be a scalar type.  The second argument must be a numeric
 * constant or constant expression. You should never use set with a variable
 * of type float. For float types use \ref mov instead.
 * The syntax of the set statement is shown below.
 * \code
 * set x, 10     // set x equal to 10
 * \endcode
 *
 * Because all arguments must fit into a 2-byte value in the NXT executable, the
 * second argument of the set statement is limited to a 16 bit signed or unsigned
 * value (-32768..65535).
 *
 */

/** @page addrof addrof
 * \brief The addrof statement
 *
 * The addrof statement gets the address of its input (second) argument and
 * stores it in the output (first) argument.  The third argument is a flag
 * which indicates whether the address should be absolute or relative.
 *
 * Relative addresses can be used like pointers along with the IOMapWrite
 * \ref syscall function.  The relative address is an offset from the start
 * of the VM memory pool (\ref CommandOffsetMemoryPool).
 * An absolute address is only useful for cases where
 * module IOMap structures expose a pointer address field.  One example is the
 * pFont address in the Display module IOMap structure (\ref DisplayOffsetPFont).
 * The syntax of the addrof statement is shown below.
 * \code
 * // addrof dest, src, brelative?
 * addrof ptrFont, fontDataArray, FALSE
 * \endcode
 *
 */

/** @page math Math Statements
 * \brief Math Statements
 *
 * Math statements enable you to perform basic math operations on data in your
 * NBC programs.  Unlike high level programming languages where mathematical
 * expressions use standard math operators (such as *, -, +, /), in NBC, as
 * with other assembly languages, math operations are expressed as statements
 * with the math operation name coming first, followed by the arguments to the
 * operation.  Nearly all the statements in this family have one output argument
 * and two input arguments. The exceptions include sqrt (square root),
 * neg (negate), abs (absolute value), and sign statements, which are unary
 * statements having a single input argument.
 *
 * Math statements in NBC differ from traditional assembly math statements
 * because many of the operations can handle arguments of scalar, array, and
 * struct types rather than only scalar types.  If, for example, you multiply
 * an array by a scalar then each of the elements in the resulting array will
 * be the corresponding element in the original array multiplied by the scalar
 * value.
 *
 * Only the abs (absolute value) and sign statements require that their arguments
 * are scalar types.  When using the standard NXT firmware these two statements
 * are implemented by the compiler since the firmware does not have built-in
 * support for them. If you install the enhanced NBC/NXC firmware and tell
 * the compiler to target it using the -EF command line switch then these
 * statements will be handled directly by the firmware itself rather than
 * by the compiler.
 *
 * This family of statements also includes several math operations that are
 * supported only by the enhanced NBC/NXC firmware. These statements cannot be
 * used at all if you tell the compiler to generate code for the standard
 * NXT firmware. The enhanced NBC/NXC firmware math statements are mostly
 * unary functions with a single input argument and a single output argument.
 * They are sin, cos, tan, sind, cosd, tand, asin, acos, atan, asind, acosd,
 * atand, sinh, cosh, tanh, sinhd, coshd, tanhd, ceil, floor, trunc, frac, exp,
 * log, and log10. There are three enhanced firmware math statements which take
 * two input arguments: pow, atan2, and atan2d. And the muldiv statement takes
 * three input arguments.
 *
 * - @subpage add
 * - @subpage sub
 * - @subpage mul
 * - @subpage div
 * - @subpage mod
 * - @subpage neg
 * - @subpage abs
 * - @subpage sign
 * - @subpage sqrt
 * - @subpage sin
 * - @subpage cos
 * - @subpage tan
 * - @subpage sind
 * - @subpage cosd
 * - @subpage tand
 * - @subpage asin
 * - @subpage acos
 * - @subpage atan
 * - @subpage atan2
 * - @subpage asind
 * - @subpage acosd
 * - @subpage atand
 * - @subpage atan2d
 * - @subpage sinh
 * - @subpage cosh
 * - @subpage tanh
 * - @subpage sinhd
 * - @subpage coshd
 * - @subpage tanhd
 * - @subpage ceil
 * - @subpage floor
 * - @subpage trunc
 * - @subpage frac
 * - @subpage exp
 * - @subpage log
 * - @subpage log10
 * - @subpage log10
 * - @subpage pow
 * - @subpage muldiv
 *
 */

/** @page add add
 * \brief The add Statement
 *
 * The add statement lets you add two input values together and store the
 * result in the first argument.  The first argument must be a variable but
 * the second and third arguments can be variables, numeric constants, or
 * constant expressions.  The syntax of the add statement is shown below.
 * \code
 * add x, x, y // add x and y and store result in x
 * \endcode
 *
 */

/** @page sub sub
 * \brief The sub Statement
 *
 * The sub statement lets you subtract two input values and store the result
 * in the first argument.  The first argument must be a variable but the
 * second and third arguments can be variables, numeric constants, or constant
 * expressions.  The syntax of the sub statement is shown below.
 * \code
 * sub x, x, y // subtract y from x and store result in x
 * \endcode
 *
 */

/** @page mul mul
 * \brief The mul Statement
 *
 * The mul statement lets you multiply two input values and store the result
 * in the first argument.  The first argument must be a variable but the
 * second and third arguments can be variables, numeric constants, or constant
 * expressions.  The syntax of the mul statement is shown below.
 * \code
 * mul x, x, x // set x equal to x^2
 * \endcode
 *
 */

/** @page div div
 * \brief The div Statement
 *
 * The div statement lets you divide two input values and store the result in
 * the first argument.  The first argument must be a variable but the second
 * and third arguments can be variables, numeric constants, or constant
 * expressions.  The syntax of the div statement is shown below.
 * \code
 * div x, x, 2 // set x equal to x / 2 (integer division)
 * \endcode
 *
 */

/** @page mod mod
 * \brief The mod Statement
 *
 * The mod statement lets you calculate the modulus value (or remainder) of
 * two input values and store the result in the first argument.  The first
 * argument must be a variable but the second and third arguments can be
 * variables, numeric constants, or constant expressions.  The syntax of
 * the mod statement is shown below.
 * \code
 * mod x, x, 4 // set x equal to x % 4 (0..3)
 * \endcode
 *
 */

/** @page neg neg
 * \brief The neg Statement
 *
 * The neg statement lets you negate an input value and store the result
 * in the first argument.  The first argument must be a variable but the
 * second argument can be a variable, a numeric constant, or a constant
 * expression.  The syntax of the neg statement is shown below.
 * \code
 * neg x, y // set x equal to -y
 * \endcode
 *
 */

/** @page abs abs
 * \brief The abs Statement
 *
 * The abs statement lets you take the absolute value of an input value
 * and store the result in the first argument.  The first argument must
 * be a variable but the second argument can be a variable, a numeric
 * constant, or a constant expression.  The syntax of the abs statement
 * is shown below.
 * \code
 * abs x, y // set x equal to the absolute value of y
 * \endcode
 *
 */

/** @page sign sign
 * \brief The sign Statement
 *
 * The sign statement lets you take the sign value (-1, 0, or 1) of
 * an input value and store the result in the first argument.  The first
 * argument must be a variable but the second argument can be a variable,
 * a numeric constant, or a constant expression.  The syntax of the sign
 * statement is shown below.
 * \code
 * sign x, y // set x equal to -1, 0, or 1
 * \endcode
 *
 */

/** @page sqrt sqrt
 * \brief The sqrt Statement
 *
 * The sqrt statement lets you take the square root of an input value
 * and store the result in the first argument.  The first argument must
 * be a variable but the second argument can be a variable, a numeric
 * constant, or a constant expression.  The syntax of the sqrt statement
 * is shown below.
 * \code
 * sqrt x, y // set x equal to the square root of y
 * \endcode
 *
 */

/** @page cos cos
 * \brief The cos Statement
 *
 * The cos statement lets you calculate the cosine value of its
 * input (second) argument (radians) and store the result in its output (first)
 * argument.  The syntax of the cos statement is shown below.
 * \code
 * cos x, y // store the cosine of y in x
 * \endcode
 *
 */

/** @page sin sin
 * \brief The sin Statement
 *
 * The sin statement lets you calculate the sine value of its
 * input (second) argument (radians) and store the result in its output (first)
 * argument.  The syntax of the sin statement is shown below.
 * \code
 * sin x, y // store the sine of y in x
 * \endcode
 *
 */

/** @page tan tan
 * \brief The tan Statement
 *
 * The tan statement lets you calculate the tangent value of its
 * input (second) argument (radians) and store the result in its output (first)
 * argument.  The syntax of the tan statement is shown below.
 * \code
 * tan x, y // store the tangent of y in x
 * \endcode
 *
 */

/** @page cosd cosd
 * \brief The cosd Statement
 *
 * The cosd statement lets you calculate the cosine value of its
 * input (second) argument (degrees) and store the result in its output (first)
 * argument.  The syntax of the cosd statement is shown below.
 * \code
 * cosd x, y // store the cosine of y in x
 * \endcode
 *
 */

/** @page sind sind
 * \brief The sind Statement
 *
 * The sind statement lets you calculate the sine value of its
 * input (second) argument (degress) and store the result in its output (first)
 * argument.  The syntax of the sind statement is shown below.
 * \code
 * sind x, y // store the sine of y in x
 * \endcode
 *
 */

/** @page tand tand
 * \brief The tand Statement
 *
 * The tand statement lets you calculate the tangent value of its
 * input (second) argument (degrees) and store the result in its output (first)
 * argument.  The syntax of the tand statement is shown below.
 * \code
 * tand x, y // store the tangent of y in x
 * \endcode
 *
 */

/** @page acos acos
 * \brief The acos Statement
 *
 * The acos statement lets you calculate the arc cosine value of its
 * input (second) argument and store the result (radians) in its output (first)
 * argument.  The syntax of the acos statement is shown below.
 * \code
 * acos x, y // store the arc cosine of y in x
 * \endcode
 *
 */

/** @page asin asin
 * \brief The asin Statement
 *
 * The asin statement lets you calculate the arc sine value of its
 * input (second) argument and store the result (radians) in its output (first)
 * argument.  The syntax of the asin statement is shown below.
 * \code
 * asin x, y // store the arc sine of y in x
 * \endcode
 *
 */

/** @page atan atan
 * \brief The atan Statement
 *
 * The atan statement lets you calculate the arc tangent value of its
 * input (second) argument and store the result (radians) in its output (first)
 * argument.  The syntax of the atan statement is shown below.
 * \code
 * atan x, y // store the arc tangent of y in x
 * \endcode
 *
 */

/** @page acosd acosd
 * \brief The acosd Statement
 *
 * The acosd statement lets you calculate the arc cosine value of its
 * input (second) argument and store the result (degrees) in its output (first)
 * argument.  The syntax of the acosd statement is shown below.
 * \code
 * acosd x, y // store the arc cosine of y in x
 * \endcode
 *
 */

/** @page asind asind
 * \brief The asind Statement
 *
 * The asind statement lets you calculate the arc sine value of its
 * input (second) argument and store the result (degrees) in its output (first)
 * argument.  The syntax of the asind statement is shown below.
 * \code
 * asind x, y // store the arc sine of y in x
 * \endcode
 *
 */

/** @page atand atand
 * \brief The atand Statement
 *
 * The atand statement lets you calculate the arc tangent value of its
 * input (second) argument and store the result (degrees) in its output (first)
 * argument.  The syntax of the atand statement is shown below.
 * \code
 * atand x, y // store the arc tangent of y in x
 * \endcode
 *
 */

/** @page atan2 atan2
 * \brief The atan2 Statement
 *
 * The atan2 statement lets you calculate the arc tangent value of its
 * two input (second and third) arguments and store the result (radians)
 * in its output (first) argument.  The syntax of the atan2 statement
 * is shown below.
 * \code
 * atan2 result, y, x // store the arc tangent of y/x in result
 * \endcode
 *
 */

/** @page atan2d atan2d
 * \brief The atan2d Statement
 *
 * The atan2d statement lets you calculate the arc tangent value of its
 * two input (second and third) arguments and store the result (degrees)
 * in its output (first) argument.  The syntax of the atan2d statement
 * is shown below.
 * \code
 * atan2d result, y, x // store the arc tangent of y/x in result
 * \endcode
 *
 */

/** @page cosh cosh
 * \brief The cosh Statement
 *
 * The cosh statement lets you calculate the hyperbolic cosine value of its
 * input (second) argument and store the result in its output (first)
 * argument.  The syntax of the cosh statement is shown below.
 * \code
 * cosh x, y // store the hyperbolic cosine of y in x
 * \endcode
 *
 */

/** @page sinh sinh
 * \brief The sinh Statement
 *
 * The sinh statement lets you calculate the hyperbolic sine value of its
 * input (second) argument and store the result in its output (first)
 * argument.  The syntax of the sinh statement is shown below.
 * \code
 * sinh x, y // store the hyperbolic sine of y in x
 * \endcode
 *
 */

/** @page tanh tanh
 * \brief The tanh Statement
 *
 * The tanh statement lets you calculate the hyperbolic tangent value of its
 * input (second) argument and store the result in its output (first)
 * argument.  The syntax of the tanh statement is shown below.
 * \code
 * tanh x, y // store the hyperbolic tangent of y in x
 * \endcode
 *
 */

/** @page coshd coshd
 * \brief The coshd Statement
 *
 * The coshd statement lets you calculate the hyperbolic cosine value of its
 * input (second) argument and store the result in its output (first)
 * argument.  The syntax of the coshd statement is shown below.
 * \code
 * coshd x, y // store the hyperbolic cosine of y in x
 * \endcode
 *
 */

/** @page sinhd sinhd
 * \brief The sinhd Statement
 *
 * The sinhd statement lets you calculate the hyperbolic sine value of its
 * input (second) argument and store the result in its output (first)
 * argument.  The syntax of the sinhd statement is shown below.
 * \code
 * sinhd x, y // store the hyperbolic sine of y in x
 * \endcode
 *
 */

/** @page tanhd tanhd
 * \brief The tanhd Statement
 *
 * The tanhd statement lets you calculate the hyperbolic tangent value of its
 * input (second) argument and store the result in its output (first)
 * argument.  The syntax of the tanhd statement is shown below.
 * \code
 * tanhd x, y // store the hyperbolic tangent of y in x
 * \endcode
 *
 */

/** @page ceil ceil
 * \brief The ceil Statement
 *
 * The ceil statement lets you calculate the smallest integral value
 * that is not less than the input (second) argument and store the
 * result in its output (first) argument.  The syntax of the ceil
 * statement is shown below.
 * \code
 * ceil x, y // store the ceil of y in x
 * \endcode
 *
 */

/** @page floor floor
 * \brief The floor Statement
 *
 * The floor statement lets you calculate the largest integral value
 * that is not greater than the input (second) argument and store the result
 * in its output (first) argument.  The syntax of the floor statement
 * is shown below.
 * \code
 * floor x, y // store the floor of y in x
 * \endcode
 *
 */

/** @page trunc trunc
 * \brief The trunc Statement
 *
 * The trunc statement lets you calculate the integer part of its
 * input (second) argument and store the result in its output (first)
 * argument.  The syntax of the trunc statement is shown below.
 * \code
 * trunc x, y // store the trunc of y in x
 * \endcode
 *
 */

/** @page frac frac
 * \brief The frac Statement
 *
 * The frac statement lets you calculate the fractional part of its
 * input (second) argument and store the result in its output (first)
 * argument.  The syntax of the frac statement is shown below.
 * \code
 * frac x, y // store the frac of y in x
 * \endcode
 *
 */

/** @page exp exp
 * \brief The exp Statement
 *
 * The exp statement lets you calculate the base-e exponential
 * function of x, which is the e number raised to the power x.
 * The syntax of the exp statement is shown below.
 * \code
 * exp result, x // store the value of e^x in result
 * \endcode
 *
 */

/** @page log log
 * \brief The log Statement
 *
 * The log statement lets you calculate the natural logarithm of x.
 * The syntax of the log statement is shown below.
 * \code
 * log result, x // store the natural logarithm of x
 * \endcode
 *
 */

/** @page log10 log10
 * \brief The log10 Statement
 *
 * The log10 statement lets you calculate the base-10 logarithm of x.
 * The syntax of the log10 statement is shown below.
 * \code
 * log10 result, x // store the base-10 logarithm of x
 * \endcode
 *
 */

/** @page pow pow
 * \brief The pow Statement
 *
 * The pow statement lets you calculate the value of x raised to the y power
 * and store the result in the output (first) argument.
 * The syntax of the pow statement is shown below.
 * \code
 * pow result, x, y//  store the x^y in result
 * \endcode
 *
 */

/** @page muldiv muldiv
 * \brief The muldiv Statement
 *
 * The muldiv statement lets you multiply two 32-bit values and then
 * divide the 64-bit result by a third 32-bit value.
 * The syntax of the muldiv statement is shown below.
 * \code
 * muldiv result, a, b, c//  store the a*b/c in result
 * \endcode
 *
 */

/** @page logic Logic Statements
 * \brief Logic Statements
 *
 * Logic statements let you perform basic logical operations on data in
 * your NBC program.  As with the math statements, the logical operation
 * name begins the statement and it is followed by the arguments to the
 * logical operation.  All the statements in this family have one output
 * argument and two input arguments except the logical not statement.
 * Each statement supports arguments of any type, scalar, array, or struct.
 *
 * - @subpage and
 * - @subpage or
 * - @subpage xor
 * - @subpage not
 *
 */

/** @page and and
 * \brief The and Statement
 *
 * The and statement lets you bitwise and together two input values and
 * store the result in the first argument.  The first argument must be a
 * variable but the second and third arguments can be a variable, a numeric
 * constant, or a constant expression.  The syntax of the and statement
 * is shown below.
 * \code
 * and x, x, y  // x = x & y
 * \endcode
 *
 */

/** @page or or
 * \brief The or Statement
 *
 * The or statement lets you bitwise or together two input values and store
 * the result in the first argument.  The first argument must be a variable
 * but the second and third arguments can be a variable, a numeric constant,
 * or a constant expression.  The syntax of the or statement is shown below.
 * \code
 * or x, x, y  // x = x | y
 * \endcode
 *
 */

/** @page xor xor
 * \brief The xor Statement
 *
 * The xor statement lets you bitwise exclusive or together two input
 * values and store the result in the first argument.  The first argument
 * must be a variable but the second and third arguments can be a variable,
 * a numeric constant, or a constant expression.  The syntax of the xor
 * statement is shown below.
 * \code
 * xor x, x, y  // x = x ^ y
 * \endcode
 *
 */

/** @page not not
 * \brief The not Statement
 *
 * The not statement lets you logically not its input value and store the
 * result in the first argument.  The first argument must be a variable
 * but the second argument can be a variable, a numeric constant, or a
 * constant expression.  The syntax of the not statement is shown below.
 * \code
 * not x, x  // x = !x (logical not – not bitwise)
 * \endcode
 *
 */

/** @page bitman Bit Manipulation Statements
 * \brief Bit Manipulation Statements
 *
 * Bit manipulation statements enable you to perform basic bitwise operations on
 * data in your NBC programs.  All statements in this family have one output
 * argument and two input arguments except the complement statement.
 *
 * Using the standard NXT firmware the basic shift right and shift left
 * statements (shr and shl) are implemented by the compiler since the firmware
 * does not support shift operations at this time. If you install the
 * enhanced NBC/NBC firmware and tell the compiler to target it using
 * the –EF command line switch, then these operations will be handled
 * directly by the firmware itself rather than by the compiler. The other
 * bit manipulation statements described in this section are only available
 * when targeting the enhanced firmware.
 *
 * - @subpage shr
 * - @subpage shl
 * - @subpage asr
 * - @subpage asl
 * - @subpage lsr
 * - @subpage lsl
 * - @subpage rotr
 * - @subpage rotl
 * - @subpage cmnt
 *
 */

/** @page shr shr
 * \brief The shr Statement
 *
 * The shr statement lets you shift right an input value by the number of
 * bits specified by the second input argument and store the resulting
 * value in the output argument.  The output (first) argument must be a
 * variable but the second and third arguments can be a variable, a
 * numeric constant, or a constant expression.  The syntax of the shr
 * statement is shown below.
 * \code
 * shr x, x, y  // x = x >> y
 * \endcode
 *
 */

/** @page shl shl
 * \brief The shl Statement
 *
 * The shl statement lets you shift left an input value by the number of
 * bits specified by the second input argument and store the resulting
 * value in the output argument.  The output (first) argument must be a
 * variable but the second and third arguments can be a variable, a
 * numeric constant, or a constant expression.  The syntax of the shl
 * statement is shown below.
 * \code
 * shl x, x, y  // x = x << y
 * \endcode
 *
 */

/** @page asr asr
 * \brief The asr Statement
 *
 * The asr statement lets you perform an arithmetic right shift operation.
 * The output (first) argument must be a variable but the second and
 * third arguments can be a variable, a numeric constant, or a constant
 * expression.  The syntax of the asr statement is shown below.
 * \code
 * asr x, x, y  // x = x >> y
 * \endcode
 *
 */

/** @page asl asl
 * \brief The asl Statement
 *
 * The asl statement lets you perform an arithmetic left shift operation.
 * The output (first) argument must be a variable but the second and third
 * arguments can be a variable, a numeric constant, or a constant
 * expression.  The syntax of the asl statement is shown below.
 * \code
 * asl x, x, y  // x = x << y
 * \endcode
 *
 */

/** @page lsr lsr
 * \brief The lsr Statement
 *
 * The lsr statement lets you perform a logical right shift operation.
 * The output (first) argument must be a variable but the second and
 * third arguments can be a variable, a numeric constant, or a constant
 * expression.  The syntax of the lsr statement is shown below.
 * \code
 * lsr x, x, y
 * \endcode
 *
 */

/** @page lsl lsl
 * \brief The lsl Statement
 *
 * The lsl statement lets you perform a logical left shift operation.
 * The output (first) argument must be a variable but the second and
 * third arguments can be a variable, a numeric constant, or a constant
 * expression.  The syntax of the lsl statement is shown below.
 * \code
 * lsl x, x, y
 * \endcode
 *
 */

/** @page rotr rotr
 * \brief The rotr Statement
 *
 * The rotr statement lets you perform a rotate right operation.  The
 * output (first) argument must be a variable but the second and third
 * arguments can be a variable, a numeric constant, or a constant
 * expression.  The syntax of the rotr statement is shown below.
 * \code
 * rotr x, x, y
 * \endcode
 *
 */

/** @page rotl rotl
 * \brief The rotl Statement
 *
 * The rotl statement lets you perform a rotate left operation.  The
 * output (first) argument must be a variable but the second and
 * third arguments can be a variable, a numeric constant, or a
 * constant expression.  The syntax of the rotl statement is shown below.
 * \code
 * rotl x, x, y
 * \endcode
 *
 */

/** @page cmnt cmnt
 * \brief The cmnt Statement
 *
 * The cmnt statement lets you perform a bitwise complement operation.
 * The output (first) argument must be a variable but the second can be
 * a variable, a numeric constant, or a constant expression.  The syntax
 * of the cmnt statement is shown below.
 * \code
 * cmnt x, y // x = ~y
 * \endcode
 *
 */

/** @defgroup cmpconst Comparison Constants
 * Logical comparison operators for use in brtst, tst, tstset, brcmp,
 * cmp, and cmpset.
 */

/** @page cmpstmnt Comparison Statements
 * \brief Comparison Statements
 *
 * Comparison statements enable you to compare data in your NBC programs. These
 * statements take a comparison code constant as their first argument. Valid
 * comparison constants are listed in the \ref cmpconst section. You can use
 * scalar, array, and aggregate types for the compare or test argument(s).
 *
 * - @subpage cmp
 * - @subpage tst
 *
 */

/** @page cmp cmp
 * \brief The cmp Statement
 *
 * The cmp statement lets you compare two different input sources.  The output
 * (second) argument must be a variable but the remaining arguments can be a
 * variable, a numeric constant, or a constant expression.  The syntax of the
 * cmp statement is shown below.
 * \code
 * cmp EQ, bXEqualsY, x, y // bXEqualsY = (x == y);
 * \endcode
 *
 */

/** @page tst tst
 * \brief The tst Statement
 *
 * The tst statement lets you compare an input source to zero.  The output (second)
 * argument must be a variable but the remaining argument can be a variable, a
 * numeric constant, or a constant expression.  The syntax of the tst statement
 * is shown below.
 * \code
 * tst GT, bXGTZero, x // bXGTZero = (x > 0);
 * \endcode
 *
 */

/** @page ctrlstmnt Control Flow Statements
 * \brief Control Flow Statements
 *
 * Control flow statements enable you to manipulate or control the execution
 * flow of your NBC programs. Some of these statements take a comparison code
 * constant as their first argument. Valid comparison constants are listed
 * in \ref cmpconst section. You can use scalar, array, and
 * aggregate types for the compare or test argument(s).
 *
 * - @subpage jmp
 * - @subpage brcmp
 * - @subpage brtst
 * - @subpage stop
 *
 */

/** @page jmp jmp
 * \brief The jmp Statement
 *
 * The jmp statement lets you unconditionally jump from the current execution
 * point to a new location.  Its only argument is a label that specifies where
 * program execution should resume. The syntax of the jmp statement is
 * shown below.
 * \code
 * jmp LoopStart // jump to the LoopStart label
 * \endcode
 *
 */

/** @page brcmp brcmp
 * \brief The brcmp Statement
 *
 * The brcmp statement lets you conditionally jump from the current execution
 * point to a new location.  It is like the cmp statement except that instead
 * of an output argument it has a label argument that specifies where program
 * execution should resume. The syntax of the brcmp statement is shown below.
 * \code
 * brcmp EQ, LoopStart, x, y // jump to LoopStart if x == y
 * \endcode
 *
 */

/** @page brtst brtst
 * \brief The brtst Statement
 *
 * The brtst statement lets you conditionally jump from the current execution
 * point to a new location.  It is like the tst statement except that instead
 * of an output argument it has a label argument that specifies where program
 * execution should resume. The syntax of the brtst statement is shown below.
 * \code
 * brtst GT, lblXGTZero, x // jump to lblXGTZero if x > 0
 * \endcode
 *
 */

/** @page stop stop
 * \brief The stop Statement
 *
 * The stop statement lets you stop program execution completely, depending
 * on the value of its boolean input argument. The syntax of the stop statement
 * is shown below.
 * \code
 * stop bProgShouldStop // stop program if flag <> 0
 * \endcode
 *
 */

/** @page syscall syscall
 * \brief The syscall Statement
 *
 * The syscall statement enables execution of various system functions
 * via a constant function ID and an aggregate type variable for passing
 * arguments to and from the system function. The syntax of the syscall
 * statement is shown below.
 * \code
 * // ptArgs is a struct with input and output args
 * syscall SoundPlayTone, ptArgs
 * \endcode
 *
 * Valid syscall statement function IDs are listed in the \ref SysCallConstants
 * section.
 *
 * - @subpage syscallargs
 *
 */

/** @page syscallargs System call structures
 * \brief System call structures
 *
 * - @subpage TLocation
 * - @subpage TSize
 * - @subpage TFileOpen
 * - @subpage TFileReadWrite
 * - @subpage TFileClose
 * - @subpage TFileResolveHandle
 * - @subpage TFileRename
 * - @subpage TFileDelete
 * - @subpage TSoundPlayFile
 * - @subpage TSoundPlayTone
 * - @subpage TSoundGetState
 * - @subpage TSoundSetState
 * - @subpage TDrawText
 * - @subpage TDrawPoint
 * - @subpage TDrawLine
 * - @subpage TDrawCircle
 * - @subpage TDrawRect
 * - @subpage TDrawGraphic
 * - @subpage TSetScreenMode
 * - @subpage TReadButton
 * - @subpage TCommLSWrite
 * - @subpage TCommLSRead
 * - @subpage TCommLSCheckStatus
 * - @subpage TRandomNumber
 * - @subpage TGetStartTick
 * - @subpage TMessageWrite
 * - @subpage TMessageRead
 * - @subpage TCommBTCheckStatus
 * - @subpage TCommBTWrite
 * - @subpage TCommBTRead
 * - @subpage TKeepAlive
 * - @subpage TIOMapRead
 * - @subpage TIOMapWrite
 * - @subpage TIOMapReadByID
 * - @subpage TIOMapWriteByID
 * - @subpage TDisplayExecuteFunction
 * - @subpage TCommExecuteFunction
 * - @subpage TLoaderExecuteFunction
 * - @subpage TFileFind
 * - @subpage TCommHSControl
 * - @subpage TCommHSCheckStatus
 * - @subpage TCommHSReadWrite
 * - @subpage TCommLSWriteEx
 * - @subpage TFileSeek
 * - @subpage TFileResize
 * - @subpage TDrawGraphicArray
 * - @subpage TDrawPolygon
 * - @subpage TDrawEllipse
 * - @subpage TDrawFont
 * - @subpage TColorSensorRead
 * - @subpage TDatalogWrite
 * - @subpage TDatalogGetTimes
 * - @subpage TSetSleepTimeout
 * - @subpage TCommBTOnOff
 * - @subpage TCommBTConnection
 * - @subpage TReadSemData
 * - @subpage TWriteSemData
 * - @subpage TUpdateCalibCacheInfo
 * - @subpage TComputeCalibValue
 * - @subpage TListFiles
 *
 */

/** @page TLocation TLocation
 * \brief The TLocation structure
 *
 * \code
 * TLocation	struct
 *  X		sword
 *  Y		sword
 * TLocation	ends
 * \endcode
 *
 */

/** @page TSize TSize
 * \brief The TSize structure
 *
 * \code
 * TSize	struct
 *  Width	sword
 *  Height	sword
 * TSize	ends
 * \endcode
 *
 */

/** @page TFileOpen TFileOpen
 * \brief The TFileOpen structure
 *
 * \code
 * // FileOpenRead, FileOpenWrite, FileOpenAppend, FileOpenWriteLinear,
 * // FileOpenWriteNonLinear, FileOpenReadLinear
 * TFileOpen	struct
 *  Result		word
 *  FileHandle	byte
 *  Filename	byte[]
 *  Length		dword
 * TFileOpen	ends
 * \endcode
 *
 */

/** @page TFileReadWrite TFileReadWrite
 * \brief The TFileReadWrite structure
 *
 * \code
 * // FileRead, FileWrite
 * TFileReadWrite	struct
 *  Result		word
 *  FileHandle	byte
 *  Buffer		byte[]
 *  Length		dword
 * TFileReadWrite	ends
 * \endcode
 *
 */

/** @page TFileClose TFileClose
 * \brief The TFileClose structure
 *
 * \code
 * // FileClose
 * TFileClose	struct
 *  Result		word
 *  FileHandle	byte
 * TFileClose	ends
 * \endcode
 *
 */

/** @page TFileResolveHandle TFileResolveHandle
 * \brief The TFileResolveHandle structure
 *
 * \code
 * // FileResolveHandle
 * TFileResolveHandle	struct
 *  Result		word
 *  FileHandle	byte
 *  WriteHandle	byte
 *  Filename	byte[]
 * TFileResolveHandle	ends
 * \endcode
 *
 */

/** @page TFileRename TFileRename
 * \brief The TFileRename structure
 *
 * \code
 * // FileRename
 * TFileRename	struct
 *  Result		word
 *  OldFilename	byte[]
 *  NewFilename	byte[]
 * TFileRename	ends
 * \endcode
 *
 */

/** @page TFileDelete TFileDelete
 * \brief The TFileDelete structure
 *
 * \code
 * // FileDelete
 * TFileDelete	struct
 *  Result		word
 *  Filename	byte[]
 * TFileDelete	ends
 * \endcode
 *
 */

/** @page TSoundPlayFile TSoundPlayFile
 * \brief The TSoundPlayFile structure
 *
 * \code
 * // SoundPlayFile
 * TSoundPlayFile	struct
 *  Result		sbyte
 *  Filename	byte[]
 *  Loop		byte
 *  Volume		byte
 * TSoundPlayFile	ends
 * \endcode
 *
 */

/** @page TSoundPlayTone TSoundPlayTone
 * \brief The TSoundPlayTone structure
 *
 * \code
 * // SoundPlayTone
 * TSoundPlayTone	struct
 *  Result		sbyte
 *  Frequency	word
 *  Duration	word
 *  Loop		byte
 *  Volume		byte
 * TSoundPlayTone	ends
 * \endcode
 *
 */

/** @page TSoundGetState TSoundGetState
 * \brief The TSoundGetState structure
 *
 * \code
 * // SoundGetState
 * TSoundGetState	struct
 *  State		byte
 *  Flags		byte
 * TSoundGetState	ends
 * \endcode
 *
 */

/** @page TSoundSetState TSoundSetState
 * \brief The TSoundSetState structure
 *
 * \code
 * // SoundSetState
 * TSoundSetState	struct
 *  Result		byte
 *  State		byte
 *  Flags		byte
 * TSoundSetState	ends
 * \endcode
 *
 */

/** @page TDrawText TDrawText
 * \brief The TDrawText structure
 *
 * \code
 * // DrawText
 * TDrawText	struct
 *  Result		sbyte
 *  Location	TLocation
 *  Text		byte[]
 *  Options	dword
 * TDrawText	ends
 * \endcode
 *
 */

/** @page TDrawPoint TDrawPoint
 * \brief The TDrawPoint structure
 *
 * \code
 * // DrawPoint
 * TDrawPoint	struct
 *  Result		sbyte
 *  Location	TLocation
 *  Options	dword
 * TDrawPoint	ends
 * \endcode
 *
 */

/** @page TDrawLine TDrawLine
 * \brief The TDrawLine structure
 *
 * \code
 * // DrawLine
 * TDrawLine	struct
 *  Result		sbyte
 *  StartLoc	TLocation
 *  EndLoc		TLocation
 *  Options	dword
 * TDrawLine	ends
 * \endcode
 *
 */

/** @page TDrawCircle TDrawCircle
 * \brief The TDrawCircle structure
 *
 * \code
 * // DrawCircle
 * TDrawCircle	struct
 *  Result		sbyte
 *  Center		TLocation
 *  Size		byte
 *  Options	dword
 * TDrawCircle	ends
 * \endcode
 *
 */

/** @page TDrawRect TDrawRect
 * \brief The TDrawRect structure
 *
 * \code
 * // DrawRect
 * TDrawRect	struct
 *  Result		sbyte
 *  Location	TLocation
 *  Size		TSize
 *  Options	dword
 * TDrawRect	ends
 * \endcode
 *
 */

/** @page TDrawGraphic TDrawGraphic
 * \brief The TDrawGraphic structure
 *
 * \code
 * // DrawGraphic
 * TDrawGraphic	struct
 *  Result		sbyte
 *  Location	TLocation
 *  Filename	byte[]
 *  Variables	sdword[]
 *  Options	dword
 * TDrawGraphic	ends
 * \endcode
 *
 */

/** @page TSetScreenMode TSetScreenMode
 * \brief The TSetScreenMode structure
 *
 * \code
 * // SetScreenMode
 * TSetScreenMode	struct
 *  Result		sbyte
 *  ScreenMode	dword
 * TSetScreenMode	ends
 * \endcode
 *
 */

/** @page TReadButton TReadButton
 * \brief The TReadButton structure
 *
 * \code
 * // ReadButton
 * TReadButton	struct
 *  Result		sbyte
 *  Index		byte
 *  Pressed	byte
 *  Count		byte
 *  Reset		byte
 * TReadButton	ends
 * \endcode
 *
 */

/** @page TCommLSWrite TCommLSWrite
 * \brief The TCommLSWrite structure
 *
 * \code
 * // CommLSWrite
 * TCommLSWrite	struct
 *  Result		sbyte
 *  Port		byte
 *  Buffer		byte[]
 *  ReturnLen	byte
 * TCommLSWrite	ends
 * \endcode
 *
 */

/** @page TCommLSRead TCommLSRead
 * \brief The TCommLSRead structure
 *
 * \code
 * // CommLSRead
 * TCommLSRead	struct
 *  Result		sbyte
 *  Port		byte
 *  Buffer		byte[]
 *  BufferLen	byte
 * TCommLSRead	ends
 * \endcode
 *
 */

/** @page TCommLSCheckStatus TCommLSCheckStatus
 * \brief The TCommLSCheckStatus structure
 *
 * \code
 * // CommLSCheckStatus
 * TCommLSCheckStatus	struct
 *  Result		sbyte
 *  Port		byte
 *  BytesReady	byte
 * TCommLSCheckStatus	ends
 * \endcode
 *
 */

/** @page TRandomNumber TRandomNumber
 * \brief The TRandomNumber structure
 *
 * \code
 * // RandomNumber
 * TRandomNumber	struct
 *  Result		sword
 * TRandomNumber	ends
 * \endcode
 *
 */

/** @page TGetStartTick TGetStartTick
 * \brief The TGetStartTick structure
 *
 * \code
 * // GetStartTick
 * TGetStartTick	struct
 *  Result		dword
 * TGetStartTick	ends
 * \endcode
 *
 */

/** @page TMessageWrite TMessageWrite
 * \brief The TMessageWrite structure
 *
 * \code
 * // MessageWrite
 * TMessageWrite	struct
 *  Result		sbyte
 *  QueueID	byte
 *  Message	byte[]
 * TMessageWrite	ends
 * \endcode
 *
 */

/** @page TMessageRead TMessageRead
 * \brief The TMessageRead structure
 *
 * \code
 * // MessageRead
 * TMessageRead	struct
 *  Result		sbyte
 *  QueueID	byte
 *  Remove		byte
 *  Message	byte[]
 * TMessageRead	ends
 * \endcode
 *
 */

/** @page TCommBTCheckStatus TCommBTCheckStatus
 * \brief The TCommBTCheckStatus structure
 *
 * \code
 * // CommBTCheckStatus
 * TCommBTCheckStatus	struct
 *  Result		sbyte
 *  Connection	byte
 * TCommBTCheckStatus	ends
 * \endcode
 *
 */

/** @page TCommBTWrite TCommBTWrite
 * \brief The TCommBTWrite structure
 *
 * \code
 * // CommBTWrite
 * TCommBTWrite	struct
 *  Result		sbyte
 *  Connection	byte
 *  Buffer		byte[]
 * TCommBTWrite	ends
 * \endcode
 *
 */

/** @page TCommBTRead TCommBTRead
 * \brief The TCommBTRead structure
 *
 * \code
 * // CommBTRead
 * TCommBTRead	struct
 *  Result		sbyte
 *  Count		byte
 *  Buffer		byte[]
 * TCommBTRead	ends
 * \endcode
 *
 */

/** @page TKeepAlive TKeepAlive
 * \brief The TKeepAlive structure
 *
 * \code
 * // KeepAlive
 * TKeepAlive	struct
 *  Result		dword
 * TKeepAlive	ends
 * \endcode
 *
 */

/** @page TIOMapRead TIOMapRead
 * \brief The TIOMapRead structure
 *
 * \code
 * // IOMapRead
 * TIOMapRead	struct
 *  Result		sbyte
 *  ModuleName	byte[]
 *  Offset		word
 *  Count		word
 *  Buffer		byte[]
 * TIOMapRead	ends
 * \endcode
 *
 */

/** @page TIOMapWrite TIOMapWrite
 * \brief The TIOMapWrite structure
 *
 * \code
 * // IOMapWrite
 * TIOMapWrite	struct
 *  Result		sbyte
 *  ModuleName	byte[]
 *  Offset		word
 *  Buffer		byte[]
 * TIOMapWrite	ends
 * \endcode
 *
 */

/** @page TIOMapReadByID TIOMapReadByID
 * \brief The TIOMapReadByID structure
 *
 * \code
 * // IOMapReadByID
 * TIOMapReadByID struct
 *   Result    sbyte
 *   ModuleID  long
 *   Offset    word
 *   Count     word
 *   Buffer    byte[]
 * TIOMapReadByID ends
 * \endcode
 *
 */

/** @page TIOMapWriteByID TIOMapWriteByID
 * \brief The TIOMapWriteByID structure
 *
 * \code
 * // IOMapWriteByID
 * TIOMapWriteByID struct
 *   Result   sbyte
 *   ModuleID long
 *   Offset   word
 *   Buffer   byte[]
 * TIOMapWriteByID ends
 * \endcode
 *
 */

/** @page TDisplayExecuteFunction TDisplayExecuteFunction
 * \brief The TDisplayExecuteFunction structure
 *
 * \code
 * // DisplayExecuteFunction
 * TDisplayExecuteFunction struct
 *   Status byte
 *   Cmd    byte
 *   On     byte
 *   X1     byte
 *   Y1     byte
 *   X2     byte
 *   Y2     byte
 * TDisplayExecuteFunction ends
 * \endcode
 *
 */

/** @page TCommExecuteFunction TCommExecuteFunction
 * \brief The TCommExecuteFunction structure
 *
 * \code
 * // CommExecuteFunction
 * TCommExecuteFunction struct
 *   Result word
 *   Cmd    byte
 *   Param1 byte
 *   Param2 byte
 *   Param3 byte
 *   Name   byte[]
 *   RetVal word
 * TCommExecuteFunction ends
 * \endcode
 *
 */

/** @page TLoaderExecuteFunction TLoaderExecuteFunction
 * \brief The TLoaderExecuteFunction structure
 *
 * \code
 * // LoaderExecuteFunction
 * TLoaderExecuteFunction struct
 *   Result   word
 *   Cmd      byte
 *   Filename byte[]
 *   Buffer   byte[]
 *   Length   long
 * TLoaderExecuteFunction ends
 * \endcode
 *
 */

/** @page TFileFind TFileFind
 * \brief The TFileFind structure
 *
 * \code
 * // FileFindFirst, FileFindNext
 * TFileFind	struct
 *  Result		word
 *  FileHandle	byte
 *  Filename	byte[]
 *  Length		dword
 * TFileFind	ends
 * \endcode
 *
 */

/** @page TCommHSControl TCommHSControl
 * \brief The TCommHSControl structure
 *
 * \code
 * // CommHSControl
 * TCommHSControl	struct
 *  Result		sbyte
 *  Command	byte
 *  BaudRate	byte
 *  Mode		word
 * TCommHSControl	ends
 * \endcode
 *
 */

/** @page TCommHSCheckStatus TCommHSCheckStatus
 * \brief The TCommHSCheckStatus structure
 *
 * \code
 * // CommHSCheckStatus
 * TCommHSCheckStatus	struct
 *  SendingData	byte
 *  DataAvailable	byte
 * TCommHSCheckStatus	ends
 * \endcode
 *
 */

/** @page TCommHSReadWrite TCommHSReadWrite
 * \brief The TCommHSReadWrite structure
 *
 * \code
 * // CommHSRead, CommHSWrite
 * TCommHSReadWrite	struct
 *  Status	sbyte
 *  Buffer	byte[]
 * TCommHSReadWrite	ends
 * \endcode
 *
 */

/** @page TCommLSWriteEx TCommLSWriteEx
 * \brief The TCommLSWriteEx structure
 *
 * \code
 * // CommLSWriteEx
 * TCommLSWriteEx	struct
 *  Result		sbyte
 *  Port		byte
 *  Buffer		byte[]
 *  ReturnLen	byte
 *  NoRestartOnRead	byte
 * TCommLSWriteEx	ends
 * \endcode
 *
 */

/** @page TFileSeek TFileSeek
 * \brief The TFileSeek structure
 *
 * \code
 * //FileSeek
 * TFileSeek	struct
 *  Result		word
 *  FileHandle	byte
 *  Origin		byte
 *  Length		sdword
 * TFileSeek	ends
 * \endcode
 *
 */

/** @page TFileResize TFileResize
 * \brief The TFileResize structure
 *
 * \code
 * //FileResize
 * TFileResize	struct
 *  Result		word
 *  FileHandle	byte
 *  NewSize	word
 * TFileResize	ends
 * \endcode
 *
 */

/** @page TDrawGraphicArray TDrawGraphicArray
 * \brief The TDrawGraphicArray structure
 *
 * \code
 * // DrawGraphicArray
 * TDrawGraphicArray	struct
 *  Result		sbyte
 *  Location	TLocation
 *  Data		byte[]
 *  Variables	sdword[]
 *  Options	dword
 * TDrawGraphicArray	ends
 * \endcode
 *
 */

/** @page TDrawPolygon TDrawPolygon
 * \brief The TDrawPolygon structure
 *
 * \code
 * // DrawPolygon
 * TDrawPolygon	struct
 *  Result		sbyte
 *  Points		TLocation[]
 *  Options	dword
 * TDrawPolygon	ends
 * \endcode
 *
 */

/** @page TDrawEllipse TDrawEllipse
 * \brief The TDrawEllipse structure
 *
 * \code
 * // DrawEllipse
 * TDrawEllipse	struct
 *  Result		sbyte
 *  Center		TLocation
 *  SizeX		byte
 *  SizeY		byte
 *  Options	dword
 * TDrawEllipse	ends
 * \endcode
 *
 */

/** @page TDrawFont TDrawFont
 * \brief The TDrawFont structure
 *
 * \code
 * // DrawFont
 * TDrawFont	struct
 *  Result		sbyte
 *  Location	TLocation
 *  Filename	byte[]
 *  Text		byte[]
 *  Options	dword
 * TDrawFont	ends
 * \endcode
 *
 */

/** @page TColorSensorRead TColorSensorRead
 * Parameters for the ColorSensorRead system call.
 * This structure is used when calling the \ref ColorSensorRead system call function.
 * Choose the sensor port (\ref NBCInputPortConstants) and after calling the function
 * read the sensor values from the ColorValue field or the raw, normalized, or
 * scaled value arrays.
 * \code
 * // ColorSensorRead
 * TColorSensorRead	struct
 *  Result          sbyte    // The function call result. NO_ERR means it succeeded.
 *  Port			byte     // The sensor port. See NBCInputPortConstants.
 *  ColorValue		sword    // The color value returned by the sensor. See InputColorValueConstants.
 *  RawArray		word[]   // Raw color values returned by the sensor. See InputColorIdxConstants.
 *  NormalizedArray	word[]   // Normalized color values returned by the sensor. See InputColorIdxConstants.
 *  ScaledArray     sword[]  // Scaled color values returned by the sensor. See InputColorIdxConstants.
 *  Invalid         byte     // Are the sensor values valid?
 * TColorSensorRead	ends
 * \endcode
 *
 */

/** @page TDatalogWrite TDatalogWrite
 * \brief The TDatalogWrite structure
 *
 * \code
 * // DatalogWrite
 * TDatalogWrite	struct
 *  Result		sbyte
 *  Message	byte[]
 * TDatalogWrite	ends
 * \endcode
 *
 */

/** @page TDatalogGetTimes TDatalogGetTimes
 * \brief The TDatalogGetTimes structure
 *
 * \code
 * // DatalogGetTimes
 * TDatalogGetTimes	struct
 *  SyncTime	dword
 *  SyncTick	dword
 * TDatalogGetTimes	ends
 * \endcode
 *
 */

/** @page TSetSleepTimeout TSetSleepTimeout
 * \brief The TSetSleepTimeout structure
 *
 * \code
 * // SetSleepTimeout
 * TSetSleepTimeout	struct
 *  Result		sbyte
 *  TheSleepTimeoutMS	dword
 * TSetSleepTimeout	ends
 * \endcode
 *
 */

/** @page TCommBTOnOff TCommBTOnOff
 * \brief The TCommBTOnOff structure
 *
 * \code
 * // CommBTOnOff
 * TCommBTOnOff	struct
 *  Result		word
 *  PowerState	byte
 * TCommBTOnOff	ends
 * \endcode
 *
 */

/** @page TCommBTConnection TCommBTConnection
 * \brief The TCommBTConnection structure
 *
 * \code
 * // CommBTConnection
 * TCommBTConnection	struct
 *  Result		word
 *  Action		byte
 *  Name		byte[]
 *  ConnectionSlot	byte
 * TCommBTConnection	ends
 * \endcode
 *
 */

/** @page TReadSemData TReadSemData
 * \brief The TReadSemData structure
 *
 * \code
 * // ReadSemData
 * TReadSemData struct
 *  SemData byte
 *  Request byte
 * TReadSemData ends
 * \endcode
 *
 */

/** @page TWriteSemData TWriteSemData
 * \brief The TWriteSemData structure
 *
 * \code
 * // WriteSemData
 * TWriteSemData struct
 *  SemData byte
 *  Request byte
 *  NewVal byte
 *  ClearBits byte
 * TWriteSemData ends
 * \endcode
 *
 */

/** @page TUpdateCalibCacheInfo TUpdateCalibCacheInfo
 * \brief The TUpdateCalibCacheInfo structure
 *
 * \code
 * // UpdateCalibCacheInfo
 * TUpdateCalibCacheInfo struct
 *  Result byte
 *  Name byte[]
 *  MinVal word
 *  MaxVal word
 * TUpdateCalibCacheInfo ends
 * \endcode
 *
 */

/** @page TComputeCalibValue TComputeCalibValue
 * \brief The TComputeCalibValue structure
 *
 * \code
 * // ComputeCalibValue
 * TComputeCalibValue struct
 *  Result byte
 *  Name byte[]
 *  RawVal word
 * TComputeCalibValue ends
 * \endcode
 *
 */

/** @page TListFiles TListFiles
 * \brief The TListFiles structure
 *
 * \code
 * // ListFiles
 * TListFiles	struct
 *  Result		sbyte
 *  Pattern	byte[]
 *  FileList	byte[][]
 * TListFiles	ends
 * \endcode
 *
 */

/** @page timing Timing Statements
 * \brief Timing Statements
 *
 * Timing statements enable you to pause the execution of a thread or
 * obtain information about the system tick counter in your NBC programs.
 * When using the standard NXT firmware NBC implements the wait and waitv
 * statements as thread-specific subroutine calls due to them not being
 * implemented. The enhanced NBC/NXC firmware implements these
 * statements natively. If needed, you can implement simple wait loops
 * using gettick.
 * \code
 * add endTick, currTick, waitms
 * Loop:
 *   gettick currTick
 * brcmp LT, Loop, currTick, endTick
 * \endcode
 *
 * - @subpage wait
 * - @subpage waitv
 * - @subpage wait2
 * - @subpage gettick
 *
 */

/** @page wait wait
 * \brief The wait Statement
 *
 * The wait statement suspends the current thread for the number of
 * milliseconds specified by its constant argument. The syntax of the
 * wait statement is shown below.
 * \code
 * wait 1000 // wait for 1 second
 * \endcode
 *
 */

/** @page waitv waitv
 * \brief The waitv Statement
 *
 * The waitv statement acts like wait but it takes a variable argument.
 * If you use a constant argument with waitv the compiler will generate
 * a temporary variable for you. The syntax of the waitv statement is
 * shown below.
 * \code
 * waitv iDelay // wait for the number of milliseconds in iDelay
 * \endcode
 *
 */

/** @page wait2 wait2
 * \brief The wait2 Statement
 *
 * The wait2 statement suspends the current thread for the number of
 * milliseconds specified by its second argument. If the second argument
 * is NA then the wait time is zero milliseconds, which simply rotates
 * the queue. The current timer value is returned in the first argument
 * if it is not NA. The syntax of the wait2 statement is shown below.
 * \code
 * set ms, 1000
 * wait2 NA, ms // wait for 1 second
 * \endcode
 *
 */

/** @page gettick gettick
 * \brief The gettick Statement
 *
 * The gettick statement suspends the current thread for the number of
 * milliseconds specified by its constant argument. The syntax of the
 * gettick statement is shown below.
 * \code
 * gettick x // set x to the current system tick count
 * \endcode
 *
 */

/** @page arrayst Array Statements
 * \brief Array Statements
 *
 * Array statements enable you to populate and manipulate arrays in
 * your NBC programs.
 *
 * - @subpage index
 * - @subpage replace
 * - @subpage arrsize
 * - @subpage arrinit
 * - @subpage arrsubset
 * - @subpage arrbuild
 * - @subpage arrop
 *
 */

/** @page index index
 * \brief The index Statement
 *
 * The index statement extracts a single element from the source array
 * and returns the value in the output (first) argument. The last argument
 * is the index of the desired element. The syntax of the index statement
 * is shown below.
 * \code
 * // extract arrayValues[index] and store it in value
 * index value, arrayValues, index
 * \endcode
 *
 */

/** @page replace replace
 * \brief The replace Statement
 *
 * The replace statement replaces one or more items in a source array
 * and stores the modified array contents in an output array. The array
 * source argument (second) can be the same variable as the array
 * destination (first) argument to replace without copying the array.
 * The index of the element(s) to be replaced is specified via the
 * third argument. The new value (last) argument can be an array, in
 * which case multiple items are replaced. The syntax of the replace
 * statement is shown below.
 * \code
 * // replace arValues[idx] with x in arNew (arValues is unchanged)
 * replace arNew, arValues, idx, x
 * \endcode
 *
 */

/** @page arrsize arrsize
 * \brief The arrsize Statement
 *
 * The arrsize statement returns the number of elements in the input
 * array (second) argument in the scalar output (first) argument. The
 * syntax of the arrsize statement is shown below.
 * \code
 * arrsize nSize, arValues  // nSize == length of array
 * \endcode
 *
 */

/** @page arrinit arrinit
 * \brief The arrinit Statement
 *
 * The arrinit statement initializes the output array (first) argument
 * using the value (second) and size (third) arguments provided. The
 * syntax of the arrinit statement is shown below.
 * \code
 * // initialize arValues with nSize zeros
 * arrinit arValues, 0, nSize
 * \endcode
 *
 */

/** @page arrsubset arrsubset
 * \brief The arrsubset Statement
 *
 * The arrsubset statement copies a subset of the input array (second)
 * argument to the output array (first) argument. The subset begins at
 * the specified index (third) argument. The number of elements in the
 * subset is specified using the length (fourth) argument. The syntax
 * of the arrsubset statement is shown below.
 * \code
 * // copy the first x elements to arSub
 * arrsubset arSub, arValues, NA, x
 * \endcode
 *
 */

/** @page arrbuild arrbuild
 * \brief The arrbuild Statement
 *
 * The arrbuild statement constructs an output array from a variable
 * number of input arrays, scalars, or aggregates. The types of all
 * the input arguments must be compatible with the type of the output
 * array (first) argument. You must provide one or more comma-separated
 * input arguments. The syntax of the arrbuild statement is shown below.
 * \code
 * // build data array from 3 sources
 * arrbuild arData, arStart, arBody, arEnd
 * \endcode
 *
 */

/** @page arrop arrop
 * \brief The arrop Statement
 *
 * The arrop statement lets you perform several different operations on
 * an array containing numeric values.  The operations are \ref OPARR_SUM,
 * \ref OPARR_MEAN, \ref OPARR_SUMSQR, \ref OPARR_STD, \ref OPARR_MIN,
 * \ref OPARR_MAX, and \ref OPARR_SORT.
 *
 * In the case of \ref OPARR_SORT the output parameter should be an array of the
 * same type as the input array. In all the other cases it can be any
 * scalar type large enough to hold the resulting value. If the data in the
 * array is of the float type then the output should also be of the float
 * type.
 *
 * The fourth and fifth arguments indicate the starting element and
 * the number of elements to operate on.  To use the entire input array you
 * simply pass the \ref NA constant in as the value for start and length.
 * The syntax of the arrop statement is shown below.
 * \code
 * // execute an array operation
 * // arrop op, dest, src, start, len
 * arrop OPARR_SUM, sum, data, NA, NA
 * arrop OPARR_SORT, data2, data, NA, NA
 * \endcode
 *
 */

/** @page stringst String Statements
 * \brief String Statements
 *
 * String statements enable you to populate and manipulate null-terminated
 * byte arrays (aka strings) in your NBC programs.
 *
 * - @subpage flatten
 * - @subpage unflatten
 * - @subpage numtostr
 * - @subpage fmtnum
 * - @subpage strtonum
 * - @subpage strsubset
 * - @subpage strcat
 * - @subpage arrtostr
 * - @subpage strtoarr
 * - @subpage strindex
 * - @subpage strreplace
 * - @subpage strlen
 *
 */

/** @page flatten flatten
 * \brief The flatten Statement
 *
 * The flatten statement converts its input (second) argument into its
 * string output (first) argument. The syntax of the flatten statement
 * is shown below.
 * \code
 * flatten strData, args  // copy args structure to strData
 * \endcode
 *
 */

/** @page unflatten unflatten
 * \brief The unflatten Statement
 *
 * The unflatten statement converts its input string (third) argument to
 * the output (first) argument type.  If the default value (fourth)
 * argument type does not match the flattened data type exactly, including
 * array sizes, then error output (second) argument will be set to TRUE
 * and the output argument will contain a copy of the default argument.
 * The syntax of the unflatten statement is shown below.
 * \code
 * unflatten args, bErr, strSource, x  // convert string to cluster
 * \endcode
 *
 */

/** @page numtostr numtostr
 * \brief The numtostr Statement
 *
 * The numtostr statement converts its scalar input (second) argument to a
 * string output (first) argument. The syntax of the numtostr statement
 * is shown below.
 * \code
 * numtostr strValue, value  // convert value to a string
 * \endcode
 *
 */

/** @page fmtnum fmtnum
 * \brief The fmtnum Statement
 *
 * The fmtnum statement converts its scalar input (third) argument to
 * a string output (first) argument. The format of the string output is
 * specified via the format string (second) argument. The syntax of the
 * fmtnum statement is shown below.
 * \code
 * fmtnum strValue, fmtStr, value  // convert value to a string
 * \endcode
 *
 */

/** @page strtonum strtonum
 * \brief The strtonum Statement
 *
 * The strtonum statement parses its input string (third) argument into
 * a numeric output (first) argument, advancing an offset output (second)
 * argument past the numeric string. The initial input offset (fourth)
 * argument determines where the string parsing begins. The default (fifth)
 * argument is the value that is returned by the statement if an error
 * occurs while parsing the string. The syntax of the strtonum statement
 * is shown below.
 * \code
 * // parse string into num
 * strtonum value, idx, strValue, idx, nZero
 * \endcode
 *
 */

/** @page strsubset strsubset
 * \brief The strsubset Statement
 *
 * The strsubset statement copies a subset of the input string (second)
 * argument to the output string (first) argument. The subset begins at
 * the specified index (third) argument. The number of characters in
 * the subset is specified using the length (fourth) argument. The syntax
 * of the strsubset statement is shown below.
 * \code
 * // copy the first x characters in strSource to strSub
 * strsubset strSub, strSource, NA, x
 * \endcode
 *
 */

/** @page strcat strcat
 * \brief The strcat Statement
 *
 * The strcat statement constructs an output string from a variable number
 * of input strings. The input arguments must all be null-terminated byte
 * arrays. You must provide one or more comma-separated input arguments.
 * The syntax of the strcat statement is shown below.
 * \code
 * // build data string from 3 sources
 * strcat strData, strStart, strBody, strEnd
 * \endcode
 *
 */

/** @page arrtostr arrtostr
 * \brief The arrtostr Statement
 *
 * The arrtostr statement copies the input byte array (second) argument
 * into its output string (first) argument and adds a null-terminator byte
 * at the end. The syntax of the arrtostr statement is shown below.
 * \code
 * arrtostr strData, arrData  // convert byte array to string
 * \endcode
 *
 */

/** @page strtoarr strtoarr
 * \brief The strtoarr Statement
 *
 * The strtoarr statement copies the input string (second) argument into
 * its output byte array (first) argument excluding the last byte, which
 * should be a null. The syntax of the strtoarr statement is shown below.
 * \code
 * strtoarr arrData, strData  // convert string to byte array
 * \endcode
 *
 */

/** @page strindex strindex
 * \brief The strindex Statement
 *
 * The strindex statement extracts a single element from the source
 * string and returns the value in the output (first) argument. The
 * last argument is the index of the desired element. The syntax of
 * the strindex statement is shown below.
 * \code
 * // extract strVal[idx] and store it in val
 * strindex val, strVal, idx
 * \endcode
 *
 */

/** @page strreplace strreplace
 * \brief The strreplace Statement
 *
 * The strreplace statement replaces one or more characters in a source
 * string and stores the modified string in an output string. The string
 * source argument (second) can be the same variable as the string
 * destination (first) argument to replace without copying the string.
 * The index of the character(s) to be replaced is specified via the
 * third argument. The new value (fourth) argument can be a string, in
 * which case multiple characters are replaced. The syntax of the
 * strreplace statement is shown below.
 * \code
 * // replace strValues[idx] with newStr in strNew
 * strreplace strNew, strValues, idx, newStr
 * \endcode
 *
 */

/** @page strlen strlen
 * \brief The strlen Statement
 *
 * The strlen statement returns the length of the input string (second)
 * argument in the scalar output (first) argument. The syntax of the
 * strlen statement is shown below.
 * \code
 * strlen nSize, strMsg  // nSize == length of strMsg
 * \endcode
 *
 */

/** @page schedst Scheduling Statements
 * \brief Scheduling Statements
 *
 * Scheduling statements enable you to control the execution of multiple
 * threads and the calling of subroutines in your NBC programs.
 *
 * - @subpage exit
 * - @subpage exitto
 * - @subpage start
 * - @subpage stopthread
 * - @subpage priority
 * - @subpage precedes
 * - @subpage follows
 * - @subpage acquire
 * - @subpage release
 * - @subpage subcall
 * - @subpage subret
 * - @subpage call
 * - @subpage return
 *
 */

/** @page exit exit
 * \brief The exit Statement
 *
 * The exit statement finalizes the current thread and schedules zero or
 * more dependant threads by specifying start and end dependency list
 * indices. The thread indices are zero-based and inclusive. The two
 * arguments are optional, in which case the compiler automatically
 * adds indices for all the dependencies. The syntax of the exit
 * statement is shown below.
 * \code
 * exit 0, 2  // schedule this thread's 3 dependants
 * exit // schedule all this thread's dependants
 * \endcode
 *
 */

/** @page exitto exitto
 * \brief The exitto Statement
 *
 * The exitto statement exits the current thread and schedules the
 * specified thread to begin executing. The syntax of the exitto
 * statement is shown below.
 * \code
 * exitto worker  // exit now and schedule worker thread
 * \endcode
 *
 */

/** @page start start
 * \brief The start Statement
 *
 * The start statement causes the thread specified in the statement to
 * start running immediately. Using the standard NXT firmware this
 * statement is implemented by the compiler using a set of
 * compiler-generated subroutines. The enhanced NBC/NXC firmware
 * implements this statement natively. The syntax of the start
 * statement is shown below.
 * \code
 * start worker  // start the worker thread
 * \endcode
 *
 */

/** @page stopthread stopthread
 * \brief The stopthread Statement
 *
 * The stopthread statement causes the thread specified in the
 * statement to stop running immediately. This statement cannot be used
 * with the standard NXT firmware. It is supported by the enhanced
 * NBC/NXC firmware. The syntax of the stopthread statement is shown below.
 * \code
 * stopthread worker  // stop the worker thread
 * \endcode
 *
 */

/** @page priority priority
 * \brief The priority Statement
 *
 * The priority statement modifies the priority of the thread specified
 * in the statement. This statement cannot be used with the standard
 * NXT firmware. It is supported by the enhanced NBC/NXC firmware. The
 * syntax of the priority statement is shown below.
 * \code
 * priority worker, 50  // change the priority of the worker thread
 * \endcode
 *
 */

/** @page precedes precedes
 * \brief The precedes Statement
 *
 * The precedes statement causes the compiler to mark the threads listed
 * in the statement as dependants of the current thread. A subset of these
 * threads will begin executing once the current thread exits, depending
 * on the form of the exit statement used at the end of the current
 * thread. The syntax of the precedes statement is shown below.
 * \code
 * precedes worker, music, walking  // configure dependant threads
 * \endcode
 *
 */

/** @page follows follows
 * \brief The follows Statement
 *
 * The follows statement causes the compiler to mark the current thread
 * as a dependant of the threads listed in the statement. The current
 * thread will be scheduled to execute if all of the threads that precede
 * it have exited and scheduled it for execution. The syntax of the
 * follows statement is shown below.
 * \code
 * follows main  // configure thread dependencies
 * \endcode
 *
 */

/** @page acquire acquire
 * \brief The acquire Statement
 *
 * The acquire statement acquires the named mutex.  If the mutex is
 * already acquired the current thread waits until it becomes available.
 * The syntax of the acquire statement is shown below.
 * \code
 * acquire muFoo  // acquire mutex for subroutine
 * \endcode
 *
 */

/** @page release release
 * \brief The release Statement
 *
 * The release statement releases the named mutex allowing other threads
 * to acquire it. The syntax of the release statement is shown below.
 * \code
 * release muFoo  // release mutex for subroutine
 * \endcode
 *
 */

/** @page subcall subcall
 * \brief The subcall Statement
 *
 * The subcall statement calls into the named thread/subroutine and waits
 * for a return (which might not come from the same thread). The second
 * argument is a variable used to store the return address. The syntax
 * of the subcall statement is shown below.
 * \code
 * subcall drawText, retDrawText  // call drawText subroutine
 * \endcode
 *
 */

/** @page subret subret
 * \brief The subret Statement
 *
 * The subret statement returns from a thread to the return address
 * value contained in its input argument. The syntax of the subret
 * statement is shown below.
 * \code
 * subret retDrawText  // return to calling routine
 * \endcode
 *
 */

/** @page call call
 * \brief The call Statement
 *
 * The call statement executes the named subroutine and waits for a
 * return.  The argument should specify a thread that was declared
 * using the subroutine keyword. The syntax of the call statement
 * is shown below.
 * \code
 * call MyFavoriteSubroutine  // call routine
 * \endcode
 *
 */

/** @page return return
 * \brief The return Statement
 *
 * The return statement returns from a subroutine. The compiler
 * automatically handles the return address for call and return when
 * they are used with subroutines rather than threads. The syntax of
 * the return statement is shown below.
 * \code
 * return  // return to calling routine
 * \endcode
 *
 */

/** @page inputst Input Statements
 * \brief Input Statements
 *
 * Input statements enable you to configure the four input ports and read
 * analog sensor values in your NBC programs. Both statements in this
 * category use input field identifiers to control which attribute of
 * the input port you are manipulating.
 *
 * - @subpage setin
 * - @subpage getin
 *
 */

/** @page setin setin
 * \brief The setin Statement
 *
 * The setin statement sets an input field of a sensor on a port to the
 * value specified in its first argument. The port is specified via the
 * second argument. The input field identifier is the third argument.
 * Valid input field identifiers
 * are listed in the \ref InputFieldConstants section. Valid port constants
 * are listed in the \ref NBCInputPortConstants section.
 * The syntax of the setin statement is shown below.
 * \code
 * setin IN_TYPE_SWITCH, IN_1, Type // set sensor to switch type
 * setin IN_MODE_BOOLEAN, IN_1, InputMode // set to boolean mode
 * \endcode
 *
 */

/** @page getin getin
 * \brief The getin Statement
 *
 * The getin statement reads a value from an input field of a sensor on a
 * port and writes the value to its first argument. The port is specified
 * via the second argument. The input field identifier is the third
 * argument.
 * Valid input field identifiers
 * are listed in the \ref InputFieldConstants section. Valid port constants
 * are listed in the \ref NBCInputPortConstants section.
 * The syntax of the getin statement is shown below.
 * \code
 * getin rVal, thePort, RawValue  // read raw sensor value
 * getin sVal, thePort, ScaledValue  // read scaled sensor value
 * getin nVal, thePort, NormalizedValue  // read normalized value
 * \endcode
 *
 */

/** @page outputst Output Statements
 * \brief Output Statements
 *
 * Output statements enable you to configure and control the three NXT
 * outputs in your NBC programs. Both statements in this category use
 * output field identifiers to control which attribute of the output
 * you are manipulating.
 *
 * - @subpage setout
 * - @subpage getout
 *
 */

/** @page setout setout
 * \brief The setout Statement
 *
 * The setout statement sets one or more output fields of a motor on one
 * or more ports to the value specified by the coupled input arguments. The
 * first argument is either a scalar value specifying a single port or a
 * byte array specifying multiple ports. After the port argument you then
 * provide one or more pairs of output field identifiers and values. You
 * can set multiple fields via a single statement.
 * Valid output field identifiers
 * are listed in the \ref OutputFieldConstants section. Valid output
 * port constants are listed in the \ref OutputPortConstants section.
 * The syntax of the setout statement is shown below.
 * \code
 * set theMode, OUT_MODE_MOTORON  // set mode to motor on
 * set rsVal, OUT_RUNSTATE_RUNNING // motor running
 * set thePort, OUT_A  // set port to #1
 * set pwr, -75 // negative power means reverse motor direction
 * // set output values
 * setout thePort, OutputMode, theMode, RunState, rsVal, Power, pwr
 * \endcode
 *
 */

/** @page getout getout
 * \brief The getout Statement
 *
 * The getout statement reads a value from an output field of a sensor on
 * a port and writes the value to its first output argument. The port is
 * specified via the second argument. The output field identifier is
 * the third argument.
 * Valid output field identifiers
 * are listed in the \ref OutputFieldConstants section. Valid output
 * port constants are listed in the \ref OutputPortConstants section.
 * The syntax of the getout statement is shown below.
 * \code
 * getout rmVal, thePort, RegMode  // read motor regulation mode
 * getout tlVal, thePort, TachoLimit  // read tachometer limit value
 * getout rcVal, thePort, RotationCount // read the rotation count
 * \endcode
 *
 */

/** @page compst Compile-time Statements
 * \brief Compile-time Statements
 *
 * Compile-time statements and functions enable you to perform simple
 * compiler operations at the time you compile your NBC programs.
 *
 * - @subpage sizeof
 * - @subpage valueof
 * - @subpage isconst
 * - @subpage compchk
 * - @subpage compif
 * - @subpage compelse
 * - @subpage compend
 * - @subpage compchktype
 *
 */

/** @page sizeof sizeof
 * \brief The sizeof function
 *
 * The sizeof(arg) compiler function returns the size of the variable you
 * pass into it. The syntax of the sizeof function is shown below.
 * \code
 * dseg segment
 *   arg byte
 *   argsize byte
 * dseg ends
 * // ...
 * set argsize, sizeof(arg) // argsize == 1
 * \endcode
 *
 */

/** @page valueof valueof
 * \brief The valueof function
 *
 * The valueof(arg) compiler function returns the value of the constant
 * expression you pass into it. The syntax of the valueof function is
 * shown below.
 * \code
 * set argval, valueof(4+3*2) // argval == 10
 * \endcode
 *
 */

/** @page isconst isconst
 * \brief The isconst function
 *
 * The isconst(arg) compiler function returns TRUE if the argument you
 * pass into it is a constant and FALSE if it is not a constant. The
 * syntax of the isconst function is shown below.
 * \code
 * set argval, isconst(4+3*2) // argval == TRUE
 * \endcode
 *
 */

/** @page compchk compchk
 * \brief The compchk Statement
 *
 * The compchk compiler statement takes a comparison constant as its first
 * argument. The second and third arguments must be constants or constant
 * expressions that can be evaluated by the compiler during program
 * compilation. It reports a compiler error if the comparison expression
 * does not evaluate to TRUE. Valid comparison constants are listed in
 * the \ref cmpconst section. The syntax of the compchk statement is shown below.
 * \code
 * compchk EQ, sizeof(arg3), 2
 * \endcode
 *
 */

/** @page compif compif
 * \brief The compif Statement
 *
 * The compif statement works together with the compelse and compend compiler
 * statements to create a compile-time if-else statement that enables you to
 * control whether or not sections of code should be included in the compiler
 * output. The compif statement takes a comparison constant as its first
 * argument. The second and third arguments must be constants or constant
 * expressions that can be evaluated by the compiler during program
 * compilation. If the comparison expression is true then code immediate
 * following the statement will be included in the executable. The compiler
 * if statement ends when the compiler finds the next compend statement.
 * To optionally provide an else clause use the compelse statement between
 * the compif and compend statements. Valid comparison constants are
 * listed in the \ref cmpconst section.
 * The syntax of the compif statement is demonstrated in the example below.
 * \code
 * compif EQ, sizeof(arg3), 2
 *   // compile this if sizeof(arg3) == 2
 * compelse
 *   // compile this if sizeof(arg3) != 2
 * compend
 * \endcode
 *
 */

/** @page compelse compelse
 * \brief The compelse Statement
 *
 * The compelse statement works together with the compif and compend compiler
 * statements to create a compile-time if-else statement that enables you to
 * control whether or not sections of code should be included in the compiler
 * output. If the comparison expression in the compif statement is false
 * then code immediately following the compelse statement will be included
 * in the executable. The compelse block ends when the compiler finds the next
 * compend statement.
 * The syntax of the compelse statement is shown in the example below.
 * \code
 * compif EQ, sizeof(arg3), 2
 *   // compile this if sizeof(arg3) == 2
 * compelse
 *   // compile this if sizeof(arg3) != 2
 * compend
 * \endcode
 *
 */

/** @page compend compend
 * \brief The compend Statement
 *
 * The compend statement works together with the compif and compelse compiler
 * statements to create a compile-time if-else statement that enables you to
 * control whether or not sections of code should be included in the compiler
 * output. The compif and compelse blocks end when the compiler finds the next
 * compend statement.
 * The syntax of the compend statement is shown in the example below.
 * \code
 * compif EQ, sizeof(arg3), 2
 *   // compile this if sizeof(arg3) == 2
 * compelse
 *   // compile this if sizeof(arg3) != 2
 * compend
 * \endcode
 *
 */

/** @page compchktype compchktype
 * \brief The compchktype Statement
 *
 * The compchktype compiler statement takes a variable as its first
 * argument. The second argument must be type name
 * that can be evaluated by the compiler during program
 * compilation. It reports a compiler error if the type of the variable does not
 * match the second argument.
 * The syntax of the compchktype statement is shown below.
 * \code
 *   compchktype _args, TDrawText
 *   syscall DrawText, _args
 * \endcode
 *
 */

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
 * as sensors 1, 2, 3, and 4. To help mitigate this confusion,
 * the NBC port name constants
 * \ref IN_1, \ref IN_2, \ref IN_3, and \ref IN_4 may be used when
 * a sensor port is required. See \ref NBCInputPortConstants.
 */

/** @defgroup InputModuleConstants Input module constants
 * Constants that are part of the NXT firmware's Input module.
 */

/** @defgroup InputModuleTypesAndModes Sensor types and modes
 * Constants that are used for defining sensor types and modes.
 *
 * The sensor ports on the NXT are capable of interfacing to a variety of different sensors.
 * It is up to the program to tell the NXT what kind of sensor is attached to each port.
 * Calling \ref SetSensorType configures a sensor's type. There are 16 sensor types, each
 * corresponding to a specific type of LEGO RCX or NXT sensor. Two of these types are
 * for NXT I2C digital sensors, either 9V powered or unpowered, and a third is used to
 * configure port \ref IN_4 as a high-speed RS-485 serial port. A seventeenth type
 * (\ref IN_TYPE_CUSTOM) is for use with custom analog sensors. And an eighteenth type
 * (\ref IN_TYPE_NO_SENSOR) is used to indicate that no sensor has been configured, effectively
 * turning off the specified port.
 *
 * In general, a program should configure the type to match the actual sensor. If a sensor
 * port is configured as the wrong type, the NXT may not be able to read it accurately.
 * Use the \ref NBCSensorTypeConstants.
 *
 * The NXT allows a sensor to be configured in different modes. The sensor mode determines
 * how a sensor's raw value is processed. Some modes only make sense for certain types of
 * sensors, for example \ref IN_MODE_ANGLESTEP is useful only with rotation sensors. Call
 * \ref SetSensorMode to set the sensor mode. The possible modes are shown below. Use
 * the \ref NBCSensorModeConstants.
 *
 * The NXT provides a boolean conversion for all sensors - not just touch sensors. This boolean
 * conversion is normally based on preset thresholds for the raw value. A "low" value (less
 * than 460) is a boolean value of 1. A high value (greater than 562) is a boolean value of 0.
 * This conversion can be modified: a slope value between 0 and 31 may be added to a sensor's
 * mode when calling \ref SetSensorMode. If the sensor's value changes more than the slope value
 * during a certain time (3ms), then the sensor's boolean state will change. This allows the
 * boolean state to reflect rapid changes in the raw value. A rapid increase will result in a
 * boolean value of 0, a rapid decrease is a boolean value of 1.
 *
 * Even when a sensor is configured for some other mode (i.e. \ref IN_MODE_PCTFULLSCALE), the boolean
 * conversion will still be carried out.
 */

/** @defgroup OutputModule Output module
 * Constants and functions related to the Output module.
 *
 * The NXT output module encompasses all the motor outputs.
 *
 * Nearly all of the NBC API functions dealing with outputs take either a
 * single output or a set of outputs as their first argument. Depending on
 * the function call, the output or set of outputs may be a constant or a
 * variable containing an appropriate output port value. The constants
 * \ref OUT_A, \ref OUT_B, and \ref OUT_C are used to identify the three
 * outputs. Unlike NQC, adding individual outputs together does not combine
 * multiple outputs. Instead, the NBC API provides predefined combinations
 * of outputs: \ref OUT_AB, \ref OUT_AC, \ref OUT_BC, and \ref OUT_ABC.
 * Manually combining outputs involves creating an array and adding two or
 * more of the three individual output constants to the array.
 *
 * \ref Power levels can range 0 (lowest) to 100 (highest). Negative power
 * levels reverse the direction of rotation (i.e., forward at a power level
 * of -100 actually means reverse at a power level of 100).
 *
 * The outputs each have several fields that define the current state of the
 * output port. These fields are defined in the \ref OutputFieldConstants section.
 */

/** @defgroup OutputModuleConstants Output module constants
 * Constants that are part of the NXT firmware's Output module.
 */

/** @defgroup CommandModule Command module
 * Constants and functions related to the Command module.
 *
 * The NXT command module encompasses support for the execution of user programs via
 * the NXT virtual machine. It also implements the direct command protocol support that
 * enables the NXT to respond to USB or Bluetooth requests from other devices such as a
 * PC or another NXT brick.
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
 * devices connected to the NXT brick. The NXT firmware also implements a message
 * queuing or mailbox system which you can access using these methods.
 *
 * Communication via Bluetooth uses a master/slave connection system. One device
 * must be designated as the master device before you run a program using Bluetooth.
 * If the NXT is the master device then you can configure up to three slave devices
 * using connection 1, 2, and 3 on the NXT brick. If your NXT is a slave device
 * then connection 0 on the brick must be reserved for the master device.
 *
 * Programs running on the master NXT brick can send packets of data to any connected
 * slave devices using the BluetoothWrite method. Slave devices write response packets
 * to the message queuing system where they wait for the master device to poll for the
 * response.
 *
 * Using the direct command protocol, a master device can send messages to slave NXT
 * bricks in the form of text strings addressed to a particular mailbox. Each mailbox
 * on the slave NXT brick is a circular message queue holding up to five messages. Each
 * message can be up to 58 bytes long.
 *
 * To send messages from a master NXT brick to a slave brick, use BluetoothWrite on
 * the master brick to send a MessageWrite direct command packet to the slave. Then,
 * you can use ReceiveMessage on the slave brick to read the message. The slave NXT
 * brick must be running a program when an incoming message packet is received. Otherwise,
 * the slave NXT brick ignores the message and the message is dropped.
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
 * processors that control the NXT. The NBC API exposes two functions that
 * are part of this module.
 */

/** @defgroup LoaderModule Loader module
 * Constants and functions related to the Loader module.
 *
 * The NXT loader module encompasses support for the NXT file system. The NXT supports creating files,
 * opening existing files, reading, writing, renaming, and deleting files.
 *
 * Files in the NXT file system must adhere to the 15.3 naming convention for a maximum
 * filename length of 19 characters. While multiple files can be opened simultaneously, a
 * maximum of 4 files can be open for writing at any given time.
 *
 * When accessing files on the NXT, errors can occur. The NBC API defines several constants
 * that define possible result codes. They are listed in the \ref LoaderErrors section.
 */

/** @defgroup SoundModule Sound module
 * Constants and functions related to the Sound module.
 *
 * The NXT sound module encompasses all sound output features. The NXT provides support for
 * playing basic tones as well as two different types of files.
 *
 * Sound files (.rso) are like .wav files. They contain thousands of sound samples that digitally
 * represent an analog waveform. With sounds files the NXT can speak or play music or make just
 * about any sound imaginable.
 *
 * Melody files are like MIDI files. They contain multiple tones with each tone being defined
 * by a frequency and duration pair. When played on the NXT a melody file sounds like a pure
 * sine-wave tone generator playing back a series of notes. While not as fancy as sound files,
 * melody files are usually much smaller than sound files.
 *
 * When a sound or a file is played on the NXT, execution of the program does not wait for the
 * previous playback to complete. To play multiple tones or files sequentially it is necessary to
 * wait for the previous tone or file playback to complete first. This can be done via the \ref wait
 * statement or by using the sound state value within a while loop.
 *
 * The NBC API defines frequency and duration constants which may be used in calls to \ref PlayTone or
 * \ref PlayToneEx. Frequency constants start with \ref TONE_A3 (the 'A' pitch in octave 3) and go to
 * \ref TONE_B7 (the 'B' pitch in octave 7). Duration constants start with \ref MS_1 (1 millisecond) and
 * go up to \ref MIN_1 (60000 milliseconds) with several constants in between. See NBCCommon.h for
 * the complete list.
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
 * The NXT low speed module encompasses support for digital I2C sensor communication.
 *
 * Use the lowspeed (aka I2C) communication methods to access devices that use the I2C
 * protocol on the NXT brick's four input ports.
 *
 * You must set the input port's \ref Type property to \ref IN_TYPE_LOWSPEED or
 * \ref IN_TYPE_LOWSPEED_9V on a given port before using an I2C device on that
 * port. Use \ref IN_TYPE_LOWSPEED_9V if your device requires 9V power from the
 * NXT brick. Remember that you also need to set the input port's
 * \ref InvalidData property to true after setting a new \ref Type, and then
 * wait in a loop for the NXT firmware to set \ref InvalidData back to false.
 * This process ensures that the firmware has time to properly initialize the
 * port, including the 9V power lines, if applicable. Some digital devices
 * might need additional time to initialize after power up.
 *
 * The \ref SetSensorLowspeed API function sets the specified port to
 * \ref IN_TYPE_LOWSPEED_9V and calls \ref ResetSensor to perform the
 * \ref InvalidData reset loop described above.
 *
 * When communicating with I2C devices, the NXT firmware uses a master/slave
 * setup in which the NXT brick is always the master device. This means that
 * the firmware is responsible for controlling the write and read operations.
 * The NXT firmware maintains write and read buffers for each port, and the
 * three main Lowspeed (I2C) methods described below enable you to access these
 * buffers.
 *
 * A call to \ref LowspeedWrite starts an asynchronous transaction between
 * the NXT brick and a digital I2C device. The program continues to run while
 * the firmware manages sending bytes from the write buffer and reading the
 * response bytes from the device. Because the NXT is the master device, you
 * must also specify the number of bytes to expect from the device in response
 * to each write operation. You can exchange up to 16 bytes in each direction
 * per transaction.
 *
 * After you start a write transaction with \ref LowspeedWrite, use \ref
 * LowspeedStatus in a loop to check the status of the port. If \ref
 * LowspeedStatus returns a status code of 0 and a count of bytes available
 * in the read buffer, the system is ready for you to use \ref LowspeedRead
 * to copy the data from the read buffer into the buffer you provide.
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
 * The NXT display module encompasses support for drawing to the NXT LCD.
 * The NXT supports drawing points, lines, rectangles, and circles on the LCD.
 * It supports drawing graphic icon files on the screen as well as text and
 * numbers. With the enhanced NBC/NXC firmware you can also draw ellipses and
 * polygons as well as text and numbers using custom RIC-based font files.
 * Also, all of the drawing operations have several drawing options for how
 * the shapes are drawn to the LCD.
 *
 * The LCD screen has its origin (0, 0) at the bottom left-hand corner of
 * the screen with the positive Y-axis extending upward and the positive
 * X-axis extending toward the right. The NBC API provides constants for
 * use in the \ref NumOut and \ref TextOut functions which make it possible
 * to specify LCD line numbers between 1 and 8 with line 1 being at the top of
 * the screen and line 8 being at the bottom of the screen. These constants
 * (\ref LCD_LINE1, \ref LCD_LINE2, \ref LCD_LINE3, \ref LCD_LINE4,
 * \ref LCD_LINE5, \ref LCD_LINE6, \ref LCD_LINE7, \ref LCD_LINE8)
 * should be used as the Y coordinate in NumOut and TextOut calls. Values of
 * Y other than these constants will be adjusted so that text and numbers
 * are on one of 8 fixed line positions.
 */

/** @defgroup HiTechnicAPI HiTechnic API Functions
 * Functions for accessing and modifying HiTechnic devices.
 */

/** @defgroup MindSensorsAPI MindSensors API Functions
 * Functions for accessing and modifying MindSensors devices.
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

/** @defgroup GraphicsLibrary A simple 3D graphics library
 * Documentation for a simple 3D graphics library.  The library code was
 * written by Arno van der Vegt.
 */

#include "NXTDefs.h"

#endif // NBCAPIDOCS_H
