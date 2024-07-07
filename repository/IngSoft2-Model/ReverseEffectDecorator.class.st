Class {
	#name : #ReverseEffectDecorator,
	#superclass : #Object,
	#instVars : [
		'effectWrapped'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
ReverseEffectDecorator class >> withEffect: anEffect [

	^ self new initializeWithEffect: anEffect
]

{ #category : #applying }
ReverseEffectDecorator >> applyReverseOn: aGame activatedBy: aShip [

	effectWrapped applyWith: aGame activatedBy: aShip
]

{ #category : #applying }
ReverseEffectDecorator >> applyWith: anEffectManager activatedBy: aShip [

	effectWrapped applyReverseOn: anEffectManager activatedBy: aShip
]

{ #category : #initialization }
ReverseEffectDecorator >> initializeWithEffect: anEffect [ 
	
	effectWrapped := anEffect.
]
