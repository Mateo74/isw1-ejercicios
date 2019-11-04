!classDefinition: #CartTest category: #TusLibros stamp: 'mm 11/4/2019 13:42:43'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'mm 11/4/2019 13:42:43'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'mm 11/4/2019 12:16:25'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'mm 11/4/2019 12:16:38'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'mm 11/4/2019 13:18:51'!
invalidCreditCard

	^CreditCard 
	newWithNumber: '123456789010111213' 
	owner: 'Pepe Sanchez' 
	andExpiraton: '042018'.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'mm 11/4/2019 12:17:13'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'mm 11/4/2019 12:16:51'!
itemSellByTheStore
	
	^ 'validBook'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'mm 11/4/2019 13:41:11'!
test01CashierDoesNotAcceptEmptyCart

	|cart creditCard|
	
	cart _ self createCart.
	creditCard _ self validCreditCard.
	
	self should: [Cashier sell: cart to: creditCard]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Cashier EmptyCartError.
		]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'mm 11/4/2019 13:29:23'!
test02CashierDoesNotAcceptExpiredCreditCard

	|cart creditCard|
	
	cart _ self createCart.
	cart add: self itemSellByTheStore.
	creditCard _ self invalidCreditCard.
	
	self should: [Cashier sell: cart to: creditCard]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Cashier ExpiredCreditCardError.
		]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'mm 11/4/2019 13:18:41'!
validCreditCard

	^CreditCard 
	newWithNumber: '123456789010111213' 
	owner: 'Pepe Sanchez' 
	andExpiraton: '042023'.! !


!classDefinition: #Cart category: #TusLibros stamp: 'mm 11/4/2019 13:42:43'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'mm 11/4/2019 13:42:43'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'mm 11/4/2019 13:42:43'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'mm 11/4/2019 13:42:43'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'mm 11/4/2019 12:22:38'!
EmptyCartError

	^'Cannot sell to empty cart.'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'mm 11/4/2019 12:58:08'!
ExpiredCreditCardError

	^'Credit card is expired.'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'mm 11/4/2019 13:35:59'!
isExpired: aCreditCard

	|today bool1 bool2 bool3|
	
	today _ Date today yyyymmdd.
	bool1 _ ((today copyFrom: 1 to: 4) > (aCreditCard expirationDate copyFrom: 3 to: 6)).
	bool2 _ ((today copyFrom: 1 to: 4) = (aCreditCard expirationDate copyFrom: 3 to: 6)).
	bool3 _ (today copyFrom: 5 to: 6) > (aCreditCard expirationDate copyFrom: 1 to: 2).
	^ bool1 or: (bool2 and: bool3).! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'mm 11/4/2019 13:42:11'!
sell: aCart to: aCreditCard

	(self isExpired: aCreditCard) ifTrue: [self error: self ExpiredCreditCardError ].
	aCart isEmpty ifTrue: [self error: self EmptyCartError].! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'mm 11/4/2019 13:42:43'!
Object subclass: #CreditCard
	instanceVariableNames: 'number date owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'nil' stamp: 'mm 11/4/2019 12:33:34'!
initializeWithNumber: aCreditCardNumber owner: aPersonName andExpiraton: anExpirationDate

	number _ aCreditCardNumber.
	owner   _ aPersonName.
	date      _ anExpirationDate.! !


!CreditCard methodsFor: 'as yet unclassified' stamp: 'mm 11/4/2019 13:01:07'!
expirationDate

	^date! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'mm 11/4/2019 13:01:44'!
number

	^number! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'mm 11/4/2019 13:01:23'!
owner

	^owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'mm 11/4/2019 13:42:43'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'nil' stamp: 'mm 11/4/2019 12:34:43'!
newWithNumber: aCreditCardNumber owner: aPersonName andExpiraton: anExpirationDate

	^self new initializeWithNumber: aCreditCardNumber owner: aPersonName andExpiraton: anExpirationDate.
! !
