"
black hole effect
"
Class {
	#name : #BlackHoleEffect,
	#superclass : #EffectOnOneShip,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
BlackHoleEffect >> affectAShip: aShip [

	aShip moveTiles: -4
]

{ #category : #applying }
BlackHoleEffect >> affectAllShips: aShipCollection but: triggeringShip [

	aShipCollection
		reject: [ :aShip | aShip = triggeringShip ]
		thenCollect: [ :aShip | aShip moveTiles: -4 ]
]
