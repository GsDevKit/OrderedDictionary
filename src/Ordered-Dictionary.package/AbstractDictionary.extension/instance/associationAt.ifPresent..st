*ordered-dictionary
associationAt: key ifPresent: aBlock
  "Answer the value of evaluating aBlock optionally with the association
	for the given key.
	If the key is not found, return nil."

  | association |
  association := self associationAt: key ifAbsent: [ ^ nil ].
  ^ aBlock cull: association