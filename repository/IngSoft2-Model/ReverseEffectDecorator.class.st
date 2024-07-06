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
ReverseEffectDecorator >> applyOn: aGame activatedBy: aShip [

	effectWrapped applyReverseOn: aGame activatedBy: aShip
]

{ #category : #applying }
ReverseEffectDecorator >> applyReverseOn: aGame activatedBy: aShip [

	effectWrapped applyOn: aGame activatedBy: aShip
]

{ #category : #initialization }
ReverseEffectDecorator >> initializeWithEffect: anEffect [ 
	
	effectWrapped := anEffect.
]
