"
null pattern implementation
"
Class {
	#name : #NullEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
NullEffect >> applyReverseWith: anEffectManager activatedBy: aShip [

	^ self
]

{ #category : #applying }
NullEffect >> applyWith: anEffectManager activatedBy: aShip [

	^ self
]
