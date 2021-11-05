Extension { #name : 'AbstractDictionary' }

{ #category : '*ordered-dictionary' }
AbstractDictionary >> associationAt: key ifPresent: aBlock [
  "Answer the value of evaluating aBlock optionally with the association
	for the given key.
	If the key is not found, return nil."

  | association |
  association := self associationAt: key ifAbsent: [ ^ nil ].
  ^ aBlock cull: association
]

{ #category : '*ordered-dictionary' }
AbstractDictionary >> capacity [
  ^ self size
]

{ #category : '*ordered-dictionary' }
AbstractDictionary >> includesIdentity: anObject [
  "Answer whether anObject is one of the values of the receiver.  Contrast #includes: in which there is only an equality check, here there is an identity check"

  self
    do: [ :each | 
      anObject == each
        ifTrue: [ ^ true ] ].
  ^ false
]

{ #category : '*ordered-dictionary' }
AbstractDictionary >> keyAtIdentityValue: value [
  "Answer the key that is the external name for the argument, value. If 
	there is none, answer nil.
	Note: There can be multiple keys with the same value. Only one is returned."

  ^ self keyAtIdentityValue: value ifAbsent: [ self errorValueNotFound: value ]
]

{ #category : '*ordered-dictionary' }
AbstractDictionary >> keyAtIdentityValue: value ifAbsent: exceptionBlock [
  "Answer the key that is the external name for the argument, value. If 
	there is none, answer the result of evaluating exceptionBlock.
	Note: There can be multiple keys with the same value. Only one is returned."

  self
    associationsDo: [ :association | 
      value == association value
        ifTrue: [ ^ association key ] ].
  ^ exceptionBlock value
]

{ #category : '*ordered-dictionary' }
AbstractDictionary >> keyForIdentity: anObject [
  "If anObject is one of the values of the receive, return its key, else return nil.  Contrast #keyAtValue: in which there is only an equality check, here there is an identity check"

  self
    associationsDo: [ :assoc | 
      assoc value == anObject
        ifTrue: [ ^ assoc key ] ].
  ^ nil
]
