Class {
	#name : #CoalitionHandler,
	#superclass : #Object,
	#instVars : [
		'reverseCoalitions',
		'normalCoalitions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
CoalitionHandler >> addToCoalitions: aCoalition [

	self verifyCoalition: aCoalition mercenary.

	normalCoalitions add: aCoalition
]

{ #category : #comparing }
CoalitionHandler >> alliesWithEnemy: aEnemyShip [

	^ (reverseCoalitions select: [ :coalition |
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

	normalCoalitions := OrderedCollection new.
	reverseCoalitions := OrderedCollection new
]

{ #category : #comparing }
CoalitionHandler >> mercenariesOfShips: aShip [

	| mercenaryCollection |
	mercenaryCollection := (normalCoalitions select: [ :coalition |
		                        (coalition hasLeader: aShip shipName) and:
			                        (reverseCoalitions includes: coalition) not ])
		                       collect: [ :coalition | coalition mercenary ].

	mercenaryCollection add: aShip shipName.
	^ mercenaryCollection
]

{ #category : #comparing }
CoalitionHandler >> modifyReverseCoalitions: aCoalition [

	(reverseCoalitions includes: aCoalition)
		ifFalse: [
			reverseCoalitions add: aCoalition.
			normalCoalitions remove: aCoalition ]
		ifTrue: [
			reverseCoalitions remove: aCoalition.
			normalCoalitions add: aCoalition ]
]

{ #category : #comparing }
CoalitionHandler >> removeCoalition: aCoalition [
	
	normalCoalitions removeAllSuchThat: [ :coalition | coalition = aCoalition ].
	reverseCoalitions removeAllSuchThat: [ :coalition | coalition = aCoalition ]
]

{ #category : #comparing }
CoalitionHandler >> verifyCoalition: mercenaryShip [

	(normalCoalitions anySatisfy: [ :coalition |
		 coalition mercenary = mercenaryShip ]) ifTrue: [
		CardExeption signal:
			'Targeted ship is already a mercenary in another coalition' ]
]
