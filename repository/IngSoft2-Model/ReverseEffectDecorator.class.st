Class {
	#name : #ReverseEffectDecorator,
	#superclass : #Object,
	#instVars : [
		'wrappedEffect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
ReverseEffectDecorator class >> withEffect: anEffect [

	^ self new initializeWithEffect: anEffect
]

{ #category : #applying }
ReverseEffectDecorator >> applyReverseOn: aGame activatedBy: aShip [

	wrappedEffect applyWith: aGame activatedBy: aShip
]

{ #category : #applying }
ReverseEffectDecorator >> applyWith: anEffectManager activatedBy: aShip [

	wrappedEffect applyReverseOn: anEffectManager activatedBy: aShip
]

{ #category : #initialization }
ReverseEffectDecorator >> initializeWithEffect: anEffect [ 
	
	wrappedEffect := anEffect.
]
