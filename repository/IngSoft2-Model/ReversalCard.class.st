"
a

"
Class {
	#name : #ReversalCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
ReversalCard >> activateWith: aCardHandler [

	aCardHandler reverseCard: target.
	aCardHandler addToActiveCards: self 
]

{ #category : #comparing }
ReversalCard >> canPlayAtAnyTime: lastCardPlayed [

	^ true
]
