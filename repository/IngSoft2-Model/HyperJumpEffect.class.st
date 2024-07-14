"
aS
"
Class {
	#name : #HyperJumpEffect,
	#superclass : #EffectOnOneShip,
	#instVars : [
		'boardParsecToTileRatio',
		'currentHyperJump',
		'hyperJumpArray'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
HyperJumpEffect class >> withParsecArray: aParsecArray andLengthInTiles: lengthInTiles andLengthInParsecs: lengthInParsecs [

	^ self new
		  initializeWithParsecArray: aParsecArray
		  andLengthInTiles: lengthInTiles
		  andLengthInParsecs: lengthInParsecs
]

{ #category : #applying }
HyperJumpEffect >> affectAShip: aShip [

	aShip moveTiles:
		(self currentParsec toUnit: Parsec) nominalValue asInteger
		* boardParsecToTileRatio
]

{ #category : #applying }
HyperJumpEffect >> affectAllShips: aShipCollection but: triggeringShip [

	aShipCollection
		reject: [ :aShip | aShip = triggeringShip ]
		thenCollect: [ :aShip |
			| aHypeJumpDistance |
			aHypeJumpDistance := (self currentParsec toUnit: Parsec)
				                     nominalValue asInteger
			                     * boardParsecToTileRatio.
			aShip moveTiles: aHypeJumpDistance ]
]

{ #category : #modifying }
HyperJumpEffect >> currentParsec [

	| currentParsecNumber |
	currentParsecNumber := hyperJumpArray indexOf: currentHyperJump.

	currentHyperJump := currentParsecNumber < hyperJumpArray size
		                    ifTrue: [
		                    hyperJumpArray at: currentParsecNumber + 1 ]
		                    ifFalse: [ hyperJumpArray at: 1 ].


	^ currentHyperJump
]

{ #category : #generators }
HyperJumpEffect >> generateParameters: aTileEffectCreator [

	aTileEffectCreator generateHyperJumpParameters: self
]

{ #category : #initialization }
HyperJumpEffect >> initializeWithParsecArray: aParsecArray andLengthInTiles: lengthInTiles andLengthInParsecs: lengthInParsecs [

	hyperJumpArray := aParsecArray asSortedCollection: [ :a :b | a > b ].

	boardParsecToTileRatio := lengthInTiles // lengthInParsecs.
	currentHyperJump := Parsec withNominalValue: 0
]
