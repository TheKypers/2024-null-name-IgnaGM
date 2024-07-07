Class {
	#name : #CardTarget,
	#superclass : #Target,
	#category : #'IngSoft2-Model'
}

{ #category : #verification }
CardTarget >> isValidWith: aTargetValidator [

	^ aTargetValidator cardIsValid: objective 
]
