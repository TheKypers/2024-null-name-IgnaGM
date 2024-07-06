"
a
"
Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'activeCards',
		'game',
		'lastCardPlayed',
		'inPlayDeck',
		'gameDeck',
		'coalitionHandler',
		'reverseEffectPolarityPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardHandler class >> withDeck: aDeck andGame: aGame [

	^ self new
		  initalizeWithDeck: aDeck
		  andGame: aGame
]

{ #category : #generating }
CardHandler >> activateCard: aCardToPlay withTarget: aTarget [

	aCardToPlay activate: self withTarget: aTarget
]

{ #category : #accessing }
CardHandler >> addCoalition: aCoalition [

	coalitionHandler addToCoalitions: aCoalition
]

{ #category : #'as yet unclassified' }
CardHandler >> addPositionOfEffectToReversePolarity: aTileTarget [

	reverseEffectPolarityPositions add: aTileTarget objective
]

{ #category : #comparing }
CardHandler >> addToActiveCards: aCard [

	activeCards add: aCard
]

{ #category : #generating }
CardHandler >> applyLastEffectOn: aTarget [

	game applyLastEffectOn: aTarget
]

{ #category : #comparing }
CardHandler >> armyOf: aShip withEnemy: aEnemyShip [
	
	^ coalitionHandler armyOf: aShip withEnemy: aEnemyShip.

]

{ #category : #accessing }
CardHandler >> changeLastCardTo: aCard [

	lastCardPlayed := aCard
]

{ #category : #'argument validation' }
CardHandler >> checkTarget: aTarget [

	^ activeCards anySatisfy: [ :card | aTarget = card ]
]

{ #category : #generating }
CardHandler >> deactivate: aTarget [

	aTarget objective deactivate: self.

]

{ #category : #modifying }
CardHandler >> giveCardTo: aShipName [

	inPlayDeck add: (gameDeck cardAtRandom withHolder: aShipName)
]

{ #category : #accessing }
CardHandler >> inPlayDeck [

	^ inPlayDeck
]

{ #category : #initialization }
CardHandler >> initalizeWithDeck: aDeck andGame: aGame [

	gameDeck := aDeck.
	inPlayDeck := OrderedCollection new.
	activeCards := OrderedCollection new.
	lastCardPlayed := NullCard new.
	game := aGame.
	coalitionHandler := CoalitionHandler new.
	reverseEffectPolarityPositions := OrderedCollection new
]

{ #category : #accessing }
CardHandler >> lastCardPlayed [

	^ lastCardPlayed
]

{ #category : #modifying }
CardHandler >> movementCardsActivated: theShipInTurn [

	^ ((activeCards select: [ :card |
		    card shouldApplyOn: theShipInTurn shipName ]) sumNumbers: [
		   :card | card applyMovement ])
]

{ #category : #'as yet unclassified' }
CardHandler >> positionsToReversePolarity [

	| reverseEffectsCopy |
	reverseEffectsCopy := reverseEffectPolarityPositions copy.
	reverseEffectPolarityPositions := OrderedCollection new.

	^ reverseEffectsCopy
]

{ #category : #comparing }
CardHandler >> removeCardFromShipDeck: aCard [

	inPlayDeck
		remove: aCard
		ifAbsent: [ Error signal: 'Card was not found in Ship Deck' ]
]

{ #category : #comparing }
CardHandler >> removeCoalitionOf: aLeader and: aMercenary [

	coalitionHandler removeCoalition:
		(ShipCoalition
			 withLeader: aLeader
			 andMercenary: aMercenary objective)
]

{ #category : #comparing }
CardHandler >> removeFromActiveCard: aTarget [

	activeCards remove: aTarget
]

{ #category : #comparing }
CardHandler >> reverseCard: aCard [

	(activeCards detect: [ :card | card = aCard objective ])
		reverseCardEffectWith: self
]

{ #category : #'as yet unclassified' }
CardHandler >> reverseCoalition: aCoalition [

	coalitionHandler modifyReverseCoalitions: aCoalition
]

{ #category : #generating }
CardHandler >> startingCards: aShipName [

	2 timesRepeat: [
		inPlayDeck add: (gameDeck cardAtRandom withHolder: aShipName) ]
]

{ #category : #comparing }
CardHandler >> validateCard: aCard [

	inPlayDeck
		detect: [ :card | card = aCard ]
		ifNone: [ CardExeption signal: 'Ship does not have that card' ]
]
