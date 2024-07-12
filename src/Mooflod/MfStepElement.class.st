Class {
	#name : 'MfStepElement',
	#superclass : 'BlElement',
	#instVars : [
		'instrument'
	],
	#category : 'Mooflod-PatternWidget',
	#package : 'Mooflod',
	#tag : 'PatternWidget'
}

{ #category : 'action' }
MfStepElement >> assignInstrument [
	"Sets drum attribute to true"

	instrument := true
]

{ #category : 'visual properties' }
MfStepElement >> backgroundPaint [ 
	"Define the background for a bar"
	^ Color white.
]

{ #category : 'public' }
MfStepElement >> click [ 

	instrument := instrument not.
	self updateBackgroundPaint
]

{ #category : 'initialization' }
MfStepElement >> initialize [

	super initialize.
	instrument := false.
	self size: self stepExtent.
	self background: self backgroundPaint.
	self initializeEvents.
	self constraintsDo: [ :e |
		e frame vertical alignCenter.
		e margin: (BlInsets all: 2) ]
]

{ #category : 'initialization' }
MfStepElement >> initializeEvents [ 

	self addEventHandlerOn: BlClickEvent do: [ 
		self click ]

]

{ #category : 'accessing' }
MfStepElement >> instrument [

	^ instrument
]

{ #category : 'removing' }
MfStepElement >> removeInstrument [
	"Sets drum attribute to false"

	instrument := false
]

{ #category : 'visual properties' }
MfStepElement >> stepExtent [
	"Size of a bar"

	^ 15 @ 21
]

{ #category : 'as yet unclassified' }
MfStepElement >> updateBackgroundPaint [

	self
		background: (instrument
		ifTrue: [ Color black ]
		ifFalse: [ Color white ])
]
