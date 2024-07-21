"
s
"
Class {
	#name : #NullCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
NullCard >> activateWith: aCardHandler [

	aCardHandler changeLastCardTo: self .
	^ self
]

{ #category : #comparing }
NullCard >> canPlayAtAnyTime: lastCardPlayed [

	^ true
]
