Class {
	#name : #ReversalCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
ReversalCard >> activateWith: aCardHandler [

	^ aCardHandler reverseCard: target
]

{ #category : #comparing }
ReversalCard >> canPlayRightNow: theShipInTurn [

	^ true
]
