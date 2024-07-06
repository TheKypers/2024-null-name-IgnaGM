"
handles battles between ships and determines who participates
"
Class {
	#name : #ShipBattle,
	#superclass : #Object,
	#instVars : [
		'dice',
		'ships'
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
	currentTurnShip position = 1 ifTrue: [ ^ self ].
	shipsInSamePosition := ships select: [ :aShip |
		                       (currentTurnShip inSamePositionAs: aShip)
			                       and:
				                       ((gameCardHandler
					                         armyOf: currentTurnShip
					                         withEnemy: currentTurnShip) includes:
					                        aShip shipName) not ].
	shipsInSamePosition do: [ :aShipInSamePosition |
		currentTurnShip position = 1 ifTrue: [ ^ self ].
		self
			resolveBattleBetween: currentTurnShip
			and: aShipInSamePosition
			with: gameCardHandler ]
]

{ #category : #initialization }
ShipBattle >> initializeWithShips: aCollectionOfShips withDice: aCollectionOfDice [

	dice := aCollectionOfDice.
	ships := aCollectionOfShips.
]

{ #category : #event }
ShipBattle >> resolveBattleBetween: aShip and: anotherShip with: aCardHandler [

	| anArmyOfShipsDiceRoll anotherArmyOfShipsDiceRoll loserShipArmy aShipArmy anotherShipArmy |
	aShipArmy := self shipsNames:
		             (aCardHandler armyOf: aShip withEnemy: anotherShip).

	anotherShipArmy := self shipsNames:
		                   (aCardHandler
			                    armyOf: anotherShip
			                    withEnemy: aShip).

	anArmyOfShipsDiceRoll := 0.
	anotherArmyOfShipsDiceRoll := 0.

	aShipArmy do: [ :aShipInArmy |
		| cardMovement |
		cardMovement := aCardHandler movementCardsActivated: aShipInArmy.
		anArmyOfShipsDiceRoll := anArmyOfShipsDiceRoll + dice throw
		                         + cardMovement ].

	anotherShipArmy do: [ :aShipInArmy |
		| cardMovement |
		cardMovement := aCardHandler movementCardsActivated: aShipInArmy.
		anotherArmyOfShipsDiceRoll := anotherArmyOfShipsDiceRoll
		                              + dice throw + cardMovement ].

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
	
	^ aShipsNameCollection collect: [ :shipName | self shipWithName: shipName  ].
]
