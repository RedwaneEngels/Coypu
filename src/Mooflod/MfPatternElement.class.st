Class {
	#name : 'MfPatternElement',
	#superclass : 'ToElement',
	#instVars : [
		'nbOfSteps'
	],
	#classVars : [
		'childrenQueue',
		'max',
		'min',
		'nbsteps'
	],
	#category : 'Mooflod-PatternWidget',
	#package : 'Mooflod',
	#tag : 'PatternWidget'
}

{ #category : 'examples' }
MfPatternElement class >> exampleSimplePattern [

	<script>
	| patternelem space |
	patternelem := self new
		               min: 4;
		               max: 32;
		               nbsteps: 32.
	space := BlSpace new.
	space root addChild: patternelem.
	space toTheme: MfMooflodTheme new.
	patternelem transformDo: [ :c | c translateBy: 180 @ 200 ].

	space show.
	^ patternelem
]

{ #category : 'adding' }
MfPatternElement >> addChildToQueue: aMfStepElement [ 

	childrenQueue addLast: aMfStepElement
]

{ #category : 'adding' }
MfPatternElement >> addInstrumentToStep [
	"Change the value of the drum attribute for the bar clicked, and update his color for visualization undestanding"

	self childrenDo: [ :child |
		child addEventHandlerOn: BlMouseDownEvent do: [ :evt |
			child instrument not
				ifTrue: [
					child background: Color black.
					child assignInstrument  ]
				ifFalse: [
					child background: Color white.
					child removeInstrument  ] ] ]
]

{ #category : 'adding' }
MfPatternElement >> addSeqStepsToThePattern: anArrayOfGates [
	"Add all bars element in the pattern to display them"

	"add steps element to a MfPatternElement where black are gates and white are rests"

	| step "changingX" nbSteps colors |
	nbSteps := anArrayOfGates size.
	colors := Array with: Color white with: Color black.
	nbOfSteps := 0.
	"changingX := 1.25."
	(nbSteps between: min and: max) ifTrue: [
		nbOfSteps := nbSteps.
		anArrayOfGates do: [ :i |
			step := MfStepElement new background: (colors at: i + 1).
			"step transformDo: [ :t | t translateBy: changingX @ 0 ].
			changingX := changingX + 17.5."
			self addChild: step ] ].
	self size: 17.5 * nbSteps @ 25.
	self addInstrumentToStep
]

{ #category : 'adding' }
MfPatternElement >> addStepsToThePattern: nbSteps [
	"Add all bars element in the pattern to display them"

	| step |
	nbOfSteps := 0.
	(nbSteps between: min and: max) ifTrue: [
		nbOfSteps := nbSteps.
		nbSteps <= 16
			ifTrue: [
				1 to: nbSteps do: [ :i |
					step := MfStepElement new.
					self addChild: step ] ]
			ifFalse: [
				1 to: 16 do: [ :i |
					step := MfStepElement new.
					self addChild: step ].
				17 to: nbSteps do: [ :i |
					step := MfStepElement new.
					self addChildToQueue: step ] ] ].
	self constraintsDo: [ :c | c horizontal fitContent ].
	self addInstrumentToStep
]

{ #category : 'visual properties' }
MfPatternElement >> backgroundPaint [ 
	"Define the background for the pattern"
	^ Color red
]

{ #category : 'as yet unclassified' }
MfPatternElement >> childrenQueue [ 

	^ childrenQueue 
]

{ #category : 'as yet unclassified' }
MfPatternElement >> childrenQueue: aCollection [ 

	childrenQueue := aCollection 
]

{ #category : 'adding' }
MfPatternElement >> forSequencer: aSequencer [
	"creates a visualization of a Sequencer, where gates are black squares and rests are white squares"

	self min: 1.
	self max: aSequencer gates size.
	self nbsSequencerStep: aSequencer gates
]

{ #category : 'initialization' }
MfPatternElement >> initialize [

	super initialize.
	childrenQueue := OrderedCollection new.
	self size: self patternExtent.
	self geometry: BlRectangleGeometry new.
	self layout: BlLinearLayout horizontal.
]

{ #category : 'accessing' }
MfPatternElement >> max [ 
	
	^max.
]

{ #category : 'accessing' }
MfPatternElement >> max: aMax [

	max:= aMax.
]

{ #category : 'accessing' }
MfPatternElement >> min [ 

	^min.
]

{ #category : 'accessing' }
MfPatternElement >> min: aMin [

	min:= aMin.
]

{ #category : 'accessing' }
MfPatternElement >> nbOfSteps [

	^ nbOfSteps
]

{ #category : 'adding' }
MfPatternElement >> nbsSequencerStep: anArrayOfGates [

	nbsteps :=anArrayOfGates size.
	self addSeqStepsToThePattern: anArrayOfGates 
]

{ #category : 'accessing' }
MfPatternElement >> nbsteps [

	^ nbsteps
]

{ #category : 'accessing' }
MfPatternElement >> nbsteps: someNbSteps [

	nbsteps := someNbSteps.
	self addStepsToThePattern: nbsteps
]

{ #category : 'initialization' }
MfPatternElement >> newMooFlodSkin [

	^ MfPatternElementSkin new
]

{ #category : 'visual properties' }
MfPatternElement >> patternExtent [

	^ 18 @ 25
]

{ #category : 'as yet unclassified' }
MfPatternElement >> translateStep [

	| first nextStep |
	first := self children first.
	self removeChild: first.
	self addChildToQueue: first.
	nextStep := self childrenQueue removeFirst.
	self addChild: nextStep
]
