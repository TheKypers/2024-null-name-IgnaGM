"
a
"
Class {
	#name : #CardGeneratorEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
CardGeneratorEffect >> applyWith: anEffectManager activatedBy: aShip [

	anEffectManager giveCardToCurrentShip: aShip
]
