"
A pool used for testing purposes
"
Class {
	#name : #PoolDefiner,
	#superclass : #SharedPool,
	#classVars : [
		'AnAuthor',
		'Gloups'
	],
	#category : #'Kernel-Tests-Classes'
}

{ #category : #'class initialization' }
PoolDefiner class >> initialize [
	
	Gloups := 42.
	AnAuthor := 'Ducasse'
]
