!classDefinition: #CartTest category: #TusLibros stamp: 'DH 11/7/2019 21:03:24'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'DH 11/7/2019 21:03:24'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #InterfaceTest category: #TusLibros stamp: 'DH 11/7/2019 21:03:24'!
TestCase subclass: #InterfaceTest
	instanceVariableNames: 'testObjectFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/7/2019 20:45:47'!
test01CannotCreateCartWithInvalidClientID

	|interface|
	interface _ testObjectFactory createInterface.
	self should: [interface createCartWithClientID: testObjectFactory invalidClientID andPassword: 'pepito'.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: Interface invalidClientIDErrorMessage equals: anError messageText.
		]
	"Habría que chequear que no se creó ningún carrito... Cómo lo hacemos????"! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/7/2019 19:38:23'!
test02CannotCreateCartWithIncorrectPassword

	|interface|
	interface _ testObjectFactory createInterface.
	self should: [interface createCartWithClientID: testObjectFactory validClientID andPassword: 'pepito'.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: Interface incorrectPasswordErrorMessage equals: anError messageText.
		]
	"Habría que chequear que no se creó ningún carrito... Cómo lo hacemos????"! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/7/2019 19:58:30'!
test03IDsOfTwoCreatedCartsAreDifferent

	|interface clientID1 clientID2 cartID1 cartID2|
	clientID1 _ testObjectFactory validClientID.
	clientID2 _ testObjectFactory anotherValidClientID.
	interface _ testObjectFactory createInterface.
	cartID1 _ interface createCartWithClientID: clientID1 andPassword: (testObjectFactory clients at: clientID1).
	cartID2 _ interface createCartWithClientID: clientID2 andPassword: (testObjectFactory clients at: clientID2).
	
	self deny: cartID1 = cartID2.
	! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/7/2019 21:00:50'!
test04CannotAddBookToNonExistentCart

	|interface book invalidCart|
	
	interface _ testObjectFactory createInterface.
	book _ testObjectFactory itemSellByTheStore.
	invalidCart _ 95173.
	
	self should: [interface add: 1 of: book to: invalidCart.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: Interface invalidCartIDErrorMessage equals: anError messageText
		].
	
	"En este caso no hay que chequear que no se haya agregado el libro porque el Carrito ni siquiera existe."
	! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/7/2019 20:43:58'!
test05CannotListANonExistentCart

	|interface invalidCart|
	
	interface _ testObjectFactory createInterface.
	invalidCart _ 95173.
	
	self should: [interface list: invalidCart.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: Interface invalidCartIDErrorMessage equals: anError messageText
		].
	! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/7/2019 20:49:11'!
test06ListingAnEmptyCartResultsInEmptyList

	|interface client cart|
	
	interface _ testObjectFactory createInterface.
	client _ testObjectFactory validClientID.
	cart _ interface createCartWithClientID: client andPassword: (testObjectFactory clients at: client).
	
	self assert: (interface list: cart) isEmpty
	! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/7/2019 21:00:33'!
test07CannotAddBookThatDoesNotBelongToEditorial

	|interface book cart client|
	
	interface _ testObjectFactory createInterface.
	book _ testObjectFactory itemNotSellByTheStore.
	client _ testObjectFactory validClientID.
	cart _ interface createCartWithClientID: client andPassword: (testObjectFactory clients at: client).
	
	self should: [interface add: 1 of: book to: cart.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: Interface bookNotFromEditorialErrorMessage equals: anError messageText.
		self assert: (interface list: cart) isEmpty.
		].
	
	"En este caso no hay que chequear que no se haya agregado el libro porque el Carrito ni siquiera existe."
	
	
	
	"
	CannotAddBookToNonExistentCart
	CannotListANonExistentCart
	ListingAnEmptyCartResultsInEmptyList
	CannotAddBookThatDoesNotBelongToEditorial
	CannotAddBookWithQuantityLessThanOne
	ListingACartShowsAddedBooks
	"
	
	! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/7/2019 20:59:48'!
test08CannotAddBookWithQuantityLessThanOne

	|interface book cart client|
	
	interface _ testObjectFactory createInterface.
	book _ testObjectFactory itemSellByTheStore.
	client _ testObjectFactory validClientID.
	cart _ interface createCartWithClientID: client andPassword: (testObjectFactory clients at: client).
	
	self should: [interface add: 0 of: book to: cart.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: Interface cannotAddLessThanOneBookToCartErrorMessage equals: anError messageText.
		self assert: (interface list: cart) isEmpty.
		].	
	

	! !


!InterfaceTest methodsFor: 'setUp/tearDown' stamp: 'DH 11/7/2019 19:31:50'!
setUp

	testObjectFactory := StoreTestObjectsFactory new.
	! !


!classDefinition: #Cart category: #TusLibros stamp: 'DH 11/7/2019 21:03:24'!
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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
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


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'DH 11/7/2019 21:03:24'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'DH 11/7/2019 21:03:24'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'DH 11/7/2019 21:03:24'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'DH 11/7/2019 21:03:24'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'DH 11/7/2019 21:03:24'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Interface category: #TusLibros stamp: 'DH 11/7/2019 21:03:24'!
Object subclass: #Interface
	instanceVariableNames: 'clients carts lastCartID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Interface methodsFor: 'as yet unclassified' stamp: 'DH 11/7/2019 21:02:52'!
add: aNumberOfBooks of: aBookISBN to: aCartID

	aNumberOfBooks < 1 ifTrue: [self error: self class cannotAddLessThanOneBookToCartErrorMessage].
	(carts includes: aCartID) ifFalse: [self error: self class invalidCartIDErrorMessage.].
	self error: self class bookNotFromEditorialErrorMessage.! !

!Interface methodsFor: 'as yet unclassified' stamp: 'DH 11/7/2019 20:52:12'!
createCartWithClientID: aClientID andPassword: aPassword

	(clients includesKey: aClientID) ifFalse: [self error: self class invalidClientIDErrorMessage.].
	((clients at: aClientID) = aPassword) ifFalse: [self error: self class incorrectPasswordErrorMessage.].
	
	lastCartID _ lastCartID + 1.
	carts add: lastCartID.
	^ lastCartID! !

!Interface methodsFor: 'as yet unclassified' stamp: 'DH 11/7/2019 20:52:25'!
initializeWith: aClientDictionary

	clients _ aClientDictionary.
	carts _ OrderedCollection new.
	lastCartID _ 0.! !

!Interface methodsFor: 'as yet unclassified' stamp: 'DH 11/7/2019 20:53:04'!
list: aCartID

	(carts includes: aCartID) ifFalse: [self error: self class invalidCartIDErrorMessage.].
	^OrderedCollection new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Interface class' category: #TusLibros stamp: 'DH 11/7/2019 21:03:24'!
Interface class
	instanceVariableNames: ''!

!Interface class methodsFor: 'errorMessages' stamp: 'DH 11/7/2019 20:29:02'!
bookNotFromEditorialErrorMessage

	^ 'Book does not belong to editorial.'! !

!Interface class methodsFor: 'errorMessages' stamp: 'DH 11/7/2019 21:00:10'!
cannotAddLessThanOneBookToCartErrorMessage

	^ 'Cannot add less than one book to cart.'! !

!Interface class methodsFor: 'errorMessages' stamp: 'DH 11/7/2019 19:38:47'!
incorrectPasswordErrorMessage

	^ 'Incorrect password.'! !

!Interface class methodsFor: 'errorMessages' stamp: 'DH 11/7/2019 20:23:19'!
invalidCartIDErrorMessage

	^ 'Cart ID does not exist.'! !

!Interface class methodsFor: 'errorMessages' stamp: 'DH 11/7/2019 20:45:47'!
invalidClientIDErrorMessage

	^ 'Invalid client ID.'! !


!Interface class methodsFor: 'as yet unclassified' stamp: 'DH 11/7/2019 19:42:19'!
newWith: aClientDictionary

	^ self new initializeWith: aClientDictionary.! !


!classDefinition: #Sale category: #TusLibros stamp: 'DH 11/7/2019 21:03:24'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros stamp: 'DH 11/7/2019 21:03:24'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'DH 11/7/2019 21:03:24'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'DH 11/7/2019 19:55:51'!
anotherValidClientID

	^8128! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'DH 11/7/2019 19:55:12'!
clients

	|clients|
	clients _ Dictionary new.
	clients at: self validClientID put: 'flan'.
	clients at: self anotherValidClientID put: 'rosebud'.
	^clients! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'DH 11/7/2019 19:56:16'!
createInterface
		
	^ Interface newWith: self clients.! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'DH 11/7/2019 19:34:49'!
invalidClientID
	
	^ 42! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'DH 11/7/2019 19:39:11'!
validClientID
	
	^ 123456! !
