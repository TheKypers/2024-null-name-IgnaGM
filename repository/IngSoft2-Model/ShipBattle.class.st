"
handles battles between ships and determines who participates
"
Class {
	#name : #ShipBattle,
	#superclass : #Object,
	#instVars : [
		'dice',
		'ships',
		'cardHanlder'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #events }
ShipBattle class >> withDice: aCollectionOfDice withShips: aCollectionOfShips [

	^ self new
		  initializeWithShips: aCollectionOfShips
		  withDice: aCollectionOfDice
]

{ #category : #initialization }
ShipBattle >> checkShipBattle: currentTurnShip withCardHandler: gameCardHandler [

	| shipsInSamePosition |
	cardHanlder := gameCardHandler.
	currentTurnShip position = 1 ifTrue: [ ^ self ].
	shipsInSamePosition := ships select: [ :aShip |
		                       (currentTurnShip inSamePositionAs: aShip)
			                       and:
				                       ((cardHanlder
					                         armyOf: currentTurnShip
					                         withEnemy: currentTurnShip) includes:
					                        aShip shipName) not ].
	shipsInSamePosition do: [ :aShipInSamePosition |
		currentTurnShip position = 1 ifTrue: [ ^ self ].
		self resolveBattleBetween: currentTurnShip and: aShipInSamePosition ]
]

{ #category : #initialization }
ShipBattle >> initializeWithShips: aCollectionOfShips withDice: aCollectionOfDice [

	dice := aCollectionOfDice.
	ships := aCollectionOfShips.
]

{ #category : #event }
ShipBattle >> resolveBattleBetween: aShip and: anotherShip [

	| anArmyOfShipsDiceRoll anotherArmyOfShipsDiceRoll loserShipArmy aShipArmy anotherShipArmy |
	aShipArmy := self shipsNames:
		             (cardHanlder armyOf: aShip withEnemy: anotherShip).

	anotherShipArmy := self shipsNames:
		                   (cardHanlder armyOf: anotherShip withEnemy: aShip).

	anArmyOfShipsDiceRoll := self throwForBattle: aShipArmy.
	anotherArmyOfShipsDiceRoll := self throwForBattle: anotherShipArmy.

	loserShipArmy := anArmyOfShipsDiceRoll > anotherArmyOfShipsDiceRoll
		                 ifTrue: [ anotherShipArmy ]
		                 ifFalse: [ aShipArmy ].

	loserShipArmy do: [ :aEnemyShip |
		aEnemyShip loseOneShield.
		aEnemyShip moveToFirstTile ]
]

{ #category : #event }
ShipBattle >> shipWithName: aShipName [

	^ ships detect: [ :ship | ship shipName = aShipName ]
]

{ #category : #event }
ShipBattle >> shipsNames: aShipsNameCollection [

	^ aShipsNameCollection collect: [ :shipName |
		  self shipWithName: shipName ]
]

{ #category : #'as yet unclassified' }
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
