!classDefinition: #CartTest category: #TusLibros stamp: 'DH 11/6/2019 23:30:43'!
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

!CartTest methodsFor: 'support' stamp: 'DH 11/6/2019 23:28:04'!
defaultCatalog
	
	|catalog|
	catalog _ Dictionary new.
	catalog at: self itemSellByTheStore put: 40.
	^catalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'DH 11/6/2019 23:30:43'!
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

!CashierTest methodsFor: 'support' stamp: 'DH 11/6/2019 23:11:42'!
creditCardWithLongOwnerName

	^CreditCard
	newWithNumber: '1234567890101112'
	owner: 'An owner with a really long name'
	andExpirationDate: (GregorianMonthOfYear year: 2023 month: May)! !

!CashierTest methodsFor: 'support' stamp: 'DH 11/6/2019 17:34:43'!
defaultCatalog
	
	|catalog|
	catalog _ Dictionary new.
	catalog at: self itemSellByTheStore put: 20.
	catalog at: self anotherItemSellByTheStore put: 30.
	^catalog! !

!CashierTest methodsFor: 'support' stamp: 'DH 11/6/2019 22:44:19'!
expiredCreditCard

	^CreditCard 
	newWithNumber: '1234567890101112' 
	owner: 'Pepe Sanchez' 
	andExpirationDate: (GregorianMonthOfYear year: 2018 month: April)! !

!CashierTest methodsFor: 'support' stamp: 'DH 11/6/2019 16:50:59'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CashierTest methodsFor: 'support' stamp: 'DH 11/6/2019 16:50:45'!
itemSellByTheStore
	
	^'validBook'! !

!CashierTest methodsFor: 'support' stamp: 'DH 11/6/2019 23:30:20'!
mockedMerchantProcessor

	^MockedMerchantProcessor new! !

!CashierTest methodsFor: 'support' stamp: 'DH 11/6/2019 23:00:53'!
testDate

	^(November/6/2019)! !

!CashierTest methodsFor: 'support' stamp: 'DH 11/6/2019 22:43:44'!
validCreditCard

	^CreditCard 
	newWithNumber: '1234567890101112' 
	owner: 'Pepe Sanchez' 
	andExpirationDate: (GregorianMonthOfYear year: 2023 month: April)! !


!CashierTest methodsFor: 'tests' stamp: 'DH 11/6/2019 22:44:52'!
test01CashierDoesNotAcceptEmptyCard

	|cart cashier salesBook|
	cart := self createCart.
	salesBook := OrderedCollection new.
	cashier := Cashier at: self testDate registeringSalesOn: salesBook debitingWith: self mockedMerchantProcessor.

	self should: [cashier checkout: cart with: self validCreditCard]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: Cashier checkoutOfEmptyCartError equals: anError messageText.
		self assert: salesBook isEmpty.
	]! !

!CashierTest methodsFor: 'tests' stamp: 'DH 11/6/2019 20:12:13'!
test02CashierCheckoutsCartWithOneItem

	|cart item cashier saleDetail|
	cart := self createCart.
	item := self itemSellByTheStore.
	cashier := Cashier at: self testDate registeringSalesOn: OrderedCollection new debitingWith: self mockedMerchantProcessor.
	
	cart add: item.
	saleDetail := cashier checkout: cart with: self validCreditCard.
	
	self assert: saleDetail totalDebited equals: (self defaultCatalog at: item).
	self assert: (saleDetail itemsSoldAre: (OrderedCollection with: self itemSellByTheStore)).! !

!CashierTest methodsFor: 'tests' stamp: 'DH 11/6/2019 20:12:20'!
test03CashierSaleDetailDoesNotIncludeItemsThatWereNotInCart

	|cart item cashier saleDetail|
	cart := self createCart.
	item := self itemSellByTheStore.
	cashier := Cashier at: self testDate registeringSalesOn: OrderedCollection new debitingWith: self mockedMerchantProcessor.
	
	cart add: item.
	saleDetail := cashier checkout: cart with: self validCreditCard.
	
	self deny: (saleDetail itemsSoldAre: (OrderedCollection with: self itemSellByTheStore with: self anotherItemSellByTheStore)).! !

!CashierTest methodsFor: 'tests' stamp: 'DH 11/6/2019 22:43:00'!
test04CashierDoesNotAcceptExpiredCreditCard

	|cart cashier salesBook|
	cart := self createCart.
	salesBook := OrderedCollection new.
	cashier := Cashier at: self testDate registeringSalesOn: salesBook debitingWith: self mockedMerchantProcessor.

	cart add: self itemSellByTheStore.

	self should: [cashier checkout: cart with: self expiredCreditCard]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: Cashier expiredCreditCardError equals: anError messageText.
		self assert: salesBook isEmpty.
	]! !

!CashierTest methodsFor: 'tests' stamp: 'DH 11/6/2019 23:12:11'!
test05CashierDoesNotAcceptCreditCardWithOwnerNameLengthGreaterThan30

	|cart cashier salesBook|
	cart := self createCart.
	salesBook := OrderedCollection new.
	cashier := Cashier at: self testDate registeringSalesOn: salesBook debitingWith: self mockedMerchantProcessor.
	
	cart add: self itemSellByTheStore.

	self should: [cashier checkout: cart with: self creditCardWithLongOwnerName]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: Cashier creditCardWithTooLongOwnerNameError equals: anError messageText.
		self assert: salesBook isEmpty.
	]
! !

!CashierTest methodsFor: 'tests' stamp: 'DH 11/6/2019 23:13:29'!
test06CashierSalesAreRegisteredOnSalesBook

	|cart item cashier firstSaleDetail secondSaleDetail salesBook|
	salesBook := OrderedCollection new.
	cashier := Cashier at: self testDate registeringSalesOn: salesBook debitingWith: self mockedMerchantProcessor.
	
	cart := self createCart.
	item := self itemSellByTheStore.
	cart add: item.
	firstSaleDetail := cashier checkout: cart with: self validCreditCard.
	
	cart := self createCart.
	item := self anotherItemSellByTheStore.
	cart add: item.
	secondSaleDetail := cashier checkout: cart with: self validCreditCard.
	
	self assert: (OrderedCollection with: firstSaleDetail with: secondSaleDetail) equals: salesBook
! !


!classDefinition: #CreditCardTest category: #TusLibros stamp: 'DH 11/6/2019 23:30:43'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'DH 11/6/2019 22:47:12'!
test01CreditCardAnswersNumberOwnerAndExpirationDateCorrectly

	|card number owner date|
	number _ '1234567890101112'.
	owner _ 'John Doe'.
	date _ GregorianMonthOfYear year: 2015 month: June.
	
	card := CreditCard
	newWithNumber: number
	owner: owner
	andExpirationDate: date.
	
	self assert: number equals: card number.
	self assert: owner equals: card ownerName.
	self assert: date equals: card expirationDate.! !

!CreditCardTest methodsFor: 'tests' stamp: 'DH 11/6/2019 22:47:20'!
test02CreditCardAnswersIfIsExpired

	|card|
	card := CreditCard
	newWithNumber: '1234567890101112'
	owner: 'John Doe'
	andExpirationDate: (GregorianMonthOfYear year: 2015 month: June).
	
	self assert: (card expiredOn: June/24/2015).
	self deny: (card expiredOn: May/4/2015).! !

!CreditCardTest methodsFor: 'tests' stamp: 'DH 11/6/2019 22:38:56'!
test03CannotCreateCreditCardWithNumberNotOf16Digits

	self assertThatCreditCardCannotBeCreatedWithNumber: '12345678'.
	self assertThatCreditCardCannotBeCreatedWithNumber: '12345678910111213'.! !


!CreditCardTest methodsFor: 'assertions' stamp: 'DH 11/6/2019 22:38:09'!
assertThatCreditCardCannotBeCreatedWithNumber: anInvalidCreditCardNumber

	self should: [
		CreditCard
		newWithNumber: anInvalidCreditCardNumber
		owner: 'John Doe'
		andExpirationDate: (GregorianMonthOfYear year: 2015 month: June).
	]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: CreditCard invalidCardNumberError equals: anError messageText.
	].! !


!classDefinition: #AbstractMerchantProcessor category: #TusLibros stamp: 'DH 11/6/2019 23:30:43'!
Object subclass: #AbstractMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AbstractMerchantProcessor methodsFor: 'debit' stamp: 'DH 11/6/2019 23:23:12'!
debit: anAmount from: aCreditCard

	^self subclassResponsibility! !


!classDefinition: #MerchantProcessor category: #TusLibros stamp: 'DH 11/6/2019 23:30:43'!
AbstractMerchantProcessor subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'debit' stamp: 'DH 11/6/2019 23:23:35'!
debit: anAmount from: aCreditCard

	^self notYetImplemented ! !


!classDefinition: #MockedMerchantProcessor category: #TusLibros stamp: 'DH 11/6/2019 23:30:43'!
AbstractMerchantProcessor subclass: #MockedMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MockedMerchantProcessor methodsFor: 'debit' stamp: 'DH 11/6/2019 23:24:02'!
debit: anAmount from: aCreditCard

	! !


!classDefinition: #Cart category: #TusLibros stamp: 'DH 11/6/2019 23:30:43'!
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


!Cart methodsFor: 'traversal' stamp: 'DH 11/6/2019 18:59:54'!
itemsDo: aBlock

	items do: aBlock! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'DH 11/6/2019 23:30:43'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'DH 11/6/2019 23:30:43'!
Object subclass: #Cashier
	instanceVariableNames: 'date salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'DH 11/6/2019 23:14:57'!
initializeWithDate: aDate salesBook: aSalesBook andMerchantProcessor: aMerchantProcessor

	date _ aDate.
	salesBook _ aSalesBook.
	merchantProcessor _ aMerchantProcessor.! !


!Cashier methodsFor: 'checkout' stamp: 'DH 11/6/2019 23:29:37'!
checkout: aCart with: aCreditCard

	|totalCost soldItems saleDetail|
	aCart isEmpty ifTrue: [self error: self class checkoutOfEmptyCartError.].
	(aCreditCard expiredOn: date) ifTrue: [self error: self class expiredCreditCardError.].
	aCreditCard ownerName size > 30 ifTrue: [self error: self class creditCardWithTooLongOwnerNameError.].
	
	totalCost _ aCart totalCost.
	soldItems _ OrderedCollection new.
	aCart itemsDo: [:item | soldItems add: item.].
	
	merchantProcessor debit: totalCost from: aCreditCard.
	
	saleDetail _ SaleDetail withTotal: totalCost andSoldItems: soldItems.
	salesBook add: saleDetail.
	^saleDetail! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'DH 11/6/2019 23:30:43'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'DH 11/6/2019 17:04:55'!
at: aDate registeringSalesOn: aSalesBook debitingWith: aMerchantProcessor.

	^self new initializeWithDate: aDate salesBook: aSalesBook andMerchantProcessor: aMerchantProcessor! !


!Cashier class methodsFor: 'error messages' stamp: 'DH 11/6/2019 17:08:38'!
checkoutOfEmptyCartError

	^'Cannot checkout an empty cart.'! !

!Cashier class methodsFor: 'error messages' stamp: 'DH 11/6/2019 23:02:50'!
creditCardWithTooLongOwnerNameError

	^'Credit card owner name has more than 30 characters.'! !

!Cashier class methodsFor: 'error messages' stamp: 'DH 11/6/2019 20:08:50'!
expiredCreditCardError

	^'Credit card is expired.'! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'DH 11/6/2019 23:30:43'!
Object subclass: #CreditCard
	instanceVariableNames: 'number ownerName expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'DH 11/6/2019 22:46:56'!
initializeWithNumber: aCreditCardNumber owner: anOwnerName andExpirationDate: aMonthOfYear

	aCreditCardNumber size = 16 ifFalse: [self error: self class invalidCardNumberError.].
	number _ aCreditCardNumber.
	ownerName _ anOwnerName.
	expirationDate _ (aMonthOfYear month/1/aMonthOfYear year)! !


!CreditCard methodsFor: 'queries' stamp: 'DH 11/6/2019 22:32:32'!
expirationDate

	^GregorianMonthOfYear year: expirationDate year number month: expirationDate month! !

!CreditCard methodsFor: 'queries' stamp: 'DH 11/6/2019 22:16:41'!
expiredOn: aDate

	|dateAsMonthOfYear|
	dateAsMonthOfYear := GregorianMonthOfYear year: aDate year month: aDate month.
	"^expirationDate <= dateAsMonthOfYear"
	^expirationDate <= aDate! !

!CreditCard methodsFor: 'queries' stamp: 'DH 11/6/2019 20:48:06'!
number

	^number! !

!CreditCard methodsFor: 'queries' stamp: 'DH 11/6/2019 20:48:14'!
ownerName

	^ownerName ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'DH 11/6/2019 23:30:43'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'DH 11/6/2019 21:54:11'!
newWithNumber: aCreditCardNumber owner: anOwnerName andExpirationDate: aMonthOfYear

	^self new initializeWithNumber: aCreditCardNumber owner: anOwnerName andExpirationDate: aMonthOfYear! !


!CreditCard class methodsFor: 'error messages' stamp: 'DH 11/6/2019 22:40:36'!
invalidCardNumberError

	^'Credit card number must have exactly 16 digits'! !


!classDefinition: #SaleDetail category: #TusLibros stamp: 'DH 11/6/2019 23:30:43'!
Object subclass: #SaleDetail
	instanceVariableNames: 'totalDebited soldItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SaleDetail methodsFor: 'total' stamp: 'DH 11/6/2019 17:20:36'!
totalDebited

	^totalDebited! !


!SaleDetail methodsFor: 'sold items' stamp: 'DH 11/6/2019 19:00:34'!
itemsSoldAre: aCollectionOfItems

	^soldItems = aCollectionOfItems! !


!SaleDetail methodsFor: 'initialization' stamp: 'DH 11/6/2019 17:22:05'!
initializeWithTotal: aTotalCost andItems: aCollectionOfItems

	totalDebited := aTotalCost.
	soldItems := aCollectionOfItems! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SaleDetail class' category: #TusLibros stamp: 'DH 11/6/2019 23:30:43'!
SaleDetail class
	instanceVariableNames: ''!

!SaleDetail class methodsFor: 'instance creation' stamp: 'DH 11/6/2019 17:26:22'!
withTotal: aTotalCost andSoldItems: aCollectionOfItems

	^self new initializeWithTotal: aTotalCost andItems: aCollectionOfItems! !
