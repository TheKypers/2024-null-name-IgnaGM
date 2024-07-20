"
a
"
Class {
	#name : #Target,
	#superclass : #Object,
	#instVars : [
		'objective'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Target class >> withObjective: anObjective [

	^ self new initializeWithObjective: anObjective
]

{ #category : #initialization }
Target >> initializeWithObjective: anObjective [

	objective := anObjective.
]

{ #category : #verification }
Target >> isValidWith: aTargetValidator [

	self subclassResponsibility
]

{ #category : #testing }
Target >> objective [

	^ objective
]
