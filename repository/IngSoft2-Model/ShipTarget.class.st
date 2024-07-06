Class {
	#name : #ShipTarget,
	#superclass : #Target,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
ShipTarget >> isValidWith: aCollectionOfShips and: aCardHandler and: aBoard [

	^ aCollectionOfShips anySatisfy: [ :ship | ship shipName = objective ]
]
