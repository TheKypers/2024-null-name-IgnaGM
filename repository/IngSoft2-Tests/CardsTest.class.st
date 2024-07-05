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
CardsTest >> testAShipCannotBeHiredByMoreThanOneShip [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection
		                      with: 'Juan'
		                      with: 'Jose'
		                      with: 'Pedro'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 7 4 4 )).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: MercenaryCard
			                                  withProbability: 100).

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardProbabilities: collectionOfCardProbabilities.

	aGame playTurn.
	aGame playCard: MercenaryCard by: 'Jose' toTarget: 'Juan'.
	aGame playTurn.

	self
		assert: (aGame playCard: MercenaryCard by: 'Pedro' toTarget: 'Juan')
		equals: 'Targeted ship is already a mercenary in another coalition'.
	self assert: (aGame shipCards: 'Pedro') size equals: 2
]

{ #category : #tests }
CardsTest >> testWhenACancelationCardIsPlayedDeactivateTargetedCard [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].


	aTileArray at: 6 put: (CardGeneratorEffect withProbabilities:
			 (OrderedCollection with: (ProbabilityAssociation
					   associate: CancellationCard
					   withProbability: 100))).

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 4 )).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: AccelerationCard
			                                  withProbability: 100).

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardProbabilities: collectionOfCardProbabilities.

	aGame playTurn.
	aGame playCard: AccelerationCard by: 'Jose' toTarget:  'all'.
	aGame playCard: CancellationCard by: 'Juan' toTarget: (AccelerationCard withHolder: 'Jose').
	aGame playTurn.
	
	self assert: (aGame allShipsPosition at: 'Jose') first equals: 5
]

{ #category : #tests }
CardsTest >> testWhenACancelationCardIsPlayedItCannotTargetANonexistentCard [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].


	aTileArray at: 6 put: (CardGeneratorEffect withProbabilities:
			 (OrderedCollection with: (ProbabilityAssociation
					   associate: CancellationCard
					   withProbability: 100))).

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 4 )).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: AccelerationCard
			                                  withProbability: 100).

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardProbabilities: collectionOfCardProbabilities.

	aGame playTurn.
	aGame playCard: AccelerationCard by: 'Jose' toTarget:  'all'.
	aGame playCard: CancellationCard by: 'Juan' toTarget: (AccelerationCard withHolder: 'Jose').
	aGame playTurn.
	
	self assert: (aGame allShipsPosition at: 'Jose') first equals: 5
]

{ #category : #tests }
CardsTest >> testWhenApplingRepeatCardOnlyEffectsTargetedToOneShipCanBeRepeated [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities |
	aTileArray := OrderedCollection new.
	15 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray at: 10 put: AtomicBombEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 9 4 )).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: RepeatCard
			                                  withProbability: 100).


	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardProbabilities: collectionOfCardProbabilities.

	aGame playTurn.

	self
		assert: (aGame playCard: RepeatCard by: 'Jose' toTarget: 'Juan')
		equals:
		'AtomicBombEffect is last effect, and doesnt target a single ship'.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 1 1 ) asOrderedCollection.
	self assert: (aGame allShipAmountOfShields at: 'Juan') equals: 2
]

{ #category : #tests }
CardsTest >> testWhenApplyingRedoCardLastCardIsPlayedAgain [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities |
	aTileArray := OrderedCollection new.
	15 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray
		at: 6
		put:
			(CardGeneratorEffect withProbabilities: (OrderedCollection with:
					  (ProbabilityAssociation
						   associate: SpeedCard
						   withProbability: 100))).

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.

	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 1)).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: RedoCard
			                                  withProbability: 100).

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardProbabilities: collectionOfCardProbabilities.

	aGame playTurn. 
	aGame playTurn.
	aGame playCard: SpeedCard by: 'Juan' toTarget: 'Juan'. 
	aGame playTurn.
	aGame playCard: RedoCard by: 'Jose' toTarget: 'Jose'. 
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 4 1 ) asOrderedCollection
]

{ #category : #tests }
CardsTest >> testWhenApplyingRedoCardMultipleTimesApplyLastNonRedoCard [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities |
	aTileArray := OrderedCollection new.
	15 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray
		at: 6
		put:
			(CardGeneratorEffect withProbabilities: (OrderedCollection with:
					  (ProbabilityAssociation
						   associate: SpeedCard
						   withProbability: 100))).

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.

	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 1)).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: RedoCard
			                                  withProbability: 100).

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardProbabilities: collectionOfCardProbabilities.

	aGame playTurn. 
	aGame playTurn.
	aGame playCard: SpeedCard by: 'Juan' toTarget: 'Juan'. 
	aGame playCard: RedoCard by: 'Juan' toTarget: 'Juan'.
	aGame playTurn.
	aGame playCard: RedoCard by: 'Jose' toTarget: 'Jose'. 
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 4 1 ) asOrderedCollection
]

{ #category : #tests }
CardsTest >> testWhenApplyingRepeatCardShipDoesNotMoveOutOfBounds [
	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray at: 6 put: BlackHoleEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 )).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: RepeatCard
			                                  withProbability: 100).

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardProbabilities: collectionOfCardProbabilities.

	aGame playTurn.
	aGame playCard: RepeatCard by: 'Jose' toTarget: 'Juan'.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 1 1 ) asOrderedCollection.
]

{ #category : #tests }
CardsTest >> testWhenMercenaryCardIsCancelledShipsCanBattleAgain [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].


	aTileArray at: 6 put: (CardGeneratorEffect withProbabilities:
			 (OrderedCollection with: (ProbabilityAssociation
					   associate: CancellationCard
					   withProbability: 100))).

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 )).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: MercenaryCard
			                                  withProbability: 100).

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardProbabilities: collectionOfCardProbabilities.

	aGame playTurn.
	aGame playCard: MercenaryCard by: 'Jose' toTarget: 'Juan'.
	aGame
		playCard: CancellationCard
		by: 'Juan'
		toTarget: (MercenaryCard withHolder: 'Jose').
	aGame playTurn.

	self assert: (aGame allShipAmountOfShields at: 'Juan') equals: 3.
	self assert: (aGame allShipAmountOfShields at: 'Jose') equals: 2
]

{ #category : #tests }
CardsTest >> testWhenMercenaryCardIsPlayedAlliedShipsDontBattle [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities aPosition |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 )).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: MercenaryCard
			                                  withProbability: 100).

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardProbabilities: collectionOfCardProbabilities.

	aGame playTurn.
	aGame playCard: MercenaryCard by: 'Jose' toTarget: 'Juan'.
	aGame playTurn.

	aPosition := #( 6 1 ) asOrderedCollection.

	self assert: (aGame allShipsPosition at: 'Juan') equals: aPosition.
	self assert: (aGame allShipsPosition at: 'Jose') equals: aPosition.

	self assert: (aGame allShipAmountOfShields at: 'Juan') equals: 3.
	self assert: (aGame allShipAmountOfShields at: 'Jose') equals: 3
]