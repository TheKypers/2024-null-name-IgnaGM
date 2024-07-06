Class {
	#name : #TileTarget,
	#superclass : #Target,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
TileTarget >> isValidWith: aCollectionOfShips and: aCardHandler and: aBoard [

	(aBoard numbOfTiles < objective) ifTrue: [
		Error signal: 'Targeted tile is out of bounds' ].

	^ true
]
