(*
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
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uLocalizedStrings;

interface

// BricxCC unit
resourcestring
  S_RESET = 'reload defaults from Default directory';
  S_COM   = 'use the named port for this instance (COM1..COMnnn, usb)';
  S_RCX   = 'use brick type N for this instance';
  S_AUTO  = 'auto connect using default or specified port and type';
  S_NONE  = 'do not connect to brick at startup';
  S_POS   = 'position windows using values in INI file';
  S_HELP  = 'display this message before starting up';
  S_NT    = 'use compiler timeout specified for this instance (in seconds)';
  S_DEBUG = 'display debug message when launching compiler';
  S_USERPATH = 'set the path for user configuration files';

// MainUnit unit
resourcestring
  sNoRCX           = 'No connection to the programmable brick. Certain options will be unavailable.';
  sNoPort          = 'no port';
  sNoRobot         = 'no robot';
  sHideCodeError   = 'Hide Code/Error|Warning Listing';
  sShowCodeError   = 'Show Code/Error|Warning Listing';
  sFirmDwnldFailed = 'Firmware download failed. Put the RCX closer and try again.';
  sWrongNum        = 'wrong download number';
  sWarnCancelFD    = 'Firmware download cancelled.';
  sBrickCommError  = 'Unable to communicate with your brick';
  sRecording       = 'Recording';
  sEnterData       = 'Enter data';
  sEnterRunParams  = 'Enter run parameters';
  SFilterAllFiles  = 'All files|*.*|';
  sProgramLocked   = 'Program is locked.';
  sClearMemConfirm = 'Are you sure you want to clear the brick''s memory?';
  sBreakAll        = 'Break all';
  sContinue        = 'Continue';
  sFileMenu        = '&File';
  sEditMenu        = '&Edit';
  sCopySpecialMenu = 'Copy &Special';
  sSearchMenu      = '&Search';
  sViewMenu        = '&View';
  sProjectManager  = '&Project Manager';
  sCodeExplorer    = 'Code E&xplorer';
  sStatusBar       = '&Status bar';
  sTemplates       = 'T&emplates';
  sHideErrors      = '&Hide Errors';
  sToolWindows     = '&Tool Windows';
  sMacroManager    = '&Macro Manager';
  spbForthConsole  = 'pbForth Console';
  sWindowList      = '&Window List';
  sToolbarsMenu    = 'Tool&bars';
  sCompileMenu     = '&Compile';
  sProgramNumberMenu = '&Program Number';
  sProgram         = 'Program';
  sToolsMenu       = '&Tools';
  sbrickOSMenu     = '&brickOS';
  sSetLNPAddress   = '&Set LNP Address...';
  sLNPAddress      = 'LNP &Address';
  sAddress         = 'Address';
  sLNPPort         = 'LNP &Port';
  sPort            = 'Port';
  sWindowMenu      = '&Window';
  sTileHorizontal  = 'Tile &Horizontal';
  sTileVertical    = 'Tile &Vertical';
  sCascade         = '&Cascade';
  sArrangeIcons    = '&Arrange Icons';
  sPositionsMenu   = '&Positions';
  sSave            = 'Save';
  sLoad            = 'Load';
  sHelpMenu        = '&Help';
  sIndex           = '&Index';
  sNQCGuide        = '&NQC Guide';
  sHowToUseHelp    = '&How to Use Help';
  sWebPage         = '&Web page';
  sNextWindow      = '&Next window';

// Editor unit
resourcestring
  S_Overwrite      = 'Overwrite';
  S_Insert         = 'Insert';
  S_ReadOnly       = 'ReadOnly';
  S_FileChanged    = 'File %s has been modified. Save changes?';
  S_Modified       = 'Modified';
  sErrors          = 'Errors';
  sFullErrors      = 'Full errors in';
  sCodeListing     = 'Code listing of';
  sCompileSuccess  = 'Program compiled successfully.';
  sCompileErrors   = 'Errors found on program compile.';
  sCompileDownloadSuccess  = 'Program compiled and downloaded successfully.';
  sCompileDownloadErrors   = 'Errors found on program compile and download.';
  sUntitled         = 'Untitled';
  sFindDeclaration  = 'Find Dec&laration';
  sClosePage        = '&Close Page';
  sOpenFileAtCursor = 'Open &File at Cursor';
  sTopicSearch      = 'Topic &Search';
  sUndo             = 'U&ndo';
  sRedo             = '&Redo';
  sCut              = 'C&ut';
  sCopy             = 'Co&py';
  sPaste            = 'P&aste';
  sDelete           = 'D&elete';
  sSelectAll        = 'Selec&t All';
  sToggleBookmarksMenu = '&Toggle Bookmarks';
  sBookmark            = 'Bookmark';
  sGotoBookmarksMenu   = '&Goto Bookmarks';
  sViewExplorer     = 'View E&xplorer';
  sToggleBreakpoint = 'Toggle Breakpoint';


// CodeUnit unit
resourcestring
  sFind         = '&Find';
  sFindNext     = 'Find &Next';
  sFindPrevious = 'Find &Previous';
  sStayOnTop    = 'Stay on &top';

// GotoLine unit
resourcestring
  sGotoError = 'Line must be between 1 and %d.';

// GX_ProcedureList
resourcestring
  SAllString  = '<All>';
  SNoneString = '<None>';
  SInvalidIndex = 'Invalid index number';
  SParseStatistics = 'Procedures processed in %g seconds';

// SearchRCX unit
resourcestring
  S_CANNOT_FIND_RCX = 'Cannot find brick. Switch it on or move it closer and press OK.';

// Translate unit
resourcestring
  S_TRANSLATE = 'Translating an old NQC program into NQC 2.0. ' +
                'This might not be completely correct. ' +
                'Please check afterwards. Do you want to continue?';

// uCodeExplorer unit
resourcestring
  sUnableToParseFile = 'Unable to parse current file';


// uParseCommon unit + others
resourcestring
  SImplementationNotFound = 'Implementation section not found (parser error?)';
  sUnknown      = 'Unknown';
  sFunction     = 'Function';
  sProcedure    = 'Procedure';
  sConstructor  = 'Constructor';
  sDestructor   = 'Destructor';
  sClassFunc    = 'Class Func';
  sClassProc    = 'Class Proc';
  sTask         = 'Task';
  sSubroutine   = 'Subroutine';
  sMacros       = 'Macros';
  sFunctions    = 'Functions';
  sSubroutines  = 'Subroutines';
  sTasks        = 'Tasks';
  sProcedures   = 'Procedures';
  sConstructors = 'Constructors';
  sDestructors  = 'Destructors';
  sExploring    = 'Exploring';

// uMacroForm unit
resourcestring
  sConfirmDeleteMM = 'Delete selected macro?';

// About unit
resourcestring
  sVersion = 'Version';
  sBuild   = 'Build';


// dlgConfirmReplace
resourcestring
  SAskReplaceText = 'Replace this occurence of "%s"?';

// DTestPrintPreview
resourcestring
  sPageLabel    = ' Page: ';
  sPrintCmdHint = 'Print (%0:s)|Print the document on %0:s';
  sWholePage    = 'Whole page';
  sPageWidth    = 'Page width';

// Construct unit
resourcestring
  sExpandAll   = 'Expand All';
  sCollapseAll = 'Collapse All';
  sDoubleClickToInsert = 'Double Click to Insert';

// ExecProgram unit
resourcestring
  sTimeout = 'Program execution timed out.  Try increasing the timeout value.';
  sAborted = 'Program execution aborted.';
  sUnableToExecute = 'Unable to create process:' + #10 + '%s' + #10#10 +
     'Make sure %s is in a directory on the system path ' + #10 +
     'or in the same directory as the controlling program' + #10 + '(%s).';

// Preferences unit
resourcestring
  S_ChangeMacroCaption    = 'Changing a Macro';
  S_ChangeMacroPrompt     = 'Change Macro %s:';
  S_ChangeTemplateCaption = 'Changing a Template';
  S_ChangeTemplatePrompt  = 'Change the Template:';
  S_InsertTemplateCaption = 'Inserting a Template';
  S_InsertTemplatePrompt  = 'Type the template you want to insert:';
  S_KeystrokeCaption      = 'Keystroke Editor';
  S_CodeTemplatesCaption  = 'Code Templates';
  S_ConfirmAPIDelete      = 'Are you sure you want to delete this item?';

// Controller unit
resourcestring
  sRaw         = 'Raw';
  sBoolean     = 'Boolean';
  sTransCount  = 'Trans Count';
  sPeriodCount = 'Period Count';
  sPercent     = 'Percent';
  sCelsius     = 'Celsius';
  sFahrenheit  = 'Fahrenheit';
  sAngle       = 'Angle';
  sNone        = 'None';
  sSwitch      = 'Switch';
  sTemperature = 'Temperature';
  sLight       = 'Reflection';
  sLightActiv  = 'Light Active';
  sLightInact  = 'Light Inactive';
  sSoundDB     = 'Sound DB';
  sSoundDBA    = 'Sound DBA';
  sCustom      = 'Custom';
  sLowspeed    = 'Lowspeed';
  sLowspeed9v  = 'Lowspeed 9V';
  sHighspeed   = 'Highspeed';
  sScoutSourceError = 'Scout only supports variable and constant sources';
  sNonSpybotSrcError = 'Only Spybots support sources past Indirect';

// Diagnose unit
resourcestring
  sRCXDead = 'Brick is NOT alive';
  sRCXAlive = 'Brick is alive';
  sVariable = 'Variable ';
  sWatch    = 'Watch';
  sInput1   = 'Input 1';
  sInput2   = 'Input 2';
  sInput3   = 'Input 3';
  sOutputA  = 'Output A';
  sOutputB  = 'Output B';
  sOutputC  = 'Output C';
  sUserSelect = 'User Select';
  sExceptions = 'Exceptions';

// EditCodeTemplate unit
resourcestring
  sNewTemplate = 'New Code Template';
  sEditTemplate = 'Edit Code Template';

// JoystickUnit unit
resourcestring
  sDriveMotor = 'Drive Motor';
  sSteerMotor = 'Steer Motor';
  sLeftMotor  = 'Left Motor';
  sRightMotor = 'Right Motor';

// MemoryUnit unit
resourcestring
  sDownloadMemMapFailed = 'Memory map download failed!';
  sSubroutinePointers   = 'Subroutine Pointers';
  sTaskPointers         = 'Task Pointers';
  sSoundPointers        = 'Sound Pointers';
  sAnimationPointers    = 'Animation Pointers';
  sDataPointer          = 'Data Pointer:            ';
  sTopOfMemory          = 'Top of Memory:           ';
  sFreeMemLeft          = 'Free Memory Left:        ';
  sTotalUsed            = 'Total Memory Used:       ';
  sDatalogStart         = 'Datalog Start Pointer:   ';
  sDatalogCurrent       = 'Datalog Current Pointer: ';

// Transdlg unit
resourcestring
  sColMacro = 'Cursor column in active editor';
  sRowMacro = 'Cursor row in active editor';
  sCurTokenMacro = 'Word at cursor in active editor';
  sPathMacro = 'Directory portion of parameter';
  sNameMacro = 'File name of parameter';
  sNameOnlyMacro = 'File name of parameter without extension';
  sExtMacro = 'File extension of parameter';
  sEdNameMacro = 'Expanded file name of active editor';
  sPromptMacro = 'Prompt for information';
  sSaveMacro = 'Save file in active editor';
  sSaveAllMacro = 'Save all modified files';
  sPortMacro = 'Current port';
  sTargetMacro = 'Current target';

// Transfer unit
resourcestring
  sConfirm = 'Delete the item entitled %s?';

// uCmdLineUtils unit
resourcestring
  UsageErrorMessage = 'Use "%s -help" for more information.';
  VersionString = ' version ';
  BuiltString = ' built ';

// uEEPROM unit
resourcestring
  sEEPROMLoadError = 'Error loading EEPROM data';
  sConfirmEEPROMWrite = 'Are you sure you want to write data to the brick?';

// uExplorerOptions unit
resourcestring
  sHidden = 'Hidden';
  sVisible = 'Visible';
  sCollapsed = 'Collapsed';
  sExpanded = 'Expanded';

// uMacroLib unit
resourcestring
  sMacroLibFormatError = 'Invalid macro library format';

// uNewWatch unit
resourcestring
  sWatchError = 'Cannot find the brick anymore';

// uNXTExplorer unit
resourcestring
  sConfirmDel     = 'Delete all the selected files?';
  sConfirmDefrag  = 'Defragment the NXT filesystem?';
  sConfirmErase   = 'Erase all files on the NXT?';
  sLowBattery     = 'Battery level is too low to complete this operation';
  sDefragError    = 'Defragmentation failed!';
  sDefragSuccess  = 'Defragmentation complete!';
  sTooBig         = 'File size (%d) of "%s" is too large.';
  sDownloadFailed = 'Download failed';
  sExit           = 'E&xit';
  sNXTViewStyleMenu = 'NXT View Style';
  sPCViewStyleMenu  = 'PC View Style';
  sAbout          = '&About';

// uNXTImage unit
resourcestring
  sBTResetConfirm   = 'Are you sure you want to reset Bluetooth to factory defaults?';
  sBootSAMBAConfirm = 'Are you sure you want to boot the NXT in SAMBA mode?';
  sUtilitiesMenu  = 'Utilities';
  sSetNXTName     = 'Set NXT Name';
  sBootSAMBA      = 'Boot NXT into SAMBA mode';
  sResetBluetooth = 'Reset Bluetooth to factory defaults';
  sRefreshRate    = '&Refresh Rate';
  sScale          = 'Sca&le';
  sDisplay        = '&Display';
  sNormal         = '&Normal';
  sPopup          = '&Popup';
  sPlayClicks     = 'Play Clicks';

// uProjectManager unit
resourcestring
  sRemoveConfirm = 'Remove the selected file(s) from the project?';

// uSetLNPAddress unit
resourcestring
  sFailedToSetLNPAddr   = 'Failed to set LNP address.'#13#10 +
    'Check the current address setting.';
  sSuccessfulSetLNPAddr = 'LNP Address successfully set to %d.';

// uWav2RsoCvt
resourcestring
  sErrRiffWaveFmt = 'Error processing %s: wave file is not RIFF/WAVE format';
  sErrPCMFmt      = 'Error processing %s: wave files must be in PCM, MS ADPCM, or IMA ADPCM format';
  sErr64kLimit    = 'Error processing %s: wave file exceeds 64k maximum size';
  sSuccess        = 'Success: %s';

// common to multiple compilers
resourcestring
  sException       = 'Exception';
  sProgramError    = '%d errors during compilation';
  sInvalidConstExpr        = 'Invalid constant expression';
  sUnmatchedCloseParen     = 'Unmatched close parenthesis';
  sParserError             = 'parser error';

// uRPGComp
resourcestring
  sNothingAfterEnd = 'Commands are not allowed after EndLoop or EndStop';
  sUnknownCommand  = 'Unknown RPG command';
  sTooManyCommands = 'Too many RPG commands in program';

// uRICComp
resourcestring
  sInvalidArgument         = 'invalid argument: %d';
  sInvalidVarMapIndex      = 'invalid varmap index: %d';
  sInvalidCommandArgument  = 'Invalid command argument';
  sSpriteLengthError       = 'sprite command must have rows with a length > 0';
  sInvalidMapSyntax        = 'Invalid map element function syntax';
  sInvalidPolygonSyntax    = 'Invalid polygon point syntax';
  sVarMapCountError        = 'varmap command must have at least two map elements';
  sPolygonCountError       = 'polygon command must have at least three points';
  sStringNotBinary         = 'String is not a valid binary number: %s';
  sInvalidHexLength        = 'Invalid length of hex string: %d';
  sUnableToFindImage       = 'Unable to find image file "%s"';

// uPreprocess unit
resourcestring
  sInvalidPreprocDirective  = 'Invalid preprocessor directive';
  sImportRICNotFound        = 'Unable to find RIC import file: "%s"';
  sImportRICMissingQuotes   = '#importric directive requires a filename (e.g., #importric "foo.ric")';
  sImportRICInvalid         = '#importric directive filename must end in ".ric"';
  sDownloadNotFound         = 'Unable to find download file: "%s"';
  sDownloadMissingQuotes    = '#download directive requires a filename (e.g., #download "foo.ric")';
  sIncludeNotFound          = 'Unable to find include file: "%s"';
  sIncludeMissingQuotes     = '#include directive requires a filename (e.g., #include "foo.h")';
  sMacroMismatch            = 'Preprocessor macro function does not match instance (%s)';
  sUnmatchedDirective       = 'Unmatched preprocessor directive';
  sInvalidPreprocExpression = 'Invalid preprocessor expression : %s';
  sInvalidCharConstant      = 'Invalid char constant';
  sMaxRecursionDepthError   = 'Max recursion depth (%d) exceeded';

// uNXTClasses
resourcestring
  sInvalidStatement    = 'Unknown or invalid statement';
  sInvalidLine         = 'Line type "%s" is not valid while in the "%s" state';
  sInvalidNumArgs      = 'Invalid number of arguments: %d expected, %d found';
  sInvalidNumArgsVar   = 'Invalid number of arguments: at least %d expected, %d found';
  sInvalidNumArgsOdd   = 'Invalid number of arguments: argument count must be odd';
  sInvalidCompareCode  = 'Invalid comparison code: %s';
  sBadConstExpression  = 'Invalid constant expression: %s';
  sConstOutOfRange     = '%d is outside the valid range [%d,%d]';
  sInvalidOpcode       = 'Invalid opcode: %s';
  sDuplicateLabel      = 'Duplicate label (%s)';
  sDuplicateDSEntry    = 'Duplicate variable declaration (%s)';
  sDuplicateType       = 'Duplicate type declaration (%s)';
  sInvalidVarDecl      = 'Invalid variable declaration (%s)';
  sInvalidVarArg       = 'Invalid variable argument: %s';
  sInvalidMutexArg     = 'Invalid mutex argument: %s';
  sInvalidClusterArg   = 'Invalid struct argument: %s';
  sInvalidArrayArg     = 'Invalid array argument: %s';
  sInvalidScalarArg    = 'Invalid scalar argument: %s';
  sInvalidStringArg    = 'Invalid string argument: %s';
  sInvalidLabelArg     = 'Invalid label argument: %s';
  sInvalidClumpArg     = 'Invalid thread argument: %s';
  sReturnNotInSub      = 'The return opcode can only be used within a subroutine';
  sNoReturnAtEndOfSub  = 'The last operation in a subroutine must be a return';
  sCompCheckFailed     = 'compchk failed.  %d is not %s %d.';
  sCompCheckTypFailed  = 'compchktype failed.  %s is not %s.';
  sInvalidCompCheck    = 'invalid compchk operation';
  sInvalidCompCheckTyp = 'invalid compchktype operation';
  sUnsafeDivision      = 'Dividing a signed number by an unsigned number is unsafe';
  sUnusedVar           = 'Unused variable: %s.  Enable optimization with -Z1 to remove.';
  sInvalidSetStatement = 'The set opcode cannot be used with float variables';
  sMainUndefined       = 'The main thread is not explicitly named';

// uNXCComp unit
resourcestring
  sTaskName                = 'Task name';
  sVariableName            = 'Variable name';
  sStringReturnValue       = 'String return value';
  sInvalidAssignment       = 'Invalid assignment';
  sDatatypesNotCompatible  = 'Datatypes are not compatible';
  sInlineInvalid           = 'The inline keyword may only be used with functions';
  sSafeCallInvalid         = 'The safecall keyword may only be used with functions';
  sBadPrototype            = 'Prototypes without parameter names are not supported';
  sMainMustBeTask          = 'main must be a task';
  sUDTNotEqual             = 'User-defined types do not match';
  sInvalidArrayDeclaration = 'Invalid array declaration';
  sInvalidGlobalArrayInit  = 'Invalid global array initialization';
  sUnknownUDT              = 'Unknown user-defined type';
  sReturnInvalid           = 'return is invalid outside a subroutine';
  sInvalidBreakContinue    = '%s is invalid outside of a loop';
  sProtoAlreadyDefined     = 'Prototype already defined - "begin"';
  sNotValidForPrototype    = 'Not valid for a prototype';
  sMissingDataType         = 'Missing Data Type';
  sDataTypesAlreadyDefined = 'Data types already defined in prototype';
  sParameterList           = 'Parameter List';
  sUnexpectedChar          = 'Unexpected character encountered';
  sValidProgBlock          = 'Valid Program Block Statement';
  sConstInitialization     = 'constant initialization';
  sInitNotAllowed          = 'Initialization is not allowed for mutex variables';
  sInvalidStringInit       = 'Invalid string initialization';
  sConstLocArrNotSupported = 'Constant local arrays are not supported';
  sUnknownAPICommand       = 'Unknown API command';
  sDefaultInvalid          = 'default is invalid outside a switch statement';
  sCaseInvalid             = 'case is invalid outside a switch statement';
  sInvalidUseOfTaskName    = 'Invalid use of task name';
  sInvalidArrayExpr        = 'Invalid array expression';
  sRecursiveInlineError    = 'Calling an inline function from an inline function is not supported';
  sNestedCallsError        = 'Nested calls to the same function are not supported.';
  sRecursiveNotAllowed     = 'Recursive function calls are not supported';
  sExpNotSupported         = 'Expressions are not supported for struct, array, or reference parameters';
  sEnhancedFirmwareReqd    = 'Enhanced firmware is required for this operation';
  sSymbolTableFull         = 'Symbol Table Full';
  sInvalidArrayDim         = 'Invalid array dimensions - must be from 1 to 4';
  sAssignTaskError         = 'Can not assign to a task or subroutine';
  sArgMustBeTask           = 'Argument must be a task';
  sInvalidReturnType       = 'Invalid return type';
  sInvalidStringAssign     = 'Invalid string assignment';
  sInvalidArrayIndex       = 'Invalid array index';
  sFloatNotSupported       = 'float types are not supported at the specified firmware version';
  sNoUnsignedFloat         = 'float types cannot be declared as unsigned';
  sMainTaskNotFound        = 'No task named "main" exists';

// uNBCCommon unit
resourcestring
  sExpectedString          = '%s expected';
  sDataType                = 'Data type';
  sIdentifier              = 'Identifier';
  sDirective               = 'Preprocessor directive';
  sNumber                  = 'Number';
  sHexNumber               = 'Hex number';
  sCharLiteral             = 'Character literal';
  sStringLiteral           = 'String literal';
  sStringType              = 'string constant or variable of type string';
  sByteArrayType           = 'byte array type';
  sStringVarType           = 'string type';
  sStructType              = 'struct type';
  sMutexType               = 'mutex type';
  sIntegerType             = 'integer type';
  sNumericType             = 'numeric type';
  sMathFactor              = 'Math Factor';
  sArrayOfString           = 'array of string';
  sArrayDatatype           = 'array data type';
  sUndefinedIdentifier     = 'Undefined Identifier %s';
  sDuplicateIdentifier     = 'Duplicate Identifier %s';
  sTooManyArgs             = 'Too many arguments';
  sTooFewArgs              = 'Too few arguments';
  sTooFewParams            = 'Too few parameters';
  sMaxParamCountExceeded   = 'Max param count exceeded';
  sConstNotAllowed         = 'Constant not allowed';

// nbc.dpr
resourcestring
  UsageSyntax    = 'Syntax: %s [options] filename [options]';
  UsagePort      = '   -S=<portname>: specify port name (COMn or usb), resource name, or alias';
  UsageBT        = '   -BT: use bluetooth';
  UsageDownload  = '   -d: download program';
  UsageRunProg   = '   -r: run program';
  UsageBinary    = '   -b: treat input file as a binary file (don''t compile it)';
  UsageQuiet     = '   -q: quiet';
  UsageNoSystem  = '   -n: prevent the system file from being included';
  UsageDefine    = '   -D=<sym>[=<value>]: define macro <sym>';
  UsageDecompile = '   -x: decompile program';
  UsageOptimize  = '   -Z[1|2]: turn on compiler optimizations';
  UsageMaxErrors = '   -ER=n: set maximum errors before aborting (0 == no limit)';
  UsageOutput    = '   -O=<outfile> : specify output file';
  UsageErrors    = '   -E=<filename> : write compiler errors to <filename>';
  UsageIncludes  = '   -I=<path>: search <path> for include files';
  UsageNBCOutput = '   -nbc=<filename> : save NXC intermediate NBC code to <filename>';
  UsageListing   = '   -L=<filename> : generate code listing to <filename>';
  UsageSymbols   = '   -Y=<filename> : generate symbol table to <filename>';
  UsageWarnings  = '   -w[-|+] : warnings off or on [default is on]';
  UsageEnhanced  = '   -EF : enhanced firmware';
  UsageSafecall  = '   -safecall: NXC will wrap all function calls in Acquire/Release';
  UsageAPI       = '   -api: dump the API to stdout';
  UsageFirmVer   = '   -v=n: set the targeted firmware version (default == 105)';
  UsageHelp      = '   -help : display command line options';

// uEditorExperts.pas
resourcestring
  SNoTokens = 'No tokens found to align on.';

implementation

end.