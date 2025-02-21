Extension { #name : #WorldState }

{ #category : #'*Morphic-Base' }
WorldState >> addAlarm: aSelector withArguments: argArray for: aTarget at: scheduledTime [
	"Add a new alarm with the given set of parameters"
	self alarms add: 
		(MorphicAlarm 
			scheduledAt: scheduledTime
			receiver: aTarget
			selector: aSelector
			arguments: argArray).
]

{ #category : #'*Morphic-Base' }
WorldState class >> browseWorldMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Browse)
		order: 10;
		help: 'Tools to explore and modify the image';
		with: [ 
			(aBuilder group: #Browsing)
				order: 1;
				withSeparatorAfter.
			(aBuilder group: #InputOutput)
				order: 2;
				withSeparatorAfter.
			(aBuilder group: #Testing)
				order: 3;
				withSeparatorAfter.
			(aBuilder group: #Searching)
				order: 4]
]

{ #category : #'*Morphic-Base' }
WorldState class >> debugWorldMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Debug)
		order: 30;
		with: [
			(aBuilder group: #Breakpoints)
				order: 1;
				withSeparatorAfter.
			(aBuilder group: #Profiling)
				order: 2;
				withSeparatorAfter.
			(aBuilder group: #Counters)
				order: 3]
]

{ #category : #'*Morphic-Base' }
WorldState class >> libraryWorldMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Tools)
		label: 'Library';
		order: 70;
		help: 'Third party tools and applications'
]

{ #category : #'*Morphic-Base' }
WorldState >> menuBuilder [

	^ (PragmaMenuBuilder
		   pragmaKeyword: self discoveredMenuPragmaKeyword
		   model: self)
		  menuSpec;
		  yourself
]

{ #category : #'*Morphic-Base' }
WorldState class >> sourcesWorldMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Sources)
		order: 50;
		help: 'Source Management Tools';
		with: [ 
			(aBuilder group: #Versioning)
				order: 1;
				withSeparatorAfter.
			(aBuilder group: #Packaging)
				order: 2;
				withSeparatorAfter.
			(aBuilder group: #Changes)
				order: 3;
				withSeparatorAfter.
			(aBuilder group: #Refactoring)
				order: 4 ]
]

{ #category : #'*Morphic-Base' }
WorldState class >> startMessageTally [

	(self confirm: 'MessageTally will start now,
and stop when the cursor goes
to the top of the screen' translated) 
		ifFalse: [ ^ self ].

	TimeProfiler spyAllOn: [
		MorphicRenderLoop new doOneCycleWhile: [ 
			self currentWorld activeHand position y > 0 ] ]
]

{ #category : #'*Morphic-Base' }
WorldState >> startMessageTally [

	self class startMessageTally
]

{ #category : #'*Morphic-Base' }
WorldState >> startStepping: aMorph at: scheduledTime selector: aSelector arguments: args stepTime: stepTime [
	"Add the given morph to the step list. Do nothing if it is already being stepped."

	self stopStepping: aMorph selector: aSelector.
	self adjustWakeupTimesIfNecessary.
	stepList add:(
		StepMessage 
			scheduledAt: scheduledTime
			stepTime: stepTime
			receiver: aMorph
			selector: aSelector
			arguments: args)
]

{ #category : #'*Morphic-Base' }
WorldState class >> startThenBrowseMessageTally [
	"Tally only the UI process"
	
	(self confirm: 'MessageTally the UI process until the
mouse pointer goes to the top of the screen')
		ifFalse: [ ^ self ].

	TimeProfiler onBlock: [
		MorphicRenderLoop new doOneCycleWhile: [ 
			self currentWorld activeHand position y > 10 ] ]
]

{ #category : #'*Morphic-Base' }
WorldState >> startThenBrowseMessageTally [

	self class startThenBrowseMessageTally
]

{ #category : #'*Morphic-Base' }
WorldState class >> systemOn: aBuilder [
	<worldMenu>
	(aBuilder item: #System)
		order: 60;
		with: [
			(aBuilder group: #SystemTools)
				order: 1;
				withSeparatorAfter.
			(aBuilder group: #Startup)
				order: 2;
				withSeparatorAfter.
			(aBuilder group: #Image)
				order: 3;
				with: [
					(aBuilder item: #'Space left')
						help: 'Do a garbage collection, and report results about the to the user.';
						order: 1;
						action: [ Smalltalk informSpaceLeftAfterGarbageCollection ].
					(aBuilder item: #'Do Image Cleanup')
						help: 'Clean out any caches and other state that should be flushed when trying to get an image into a pristine state.';
						order: 2;
						action: [ Smalltalk cleanUp: true ].
					aBuilder 	withSeparatorAfter].
			(aBuilder group: #World)
				order: 4;
				with: [
					(aBuilder item: #'Start drawing again')
						help: 'Resume the drawing after a draw error of the world.';
						order: 1;
						action: [ self currentWorld resumeAfterDrawError ].
					(aBuilder item: #'Start stepping again')
						help: 'Resume stepping of Morph after an error has occured.';
						order: 2;
						action: [ self currentWorld resumeAfterStepError ].
					(aBuilder item: #'Restore display')
						help: 'Restore Morphic display.';
						order: 3;
						action: [ self currentWorld restoreMorphicDisplay ].
					aBuilder withSeparatorAfter ] ]
]

{ #category : #'*Morphic-Base' }
WorldState class >> windowsOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Windows)
		order: 90;
		with: [ (aBuilder item: #'Collapse all windows')
				action: [ self currentWorld collapseAll ];
				help: 'Reduce all open windows to collapsed forms that only show titles' translated.
			(aBuilder item: #'Expand all windows')
				iconName: #expandBox;
				action: [ self currentWorld expandAll ];
				help: 'Expand all collapsed windows back to their expanded forms' translated.
			(aBuilder item: #'Fit all windows')
				action: [ self currentWorld fitAllVisibleWindows ];
				help: 'Fit all open windows as visible in World' translated.
			(aBuilder item: #'Close all debuggers')
				help: 'Close all opened debugger in the image.';
				action: [ OupsDebuggerSystem closeAllDebuggers ].
			(aBuilder item: #'Send top window to back (\)')
				action: [ SystemWindow sendTopWindowToBack ];
				help: 'Make the topmost window become the backmost one, and activate the window just beneath it.' translated.
			(aBuilder item: #'Move windows onscreen')
				action: [ self currentWorld bringWindowsFullOnscreen ];
				help: 'Make all windows fully visible on the screen' translated.
			(aBuilder item: #'Delete unchanged windows')
				action: [ self currentWorld closeUnchangedWindows ];
				help: 'Deletes all windows that do not have unsaved text edits.' translated.
			(aBuilder item: #'Delete all windows discarding edits')
				action: [ self currentWorld closeAllWindowsDiscardingChanges ];
				help: 'Deletes all windows even if they have unsaved text edits.' translated.
			(aBuilder item: #'Toggle full screen mode')
				action: [ Display toggleFullscreen ];
				help: 'Turn full screen mode on when it is off, off when it is on.' translated ]
]
