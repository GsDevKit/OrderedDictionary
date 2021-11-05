Class {
	#name : 'OrderedIdentityDictionary',
	#superclass : 'OrderedDictionary',
	#type : 'variable',
	#category : 'Ordered-Dictionary'
}

{ #category : 'accesing' }
OrderedIdentityDictionary >> dictionaryClass [
  ^ IdentityDictionary
]

{ #category : 'accesing' }
OrderedIdentityDictionary >> indexOfKey: aKey ifAbsent: aBlock [
  ^ self identityIndexOfKey: aKey ifAbsent: aBlock
]

{ #category : 'private' }
OrderedIdentityDictionary >> orderedKeysIndexOf: aKey [
  ^ orderedKeys identityIndexOf: aKey
]
