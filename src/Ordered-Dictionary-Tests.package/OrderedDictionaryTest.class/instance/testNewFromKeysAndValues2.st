tests - creation
testNewFromKeysAndValues2
 
	| dict newDict |
	dict := self dictionaryClass new
	       at: #a put: 1;
			 at: #b put: 2;
			 at: #c put: 3; yourself.
	newDict := self dictionaryClass newFromKeys: dict keys andValues: dict values.
	dict keysAndValuesDo: [:k :v|
		self assert: (newDict at: k) equals: v ]. 