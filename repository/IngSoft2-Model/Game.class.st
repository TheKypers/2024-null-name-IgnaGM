"
Game Class
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'gameBoard',
		'gameShips',
		'dice',
		'gameTurnHandler',
		'shipBattleHandler',
		'theShipInCurrentTurn',
		'gameCardHandler',
		'gameEffectHandler',
		'targetValidator'
	],
	#classInstVars : [
		'isFinished'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
Game class >> isValid: aBoard with: aNameCollection and: aDice [

	aNameCollection isEmpty ifTrue: [
		InvalidArgumentExeption signal: 'Game cannot be created without any Ship names' ].
	(aBoard respondsTo: #numbOfTiles) ifFalse: [
		InvalidArgumentExeption signal: 'Game cannot be started without a board' ].
	(aDice respondsTo: #throw) ifFalse: [
		InvalidArgumentExeption signal: 'Game cannot be started without at least one die' ]
]

{ #category : #'class initialization' }
Game class >> withBoard: aBoard withShipNames: aNameCollection withDice: aDice [

	| collectionOfCards |
	collectionOfCards := OrderedCollection new.
	aNameCollection size * 2 timesRepeat: [
		collectionOfCards add: NullCard ].

	self isValid: aBoard with: aNameCollection and: aDice.
	^ self new
		  initializeGameWith: aBoard
		  withShipNames: aNameCollection asSet
		  withDice: aDice
		  withGameDeck:
		  (LoadedDeck withCards: collectionOfCards)
]

{ #category : #'class initialization' }
Game class >> withBoard: aBoard withShipNames: aNameCollection withDice: aDice withDeck: aDeck [

	self isValid: aBoard with: aNameCollection and: aDice.
	^ self new
		  initializeGameWith: aBoard
		  withShipNames: aNameCollection
		  withDice: aDice
		  withGameDeck: aDeck
]

{ #category : #accessing }
Game >> adjustShipPosition: aShip [

	gameBoard adjustShipPosition: aShip.
	gameBoard snapToFinishTile: aShip
]

{ #category : #accessing }
Game >> allShipAmountOfShields [

	| shipShields |
	shipShields := Dictionary new.
	gameShips do: [ :aShip |
		shipShields
			at: aShip shipName put: aShip amountOfShieldsActive;
			yourself ].
	^ shipShields
]

{ #category : #accessing }
Game >> allShipsPosition [

	| shipPositions |
	shipPositions := Dictionary new.
	gameShips do: [ :aShip |
		shipPositions
			at: aShip shipName
			put: (OrderedCollection with: aShip position with: aShip lapsDone);
			yourself ].
	^ shipPositions
]

{ #category : #testing }
Game >> canPlayNextTurnOf [

	self isFinished ifTrue: [
		Error signal: 'Game is Over you cant Keep Playing' ].
]

{ #category : #modifying }
Game >> giveCardToAllShipsBut: aShip [

	gameShips
		reject: [ :ship | ship = aShip ]
		thenCollect: [ :ship | gameCardHandler giveCardTo: ship shipName ].
]

{ #category : #modifying }
Game >> giveCardToCurrentShip: aShip [

	gameCardHandler giveCardTo: aShip shipName
]

{ #category : #initialization }
Game >> initializeGameWith: aBoard withShipNames: aNameCollection withDice: aDice withGameDeck: aDeck [

	| aCoalitionHandler |
	gameBoard := aBoard.
	gameShips := aNameCollection asOrderedCollection collect: [ :aName |
		             Ship createWithName: aName ].

	dice := aDice.
	gameTurnHandler := TurnHandler withShips: gameShips.

	aCoalitionHandler := CoalitionHandler new.

	shipBattleHandler := ShipBattle
		                     withDice: dice
		                     withShips: gameShips
		                     andCoalitionHandler: aCoalitionHandler.

	gameEffectHandler := EffectManager
		                     withBoard: gameBoard
		                     andShips: gameShips
		                     andGame: self.

	gameCardHandler := CardHandler
		                   withDeck: aDeck
		                   withEffectHandler: gameEffectHandler
		                   andCoalitionHandler: aCoalitionHandler.

	targetValidator := TargetValidator
		                   withBoard: gameBoard
		                   withShips: gameShips
		                   andCardHandler: gameCardHandler.

	theShipInCurrentTurn := gameTurnHandler currentTurnShip.
	gameShips do: [ :ship | gameCardHandler startingCards: ship shipName ]
]

{ #category : #testing }
Game >> isFinished [

	^ gameShips anySatisfy: [ :aShip | gameBoard isInLastTile: aShip ]
]

{ #category : #event }
Game >> playCard: aCard by: aShipName toTarget: aTarget [

	| aCardToPlay |
	aCardToPlay := aCard withHolder: aShipName andTarget: aTarget.

	gameCardHandler validateCard: aCardToPlay.
	targetValidator targetIsValid: aTarget.

	(gameCardHandler canPlayCard: aCardToPlay withTurnShip: theShipInCurrentTurn ) ifFalse: [
		CardExeption signal:
			'Ship cannot throw this card as its not his turn' ].

	gameCardHandler activateCard: aCardToPlay.
	gameCardHandler removeCardFromShipDeck: aCardToPlay
]

{ #category : #modifying }
Game >> playTurn [

	| diceMovement cardMovment |
	self canPlayNextTurnOf.

	[ gameTurnHandler turnShipCanPlayTurn ]
		on: TurnExeption
		do: [ :ex | ^ ex messageText ].

	diceMovement := dice throw.
	cardMovment := gameCardHandler movementCardsActivated:
		               theShipInCurrentTurn.
	theShipInCurrentTurn moveTiles: diceMovement + cardMovment.

	self adjustShipPosition: theShipInCurrentTurn.
	gameEffectHandler applyTileEffectTriggeredBy: theShipInCurrentTurn.

	shipBattleHandler
		checkShipBattle: theShipInCurrentTurn
		withCardHandler: gameCardHandler.

	gameTurnHandler checkForShipsWithNoShield.
	gameTurnHandler nextTurn.
	theShipInCurrentTurn := gameTurnHandler currentTurnShip
]

{ #category : #accessing }
Game >> shipRankings [

	| sortedShips rankDictionary |
	sortedShips := gameShips asSortedCollection: [ :ship1 :ship2 |
		               ship1 > ship2 ].

	rankDictionary := Dictionary new.
	sortedShips withIndexDo: [ :elemento :indice |
		rankDictionary at: indice put: elemento ].

	^ rankDictionary
]

{ #category : #accessing }
Game >> shipWithName: aShipName hasAmountOfCards: anAmountOfCards [

	^ gameCardHandler
		  shipWithName: aShipName
		  hasAmountOfCards: anAmountOfCards
]

{ #category : #modifying }
Game >> skipTurn [

	| skipedTurn |
	self canPlayNextTurnOf.

	[ gameTurnHandler turnShipCanPlayTurn ]
		on: TurnExeption
		do: [ :ex | ^ ex messageText ].

	theShipInCurrentTurn healFullShields.

	gameTurnHandler nextTurn.
	skipedTurn := theShipInCurrentTurn shipName , ' skipped their turn'.
	theShipInCurrentTurn := gameTurnHandler currentTurnShip.
	
	^ skipedTurn
]

{ #category : #accessing }
Game >> winnerName [

	self isFinished ifFalse: [ ^ 'There is no winner yet' ].
	^ (gameShips detect: [ :aShip | gameBoard isInLastTile: aShip ])
		  shipName
]
