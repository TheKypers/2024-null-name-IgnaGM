Class {
	#name : #ReversePolarityTest,
	#superclass : #CardsEffectTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ReversePolarityTest >> testWhenReversePolarityCardIsPlayedTargetingABlackHoleEffectTheEffectTargetedIsReversed [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray at: 6 put: BlackHoleEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 8 5 )).

	collectionOfCards := OrderedCollection new.
	1 timesRepeat: [ collectionOfCards add: ReversePolarityCard ].

	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.

	aTarget := TileTarget withObjective: 6.

	aGame playCard: ReversePolarityCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 5 1 ) asOrderedCollection.
	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 6 1 ) asOrderedCollection
]

{ #category : #tests }
ReversePolarityTest >> testWhenReversePolarityTargetigAnEffectIsAffectedByAReversalCardTheEffectAffectsItsNormalTarget [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget anotherTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray at: 6 put: BlackHoleEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 8 5 )).

	collectionOfCards := OrderedCollection new.
	3 timesRepeat: [ collectionOfCards add: ReversePolarityCard ].
	1 timesRepeat: [ collectionOfCards add: ReversalCard  ].

	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.

	aTarget := TileTarget withObjective: 6.
	anotherTarget := CardTarget withObjective:
		                 (ReversePolarityCard
			                  withHolder: 'Juan'
			                  andTarget: aTarget).

	aGame playCard: ReversePolarityCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.
	aGame playCard: ReversalCard by: 'Jose' toTarget: anotherTarget.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 9 1 ) asOrderedCollection.

	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 2 1 ) asOrderedCollection
]

{ #category : #tests }
ReversePolarityTest >> testWhenReversePolarityTargetingABlackHoleEffectTileIsCanceledEffectIsNormalyApplied [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget anotherTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray at: 6 put: BlackHoleEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 8 5 )).

	collectionOfCards := OrderedCollection new.
	3 timesRepeat: [ collectionOfCards add: ReversePolarityCard ].
	1 timesRepeat: [ collectionOfCards add: CancellationCard ].

	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.

	aTarget := TileTarget withObjective: 6.
	anotherTarget := CardTarget withObjective:
		                 (ReversePolarityCard
			                  withHolder: 'Juan'
			                  andTarget: aTarget).

	aGame playCard: ReversePolarityCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.
	aGame playCard: CancellationCard by: 'Jose' toTarget: anotherTarget.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 9 1 ) asOrderedCollection.

	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 2 1 ) asOrderedCollection
]