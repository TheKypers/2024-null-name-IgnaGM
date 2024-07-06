Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
SpeedCard >> activate: aCardHandler withTarget: aTarget [

	target := aTarget.
	movement := 1.
	aCardHandler addToActiveCards: self.
	aCardHandler changeLastCardTo: self
]

{ #category : #comparing }
SpeedCard >> applyMovement [

	^ movement 
]

{ #category : #comparing }
SpeedCard >> canPlayRightNow: theShipInTurn [

	^ theShipInTurn shipName = holder
]

{ #category : #'as yet unclassified' }
SpeedCard >> reverseCardEffectWith: anCardHandler [

	movement := movement negated
]

{ #category : #comparing }
SpeedCard >> shouldApplyOn: aTarget [

	^ target objective  = aTarget
]
