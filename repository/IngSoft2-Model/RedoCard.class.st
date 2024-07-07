Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
RedoCard >> activateWith: aCardHandler [

	aCardHandler activateCard: (aCardHandler lastCardPlayed class
			 withHolder: holder
			 andTarget: target)
]

{ #category : #comparing }
RedoCard >> canPlayRightNow: theShipInTurn [

	^ true
]
