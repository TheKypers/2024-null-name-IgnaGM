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

{ #category : #'class initialization' }
TargetValidator class >> withBoard: aBoard withShips: aCollectionOfShips andCardHandler: aCardHandler [

	^ self new
		  withBoard: aBoard
		  withShips: aCollectionOfShips
		  andCardHandler: aCardHandler
]

{ #category : #validations }
TargetValidator >> cardIsValid: aCardTarget [

	(cardHandler checkTarget: aCardTarget) ifFalse: [
		Error signal: 'Targeted ship is not valid' ]
]

{ #category : #validations }
TargetValidator >> positionTargetIsValid: aPositionTarget [

	board numbOfTiles < aPositionTarget ifTrue: [
		Error signal: 'Targeted tile is out of bounds' ].

	^ true
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

{ #category : #initialization }
TargetValidator >> withBoard: aBoard withShips: aCollectionOfShips andCardHandler: aCardHandler [

	board := aBoard.
	ships := aCollectionOfShips.
	cardHandler := aCardHandler
]
