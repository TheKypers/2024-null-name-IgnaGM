"
handles battles between ships and determines who participates
"
Class {
	#name : #ShipBattle,
	#superclass : #Object,
	#instVars : [
		'dice',
		'ships',
		'cardHanlder',
		'coalitionHanlder'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
ShipBattle class >> withDice: aCollectionOfDice withShips: aCollectionOfShips andCoalitionHandler: aColitionHandler [

	^ self new
		  initializeWithShips: aCollectionOfShips
		  withDice: aCollectionOfDice
		andCoalitionHandler:aColitionHandler.
			
]

{ #category : #initialization }
ShipBattle >> checkShipBattle: currentTurnShip withCardHandler: gameCardHandler [

	| shipsInSamePosition |
	cardHanlder := gameCardHandler.
	currentTurnShip position = 1 ifTrue: [ ^ self ].
	shipsInSamePosition := ships select: [ :aShip |
		                       (currentTurnShip inSamePositionAs: aShip)
			                       and:
			                       (coalitionHanlder
				                        ship: aShip
				                        isNotAnAllyOf: currentTurnShip) ].
	shipsInSamePosition do: [ :aShipInSamePosition |
		currentTurnShip position = 1 ifTrue: [ ^ self ].
		self resolveBattleBetween: currentTurnShip and: aShipInSamePosition ]
]

{ #category : #initialization }
ShipBattle >> initializeWithShips: aCollectionOfShips withDice: aCollectionOfDice andCoalitionHandler: aColitionHandler [

	dice := aCollectionOfDice.
	ships := aCollectionOfShips.
	coalitionHanlder := aColitionHandler.
]

{ #category : #event }
ShipBattle >> resolveBattleBetween: aShip and: anotherShip [

	| anArmyOfShipsDiceRoll anotherArmyOfShipsDiceRoll loserShipArmy aShipArmy anotherShipArmy |
	aShipArmy := self shipsNames:
		             (coalitionHanlder armyOf: aShip withEnemy: anotherShip).
	
	anotherShipArmy := self shipsNames:
		                   (coalitionHanlder
			                    armyOf: anotherShip
			                    withEnemy: aShip).

	anArmyOfShipsDiceRoll := self throwForBattle: aShipArmy.
	anotherArmyOfShipsDiceRoll := self throwForBattle: anotherShipArmy.

	loserShipArmy := anArmyOfShipsDiceRoll > anotherArmyOfShipsDiceRoll
		                 ifTrue: [ anotherShipArmy ]
		                 ifFalse: [ aShipArmy ].

	loserShipArmy do: [ :aEnemyShip |
		aEnemyShip loseOneShield.
		aEnemyShip moveToFirstTile ]
]

{ #category : #translating }
ShipBattle >> shipWithName: aShipName [

	^ ships detect: [ :ship | ship shipName = aShipName ]
]

{ #category : #translating }
ShipBattle >> shipsNames: aShipsNameCollection [

	^ aShipsNameCollection collect: [ :shipName |
		  self shipWithName: shipName ]
]

{ #category : #event }
ShipBattle >> throwForBattle: anArmy [

	| armyOfShipsDiceRoll |
	armyOfShipsDiceRoll := 0.

	anArmy do: [ :aShipInArmy |
		| cardMovement |
		cardMovement := cardHanlder movementCardsActivated: aShipInArmy.
		armyOfShipsDiceRoll := armyOfShipsDiceRoll + dice throw
		                       + cardMovement ].

	^ armyOfShipsDiceRoll
]
