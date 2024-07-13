"
Superclass for tile effects
"
Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
Effect >> applyReverseOn: anEffectManager activatedBy: aShip [

	self subclassResponsibility
]

{ #category : #applying }
Effect >> applyWith: anEffectManager activatedBy: aShip [

	self subclassResponsibility
]

{ #category : #generators }
Effect >> generateParameters: aTileEffectCreator [

	^ self
]
