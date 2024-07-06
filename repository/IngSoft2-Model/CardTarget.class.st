Class {
	#name : #CardTarget,
	#superclass : #Target,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
CardTarget >> isValidWith: aCollectionOfShips and: aCardHandler and: aBoard [

	^ aCardHandler checkTarget: objective
]
