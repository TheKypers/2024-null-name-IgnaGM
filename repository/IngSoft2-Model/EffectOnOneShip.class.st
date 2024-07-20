"
proof of concept
"
Class {
	#name : #EffectOnOneShip,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
EffectOnOneShip >> applyReverseWith: aGame activatedBy: aShip [

	aGame applyEffectOnAllShipsButOne: self triggerByShip: aShip
]

{ #category : #applying }
EffectOnOneShip >> applyWith: anEffectManager activatedBy: aShip [

	anEffectManager applyEffectOnOneShip: self triggeredBy: aShip
]
