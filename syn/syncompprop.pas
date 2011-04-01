unit syncompprop;

interface

uses
  SysUtils,
  Classes,
{$IFNDEF FPC}
  SynCompletionProposal,
{$ELSE}
  SynCompletion,
{$ENDIF}
  SynEdit;

type
{$IFDEF FPC}
  TBaseCompType = TSynCompletion;
{$ELSE}
  TBaseCompType = TSynCompletionProposal;
{$ENDIF}

type
  TBricxCCCompletion = class(TBaseCompType)
  private
  protected
  public
  end;


implementation


end.