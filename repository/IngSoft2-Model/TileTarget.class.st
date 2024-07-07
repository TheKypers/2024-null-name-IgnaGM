"
a
"
Class {
	#name : #TileTarget,
	#superclass : #Target,
	#category : #'IngSoft2-Model'
}

{ #category : #verification }
TileTarget >> isValidWith: aTargetValidator [

	aTargetValidator tileTargetIsValid: objective
]
