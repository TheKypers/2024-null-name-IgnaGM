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

	| mercenaryCollection rougeMercenaryCollection combinedSet armyCollection |
	mercenaryCollection := self mercenariesOfShips: aShip.
	rougeMercenaryCollection := self alliesWithEnemy: aEnemyShip.

	combinedSet := mercenaryCollection asSet union:
		               rougeMercenaryCollection asSet.
	armyCollection := OrderedCollection withAll: combinedSet asArray.

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
CoalitionHandler >> modifyReverseCoalitionsWith: aLeader andMercenary: aMercenary [

	| aNormalCoalition aReversedCoalition |
	aNormalCoalition := NormalShipCoalition
		                    withLeader: aLeader
		                    andMercenary: aMercenary.

	aReversedCoalition := ReversedShipCoalition
		                      withLeader: aLeader
		                      andMercenary: aMercenary.

	(coalitions includes: aNormalCoalition)
		ifTrue: [
			coalitions remove: aNormalCoalition.
			coalitions add: aReversedCoalition ]
		ifFalse: [
			coalitions add: aNormalCoalition.
			coalitions remove: aReversedCoalition ]
]

{ #category : #comparing }
CoalitionHandler >> removeCoalitionOf: aLeader and: aMercenary [

	coalitions removeAllSuchThat: [ :coalition |
		coalition hasSameMembersAs:
			(ShipCoalition
				 withLeader: aLeader
				 andMercenary: aMercenary objective) ]
]

{ #category : #comparing }
CoalitionHandler >> verifyCoalition: mercenaryShip [

	(coalitions anySatisfy: [ :coalition |
		 coalition mercenary = mercenaryShip ]) ifTrue: [
		CardExeption signal:
			'Targeted ship is already a mercenary in another coalition' ]
]
