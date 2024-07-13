"
a
"
Class {
	#name : #CardGeneratorEffect,
	#superclass : #Effect,
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
