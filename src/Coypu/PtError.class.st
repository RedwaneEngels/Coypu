Class {
	#name : #PtError,
	#superclass : #FFIEnumeration,
	#classVars : [
		'error',
		'noerror'
	],
	#category : 'Coypu'
}

{ #category : #'enum declaration' }
PtError class >> enumDecl [ 
^ #(
noerror 0
error 1
)
]
