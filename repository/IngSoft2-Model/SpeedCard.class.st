"
a
"
Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
SpeedCard >> activateWith: aCardHandler [

	movement := 1.
	aCardHandler addToActiveCards: self.
	aCardHandler changeLastCardTo: self
]

{ #category : #comparing }
SpeedCard >> canPlayAtAnyTime: lastCardPlayed [

	^ false
]

{ #category : #event }
SpeedCard >> reverseCardEffectWith: aCardHandler [

	movement := movement negated
]

{ #category : #comparing }
SpeedCard >> shouldApplyOn: aTarget [

	^ target objective  = aTarget
]
