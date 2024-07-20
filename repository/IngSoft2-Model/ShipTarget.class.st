"
a
"
Class {
	#name : #ShipTarget,
	#superclass : #Target,
	#category : #'IngSoft2-Model'
}

{ #category : #verification }
ShipTarget >> isValidWith: aTargetValidator [

	aTargetValidator shipTargetIsValid: objective .
]
