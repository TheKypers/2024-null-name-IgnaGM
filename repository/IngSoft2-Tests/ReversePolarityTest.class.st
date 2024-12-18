Class {
	#name : #ReversePolarityTest,
	#superclass : #CardsEffectTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ReversePolarityTest >> testWhenReversePolarityCardIsPlayedTargetingABlackHoleEffectTheTargetAffectedIsReversed [

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

	aTarget := PositionTarget withObjective: 6.

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
ReversePolarityTest >> testWhenReversePolarityCardIsPlayedTargetingACardGeneratorEffectTargetAffectedIsReversed [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray at: 6 put: CardGeneratorEffect new.

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

	aTarget := PositionTarget withObjective: 6.

	aGame playTurn.
	aGame playCard: ReversePolarityCard by: 'Jose' toTarget: aTarget.
	aGame playTurn.

	self assert: (aGame shipWithName: 'Juan' hasAmountOfCards: 3).
	self assert: (aGame shipWithName: 'Jose' hasAmountOfCards: 1)
]

{ #category : #tests }
ReversePolarityTest >> testWhenReversePolarityCardIsPlayedTargetingAHyperJumpEffectTheTargetAffectedIsReversed [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget aParsecCollection |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aParsecCollection := OrderedCollection
		                     with: (Parsec withNominalValue: 1)
		                     with: (Parsec withNominalValue: 2)
		                     with: (Parsec withNominalValue: -2)
		                     with: (Parsec withNominalValue: 1).

	aTileArray at: 6 put: (HyperJumpEffect
			 withParsecArray: aParsecCollection
			 andLengthInTiles: 10
			 andLengthInParsecs: 5).

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 4 5 )).

	collectionOfCards := OrderedCollection new.
	1 timesRepeat: [ collectionOfCards add: ReversePolarityCard ].

	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.

	aTarget := PositionTarget withObjective: 6.

	aGame playCard: ReversePolarityCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 9 1 ) asOrderedCollection.

	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 6 1 ) asOrderedCollection
]

{ #category : #tests }
ReversePolarityTest >> testWhenReversePolarityCardIsPlayedTargetingAHyperSpaceJumpEffectTheTargetAffectedIsReversed [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray at: 6 put: HyperSpaceJumpEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 4 5 )).

	collectionOfCards := OrderedCollection new.
	1 timesRepeat: [ collectionOfCards add: ReversePolarityCard ].

	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.

	aTarget := PositionTarget withObjective: 6.

	aGame playCard: ReversePolarityCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 9 1 ) asOrderedCollection.
	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 6 1 ) asOrderedCollection
]

{ #category : #tests }
ReversePolarityTest >> testWhenReversePolarityCardIsPlayedTargetingAMoonWalkEffectTheTargetAffectedIsReversed [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray at: 6 put: (MoonWalkEffect withMoonwalkDistance: 2).

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

	aTarget := PositionTarget withObjective: 6.

	aGame playCard: ReversePolarityCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 9 1 ) asOrderedCollection.
	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 4 1 ) asOrderedCollection
]

{ #category : #tests }
ReversePolarityTest >> testWhenReversePolarityCardIsPlayedTargetingAWormholeEffectTheTargetAffectedIsReversed [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray at: 6 put: (WormholeEffect fromPosition: 6 toPosition: 4).
	aTileArray at: 4 put: (WormholeEffect fromPosition: 4 toPosition: 6).

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

	aTarget := PositionTarget withObjective: 6.

	aGame playCard: ReversePolarityCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 1 1 ) asOrderedCollection.
	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 6 1 ) asOrderedCollection
]

{ #category : #tests }
ReversePolarityTest >> testWhenReversePolarityCardIsPlayedTargetingAnAtomicBombEffectTheTargetAffectedIsReversed [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray at: 6 put: AtomicBombEffect new.

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

	aTarget := PositionTarget withObjective: 6.

	aGame playCard: ReversePolarityCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 9 1 ) asOrderedCollection.
	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 6 1 ) asOrderedCollection
]

{ #category : #tests }
ReversePolarityTest >> testWhenReversePolarityCardIsPlayedTargetingAnNullEffectTheTargetAffectedIsNull [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

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

	aTarget := PositionTarget withObjective: 6.

	aGame playCard: ReversePolarityCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 9 1 ) asOrderedCollection.
	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 6 1 ) asOrderedCollection
]

{ #category : #tests }
ReversePolarityTest >> testWhenReversePolarityTargetigAnEffectIsAffectedByAReversalCardTheEffectIsNormalyApplied [

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

	aTarget := PositionTarget withObjective: 6.
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
ReversePolarityTest >> testWhenReversePolarityTargetingAnEffectIsCanceledEffectIsNormalyApplied [

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

	aTarget := PositionTarget withObjective: 6.
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
