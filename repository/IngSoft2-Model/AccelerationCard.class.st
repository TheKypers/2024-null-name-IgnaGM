Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
AccelerationCard >> activate: aCardHandler withTarget: aTarget [

	target := aTarget.
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

{ #category : #'as yet unclassified' }
AccelerationCard >> reverseCardEffect [

	movement := movement negated
]
