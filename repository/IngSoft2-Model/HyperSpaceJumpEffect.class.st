"
HyperSpaceJump class
"
Class {
	#name : #HyperSpaceJumpEffect,
	#superclass : #EffectOnOneShip,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
HyperSpaceJumpEffect >> affectAShip: aShip [
	
	aShip moveTiles: 4.
	aShip loseOneShield.
]

{ #category : #applying }
HyperSpaceJumpEffect >> affectAllShips: aShipCollection but: triggeringShip [

	aShipCollection
		reject: [ :ship | ship = triggeringShip ]
		thenCollect: [ :ship |
			ship moveTiles: 4.
			ship loseOneShield ]
]
