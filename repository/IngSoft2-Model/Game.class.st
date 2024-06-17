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
		'theShipInCurrentTurn'
	],
	#classInstVars : [
		'isFinished'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
Game class >> isValid: aBoard with: aNameCollection and: aDice [

	aNameCollection isEmpty ifTrue: [
		Error signal: 'Game cannot be created without any Ship names' ].
	(aBoard respondsTo: #numbOfTiles) ifFalse: [
		Error signal: 'Game cannot be started without a board' ].
	(aDice respondsTo: #throw) ifFalse: [
		Error signal: 'Game cannot be started without at least one die' ]
]

{ #category : #'class initialization' }
Game class >> withBoard: aBoard withShipNames: aNameCollection withDice: aDice [

	self isValid: aBoard with: aNameCollection and: aDice.
	^ self new
		  initializeGameWith: aBoard
		  withShipNames: aNameCollection asSet
		  withDice: aDice
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

{ #category : #event }
Game >> applyEffectOnAllShips: anEffect [

	anEffect affectAShipCollection: gameShips.
	gameShips do: [ :aShip |
		gameBoard adjustShipPosition: aShip.]
]

{ #category : #event }
Game >> applyEffectOnAllShipsButOne: anEffect [

	anEffect affectAllShips: gameShips but: theShipInCurrentTurn.
	gameShips do: [ :aShip |
		gameBoard adjustShipPosition: aShip. ]
]

{ #category : #event }
Game >> applyEffectOnOneShip: anEffect [

	anEffect affectAShip: theShipInCurrentTurn.
	gameShips do: [ :aShip |
		gameBoard adjustShipPosition: aShip.]
]

{ #category : #testing }
Game >> canPlayNextTurnOf [

	self isFinished ifTrue: [
		Error signal: 'Game is Over you cant Keep Playing' ].
]

{ #category : #initialization }
Game >> initializeGameWith: aBoard withShipNames: aNameCollection withDice: aDice [

	gameBoard := aBoard.
	gameShips := aNameCollection asOrderedCollection collect: [ :aName |
		             Ship createWithName: aName ].
	dice := aDice.
	gameTurnHandler := TurnHandler withShips: gameShips.
	shipBattleHandler := ShipBattle withDice: dice withShips: gameShips
]

{ #category : #testing }
Game >> isFinished [

	^ gameShips anySatisfy: [ :aShip | gameBoard isInLastTile: aShip ]
]

{ #category : #modifying }
Game >> playTurn [

	| movement |
	self canPlayNextTurnOf.

	[ gameTurnHandler turnShipCanPlayTurn ]
		on: TurnExeption
		do: [ :ex | ^ ex messageText ].

	theShipInCurrentTurn := gameTurnHandler currentTurnShip.
	movement := dice throw.
	theShipInCurrentTurn moveTiles: movement.
	gameBoard adjustShipPosition: theShipInCurrentTurn.
	gameBoard snapToFinishTile: theShipInCurrentTurn.
	gameBoard applyTileEffectOn: self at: theShipInCurrentTurn position.
	shipBattleHandler checkShipBattle: theShipInCurrentTurn.
	gameTurnHandler checkForShipsWithNoShield.
	gameTurnHandler nextTurn
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

{ #category : #modifying }
Game >> skipTurn [

	self canPlayNextTurnOf.
	
	[ gameTurnHandler turnShipCanPlayTurn ]
		on: TurnExeption
		do: [ :ex | ^ ex messageText ].
	
	theShipInCurrentTurn := gameTurnHandler currentTurnShip.

	theShipInCurrentTurn healFullShields.
	gameTurnHandler nextTurn.
	^ theShipInCurrentTurn shipName , ' skipped their turn'
]

{ #category : #accessing }
Game >> winnerName [

	self isFinished ifFalse: [ ^ 'There is no winner yet' ].
	^ (gameShips detect: [ :aShip | gameBoard isInLastTile: aShip ])
		  shipName
]