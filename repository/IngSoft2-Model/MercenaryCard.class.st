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
MercenaryCard >> canPlayAtAnyTime: lastCardPlayed [

	^ false
]

{ #category : #event }
MercenaryCard >> deactivate: aCardHandler [

	aCardHandler removeCoalition:
		(ShipCoalition withLeader: holder andMercenary: target objective)
]

{ #category : #event }
MercenaryCard >> reverseCardEffectWith: anCardHandler [

	anCardHandler reverseCoalition:
		(ShipCoalition withLeader: holder andMercenary: target objective)
]
