Extension { #name : #SycCopyClassCommand }

{ #category : #'*Calypso-SystemTools-FullBrowser' }
SycCopyClassCommand class >> fullBrowserMenuActivation [
	<classAnnotation>
	
	^CmdContextMenuActivation byRootGroupItemFor: ClyFullBrowserClassContext
]

{ #category : #'*Calypso-SystemTools-FullBrowser' }
SycCopyClassCommand class >> fullBrowserShortcutActivation [
	<classAnnotation>
	
	^CmdShortcutActivation by: $c meta for: ClyFullBrowserClassContext
]
