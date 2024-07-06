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
BlackHoleEffect >> affectAllShips: aShipCollection but: currentTurnShip [

	aShipCollection
		reject: [ :aShip | aShip = currentTurnShip ]
		thenCollect: [ :aShip | aShip moveTiles: -4 ]
]
