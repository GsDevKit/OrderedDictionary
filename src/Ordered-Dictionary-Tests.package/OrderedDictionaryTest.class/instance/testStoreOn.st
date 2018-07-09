tests
testStoreOn
	| print |
	print := String streamContents: [ :s | self orderedAssociations storeOn: s ].
	self assertDictionary: (Object readFromString:  print) equals: self orderedAssociations.
	print := String streamContents: [ :s | self emptyDictionary storeOn: s ].
	self assertDictionary: (Object readFromString:  print) equals: self emptyDictionary