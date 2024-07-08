Class {
	#name : #BattleTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BattleTest >> testShipsCannotBattleInTheFirstTileOfABoard [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie aTileArray aParsecAmount |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 16 16 4 5 )).
	aParsecAmount := Parsec withNominalValue: 16.
	aTileArray := OrderedCollection new.

	16 timesRepeat: [ aTileArray add: NullEffect new ].

	aGame := Game
		         withBoard: (Board
				          withTileEffectCollection: aTileArray
				          withLengthInUnits: aParsecAmount
				          withAmountOfLaps: 3)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.

	self assert: (aGame allShipAmountOfShields at: 'Juan') equals: 3.
	self assert: (aGame allShipAmountOfShields at: 'Pedro') equals: 3
]

{ #category : #tests }
BattleTest >> testWhenMercenaryCardIsPlayedAlliedShipsDontBattle [

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
BattleTest >> testWhenShipInAGameLandsInATileWithAnotherShipThenTheyBattle [

	| aGame aCollectionOfNames aCollectionOfDie aTileArray |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 10 10 4 5 )).


	aTileArray := OrderedCollection new.
	16 timesRepeat: [ aTileArray add: NullEffect new ].
	
	aGame := Game
		         withBoard: (Board
				          withTileEffectCollection: aTileArray
				          withLengthInUnits: (Parsec withNominalValue: 16)
				          withAmountOfLaps: 1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.

	self assert: (aGame allShipAmountOfShields at: 'Pedro') equals: 2
]

{ #category : #tests }
BattleTest >> testWhenShipLosesABattleThenGoBackToFirstTile [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie aTileArray|
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 10 10 4 5 )).
	
	aTileArray := OrderedCollection new.

	16 timesRepeat: [ aTileArray add: NullEffect new ].

	aGame := Game
		         withBoard: (Board
				          withTileEffectCollection: aTileArray
				          withLengthInUnits: (Parsec withNominalValue: 16)
				          withAmountOfLaps: 1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Pedro')
		equals: #( 1 1 ) asOrderedCollection
]

{ #category : #tests }
BattleTest >> testWhenShipWithMercenariesBattleAllOfThenThrowTheDice [

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
