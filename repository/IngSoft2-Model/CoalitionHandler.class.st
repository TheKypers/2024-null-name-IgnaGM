"
a
"
Class {
	#name : #CoalitionHandler,
	#superclass : #Object,
	#instVars : [
		'coalitions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
CoalitionHandler >> addToCoalitions: aCoalition [

	self verifyCoalition: aCoalition mercenary.

	coalitions add: aCoalition
]

{ #category : #comparing }
CoalitionHandler >> alliesWithEnemy: aEnemyShip [

	^ (coalitions  select: [ :coalition |
		   (coalition hasLeader: aEnemyShip shipName) and:
			   coalition isReversed ]) collect: [ :coalition |
		  coalition mercenary ]
]

{ #category : #comparing }
CoalitionHandler >> armyOf: aShip withEnemy: aEnemyShip [

	| mercenariesCollections reversedMercenariesCollections armyCollection |
	
	mercenariesCollections := self mercenariesOfShips: aShip.
	reversedMercenariesCollections := self alliesWithEnemy: aEnemyShip.

	armyCollection := mercenariesCollections union:
		                  reversedMercenariesCollections.

	^ armyCollection
]

{ #category : #initialization }
CoalitionHandler >> initialize [

	coalitions := OrderedCollection new.
]

{ #category : #comparing }
CoalitionHandler >> mercenariesOfShips: aShip [

	| mercenaryCollection |
	mercenaryCollection := (coalitions select: [ :coalition |
		                        (coalition hasLeader: aShip shipName) and:
			                        coalition isReversed not ]) collect: [
		                       :coalition | coalition mercenary ].

	mercenaryCollection add: aShip shipName.
	^ mercenaryCollection
]

{ #category : #comparing }
CoalitionHandler >> modifyReverseCoalitionsWith: aCoalition [

	(coalitions detect: [ :coalition | coalition = aCoalition ])
		reverseCoaltion
]

{ #category : #comparing }
CoalitionHandler >> removeCoalition: aCoalition [

	coalitions removeAllSuchThat: [ :coalition | coalition = aCoalition ]
]

{ #category : #comparing }
CoalitionHandler >> ship: aShip isNotAnAllyOf: currentTurnShip [

	^ ((self armyOf: currentTurnShip withEnemy: currentTurnShip)
		   includes: aShip shipName) not
]

{ #category : #comparing }
CoalitionHandler >> verifyCoalition: mercenaryShip [

	(coalitions anySatisfy: [ :coalition |
		 coalition mercenary = mercenaryShip ]) ifTrue: [
		CardExeption signal:
			'Targeted ship is already a mercenary in another coalition' ]
]
