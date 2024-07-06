Class {
	#name : #CoalitionHandler,
	#superclass : #Object,
	#instVars : [
		'coalitions',
		'conflictCoalition'
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

	^ (conflictCoalition select: [ :coalition |
		   coalition hasLeader: aEnemyShip shipName ]) collect: [ :coalition |
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
	conflictCoalition := OrderedCollection new
]

{ #category : #comparing }
CoalitionHandler >> mercenariesOfShips: aShip [

	| mercenaryCollection |
	mercenaryCollection := (coalitions select: [ :coalition |
		                        (coalition hasLeader: aShip shipName) and:
			                        (conflictCoalition includes: coalition) not ])
		                       collect: [ :coalition | coalition mercenary ].

	mercenaryCollection add: aShip shipName.
	^ mercenaryCollection
]

{ #category : #comparing }
CoalitionHandler >> modifyReverseCoalitions: aCoalition [

	(conflictCoalition includes: aCoalition)
		ifFalse: [
			conflictCoalition add: aCoalition.
			coalitions remove: aCoalition ]
		ifTrue: [
			conflictCoalition remove: aCoalition.
			coalitions add: aCoalition ]
]

{ #category : #comparing }
CoalitionHandler >> removeCoalition: aCoalition [
	
	coalitions removeAllSuchThat: [ :coalition | coalition = aCoalition ].
	conflictCoalition removeAllSuchThat: [ :coalition | coalition = aCoalition ]
]

{ #category : #comparing }
CoalitionHandler >> verifyCoalition: mercenaryShip [

	(coalitions anySatisfy: [ :coalition |
		 coalition mercenary = mercenaryShip ]) ifTrue: [
		CardExeption signal:
			'Targeted ship is already a mercenary in another coalition' ]
]
