"
a
"
Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'activeCards',
		'lastCardPlayed',
		'inPlayDeck',
		'gameDeck',
		'coalitionHandler',
		'effectHandler'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardHandler class >> withDeck: aDeck andEffectHandler: anEffectHanlder [

	^ self new
		  initalizeWithDeck: aDeck
		  andAEffectHandler: anEffectHanlder
]

{ #category : #generating }
CardHandler >> activateCard: aCardToPlay [

	aCardToPlay activateWith: self
]

{ #category : #accessing }
CardHandler >> addCoalition: aCoalition [

	coalitionHandler addToCoalitions: aCoalition
]

{ #category : #comparing }
CardHandler >> addToActiveCards: aCard [

	activeCards add: aCard
]

{ #category : #generating }
CardHandler >> applyLastEffectOn: aTarget [

	effectHandler applyLastEffectOn: aTarget
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

{ #category : #initialization }
CardHandler >> initalizeWithDeck: aDeck andAEffectHandler: anEffectHandler [

	gameDeck := aDeck.
	inPlayDeck := OrderedCollection new.
	activeCards := OrderedCollection new.
	lastCardPlayed := NullCard new.
	effectHandler := anEffectHandler.
	coalitionHandler := CoalitionHandler new
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

{ #category : #modifying }
CardHandler >> reverseCoalition: aCoalition [

	coalitionHandler modifyReverseCoalitions: aCoalition
]

{ #category : #modifying }
CardHandler >> reverseEffectPolarity: aPositionTarget [

	effectHandler reversePolarityOfEffectAt: aPositionTarget
]

{ #category : #comparing }
CardHandler >> shipWithName: aShipName hasAmountOfCards: anAmountOfCards [

	^ (inPlayDeck select: [ :card | card holder = aShipName ]) size
	  = anAmountOfCards
]

{ #category : #generating }
CardHandler >> startingCards: aShipName [

	2 timesRepeat: [ self giveCardTo: aShipName ]
]

{ #category : #comparing }
CardHandler >> validateCard: aCard [

	inPlayDeck
		detect: [ :card | card = aCard ]
		ifNone: [ CardExeption signal: 'Ship does not have that card' ]
]
