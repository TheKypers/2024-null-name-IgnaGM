"
Dice is a class that is composed of multiple Die
"
Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
Dice class >> isValid: aDieCollection [

	aDieCollection isEmpty ifTrue: [
		InvalidArgumentExeption signal: 'There should be at least 1 Die' ]
]

{ #category : #'class initialization' }
Dice class >> with: aDieCollection [
	self isValid: aDieCollection.
	^(self new) inializeWith: aDieCollection
]

{ #category : #initialization }
Dice >> inializeWith: aDieCollection [

	dice := aDieCollection
]

{ #category : #action }
Dice >> numberOfDie [

	^ dice size
]

{ #category : #action }
Dice >> throw [

	^ (dice collect: [ :die | die throw ]) sum
]
