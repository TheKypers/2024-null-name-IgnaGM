"
a
"
Class {
	#name : #ReversePolarityCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
ReversePolarityCard >> activateWith: aCardHandler [

	aCardHandler reverseEffectPolarity: target.
	aCardHandler addToActiveCards: self
]

{ #category : #comparing }
ReversePolarityCard >> canPlayRightNow: theShipInTurn [

	^ theShipInTurn shipName = holder
]

{ #category : #event }
ReversePolarityCard >> deactivate: aCardHandler [

	aCardHandler reverseEffectPolarity: target
]

{ #category : #event }
ReversePolarityCard >> reverseCardEffectWith: aCardHandler [

	aCardHandler reverseEffectPolarity: target
]
