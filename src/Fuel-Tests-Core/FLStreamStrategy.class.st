"
I am a strategy that help tests for writing (and then reading) on streams.
"
Class {
	#name : #FLStreamStrategy,
	#superclass : #Object,
	#category : #'Fuel-Tests-Core-Support-StreamStrategies'
}

{ #category : #serializing }
FLStreamStrategy >> fuelAccept: aGeneralMapper [
	"Visit myself as a substitution. See #fuelSubstitution."

	^ aGeneralMapper visitSubstitution: self by: nil
]

{ #category : #reading }
FLStreamStrategy >> readStream [
	self subclassResponsibility
]

{ #category : #writing }
FLStreamStrategy >> writeStream [
	self subclassResponsibility
]
