Class {
	#name : #NullTarget,
	#superclass : #Target,
	#category : #'IngSoft2-Model'
}

{ #category : #verification }
NullTarget >> isValidWith: aTargetValidator [

	Error signal: 'No target has been set'
]
