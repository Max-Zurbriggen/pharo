Extension { #name : #BlockClosure }

{ #category : #'*SortFunctions-Core-converting' }
BlockClosure >> asSortFunction [
	"Return a SortFunction around the receiver. If the receiver is a 2 arg block, it is assumed it will do the collation directly itself, returning -1, 0, or 1. If the receiver is a one arg block, it will be evaluated for each a and b and of the sort input, and the result of sending <=> to those will be used"
	
	self numArgs = 1 ifTrue: [^PropertySortFunction property: self].
	self numArgs = 2 ifTrue: [^CollatorBlockFunction usingBlock: self].

	self error: 'Can not be converted to sort function. It should have one or two args'
]

{ #category : #'*SortFunctions-Core-converting' }
BlockClosure >> ascending [
	"Return a SortFunction around the receiver. If the receiver is a 2 arg block, it is assumed it will do the collation directly itself, returning -1, 0, or 1. If the receiver is a one arg block, it will be evaluated for each a and b and of the sort input, and the result of sending <=> to those will be used."

	^self asSortFunction
]

{ #category : #'*SortFunctions-Core-converting' }
BlockClosure >> collatedBy: aSortFunction [
	"Return a SortFunction around the receiver. If the receiver is a 2 arg block, it is assumed it will do the collation directly itself, returning -1, 0, or 1. If the receiver is a one arg block, it will be evaluated for each a and b and of the sort input, and the result of using aSortFunction on those will be used"
	
	self numArgs = 1 ifTrue: [^PropertySortFunction property: self collatedWith: aSortFunction asSortFunction].
	self error: 'Can not be converted to sort function. It should have one arg'
]

{ #category : #'*SortFunctions-Core-converting' }
BlockClosure >> descending [
	"Opposite direction as ascending."

	^self asSortFunction reversed
]
