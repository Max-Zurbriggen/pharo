"
I am used to test the behavior of Context>>jump in MethodContextTest. My example methods includes instance variable stores. When my instance is read-only or writeable, the example method uses or not the write barrier call-back. The copy of the context answered can be used to ensure the stack state is correct.

"
Class {
	#name : #SimulationMock,
	#superclass : #Object,
	#instVars : [
		'instVar1'
	],
	#category : #'Kernel-Tests-Methods'
}

{ #category : #examples }
SimulationMock >> exampleClosure [
	<sampleInstance>
	"This is a pathological case where the method has no arguments, no temporaries, and the instance variable store is followed by the creation of a closure with no copied values."
	instVar1 := 1.
	[ 2 ] value.
	^ thisContext copy
]

{ #category : #examples }
SimulationMock >> exampleSelfReturnCall [

	"A simple case where a yourself message is sent to an object"

	<sampleInstance>
	self yourself
]

{ #category : #examples }
SimulationMock >> exampleSend [
	<sampleInstance>
	"This is a pathological case where the method has no arguments, no temporaries, and the instance variable store is followed by the creation of a closure with no copied values."
	instVar1 := 1.
	self yourself.
	^ thisContext copy
]

{ #category : #examples }
SimulationMock >> exampleStore [
	<sampleInstance>
	"This is a pathological case where the method has no arguments, no temporaries, and the instance variable store is followed by the creation of a closure with no copied values."
	instVar1 := 1.
	instVar1 := 2.
	^ thisContext copy
]
