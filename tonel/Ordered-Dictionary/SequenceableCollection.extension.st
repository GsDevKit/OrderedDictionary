Extension { #name : 'SequenceableCollection' }

{ #category : '*ordered-dictionary' }
SequenceableCollection >> identityIndexOf: anElement [
  "Answer the index of anElement within the receiver. If the receiver does 
	not contain anElement, answer 0."

  ^ self identityIndexOf: anElement ifAbsent: [ 0 ]
]

{ #category : '*ordered-dictionary' }
SequenceableCollection >> identityIndexOf: anElement ifAbsent: exceptionBlock [
  "Answer the index of anElement within the receiver. If the receiver does 
	not contain anElement, answer the result of evaluating the argument, 
	exceptionBlock."

  1 to: self size do: [ :i | 
    (self at: i) == anElement
      ifTrue: [ ^ i ] ].
  ^ exceptionBlock value
]
