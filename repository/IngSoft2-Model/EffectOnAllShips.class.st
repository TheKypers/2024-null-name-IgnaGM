"
proof of concept
"
Class {
	#name : #EffectOnAllShips,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
EffectOnAllShips >> affectAShipCollection: aShipCollection [

	^ self subclassResponsibility
]

{ #category : #applying }
EffectOnAllShips >> applyReverseOn: anEffectManager activatedBy: triggeringShip [

	^ self
]

{ #category : #applying }
EffectOnAllShips >> applyWith: anEffectManager activatedBy: aShip [

	anEffectManager applyEffectOnAllShips: self
]
