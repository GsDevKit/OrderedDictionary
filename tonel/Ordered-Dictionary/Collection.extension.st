Extension { #name : 'Collection' }

{ #category : '*ordered-dictionary' }
Collection >> copyEmpty [
  ^ self species new
]

{ #category : '*ordered-dictionary' }
Collection >> reject: rejectBlock thenDo: doBlock [
  "Utility method to improve readability."

  (self reject: rejectBlock) do: doBlock
]
