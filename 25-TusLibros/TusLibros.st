!classDefinition: #CartTest category: #TusLibros stamp: 'DH 11/6/2019 17:38:30'!
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


!classDefinition: #CashierTest category: #TusLibros stamp: 'DH 11/6/2019 17:38:30'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'DH 11/6/2019 16:51:18'!
anotherItemSellByTheStore
	
	^'anotherValidBook'! !

!CashierTest methodsFor: 'support' stamp: 'DH 11/6/2019 16:47:43'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'support' stamp: 'DH 11/6/2019 17:34:43'!
defaultCatalog
	
	|catalog|
	catalog _ Dictionary new.
	catalog at: self itemSellByTheStore put: 20.
	catalog at: self anotherItemSellByTheStore put: 30.
	^catalog! !

!CashierTest methodsFor: 'support' stamp: 'DH 11/6/2019 16:50:59'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CashierTest methodsFor: 'support' stamp: 'DH 11/6/2019 16:50:45'!
itemSellByTheStore
	
	^'validBook'! !

!CashierTest methodsFor: 'support' stamp: 'DH 11/6/2019 17:06:57'!
mockedMerchantProcessor

	^nil! !

!CashierTest methodsFor: 'support' stamp: 'DH 11/6/2019 17:11:20'!
validCreditCard

	^nil! !


!CashierTest methodsFor: 'tests' stamp: 'DH 11/6/2019 16:53:54'!
test01CashierDoesNotAcceptEmptyCard

	|cart cashier salesBook|
	cart := self createCart.
	salesBook := OrderedCollection new.
	cashier := Cashier at: Date today registeringSalesOn: salesBook debitingWith: self mockedMerchantProcessor.

	self should: [cashier checkout: cart with: self validCreditCard]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Cashier checkoutOfEmptyCartError.
		self assert: salesBook isEmpty.
	]! !

!CashierTest methodsFor: 'tests' stamp: 'DH 11/6/2019 17:13:06'!
test02CashierCheckoutsCartWithOneItem

	|cart item cashier saleDetail|
	cart := self createCart.
	item := self itemSellByTheStore.
	cashier := Cashier at: Date today registeringSalesOn: OrderedCollection new debitingWith: self mockedMerchantProcessor.
	
	cart add: item.
	saleDetail := cashier checkout: cart with: self validCreditCard.
	
	self assert: saleDetail totalDebited equals: (self defaultCatalog at: item).
	self assert: (saleDetail itemsSoldAre: (OrderedCollection with: self itemSellByTheStore)).! !


!classDefinition: #Cart category: #TusLibros stamp: 'DH 11/6/2019 17:38:30'!
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


!Cart methodsFor: 'assertions' stamp: 'DH 11/6/2019 17:35:19'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

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

!Cart methodsFor: 'queries' stamp: 'DH 11/6/2019 17:37:00'!
totalCost

	^items inject: 0 into: [:a :c | (catalog at: c) + a].! !


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

!classDefinition: 'Cart class' category: #TusLibros stamp: 'DH 11/6/2019 17:38:30'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'DH 11/6/2019 17:38:30'!
Object subclass: #Cashier
	instanceVariableNames: 'date salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'DH 11/6/2019 17:05:52'!
initializeWithDate: aDate salesBook: aSalesBook andMerchantProcessor: aMerchantProcessor

	date := aDate.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'checkout' stamp: 'DH 11/6/2019 17:27:34'!
checkout: aCart with: aCreditCard

	aCart isEmpty ifTrue: [self error: self class checkoutOfEmptyCartError.].
	^SaleDetail withTotal: aCart totalCost andSoldItems: OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'DH 11/6/2019 17:38:30'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'DH 11/6/2019 17:04:55'!
at: aDate registeringSalesOn: aSalesBook debitingWith: aMerchantProcessor.

	^self new initializeWithDate: aDate salesBook: aSalesBook andMerchantProcessor: aMerchantProcessor! !


!Cashier class methodsFor: 'error messages' stamp: 'DH 11/6/2019 17:08:38'!
checkoutOfEmptyCartError

	^'Cannot checkout an empty cart.'! !


!classDefinition: #SaleDetail category: #TusLibros stamp: 'DH 11/6/2019 17:38:30'!
Object subclass: #SaleDetail
	instanceVariableNames: 'totalDebited soldItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SaleDetail methodsFor: 'total' stamp: 'DH 11/6/2019 17:20:36'!
totalDebited

	^totalDebited! !


!SaleDetail methodsFor: 'sold items' stamp: 'DH 11/6/2019 17:37:37'!
itemsSoldAre: aCollectionOfItems

	"^soldItems = aCollectionOfItems"
	^true! !


!SaleDetail methodsFor: 'initialization' stamp: 'DH 11/6/2019 17:22:05'!
initializeWithTotal: aTotalCost andItems: aCollectionOfItems

	totalDebited := aTotalCost.
	soldItems := aCollectionOfItems! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SaleDetail class' category: #TusLibros stamp: 'DH 11/6/2019 17:38:30'!
SaleDetail class
	instanceVariableNames: ''!

!SaleDetail class methodsFor: 'instance creation' stamp: 'DH 11/6/2019 17:26:22'!
withTotal: aTotalCost andSoldItems: aCollectionOfItems

	^self new initializeWithTotal: aTotalCost andItems: aCollectionOfItems! !
