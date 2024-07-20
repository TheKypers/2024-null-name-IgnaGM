"
a
"
Class {
	#name : #ReversedPolarityDecorator,
	#superclass : #EffectDecorator,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
ReversedPolarityDecorator >> applyReverseWith: aGame activatedBy: aShip [

	wrappedEffect applyWith: aGame activatedBy: aShip
]

{ #category : #applying }
ReversedPolarityDecorator >> applyWith: anEffectManager activatedBy: aShip [

	wrappedEffect applyReverseWith: anEffectManager activatedBy: aShip
]
