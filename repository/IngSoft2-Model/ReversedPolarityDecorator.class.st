"
a
"
Class {
	#name : #ReversedPolarityDecorator,
	#superclass : #Object,
	#instVars : [
		'wrappedEffect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
ReversedPolarityDecorator class >> withEffect: anEffect [

	^ self new initializeWithEffect: anEffect
]

{ #category : #applying }
ReversedPolarityDecorator >> applyReverseOn: aGame activatedBy: aShip [

	wrappedEffect applyWith: aGame activatedBy: aShip
]

{ #category : #applying }
ReversedPolarityDecorator >> applyWith: anEffectManager activatedBy: aShip [

	wrappedEffect applyReverseOn: anEffectManager activatedBy: aShip
]

{ #category : #initialization }
ReversedPolarityDecorator >> initializeWithEffect: anEffect [ 
	
	wrappedEffect := anEffect.
]
