"
a
"
Class {
	#name : #CardGeneratorEffect,
	#superclass : #EffectOnOneShip,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
CardGeneratorEffect >> applyReverseOn: anEffectManager activatedBy: aShip [

	anEffectManager giveCardToAllShipsBut: aShip
]

{ #category : #applying }
CardGeneratorEffect >> applyWith: anEffectManager activatedBy: aShip [

	anEffectManager giveCardToCurrentShip: aShip
]
