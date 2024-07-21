"
a

"
Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
AccelerationCard >> activateWith: aCardHandler [

	movement := 1.
	aCardHandler addToActiveCards: self.
	aCardHandler changeLastCardTo: self
]

{ #category : #comparing }
AccelerationCard >> canPlayAtAnyTime: lastCardPlayed [

	^ false
]

{ #category : #event }
AccelerationCard >> reverseCardEffectWith: anCardHandler [

	movement := movement negated
]
