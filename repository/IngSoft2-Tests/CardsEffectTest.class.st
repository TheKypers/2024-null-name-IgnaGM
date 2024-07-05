Class {
	#name : #CardsEffectTest,
	#superclass : #CardsTest,
	#category : #'IngSoft2-Tests'
}

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
