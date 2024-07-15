"
a
"
Class {
	#name : #NullTarget,
	#superclass : #Target,
	#category : #'IngSoft2-Model'
}

{ #category : #verification }
NullTarget >> isValidWith: aTargetValidator [

	CardExeption signal: 'No target has been set'
]
