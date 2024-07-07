Class {
	#name : #EffectManager,
	#superclass : #Object,
	#instVars : [
		'board',
		'ships',
		'lastEffect',
		'game'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
EffectManager class >> withBoard: aBoard andShips: aCollectionOfShips andGame: aGame [

	^ self new
		  initializeWithBoard: aBoard
		  andShips: aCollectionOfShips
		  andGame: aGame
]

{ #category : #initialization }
EffectManager >> applyEffectOnAllShips: anEffect [

	anEffect affectAShipCollection: ships.

	ships do: [ :anAffectedShip |
		board adjustShipPosition: anAffectedShip.
		board snapToFinishTile: anAffectedShip ]
]

{ #category : #initialization }
EffectManager >> applyEffectOnAllShipsButOne: anEffect triggerByShip: aShip [

	anEffect affectAllShips: ships but: aShip.
	ships do: [ :anAffectedShip |
		board adjustShipPosition: anAffectedShip.
		board snapToFinishTile: anAffectedShip ]
]

{ #category : #initialization }
EffectManager >> applyEffectOnOneShip: anEffect triggeredBy: aShip [

	anEffect affectAShip: aShip.
	board adjustShipPosition: aShip.
	board snapToFinishTile: aShip
]

{ #category : #initialization }
EffectManager >> applyLastEffectOn: aTarget [

	| aShip |
	aShip := self shipWithName: aTarget objective.
	lastEffect applyWith: self activatedBy: aShip
]

{ #category : #initialization }
EffectManager >> applyTileEffectTriggeredBy: aShip [

	board applyTileEffectWith: self triggeredBy: aShip
]

{ #category : #initialization }
EffectManager >> giveCardToCurrentShip: aShip [

	game giveCardToCurrentShip: aShip
]

{ #category : #initialization }
EffectManager >> initializeWithBoard: aBoard andShips: aCollectionOfShips andGame: aGame [

	board := aBoard.
	ships := aCollectionOfShips.
	game := aGame.
	lastEffect := NullEffect
]

{ #category : #initialization }
EffectManager >> lastEffectAppliedIs: anEffect [

	lastEffect := anEffect
]

{ #category : #initialization }
EffectManager >> reversePolarityOfTile: aTileTarget [

	board reversePolarityAt: aTileTarget objective
]

{ #category : #initialization }
EffectManager >> shipWithName: aShipName [

	^ ships detect: [ :ship | ship shipName = aShipName ]
]
