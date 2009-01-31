unit uTreeSaver;

interface

uses
  SysUtils, Classes, ComCtrls, Registry;

type
  ETreeSaver = class(Exception);

  TTreeNodeSaveEvent = procedure (Sender: TObject; Node: TTreeNode; var ID: String) of object;

  TTreeSaveState = (ssNone,ssSaving,ssRestoring);

  TBricxCCTreeSave = class(TComponent)
  protected
    fTreeView:		TCustomTreeView;
    fOnNodeSaver:	TTreeNodeSaveEvent;
    Nodes:		TStringList;
    Selected:		String;
    TopItem:		String;
    fSaverState:	TTreeSaveState;
    function		Items: TTreeNodes;
    function		NodeString(Node: TTreeNode): String;
    procedure		CheckTree;
    procedure		Clear;
  public
    constructor	Create(AOwner: TComponent); override;
    destructor	Destroy; override;
    procedure		Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure		Save; virtual;
    procedure		Restore; virtual;
    procedure		SaveToRegistry(Registry: TRegistry); virtual;
    procedure		RestoreFromRegistry(Registry: TRegistry); virtual;
    property		State: TTreeSaveState read fSaverState;
    function		NodePath(Node: TTreeNode): String; virtual;
  published
    property		TreeView: TCustomTreeView read fTreeView write fTreeView;
    property		OnNodeSaver: TTreeNodeSaveEvent read fOnNodeSaver write fOnNodeSaver;
  end;

implementation

const
  RegistryKey = '\Nodes';					// registry sub-key where nodes are saved
  RegExpanded = 'Expanded[%d]';		// registry value for expanded nodes
  RegSelected = 'Selected';				// registry value for selected node
  RegTopItem  = 'TopItem';				// registry value for top item in tree

type
  {TNodeState objects are added to the Nodes stringlist to indicate the
  expanded state of a node.  only nodes that are expanded appear in the list}
  TNodeState = class(TObject)
  public
    Expanded:	Boolean;
  end;

  TCrackTreeNode = class(TTreeNode);

constructor	TBricxCCTreeSave.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nodes := TStringList.Create;
  Nodes.Sorted := True;					// to make searching quicker
  fSaverState := ssNone;
end;

destructor	TBricxCCTreeSave.Destroy;
begin
  Clear;
  Nodes.Free;
  inherited Destroy;
end;

procedure	TBricxCCTreeSave.Clear;
begin
  Selected := '';			// assume no node is selected
  TopItem := '';			// assume no nodes exist in the tree

	{the TNodeState objects in the list must be freed}
	with Nodes do begin
  	while Count > 0 do begin
    	TNodeState(Objects[0]).Free;
      Delete(0);
    end;
  end;
end;

procedure	TBricxCCTreeSave.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (AComponent = TreeView) and (Operation = opRemove) then
    TreeView := nil;
end;

procedure	TBricxCCTreeSave.Save;
var
Node:		TTreeNode;
S:			String;
NState:	TNodeState;
begin
	{this method scans the tree, populating the Nodes list with the tree nodes
  that are expanded}
  fSaverState := ssSaving;
  try
		Clear;							// clear any nodes already in the list
		CheckTree;					// make sure we have access to a treeview

		with Items do begin
	  	Node := GetFirstNode;
	    while Assigned(Node) do begin
      	S := NodeString(Node);
        if TreeView.Selected = Node then
			  	Selected := S;						// save the selected node
			  if TreeView.TopItem = Node then
			  	TopItem := S;             // save the first visible node

				{if this node is expanded then we want to add it to the nodes list.  only expanded
        nodes appear in the list.  the TNodeState object is used to
        store the expanded state in the string list}
	    	if Node.Expanded then begin
        	NState := TNodeState.Create;
          NState.Expanded := Node.Expanded;
	      	Nodes.AddObject(S,NState);
        end;
	    	Node := Node.GetNext;
	    end;
	  end;
  finally
	  fSaverState := ssNone;
	end;
end;

procedure	TBricxCCTreeSave.Restore;
var
Node:			TTreeNode;
S:				String;
SelectedNode:	TTreeNode;
TopNode:	TTreeNode;
Index:		Integer;
NState:		TNodeState;
begin
	{this method restores the tree from a previously 'saved' state.}
  fSaverState := ssRestoring;
  try
		CheckTree;								// make sure we have access to a tree view
	  SelectedNode := nil;			// assume no currently selected node
	  TopNode := nil;						// assume no nodes in the tree
		with Items do begin
			BeginUpdate;
	    try
		  	Node := GetFirstNode;
		    while Assigned(Node) do begin
        	{as we scan thru the tree, check to see if this node was previously
          saved as the selected to topitem node}
		    	S := NodeString(Node);
		    	if S = Selected then
		      	SelectedNode := Node;
		      if S = TopItem then
		      	TopNode := Node;

          {see if this node is in the string list.  if it is then it was
          saved as an expanded node.  if it's not in the list then
          there's nothing special about this node}
          Index := Nodes.IndexOf(S);
          if Index <> - 1 then begin
          	NState := TNodeState(Nodes.Objects[Index]);
		      	if NState.Expanded then
            	Node.Expand(False);
          end;
		    	Node := Node.GetNext;
		    end;

        {we have to wait until the nodes are expanded to set the selected
        and topitem node, otherwise, the tree might scroll}

	      if Assigned(SelectedNode) then begin
          // D7 has wrapped the TTreeNode SetSelected code in a
          // "if Value <> Selected then."  Because SelectedNode.Selected = true
          // calling TreeView.Selected will have no effect.  To get around this
          // we make a call to the protected method SetSelectedBit
          // so SelectedNode.Selected = false
//          TCrackTreeNode(SelectedNode).SetSelectedBit(false);
          TreeView.Selected := SelectedNode;
        end;
	      if Assigned(TopNode) then
        begin
		      TreeView.TopItem := TopNode;
        end;
	    finally
	    	EndUpdate;
	    end;
  	end;
  finally
	  fSaverState := ssNone;
  end;
end;

function	TBricxCCTreeSave.Items: TTreeNodes;
begin
	if TreeView is TTreeView then
  	Result := TTreeView(TreeView).Items
  else
  	Result := nil;
end;

function	TBricxCCTreeSave.NodeString(Node: TTreeNode): String;
begin
	{the purpose of this function is to return a string which can be used to
  uniquely identify a node.  the default is the nodepath; but this can be
  can by using an OnNodeSaver event handler}
  Result := NodePath(Node);
  if Assigned(OnNodeSaver) then
  	OnNodeSaver(Self,Node,Result);
end;

function	TBricxCCTreeSave.NodePath(Node: TTreeNode): String;
begin
	{generate a string representing the full path of the given node.  the format
  of the path is:  ParentText....ParentText.ParentText.Text}
	Result := Node.Text;
  while Node.Parent <> nil do begin
  	Node := Node.Parent;
    Result := Node.Text + '.' + Result;
  end;
end;

procedure	TBricxCCTreeSave.CheckTree;
begin
	{if we don't have a treeview then raise an exception}
	if not (TreeView is TTreeView) then
  	raise ETreeSaver.Create('TreeView is not assigned');
end;


procedure	TBricxCCTreeSave.SaveToRegistry(Registry: TRegistry);
var
ExpandedIndex:	Integer;
I:							Integer;
NState:					TNodeState;
RegPath:				String;
begin
	{this method saves the state of the tree to the registry.}
  Save;					// build the internal string list of nodes

  {the nodes are not saved at the currently open registry key but are saved
  1 level below it.  before the node info is written to the registry, the
  registry key is deleted to remove any previously saved node info}
	RegPath := Registry.CurrentPath;
  Registry.CloseKey;
	Registry.DeleteKey(RegPath + RegistryKey);
  Registry.OpenKey(RegPath + RegistryKey,True);

  ExpandedIndex := 0;			// counter for the Expanded[%d] value

  {go thru the nodes list and write which nodes are expanded to
  the registry}
  for I := 0 to Nodes.Count - 1 do begin
  	NState := TNodeState(Nodes.Objects[I]);
		if NState.Expanded then begin
    	Registry.WriteString( Format(RegExpanded,[ExpandedIndex]), Nodes[I]);
      Inc(ExpandedIndex);
    end;
	end;

  {save the selected node to the registry}
  if Selected <> '' then
   	Registry.WriteString( RegSelected, Selected);

  {save the top node to the registry}
  if TopItem <> '' then
   	Registry.WriteString( RegTopItem, TopItem);

  {re-open the registry to the key it was opened to when this method was called}
  Registry.CloseKey;
  Registry.OpenKey(RegPath,True);
end;

procedure	TBricxCCTreeSave.RestoreFromRegistry(Registry: TRegistry);
var
S:				String;
I:				Integer;
RegPath:	String;
	function	GetNodeState(S: String): TNodeState;
  var
  Index:	Integer;
  begin
  	Index := Nodes.IndexOf(S);
    if Index = -1 then
    	Index := Nodes.AddObject(S,TNodeState.Create);
    Result := TNodeState(Nodes.Objects[Index]);
  end;
begin
	{this method restores the internal nodes list from the registry and the
  restores the tree to that state}

	Clear;

  {the nodes are not saved at the currently open registry key but are saved
  1 level below it}
	RegPath := Registry.CurrentPath;
  Registry.CloseKey;
  Registry.OpenKey(RegPath + RegistryKey,True);

  {since we don't know how many nodes were expanded, we have to
  loop thru using an index until we hit a registry value that doesn't exist}
  I := 0;
  while Registry.ValueExists(Format(RegExpanded,[I])) do begin
    S := Registry.ReadString(Format(RegExpanded,[I]));
    GetNodeState(S).Expanded := True;
  	Inc(I);
  end;

  {restore the selected node (if it's in the registry)}
  if Registry.ValueExists(RegSelected) then
		Selected := Registry.ReadString(RegSelected);

  {restore the top node (if it's in the registry)}
  if Registry.ValueExists(RegTopItem) then
   	TopItem := Registry.ReadString(RegTopItem);

  Restore;		// update the state of the tree view control

  {re-open the registry to the key it was opened to when this method was called}
  Registry.CloseKey;
  Registry.OpenKey(RegPath,True);
end;

end.

