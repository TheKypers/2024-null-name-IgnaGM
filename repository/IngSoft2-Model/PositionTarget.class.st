"
a
"
Class {
	#name : #PositionTarget,
	#superclass : #Target,
	#category : #'IngSoft2-Model'
}

{ #category : #verification }
PositionTarget >> isValidWith: aTargetValidator [

	aTargetValidator positionTargetIsValid: objective
]
