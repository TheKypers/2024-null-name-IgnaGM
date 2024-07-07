"
a
"
Class {
	#name : #TargetValidator,
	#superclass : #Object,
	#instVars : [
		'board',
		'ships',
		'cardHandler'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
TargetValidator class >> with: aBoard and: aCollectionOfShips and: aCardHandler [

	^ self new
		  initalizeWith: aBoard
		  and: aCollectionOfShips
		  and: aCardHandler
]

{ #category : #validations }
TargetValidator >> cardIsValid: aCardTarget [

	(cardHandler checkTarget: aCardTarget) ifFalse: [
		Error signal: 'Targeted ship is not valid' ]
]

{ #category : #initialization }
TargetValidator >> initalizeWith: aBoard and: aCollectionOfShips and: aCardHandler [

	board := aBoard.
	ships := aCollectionOfShips.
	cardHandler := aCardHandler
]

{ #category : #validations }
TargetValidator >> shipTargetIsValid: aShipTarget [

	(ships anySatisfy: [ :ship | ship shipName = aShipTarget ]) ifFalse: [
		CardExeption signal: 'Targeted ship is not valid' ]
]

{ #category : #validations }
TargetValidator >> targetIsValid: aTarget [

	aTarget isValidWith: self
]

{ #category : #validations }
TargetValidator >> tileTargetIsValid: aTileTarget [

	board numbOfTiles < aTileTarget ifTrue: [
		Error signal: 'Targeted tile is out of bounds' ].

	^ true
]
