"
a
"
Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
CancellationCard >> activateWith: aCardHandler [

	aCardHandler deactivate: target.
	aCardHandler removeFromActiveCard: target objective.

	aCardHandler changeLastCardTo: self
]

{ #category : #comparing }
CancellationCard >> canPlayRightNow: theShipInTurn [

	^ true
]
