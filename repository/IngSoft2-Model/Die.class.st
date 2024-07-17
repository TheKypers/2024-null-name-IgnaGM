"
Die class
"
Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
Die class >> isValid: anAmountOfFaces [

	anAmountOfFaces < 3 ifTrue: [
		InvalidArgumentExeption signal: 'Faces should be more than 2' ]
]

{ #category : #testing }
Die class >> of: anAmountOfFaces [

	self isValid: anAmountOfFaces.
	^ self new initializeOf: anAmountOfFaces
]

{ #category : #initialization }
Die >> initializeOf: anAmountOfFaces [

	faces := anAmountOfFaces
]

{ #category : #event }
Die >> throw [

	^ faces atRandom
]
