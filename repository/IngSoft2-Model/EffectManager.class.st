"
a
"
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

{ #category : #'class initialization' }
EffectManager class >> withBoard: aBoard andShips: aCollectionOfShips andGame: aGame [

	^ self new
		  initializeWithBoard: aBoard
		  andShips: aCollectionOfShips
		  andGame: aGame
]

{ #category : #modifying }
EffectManager >> applyEffectOnAllShips: anEffect [

	anEffect affectAShipCollection: ships.

	ships do: [ :anAffectedShip |
		board adjustShipPosition: anAffectedShip.
		board snapToFinishTile: anAffectedShip ].

	self lastEffectAppliedIs: anEffect
]

{ #category : #modifying }
EffectManager >> applyEffectOnAllShipsButOne: anEffect triggerByShip: aShip [

	anEffect affectAllShips: ships but: aShip.
	ships do: [ :anAffectedShip |
		board adjustShipPosition: anAffectedShip.
		board snapToFinishTile: anAffectedShip ].
	self lastEffectAppliedIs: anEffect.
]

{ #category : #modifying }
EffectManager >> applyEffectOnOneShip: anEffect triggeredBy: aShip [

	anEffect affectAShip: aShip.
	board adjustShipPosition: aShip.
	board snapToFinishTile: aShip.
	self lastEffectAppliedIs: anEffect
]

{ #category : #event }
EffectManager >> applyLastEffectOn: aTarget [

	| aShip |
	aShip := self shipWithName: aTarget objective.
	lastEffect applyWith: self activatedBy: aShip
]

{ #category : #event }
EffectManager >> applyTileEffectTriggeredBy: aShip [

	board applyTileEffectWith: self triggeredBy: aShip
]

{ #category : #modifying }
EffectManager >> giveCardToAllShipsBut: aShip [

	game giveCardToAllShipsBut: aShip.
	self lastEffectAppliedIs: CardGeneratorEffect new.
]

{ #category : #modifying }
EffectManager >> giveCardToCurrentShip: aShip [

	game giveCardToCurrentShip: aShip.
	self lastEffectAppliedIs: CardGeneratorEffect new
]

{ #category : #initialization }
EffectManager >> initializeWithBoard: aBoard andShips: aCollectionOfShips andGame: aGame [

	board := aBoard.
	ships := aCollectionOfShips.
	game := aGame.
	lastEffect := NullEffect
]

{ #category : #accessing }
EffectManager >> lastEffectAppliedIs: anEffect [

	lastEffect := anEffect
]

{ #category : #modifying }
EffectManager >> reversePolarityOfEffectAt: aTileTarget [

	board reversePolarityAt: aTileTarget objective
]

{ #category : #accessing }
EffectManager >> shipWithName: aShipName [

	^ ships detect: [ :ship | ship shipName = aShipName ]
]
