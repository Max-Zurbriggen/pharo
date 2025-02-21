Class {
	#name : #CDExistingClassDefinitionTest,
	#superclass : #CDBehaviorParserTest,
	#category : #'ClassParser-Tests'
}

{ #category : #helpers }
CDExistingClassDefinitionTest >> classDefinitionString [

	^ (ClassDefinitionPrinter oldPharo for: CDClassWithFullDefinitionExample) definitionString
]

{ #category : #helpers }
CDExistingClassDefinitionTest >> className [

	^ CDClassWithFullDefinitionExample name
]

{ #category : #helpers }
CDExistingClassDefinitionTest >> firstInstanceVariableName [
	
	^ 'instVar1'
]

{ #category : #helpers }
CDExistingClassDefinitionTest >> secondInstanceVariableName [

	^ 'instVar2'
]

{ #category : #helpers }
CDExistingClassDefinitionTest >> testClassNameNodeIsPolymorphicToRBVariableNode [
	
	| nameNode |
	nameNode := classDefinition classNameNode.
	self assert: nameNode isVariable. "It is polymorphic to class reference nodes in method sources"
	self deny: nameNode isTempVariable
]

{ #category : #helpers }
CDExistingClassDefinitionTest >> testGettingExistingClass [
	
	| class |
	class := classDefinition existingClassIfAbsent: [].
	self assert: class equals: CDClassWithFullDefinitionExample
]

{ #category : #helpers }
CDExistingClassDefinitionTest >> testGettingExistingClassNameBinding [
	
	| binding |
	binding := classDefinition classNameNode binding.
	
	self assert: binding identicalTo: CDClassWithFullDefinitionExample binding
]

{ #category : #helpers }
CDExistingClassDefinitionTest >> testSharedSlotNodeArePolymorphicToRBVariableNodes [
	
	| classVarNode |
	classVarNode := classDefinition sharedSlotNodes first.
	
	self assert: classVarNode isVariable.
	self deny: classVarNode isTempVariable.
	self deny: classVarNode isGlobalVariable.
	self assert: classVarNode isClassVariable.
	self deny: classVarNode isInstanceVariable.
	self assert: classVarNode isLiteralVariable.
	self deny: classVarNode isUndeclaredVariable.
]

{ #category : #helpers }
CDExistingClassDefinitionTest >> testSlotNodeArePolymorphicToRBVariableNodes [
	
	| slotNode |
	slotNode := classDefinition slotNodes first.
	self assert: slotNode isVariable.
	self deny: slotNode isTempVariable.
	self deny: slotNode isGlobalVariable.
	self deny: slotNode isClassVariable.
	self assert: slotNode isInstanceVariable.
	self deny: slotNode isLiteralVariable.
	self deny: slotNode isUndeclaredVariable.
]

{ #category : #helpers }
CDExistingClassDefinitionTest >> testSlotNodeBinding [
	
	| slotNode |
	slotNode := classDefinition slotNodes first.
	self assert: slotNode binding identicalTo: slotNode
]
