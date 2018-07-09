instance-creation
newFromKeys: keys andValues: values
	"Create a dictionary from the keys and values arguments which should have the same length."
	
	| dict |
	dict := self new.
	keys with: values do: [ :k :v | dict at: k put: v ].
	^ dict