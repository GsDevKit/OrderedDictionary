Extension { #name : 'SequenceableCollection' }

{ #category : '*ordereddictionary-gemstone36-' }
SequenceableCollection >> copyFirst: n [
	"Answer the first n elements of the receiver.
	Raise an error if there are not enough elements."

	^ self copyFrom: 1 to: n
]