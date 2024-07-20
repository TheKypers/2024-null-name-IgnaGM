"
a
"
Class {
	#name : #ReversedPolarityDecorator,
	#superclass : #EffectDecorator,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
ReversedPolarityDecorator >> applyReverseOn: aGame activatedBy: aShip [

	wrappedEffect applyWith: aGame activatedBy: aShip
]

{ #category : #applying }
ReversedPolarityDecorator >> applyWith: anEffectManager activatedBy: aShip [

	wrappedEffect applyReverseOn: anEffectManager activatedBy: aShip
]
