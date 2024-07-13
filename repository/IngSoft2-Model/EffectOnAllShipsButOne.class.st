"
proof of concept
"
Class {
	#name : #EffectOnAllShipsButOne,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
EffectOnAllShipsButOne >> affectAShip: aShip [

	self subclassResponsibility
]

{ #category : #applying }
EffectOnAllShipsButOne >> affectAllShips: aCollection but: aShip [

	^ self subclassResponsibility
]

{ #category : #applying }
EffectOnAllShipsButOne >> applyReverseOn: anEffectManager activatedBy: aShip [

	anEffectManager applyEffectOnOneShip: self triggeredBy: aShip
]

{ #category : #applying }
EffectOnAllShipsButOne >> applyWith: anEffectManager activatedBy: aShip [

	anEffectManager
		applyEffectOnAllShipsButOne: self
		triggerByShip: aShip
]
