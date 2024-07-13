"
null pattern implementation
"
Class {
	#name : #NullEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
NullEffect >> applyReverseOn: anEffectManager activatedBy: aShip [

	^ self
]

{ #category : #applying }
NullEffect >> applyWith: anEffectManager activatedBy: aShip [

	^ self
]
