Class {
	#name : 'OrderedIdentityDictionaryTest',
	#superclass : 'OrderedDictionaryTest',
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
