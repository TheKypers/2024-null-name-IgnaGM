Class {
	#name : #ReversalCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
ReversalCard >> activate: aCardHandler withTarget: aCard [

	^ aCardHandler reverseCard: aCard
]

{ #category : #comparing }
ReversalCard >> canPlayRightNow: theShipInTurn [

	^ true
]
