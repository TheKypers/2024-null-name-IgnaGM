Class {
	#name : #CardsEffectTest,
	#superclass : #CardsTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardsEffectTest >> testAShipCannotBeHiredByMoreThanOneShip [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget |
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
	
	collectionOfCards := OrderedCollection new.
	10 timesRepeat: [ collectionOfCards add: MercenaryCard ].
	aDeck := LoadedDeck withCards: collectionOfCards.
	
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.
	
	aTarget := ShipTarget withObjective: 'Juan'.
	
	aGame playTurn.
	aGame playCard: MercenaryCard by: 'Jose' toTarget: aTarget .
	aGame playTurn.

	self
		assert: (aGame playCard: MercenaryCard by: 'Pedro' toTarget: aTarget)
		equals: 'Targeted ship is already a mercenary in another coalition'.
	self assert: (aGame shipCards: 'Pedro') size equals: 2
]

{ #category : #tests }
CardsEffectTest >> testWhenACancelationCardIsPlayedDeactivateTargetedCard [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget anotherTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 4 )).

	collectionOfCards := OrderedCollection
		                     with: CancellationCard
		                     with: AccelerationCard
		                     with: CancellationCard
		                     with: AccelerationCard.

	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.

	aTarget := CardTarget withObjective:
		           (AccelerationCard withHolder: 'Jose').
		
	anotherTarget := AllShipsTarget new.
	
	aGame playTurn.
	aGame playCard: AccelerationCard by: 'Jose' toTarget: anotherTarget.
	aGame playCard: CancellationCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.

	self assert: (aGame allShipsPosition at: 'Jose') first equals: 5
]

{ #category : #tests }
CardsEffectTest >> testWhenACancelationCardIsPlayedItCannotTargetANonexistentCard [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget anotherTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].


	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 4 )).

	collectionOfCards := OrderedCollection
		                     with: CancellationCard
		                     with: AccelerationCard
		                     with: CancellationCard
		                     with: AccelerationCard.
	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.

	aTarget := CardTarget withObjective:
		           (AccelerationCard withHolder: 'Jose').

	anotherTarget := AllShipsTarget new.


	aGame playTurn.
	aGame playCard: AccelerationCard by: 'Jose' toTarget: anotherTarget.
	aGame playCard: CancellationCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.

	self assert: (aGame allShipsPosition at: 'Jose') first equals: 5
]

{ #category : #tests }
CardsEffectTest >> testWhenApplingRepeatCardLastEffectIsAppliedToTheTargetedShip [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget |
	aTileArray := OrderedCollection new.
	15 timesRepeat: [ aTileArray add: NullEffect new ].
	
	aTileArray at: 10 put: BlackHoleEffect new.
	
	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 9 4 )).

	collectionOfCards := OrderedCollection new.
	10 timesRepeat: [ collectionOfCards add: RepeatCard ].
	aDeck := LoadedDeck withCards: collectionOfCards.
	
	
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.

	aTarget := ShipTarget withObjective: 'Juan'.

	aGame playTurn.
	aGame playCard: RepeatCard by: 'Jose' toTarget: aTarget.
	
	self assert: (aGame allShipsPosition at: 'Juan') equals: #(2 1) asOrderedCollection 
]

{ #category : #tests }
CardsEffectTest >> testWhenApplyingRedoCardLastCardIsPlayedAgain [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget anotherTarget |
	aTileArray := OrderedCollection new.
	15 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray at: 6 put: CardGeneratorEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.

	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 1 )).

	collectionOfCards := OrderedCollection new.
	4 timesRepeat: [ collectionOfCards add: RedoCard ].
	collectionOfCards add: SpeedCard.
	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.

	aTarget := ShipTarget withObjective: 'Juan'.
	anotherTarget := ShipTarget withObjective: 'Jose'.

	aGame playTurn.
	aGame playTurn.
	aGame playCard: SpeedCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.
	aGame playCard: RedoCard by: 'Jose' toTarget: anotherTarget.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 4 1 ) asOrderedCollection
]

{ #category : #tests }
CardsEffectTest >> testWhenApplyingRedoCardMultipleTimesApplyLastNonRedoCard [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget anotherTarget |
	aTileArray := OrderedCollection new.
	15 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray at: 6 put: CardGeneratorEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.

	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 1 )).

	collectionOfCards := OrderedCollection new.
	4 timesRepeat: [ collectionOfCards add: RedoCard ].
	collectionOfCards add: SpeedCard.
	aDeck := LoadedDeck withCards: collectionOfCards.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.
	
	aTarget := ShipTarget withObjective: 'Juan'.
	anotherTarget := ShipTarget withObjective: 'Jose'.
	
	
	aGame playTurn.
	aGame playTurn.
	aGame playCard: SpeedCard by: 'Juan' toTarget: aTarget.
	aGame playCard: RedoCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.
	aGame playCard: RedoCard by: 'Jose' toTarget: anotherTarget.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 4 1 ) asOrderedCollection
]

{ #category : #tests }
CardsEffectTest >> testWhenApplyingRepeatCardShipDoesNotMoveOutOfBounds [

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
		                    (SequenceDie withSequence: #( 5 )).

	collectionOfCards := OrderedCollection new.
	10 timesRepeat: [ collectionOfCards add: RepeatCard ].
	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.

	aTarget := ShipTarget withObjective: 'Juan'.

	aGame playTurn.
	aGame playCard: RepeatCard by: 'Jose' toTarget: aTarget.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 1 1 ) asOrderedCollection
]

{ #category : #tests }
CardsEffectTest >> testWhenMercenaryCardIsCancelledShipsCanBattleAgain [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget anotherTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].


	aTileArray at: 6 put: CardGeneratorEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 )).

	collectionOfCards := OrderedCollection new.
	4 timesRepeat: [ collectionOfCards add: MercenaryCard ].
	collectionOfCards add: CancellationCard.
	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.


	aTarget := ShipTarget withObjective: 'Juan'.
	anotherTarget := CardTarget withObjective: (MercenaryCard
			                  withHolder: 'Jose'
			                  andTarget: (ShipTarget withObjective: 'Juan')).

	aGame playTurn.
	aGame playCard: MercenaryCard by: 'Jose' toTarget: aTarget.
	aGame playCard: CancellationCard by: 'Juan' toTarget: anotherTarget.
	aGame playTurn.

	self assert: (aGame allShipAmountOfShields at: 'Juan') equals: 3.
	self assert: (aGame allShipAmountOfShields at: 'Jose') equals: 2
]

{ #category : #tests }
CardsEffectTest >> testWhenMercenaryCardIsPlayedAlliedShipsDontBattle [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray aPosition collectionOfCards aDeck aTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 )).


	collectionOfCards := OrderedCollection new.
	10 timesRepeat: [ collectionOfCards add: MercenaryCard ].
	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.
	
	aTarget := ShipTarget withObjective: 'Juan'	.
	aGame playTurn.
	aGame playCard: MercenaryCard by: 'Jose' toTarget: aTarget.
	aGame playTurn.

	aPosition := #( 6 1 ) asOrderedCollection.

	self assert: (aGame allShipsPosition at: 'Juan') equals: aPosition.
	self assert: (aGame allShipsPosition at: 'Jose') equals: aPosition.

	self assert: (aGame allShipAmountOfShields at: 'Juan') equals: 3.
	self assert: (aGame allShipAmountOfShields at: 'Jose') equals: 3
]

{ #category : #tests }
CardsEffectTest >> testWhenOneAccelerationCardIsPlayedShipsMoveOneExtraTile [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 4 )).

	
	collectionOfCards := OrderedCollection new.
	10 timesRepeat: [ collectionOfCards add: AccelerationCard ].
	aDeck := LoadedDeck withCards: collectionOfCards.
	
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.
	
	aTarget := AllShipsTarget new.
	
	aGame playCard: AccelerationCard by: 'Juan' toTarget:  aTarget.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame allShipsPosition at: 'Juan') first equals: 7.
	self assert: (aGame allShipsPosition at: 'Jose') first equals: 6
]

{ #category : #tests }
CardsEffectTest >> testWhenOneSpeedCardIsPlayedTargetedShipMoveOneExtraTile [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget|
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 4 )).

	collectionOfCards := OrderedCollection new.
	10 timesRepeat: [ collectionOfCards add: SpeedCard ].
	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.
	
	aTarget := ShipTarget withObjective: 'Juan'.
	
	aGame playCard: SpeedCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame allShipsPosition at: 'Juan') first equals: 7.
	self assert: (aGame allShipsPosition at: 'Jose') first equals: 5
]

{ #category : #tests }
CardsEffectTest >> testWhenOneSpeedCardIsPlayedWhenShipBattelsItThrowResultIsIncreasedByOne [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget|
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 4 5 4 4)).

	collectionOfCards := OrderedCollection new.
	10 timesRepeat: [ collectionOfCards add: SpeedCard ].
	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.
	
	aTarget := ShipTarget withObjective: 'Juan'.
	
	aGame playCard: SpeedCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.
	aGame playTurn.
	
	self assert: (aGame allShipAmountOfShields  at: 'Juan') equals: 3.
	self assert: (aGame allShipAmountOfShields  at: 'Jose') equals: 2.
	
]

{ #category : #tests }
CardsEffectTest >> testWhenReversalCardIsPlayedTargetingAnAccelerationCardShipMovesOneLessTile [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget anotherTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].


	aTileArray at: 6 put: CardGeneratorEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 )).

	collectionOfCards := OrderedCollection new.
	4 timesRepeat: [ collectionOfCards add: AccelerationCard  ].
	collectionOfCards add: ReversalCard.
	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.


	aTarget := AllShipsTarget new.
	anotherTarget := CardTarget withObjective: (AccelerationCard
			                  withHolder: 'Jose'
			                  andTarget: aTarget).
			
	aGame playTurn.
	aGame playCard: AccelerationCard by: 'Jose' toTarget: aTarget.
	aGame playCard: ReversalCard by: 'Juan' toTarget: anotherTarget.
	aGame playTurn.


	self assert: (aGame allShipsPosition  at: 'Juan') equals: #(6 1) asOrderedCollection .
	self assert: (aGame allShipsPosition at: 'Jose') equals: #(5 1) asOrderedCollection.
	
]

{ #category : #tests }
CardsEffectTest >> testWhenReversalCardIsPlayedTargetingAnMercenaryCardMercenaryShipHelpsEnemyWhenLeaderIsInBattle [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget anotherTarget |
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
		                    (SequenceDie withSequence: #( 5 5 4 3 2)).

	collectionOfCards := OrderedCollection new.
	4 timesRepeat: [ collectionOfCards add: MercenaryCard ].
	collectionOfCards add: ReversalCard.
	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.


	aTarget := ShipTarget withObjective: 'Jose'.
	anotherTarget := CardTarget withObjective:
		                 (MercenaryCard
			                  withHolder: 'Juan'
			                  andTarget: aTarget).

	aGame playCard: MercenaryCard by: 'Juan' toTarget: aTarget.
	aGame skipTurn .
	aGame skipTurn .
	aGame playCard: ReversalCard by: 'Pedro' toTarget: anotherTarget.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame allShipAmountOfShields at: 'Juan') equals: 2.
	self assert: (aGame allShipAmountOfShields at: 'Jose') equals: 3.
	self assert: (aGame allShipAmountOfShields at: 'Pedro') equals: 3
]

{ #category : #tests }
CardsEffectTest >> testWhenReversalCardIsPlayedTargetingAnSpeedCardShipMovesOneLessTile [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget anotherTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].


	aTileArray at: 6 put: CardGeneratorEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 )).

	collectionOfCards := OrderedCollection new.
	4 timesRepeat: [ collectionOfCards add: SpeedCard  ].
	collectionOfCards add: ReversalCard.
	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.


	aTarget := ShipTarget withObjective: 'Jose'.
	anotherTarget := CardTarget withObjective: (SpeedCard
			                  withHolder: 'Jose'
			                  andTarget: aTarget).
			
	aGame playTurn.
	aGame playCard: SpeedCard  by: 'Jose' toTarget: aTarget.
	aGame playCard: ReversalCard by: 'Juan' toTarget: anotherTarget.
	aGame playTurn.


	self assert: (aGame allShipsPosition  at: 'Juan') equals: #(6 1) asOrderedCollection .
	self assert: (aGame allShipsPosition at: 'Jose') equals: #(5 1) asOrderedCollection.
	
]

{ #category : #tests }
CardsEffectTest >> testWhenReversePolarityIsAppliesBlackHoleEffectAppliesEffectAccordingly [

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
CardsEffectTest >> testWhenReversePolarityIsCanceledBlackHoleEffectApliesEffectNormaly [

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
CardsEffectTest >> testWhenReversePolarityTargetingABlackHoleEffectTileIsCanceledEffectIsNormalyApplied [

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

{ #category : #tests }
CardsEffectTest >> testWhenShipWithMercenariesBattleAllOfThenThrowTheDice [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget |
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
	
	collectionOfCards := OrderedCollection new.
	10 timesRepeat: [ collectionOfCards add: MercenaryCard ].
	aDeck := LoadedDeck withCards: collectionOfCards.
	
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.

	aTarget := ShipTarget withObjective: 'Juan'.
	
	aGame playTurn.
	aGame playCard: MercenaryCard by: 'Jose' toTarget: aTarget.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame allShipAmountOfShields at: 'Pedro') equals: 2
]

{ #category : #tests }
CardsEffectTest >> testWhenTwoReversalCardArePlayedTargetingAnMercenaryCardMercenaryTheyCancelOut [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget anotherTarget |
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
		                    (SequenceDie withSequence: #( 5 5 4 2 5 )).

	collectionOfCards := OrderedCollection new.
	4 timesRepeat: [ collectionOfCards add: MercenaryCard ].
	4 timesRepeat: [ collectionOfCards add: ReversalCard ].
	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.


	aTarget := ShipTarget withObjective: 'Jose'.
	anotherTarget := CardTarget withObjective:
		                 (MercenaryCard
			                  withHolder: 'Juan'
			                  andTarget: aTarget).

	aGame playCard: MercenaryCard by: 'Juan' toTarget: aTarget.
	aGame skipTurn.
	aGame skipTurn.
	aGame playCard: ReversalCard by: 'Pedro' toTarget: anotherTarget.
	aGame playCard: ReversalCard by: 'Pedro' toTarget: anotherTarget.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame allShipAmountOfShields at: 'Juan') equals: 3.
	self assert: (aGame allShipAmountOfShields at: 'Jose') equals: 3.
	self assert: (aGame allShipAmountOfShields at: 'Pedro') equals: 2
]
