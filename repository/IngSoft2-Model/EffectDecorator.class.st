"
Effect decorator superclass to organize all posible effect decorators
"
Class {
	#name : #EffectDecorator,
	#superclass : #Object,
	#instVars : [
		'wrappedEffect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
EffectDecorator class >> withEffect: anEffect [

	^ self new initializeWithEffect: anEffect
]

{ #category : #applying }
EffectDecorator >> applyWith: anEffectManager activatedBy: aShip [

	self subclassResponsibility
]

{ #category : #initialization }
EffectDecorator >> initializeWithEffect: anEffect [

	wrappedEffect := anEffect
]
