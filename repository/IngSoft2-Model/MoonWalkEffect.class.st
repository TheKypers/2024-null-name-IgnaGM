"
moon walk effect class
"
Class {
	#name : #MoonWalkEffect,
	#superclass : #EffectOnAllShipsButOne,
	#instVars : [
		'moonWalkDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
MoonWalkEffect class >> isValid: aDistance [

	aDistance strictlyPositive ifFalse: [
		Error signal: 'Moonwalk distance must be strictly positive' ]
]

{ #category : #'class initialization' }
MoonWalkEffect class >> withMoonwalkDistance: aDistance [
	
	self isValid:aDistance.
	
	^ self new initializeWithMoonwalkDistance: aDistance 
]

{ #category : #applying }
MoonWalkEffect >> affectAShip: aShip [

	aShip moveTiles: moonWalkDistance negated
]

{ #category : #applying }
MoonWalkEffect >> affectAllShips: aShipCollection but: aShip [

	aShipCollection
		reject: [ :ship | ship = aShip ]
		thenCollect: [ :ship | ship moveTiles: moonWalkDistance negated ]
]

{ #category : #generators }
MoonWalkEffect >> generateParameters: aTileEffectCreator [

	aTileEffectCreator generateMoonWalkParameters: self
]

{ #category : #initialization }
MoonWalkEffect >> initializeWithMoonwalkDistance: aDistance [

	moonWalkDistance := aDistance
]
