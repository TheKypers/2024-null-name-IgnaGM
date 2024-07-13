"
a
"
Class {
	#name : #MercenaryCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
MercenaryCard >> activateWith: aCardHandler [

	aCardHandler addCoalition:
		(ShipCoalition withLeader: holder andMercenary: target objective).
	aCardHandler addToActiveCards: self.
	aCardHandler changeLastCardTo: self
]

{ #category : #comparing }
MercenaryCard >> canPlayRightNow: theShipInTurn [

	^ theShipInTurn shipName = holder
]

{ #category : #event }
MercenaryCard >> deactivate: aCardHandler [

	aCardHandler removeCoalitionOf: holder and: target
]

{ #category : #event }
MercenaryCard >> reverseCardEffectWith: anCardHandler [

	anCardHandler reverseCoalition: holder andMercenary: target objective
]
