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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
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
  sNoBrick         = 'No connection to the programmable brick. Certain options will be unavailable.';
  sNoPort          = 'no port';
  sNoRobot         = 'no robot';
  sHideCodeError   = 'Hide Code/Error|Warning Listing';
  sShowCodeError   = 'Show Code/Error|Warning Listing';
  sFirmDwnldFailed = 'Firmware download failed. Please try again after checking configuration.';
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
  sGuidePDFs       = 'Guide PDFs';
  sTutorialPDFs    = 'Tutorial PDFs';

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
  sGotoLine     = '&Goto Line';
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
  S_CANNOT_FIND_BRICK = 'Cannot find brick. Switch it on or move it closer and press OK.';
  S_SEARCHING_NXT   = 'Searching for NXTs';
  S_SEARCHING_BRICK = 'Searching for a brick';

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
  sColorFull   = 'Color Full';
  sColorRed    = 'Color Red';
  sColorGreen  = 'Color Green';
  sColorBlue   = 'Color Blue';
  sColorNone   = 'Color None';
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
  sConfirmDefrag  = 'Defragment the PBrick filesystem.'#13#10 +
    'This operation attempts to a) upload all files from the PBrick ' +
    'to your computer, b) erase the PBrick flash memory, and c) download ' +
    'all the files back to the PBrick. It is possible that the defragment ' +
    'operation may not complete successfully and files may be lost.'#13#10 +
    'Do you want to go ahead with the defragmentation operation?';
  sConfirmErase   = 'Erase all files on the PBrick?';
  sLowBattery     = 'Battery level is too low to complete this operation';
  sDefragError    = 'Defragmentation failed!';
  sDefragSuccess  = 'Defragmentation complete!';
  sTooBig         = 'File size (%d) of "%s" is too large.';
  sDownloadFailed = 'Download failed';
  sExit           = 'E&xit';
  sNXTViewStyleMenu = 'PBrick View Style';
  sPCViewStyleMenu  = 'PC View Style';
  sAbout          = '&About';
  sSelectPath     = 'Select Path';
  sEnterPath      = 'Enter new path';
  sFolderName     = 'Folder Name';
  sEnterFolder    = 'Enter a folder name';

// uNXTImage unit
resourcestring
  sBTResetConfirm   = 'Are you sure you want to reset Bluetooth to factory defaults?';
  sBootSAMBAConfirm = 'Are you sure you want to boot the PBrick in SAMBA mode?';
  sUtilitiesMenu  = 'Utilities';
  sSetNXTName     = 'Set PBrick Name';
  sBootSAMBA      = 'Boot PBrick into SAMBA mode';
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
  sEllipseRequires127      = 'The ellipse command requires the enhanced NBC/NXC firmware, v1.27 or greater';
  sPolygonRequires127      = 'The polygon command requires the enhanced NBC/NXC firmware, v1.27 or greater';

// uPreprocess unit
resourcestring
  sInvalidPreprocDirective  = 'Invalid preprocessor directive';
  sImportNotFound           = 'Unable to find import file: "%s"';
  sImportMissingQuotes      = '#import directive requires a filename (e.g., #import "foo.txt")';
  sDownloadNotFound         = 'Unable to find download file: "%s"';
  sDownloadMissingQuotes    = '#download directive requires a filename (e.g., #download "foo.ext")';
  sIncludeNotFound          = 'Unable to find include file: "%s"';
  sIncludeMissingQuotes     = '#include directive requires a filename (e.g., #include "foo.h")';
  sMacroMismatch            = 'Preprocessor macro function does not match instance (%s)';
  sUnmatchedDirective       = 'Unmatched preprocessor directive';
  sInvalidPreprocExpression = 'Invalid preprocessor expression : %s';
  sInvalidCharConstant      = 'Invalid char constant';
  sMaxRecursionDepthError   = 'Max recursion depth (%d) exceeded';
  sIncludePath              = 'Include path';
  sSearchingForFile         = 'Searching for file';
  sFoundFile                = 'Found file';
  sProcessingDownload       = 'Processing download';
  sProcessingImport         = 'Processing import';
  sProcessingInclude        = 'Processing include';

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
  sNoNegShifts         = 'Negative shifts are not supported';
  sNBCLoadSystemFiles  = 'Loading NBC system files';
  sNBCPreprocess       = 'Running NBC Preprocessor';
  sNBCCompilingSource  = 'Compiling NBC source code';
  sNBCOptMutexes       = 'Optimize mutexes';
  sNBCCompBegin        = 'NBC compilation begins';
  sUnmatchedCompDir    = 'Unmatched compiler directive (compif/compelse/compend)';

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
  sInvalidArrayInit        = 'Invalid array or struct initialization';
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
  sStatLocArrNotSupported  = 'Static local arrays are not supported';
  sUnknownAPICommand       = 'Unknown API command';
  sDefaultInvalid          = 'default is invalid outside a switch statement';
  sCaseInvalid             = 'case is invalid outside a switch statement';
  sCaseDuplicateNotAllowed = 'duplicate case labels are not allowed';
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
  sConstNotInline          = 'Only inline functions can correctly use non-reference constant parameters';
  sInvalidFuncDecl         = 'Declaration syntax error';
  sDefaultParamError       = 'Invalid parameter syntax with default values';
  sInvalidFunctionCall     = 'Invalid function call';
  sInvalidEnumDecl         = 'Invalid enum declaration';
  sUnknownDatatype         = 'Unknown datatype';
  sCompileTargets          = 'Compiling for firmware version %d, NBC/NXC enhanced = %s';
  sCurrentFile             = 'Current file = "%s"';
  sConstOrConstExpr        = 'constant or constant expression';
  sNotAnAPIFunc            = '%s is not an API function';
  sNotAnAPIStrFunc         = '%s is not an API string function';
  sTooManyInitializers     = 'Too many initializers';

// shared between uNXCComp and uSPCComp
resourcestring
  sMainTaskNotFound     = 'No task named "main" exists';
  sXXXGenerateTrailer   = '%s generate trailer';
  sXXXProcessGlobals    = '%s processing global declarations';
  sXXXProcedure         = '%s processing procedure block: %s';
  sXXXFunction          = '%s processing function block: %s';
  sXXXCompBegin         = '%s compilation begins';
  sXXXPreprocess        = 'Running %s preprocessor';
  sXXXInitProgram       = '%s init program';
  sXXXParseProg         = '%s parse program code';
  sXXXCodeGenComplete   = '%s code generation finished';

  sOptClump            = 'Optimizing code: %s';
  sFinalizeDepends  = 'Finalizing dependencies';
  sOptimizeLevel    = 'Optimizing at level %d';
  sBuildRefs        = 'Build codespace references';
  sCompactCode      = 'Compact the codespace';
  sRemoveLabels     = 'Remove unused labels';
  sRemovePragmas    = 'Remove unused pragmas';
  sRunCodeOpts      = 'Run codespace optimizations';
  sCompactAfterOpt  = 'Compact the codespace after optimizations';
  sCompactData      = 'Compact the dataspace';
  sSortDataspace    = 'Sort the dataspace';
  sGenerateRawDS    = 'Generate raw dataspace data';
  sFillCodeArrays   = 'Fill code arrays';
  sUpdateHeader     = 'Update executable file header';
  sWriteHeader      = 'Write file header to executable';
  sWriteDataspace   = 'Write dataspace to executable';
  sWriteClumpData   = 'Write clump data to executable';
  sWriteCodespace   = 'Write code to executable';
  sWriteOptSource   = 'Write optimized source to compiler output';
  sFinished         = 'Finished';
  sNBCCompFinished     = 'Finished compiling NBC source code';

// uNBCCommon unit
resourcestring
  sExpectedString          = '%s expected';
  sDataType                = 'Data type';
  sIdentifier              = 'Identifier';
  sDirective               = 'Preprocessor directive';
  sNumber                  = 'Number';
  sHexNumber               = 'Hex number';
  sBinaryNumber            = 'Binary number';
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
  sConstNotAllowed         = 'Constant not allowed on LHS of assignment';
  sConstRequired           = 'A constant is required in this context';
  sFuncParamDeclMismatch   = 'Function parameter declaration mismatch';
  sPointerRequired         = 'A pointer is required in this context';
  sUnsupportedDeref        = 'Unsupported dereference syntax';
  sInvalidDeref            = 'Invalid dereference syntax';
  sInvalidAddressOf        = 'Invalid address of syntax';
  sInvalidPointerSyntax    = 'Invalid pointer syntax';

// evc.dpr
resourcestring
  UsageEV3FirmVer = '   -v=n: set the targeted firmware version (default == 105)';

// nbc.dpr
resourcestring
  UsageSyntax    = 'Syntax: %s [options] filename [options]';
  UsagePort      = '   -S=<portname>: specify port name (usb), brick resource name, or alias';
  UsageDownload  = '   -d: download program';
  UsageRunProg   = '   -r: download and run program';
  UsageBinary    = '   -b: treat input file as a binary file (don''t compile it)';
  UsageQuiet     = '   -q: quiet';
  UsageNoSystem  = '   -n: prevent the system file from being included';
  UsageDefine    = '   -D=<sym>[=<value>]: define macro <sym>';
  UsageDecompile = '   -x: decompile program';
  UsageOptimize  = '   -Z[1|2|3|4|5|6]: turn on compiler optimizations';
  UsageMaxErrors = '   -ER=n: set maximum errors before aborting (0 == no limit)';
  UsageMaxDepth  = '   -PD=n: set max preprocessor recursion depth (default == 10)';
  UsageOutput    = '   -O=<outfile> : specify output file';
  UsageErrors    = '   -E=<filename> : write compiler messages to <filename>';
  UsageIncludes  = '   -I=<path>: search <path> for include files';
  UsageASMOutput = '   -asm=<filename> : save intermediate (assembler) code to <filename>';
  UsageListing   = '   -L=<filename> : generate code listing to <filename>';
  UsageSymbols   = '   -Y=<filename> : generate symbol table to <filename>';
  UsageWarnings  = '   -w[-|+] : warnings off or on (default is on)';
  UsageStatusMsg = '   -sm[-|+] : status messages off or on (default is on)';
  UsageEnhanced  = '   -EF : enhanced firmware';
  UsageSafecall  = '   -safecall: NXC will wrap all function calls in Acquire/Release';
  UsageAPI       = '   -api: dump the NBC/NXC API to stdout';
  UsageFirmVer   = '   -v=n: set the targeted firmware version (default == 128, NXT 1.1 == 105)';
  UsageHelp      = '   -help : display command line options';
  UsageFolder    = '   -F=<path> : remote destination folder (default is /media/card)';

// uEditorExperts.pas
resourcestring
  SNoTokens           = 'No tokens found to align on.';
  sEECommentName      = 'Comment Code';
  sEEUncommentName    = 'Uncomment Code';
  sEEAlignName        = 'Align Lines';
  sEEPrevIdentName    = 'Previous Identifier';
  sEENextIdentName    = 'Next Identifier';
  sEEReverseName      = 'Reverse Statement';
  sEEGrepSearchName   = 'Grep Search';
  sEEGrepResultsName  = 'Grep Results';
  sEECommentHelp      = '  This expert comments out a selected block of code. To ' +
    'use it, select a block in the Delphi editor and activate this expert. ' + #13#10#13#10 +
    '  You can configure this expert to use different comment styles.';
  sEEUncommentHelp    = '  This expert uncomments a selected block of code.  To ' +
    'use it, select a block in the IDE code editor and activate this expert.' + #13#10 +
    '  Uncommenting is performed using the comment style that you selected for ' +
    'the Comment Code editor expert.';
  sEEAlignHelp        = '  This expert aligns the text of the selected lines at ' +
    'the first occurrence of a chosen token in each line.  To use it, select a ' +
    'block of code in the code editor and activate this expert.  You may find ' +
    'this feature useful to align the right hand side of variable, field, or ' +
    'constant declarations and other similar lists. ' + #13#10 +
    '  There are two alignment modes.  In the "Align at rightmost token" mode, ' +
    'the rightmost token found in the selected text becomes the column position ' +
    'the other lines are aligned to.  In the "Align at first token" mode, the ' +
    'first located token is used to determine the alignment column.  In this ' +
    'second mode, any line whose token prefix is longer than the position of ' +
    'the first token will not be modified. ' + #13#10 +
    '  You can configure the list of tokens to align on as well as the minimum ' +
    'number of space characters that must precede a token that is being aligned.';
  sEEPrevIdentHelp    = '  This expert detects the identifier under the cursor ' +
    'and allows you to quickly jump to the previous occurrence of that ' +
    'identifier in the same file.';
  sEENextIdentHelp    = '  This expert detects the identifier under the ' +
    'cursor and allows you to quickly jump to the next occurrence of that ' +
    'identifier in the same file.';
  sEEReverseHelp      = '  This expert reverses all assignment statements in ' +
    'a selected block of code. It expects all reversible statements to be ' +
    'contained on a single line.';
  sEEGrepSearchHelp   = 'Start a new grep search.';
  sEEGrepResultsHelp  = 'Show previous grep search results.';

// nextscreen.dpr
resourcestring
  sUnableToConnect = 'Unable to connect to the selected NXT brick.';

// piano.pas
resourcestring
  sPianoFilter = 'NQC Files (*.nqc,*.nqh)|*.nqc;*.nqh|' +
                 'MindScript files (*.rcx2;*.lsc)|*.rcx2;*.lsc|' +
                 'LASM Files (*.lasm)|*.lasm|' +
                 'C++ Files (*.c,*.cpp,*.h,*.hpp)|*.c;*.cpp;*.h;*.hpp|' +
                 'Pascal Files (*.pas,*.dpr,*.dpk,*.inc)|*.pas;*.dpr;*.dpk;*.inc|' +
                 'Forth Files (*.4th, *.f, *.fr, *.fth)|*.4th;*.f;*.fr;*.fth|' +
                 'Java Files (*.java)|*.java|' +
                 'Next Byte Code Files (*.nbc)|*.nbc|' +
                 'NXC Files (*.nxc)|*.nxc|' +
                 'NXT Melody Files (*.rmd)|*.rmd|';

// uportsedit.pas
resourcestring
  sSaveNXTDatChanges = 'Save changes to bricks.dat file?';
  
// uNBCInterface.pas
resourcestring
  sCannotFindFile       = 'Unable to find the specified input file'#13#10'File "%s" ; line 1';
  sInvalidFileType      = 'Unexpected file type specified (%s)';
  sSPCCompilationFailed = 'SPC compilation failed.';
  sNXCCompilationFailed = 'NXC compilation failed.';
  sNBCCompilationFailed = 'NBC compilation failed.';
  sVersionCheckFailed   = 'Firmware version check failed.';

// uNXTWatchList.pas
resourcestring
  sConfirmDeleteAllWatches = 'Delete all watches?';
  sWatchName = 'Watch Name';
  sWatchValue = 'Value';
  sNotYetImplemented = 'Not yet implemented';

// uSPCComp.pas
resourcestring
  sConstantShifts   = 'Shifts must be constant';
  sArrayLenRequired = 'Arrays without initializer must have a constant length specified.';
  sArrayLenInvalid  = 'Invalid array length specification';
  sInvalidShift     = 'Shift constant must range from 0 to 31';

// uSimpleTerm.pas
resourcestring
  sNXTResponseMailbox = 'NXT Response Mailbox';
  sPreferences = '&Preferences';
  sEdit = '&Edit';
  sFile = '&File';
  
implementation

end.
