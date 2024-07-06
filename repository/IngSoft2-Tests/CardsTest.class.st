Class {
	#name : #CardsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardsTest >> should: anErrorBlock raise: exceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: exceptionClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
CardsTest >> testTotalSumOfCardsProbabilitiesIs100 [

	| aBoard aCollectionOfNames aCollectionOfDie aTileArray aDeck |
	aTileArray := OrderedCollection new.
	2 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.

	aCollectionOfNames := OrderedCollection with: 'Jose'.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 10).


	self
		should: [
			aDeck := Deck withCardProbabilities:
				         (OrderedCollection with: (ProbabilityAssociation
						           associate: CancellationCard
						           withProbability: 50)) ]
		raise: Error
		withMessage:
		'Total card probabilities cannot be diferent from 100%'
]
