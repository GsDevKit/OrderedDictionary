Class {
	#name : 'OrderedDictionary',
	#superclass : 'Collection',
	#type : 'variable',
	#instVars : [
		'dictionary',
		'orderedKeys'
	],
	#category : 'Ordered-Dictionary'
}

{ #category : 'instance-creation' }
OrderedDictionary class >> new [
  ^ self new: 10
]

{ #category : 'instance-creation' }
OrderedDictionary class >> new: aCapacity [
  ^ self basicNew initialize: aCapacity
]

{ #category : 'instance-creation' }
OrderedDictionary class >> newFrom: anAssociationCollection [
  | newDictionary |
  newDictionary := self new: anAssociationCollection size.
  anAssociationCollection
    associationsDo: [ :each | newDictionary at: each key put: each value ].
  ^ newDictionary
]

{ #category : 'instance-creation' }
OrderedDictionary class >> newFromKeys: keys andValues: values [
	"Create a dictionary from the keys and values arguments which should have the same length."
	
	| dict |
	dict := self new.
	keys with: values do: [ :k :v | dict at: k put: v ].
	^ dict
]

{ #category : 'instance-creation' }
OrderedDictionary class >> newFromPairs: aSequenceableCollection [
  | newDictionary |
  newDictionary := self new: (aSequenceableCollection size / 2) floor.
  1 to: aSequenceableCollection size - 1 by: 2 do: [ :i | 
    newDictionary
      at: (aSequenceableCollection at: i)
      put: (aSequenceableCollection at: i + 1) ].
  ^ newDictionary
]

{ #category : 'adding' }
OrderedDictionary >> = anObject [
  self == anObject
    ifTrue: [ ^ true ].
  (self species == anObject species and: [ self size = anObject size ])
    ifFalse: [ ^ false ].
  dictionary
    associationsDo: [ :each | 
      (anObject at: each key ifAbsent: [ ^ false ]) = each value
        ifFalse: [ ^ false ] ].
  ^ true
]

{ #category : 'adding' }
OrderedDictionary >> add: anAssociation [
  | oldSize |
  oldSize := dictionary size.
  dictionary add: anAssociation.
  dictionary size > oldSize
    ifTrue: [ 
      orderedKeys size > oldSize
        ifFalse: [ self growOrderedKeys ].
      orderedKeys at: oldSize + 1 put: anAssociation key ].
  ^ anAssociation
]

{ #category : 'adding' }
OrderedDictionary >> addAll: anAssociationCollection [
  "Since Collection implements #associationsDo:, this method can accept
	any collection of associations including Arrays and OrderedCollections"

  anAssociationCollection associationsDo: [ :each | self add: each ].
  ^ anAssociationCollection
]

{ #category : 'accessing' }
OrderedDictionary >> associationAt: aKey [
  ^ dictionary associationAt: aKey
]

{ #category : 'accessing' }
OrderedDictionary >> associationAt: aKey ifAbsent: aBlock [
  ^ dictionary associationAt: aKey ifAbsent: aBlock
]

{ #category : 'accessing' }
OrderedDictionary >> associationAt: aKey ifPresent: aBlock [
  ^ dictionary associationAt: aKey ifPresent: aBlock
]

{ #category : 'accessing' }
OrderedDictionary >> associations [
  | associations i |
  associations := Array new: self size.
  i := 1.
  self
    associationsDo: [ :each | 
      associations at: i put: each.
      i := i + 1 ].
  ^ associations
]

{ #category : 'enumerating' }
OrderedDictionary >> associationsDo: aBlock [
  self keysDo: [ :each | aBlock value: (self associationAt: each) ]
]

{ #category : 'enumerating' }
OrderedDictionary >> associationsSelect: aBlock [
  ^ self species newFrom: (self associations select: aBlock)
]

{ #category : 'accessing' }
OrderedDictionary >> at: aKey [
  ^ dictionary at: aKey
]

{ #category : 'accessing' }
OrderedDictionary >> at: aKey ifAbsent: aBlock [
  ^ dictionary at: aKey ifAbsent: aBlock
]

{ #category : 'accessing' }
OrderedDictionary >> at: aKey ifAbsentPut: aBlock [
  ^ self at: aKey ifAbsent: [ self at: aKey put: aBlock value ]
]

{ #category : 'accessing' }
OrderedDictionary >> at: aKey ifPresent: aBlock [
  ^ dictionary at: aKey ifPresent: aBlock
]

{ #category : 'accessing' }
OrderedDictionary >> at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
  ^ dictionary at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock
]

{ #category : 'accessing' }
OrderedDictionary >> at: aKey ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock [
  ^ dictionary at: aKey ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock
]

{ #category : 'accessing' }
OrderedDictionary >> at: aKey put: aValue [
  | oldSize |
  oldSize := dictionary size.
  dictionary at: aKey put: aValue.
  dictionary size > oldSize
    ifTrue: [ 
      orderedKeys size > oldSize
        ifFalse: [ self growOrderedKeys ].
      orderedKeys at: oldSize + 1 put: aKey ].
  ^ aValue
]

{ #category : 'accessing' }
OrderedDictionary >> bindingOf: varName [
  ^ self associationAt: varName ifAbsent: [ nil ]
]

{ #category : 'enumerating' }
OrderedDictionary >> bindingsDo: aBlock [
  self associationsDo: aBlock
]

{ #category : 'accessing' }
OrderedDictionary >> capacity [
  ^ dictionary capacity
]

{ #category : 'enumerating' }
OrderedDictionary >> collect: aBlock [
  ^ self species
    newFrom:
      (self associations collect: [ :each | each key -> (aBlock value: each value) ])
]

{ #category : 'adding' }
OrderedDictionary >> declare: aKey from: aDictionary [
  (self includesKey: aKey)
    ifTrue: [ ^ self ].
  (aDictionary includesKey: aKey)
    ifTrue: [ 
      self add: (aDictionary associationAt: aKey).
      aDictionary removeKey: aKey ]
    ifFalse: [ self add: aKey -> nil ]
]

{ #category : 'private' }
OrderedDictionary >> dictionary [
  ^ dictionary
]

{ #category : 'accessing' }
OrderedDictionary >> dictionaryClass [
  ^ Dictionary
]

{ #category : 'enumerating' }
OrderedDictionary >> do: aBlock [
  self valuesDo: aBlock
]

{ #category : 'private' }
OrderedDictionary >> errorInvalidIndex: anIndex [
  Error signalFor: anIndex
]

{ #category : 'private' }
OrderedDictionary >> growOrderedKeys [
  orderedKeys := (Array new: ((orderedKeys size * 1.5) asInteger max: 10))
    replaceFrom: 1
    to: orderedKeys size
    with: orderedKeys
    startingAt: 1
]

{ #category : 'testing' }
OrderedDictionary >> hasBindingThatBeginsWith: aString [
  ^ dictionary hasBindingThatBeginsWith: aString
]

{ #category : 'adding' }
OrderedDictionary >> hash [
  ^ dictionary hash
]

{ #category : 'accessing' }
OrderedDictionary >> identityIndexOfKey: aKey [
  ^ self identityIndexOfKey: aKey ifAbsent: [ 0 ]
]

{ #category : 'accessing' }
OrderedDictionary >> identityIndexOfKey: aKey ifAbsent: aBlock [
  1 to: self size do: [ :i | 
    (orderedKeys at: i) == aKey
      ifTrue: [ ^ i ] ].
  ^ aBlock value
]

{ #category : 'testing' }
OrderedDictionary >> includes: anObject [
  ^ dictionary includes: anObject
]

{ #category : 'testing' }
OrderedDictionary >> includesAssociation: anAssociation [
	^ (self associationAt: anAssociation key ifAbsent: [ ^ false ]) value = anAssociation value
]

{ #category : 'testing' }
OrderedDictionary >> includesIdentity: anObject [
  ^ dictionary includesIdentity: anObject
]

{ #category : 'testing' }
OrderedDictionary >> includesKey: aKey [
  ^ dictionary includesKey: aKey
]

{ #category : 'accessing' }
OrderedDictionary >> indexOfKey: aKey [
  ^ self indexOfKey: aKey ifAbsent: [ 0 ]
]

{ #category : 'accessing' }
OrderedDictionary >> indexOfKey: aKey ifAbsent: aBlock [
  1 to: self size do: [ :i | 
    (orderedKeys at: i) = aKey
      ifTrue: [ ^ i ] ].
  ^ aBlock value
]

{ #category : 'initialization' }
OrderedDictionary >> initialize: aCapacity [
  dictionary := self dictionaryClass new: aCapacity.
  orderedKeys := Array new: aCapacity
]

{ #category : 'testing' }
OrderedDictionary >> isDictionary [
  ^ true
]

{ #category : 'testing' }
OrderedDictionary >> isHealthy [
  ^ dictionary isHealthy
]

{ #category : 'accessing' }
OrderedDictionary >> keyAtIdentityValue: aValue [
  ^ dictionary keyAtIdentityValue: aValue
]

{ #category : 'accessing' }
OrderedDictionary >> keyAtIdentityValue: aValue ifAbsent: aBlock [
  ^ dictionary keyAtIdentityValue: aValue ifAbsent: aBlock
]

{ #category : 'accessing' }
OrderedDictionary >> keyAtIndex: anIndex [
  ^ self keyAtIndex: anIndex ifAbsent: [ self errorInvalidIndex: anIndex ]
]

{ #category : 'accessing' }
OrderedDictionary >> keyAtIndex: anIndex ifAbsent: aBlock [
  (anIndex > 0 and: [ anIndex <= self size ])
    ifTrue: [ ^ orderedKeys at: anIndex ]
    ifFalse: [ ^ aBlock value ]
]

{ #category : 'accessing' }
OrderedDictionary >> keyAtValue: aValue [
  ^ dictionary keyAtValue: aValue
]

{ #category : 'accessing' }
OrderedDictionary >> keyAtValue: aValue ifAbsent: aBlock [
  ^ dictionary keyAtValue: aValue ifAbsent: aBlock
]

{ #category : 'accessing' }
OrderedDictionary >> keyForIdentity: anObject [
  ^ dictionary keyForIdentity: anObject
]

{ #category : 'accessing' }
OrderedDictionary >> keys [
  ^ orderedKeys copyFrom: 1 to: self size
]

{ #category : 'enumerating' }
OrderedDictionary >> keysAndValuesDo: aBlock [
  self keysDo: [ :each | aBlock value: each value: (self at: each) ]
]

{ #category : 'removing' }
OrderedDictionary >> keysAndValuesRemove: aTwoArgumentBlock [
  | removedAssociations |
  removedAssociations := OrderedCollection new.
  self
    associationsDo: [ :each | 
      (aTwoArgumentBlock value: each key value: each value)
        ifTrue: [ removedAssociations add: each ] ].
  removedAssociations do: [ :each | self removeKey: each key ]
]

{ #category : 'enumerating' }
OrderedDictionary >> keysDo: aBlock [
  1 to: self size do: [ :i | aBlock value: (orderedKeys at: i) ]
]

{ #category : 'accessing' }
OrderedDictionary >> keysSortedSafely [
  ^ dictionary keysSortedSafely asArray
]

{ #category : 'private' }
OrderedDictionary >> orderedKeys [
  ^ orderedKeys
]

{ #category : 'private' }
OrderedDictionary >> orderedKeysIndexOf: aKey [
  ^ orderedKeys indexOf: aKey
]

{ #category : 'private' }
OrderedDictionary >> orderedKeysRemove: aRemovedKey [
  | index |
  index := self orderedKeysIndexOf: aRemovedKey.	"shift every remaining key after to the left by one"
  orderedKeys
    replaceFrom: index
    to: self size
    with: orderedKeys
    startingAt: index + 1.	"one key was removed and the rest shifted, so nil what was the last
	key slot before removing and shifting"
  orderedKeys at: self size + 1 put: nil
]

{ #category : 'copying' }
OrderedDictionary >> postCopy [
  orderedKeys := orderedKeys copy.
  dictionary := dictionary copy
]

{ #category : 'printing' }
OrderedDictionary >> printElementsOn: aStream [
  aStream nextPut: $(.
  self size > 100
    ifTrue: [ 
      aStream nextPutAll: 'size '.
      self size printOn: aStream ]
    ifFalse: [ 
      self associations
        withIndexDo: [ :each :i | 
          aStream
            print: each key;
            nextPutAll: '->';
            print: each value.
          i < self size
            ifTrue: [ aStream space ] ] ].
  aStream nextPut: $)
]

{ #category : 'removing' }
OrderedDictionary >> remove: anObject ifAbsent: aBlock [
  self shouldNotImplement
]

{ #category : 'removing' }
OrderedDictionary >> removeAll [
  1 to: self size do: [ :i | orderedKeys at: i put: nil ].
  dictionary removeAll
]

{ #category : 'removing' }
OrderedDictionary >> removeKey: aKey [
  | value |
  value := dictionary removeKey: aKey.
  self orderedKeysRemove: aKey.
  ^ value
]

{ #category : 'removing' }
OrderedDictionary >> removeKey: aKey ifAbsent: aBlock [
  | oldSize value |
  oldSize := dictionary size.
  value := dictionary removeKey: aKey ifAbsent: aBlock.
  dictionary size < oldSize
    ifTrue: [ self orderedKeysRemove: aKey ].
  ^ value
]

{ #category : 'removing' }
OrderedDictionary >> removeKeys: aKeyCollection [
  "Fast removal of multiple keys; returns self to avoid
	having to create a removed value collection and does not
	raise errors."

  aKeyCollection size > 1
    ifTrue: [ 
      | oldSize newOrderedKeys newOrderedKeysIndex |
      oldSize := self size.
      aKeyCollection
        do: [ :each | dictionary removeKey: each ifAbsent: [ nil ] ].
      newOrderedKeys := Array new: oldSize.
      newOrderedKeysIndex := 0.
      1 to: oldSize do: [ :i | 
        | key |
        (dictionary includesKey: (key := orderedKeys at: i))
          ifTrue: [ newOrderedKeys at: (newOrderedKeysIndex := newOrderedKeysIndex + 1) put: key ] ].
      orderedKeys := newOrderedKeys ]
    ifFalse: [ 
      aKeyCollection size = 1
        ifTrue: [ 
          "use #anyOne, because it can be a Set"
          self removeKey: aKeyCollection anyOne ifAbsent: [ nil ] ] ]
]

{ #category : 'removing' }
OrderedDictionary >> removeUnreferencedKeys [
  ^ self unreferencedKeys do: [ :each | self removeKey: each ]
]

{ #category : 'enumerating' }
OrderedDictionary >> select: aBlock [
  ^ self species
    newFrom: (self associations select: [ :each | aBlock value: each value ])
]

{ #category : 'accessing' }
OrderedDictionary >> size [
  ^ dictionary size
]

{ #category : 'private' }
OrderedDictionary >> unreferencedKeys [
  ^ Dictionary unreferencedKeysIn: self
]

{ #category : 'accessing' }
OrderedDictionary >> values [
  ^ self associations collect: [ :each | each value ]
]

{ #category : 'enumerating' }
OrderedDictionary >> valuesDo: aBlock [
  self keysDo: [ :each | aBlock value: (self at: each) ]
]