"
associates effects and their generation probability
"
Class {
	#name : #EffectProbability,
	#superclass : #Object,
	#instVars : [
		'effect',
		'probability',
		'lowerBound',
		'upperBound'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
EffectProbability class >> effect: aEffect withProbability: aProbability [

	^ self new
		  initializeWithEffect: aEffect
		  withProbability: aProbability
]

{ #category : #initialization }
EffectProbability >> effect [

	^ effect value
]

{ #category : #initialization }
EffectProbability >> initializeWithEffect: aEffect withProbability: aProbability [

	effect := aEffect.
	probability := aProbability
]

{ #category : #initialization }
EffectProbability >> probability [

	^ probability
]

{ #category : #testing }
EffectProbability >> rangeIncludes: aNumber [

	^  aNumber between: lowerBound  and: upperBound.
	
	"
	DEJO ESTO POR QUE FUNCIONA DE ALGUNA MANERA NO SE COMO
	
	(lowerBound < aNumber and: aNumber <= upperBound) or:
		  (lowerBound = 0 and: aNumber = 0)
	
	"
]

{ #category : #initialization }
EffectProbability >> setRange: aLowerBound [

	lowerBound := aLowerBound.
	upperBound := aLowerBound + probability
]