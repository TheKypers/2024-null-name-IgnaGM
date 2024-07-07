Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
AccelerationCard >> activateWith: aCardHandler [

	movement  := 1.
	aCardHandler addToActiveCards: self.
	aCardHandler changeLastCardTo: self
]

{ #category : #comparing }
AccelerationCard >> applyMovement [

	^ movement
]

{ #category : #comparing }
AccelerationCard >> canPlayRightNow: theShipInTurn [

	^ theShipInTurn shipName = holder
]

{ #category : #event }
AccelerationCard >> reverseCardEffectWith: anCardHandler [

	movement := movement negated
]
