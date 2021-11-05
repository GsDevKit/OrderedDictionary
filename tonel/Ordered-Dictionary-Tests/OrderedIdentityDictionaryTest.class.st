Class {
	#name : 'OrderedIdentityDictionaryTest',
	#superclass : 'OrderedDictionaryTest',
	#type : 'variable',
	#category : 'Ordered-Dictionary-Tests'
}

{ #category : 'accessing' }
OrderedIdentityDictionaryTest >> dictionaryClass [
  ^ OrderedIdentityDictionary
]

{ #category : 'testing' }
OrderedIdentityDictionaryTest >> isTestingIdentityDictionary [
  ^ true
]
