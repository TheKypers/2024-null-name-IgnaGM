Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
RepeatCard >> activateWith: aCardHandler [

	aCardHandler applyLastEffectOn: target.
	aCardHandler changeLastCardTo: self
]

{ #category : #comparing }
RepeatCard >> canPlayRightNow: theShipInTurn [

	^true
]
