!classDefinition: #CartTest category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'DH 11/18/2019 20:29:44'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'DH 11/18/2019 20:32:07'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'DH 11/18/2019 20:29:48'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
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


!classDefinition: #CashierTest category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
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


!classDefinition: #InterfaceTest category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
TestCase subclass: #InterfaceTest
	instanceVariableNames: 'testObjectFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/18/2019 19:48:36'!
test01CannotCreateCartWithInvalidClientID

	|interface|
	interface _ testObjectFactory createInterfaceWithMerchantProcessor: self.
	self should: [interface createCartWithClientID: testObjectFactory invalidClientID andPassword: 'pepito'.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: Interface invalidClientIDErrorMessage equals: anError messageText.
		]! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/18/2019 19:48:49'!
test02CannotCreateCartWithIncorrectPassword

	|interface|
	interface _ testObjectFactory createInterfaceWithMerchantProcessor: self.
	self should: [interface createCartWithClientID: testObjectFactory validClientID andPassword: 'pepito'.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: Interface incorrectPasswordErrorMessage equals: anError messageText.
		]! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/16/2019 15:41:20'!
test03IDsOfTwoCreatedCartsAreDifferent

	|interface clientID1 clientID2 cartID1 cartID2|
	interface _ testObjectFactory createInterfaceWithMerchantProcessor: self.
	clientID1 _ testObjectFactory validClientID.
	clientID2 _ testObjectFactory anotherValidClientID.
	cartID1 _ interface createCartWithClientID: clientID1 andPassword: (testObjectFactory passwordFor: clientID1).
	cartID2 _ interface createCartWithClientID: clientID2 andPassword: (testObjectFactory passwordFor: clientID2).
	
	self deny: cartID1 = cartID2.
	! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/14/2019 18:52:12'!
test04CannotAddBookToNonExistentCart

	|interface book|
	
	interface _ testObjectFactory createInterfaceWithMerchantProcessor: self.
	book _ testObjectFactory itemSellByTheStore.
	
	self should: [interface add: 1 of: book to: testObjectFactory invalidCartID.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: Interface invalidCartIDErrorMessage equals: anError messageText
	].
	! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/14/2019 18:52:34'!
test05CannotListANonExistentCart

	|interface|
	
	interface _ testObjectFactory createInterfaceWithMerchantProcessor: self.
	
	self should: [interface list: testObjectFactory invalidCartID.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: Interface invalidCartIDErrorMessage equals: anError messageText
		].
	! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/16/2019 15:41:52'!
test06ListingAnEmptyCartResultsInEmptyList

	|interface client cart|
	
	interface _ testObjectFactory createInterfaceWithMerchantProcessor: self.
	client _ testObjectFactory validClientID.
	cart _ interface createCartWithClientID: client andPassword: (testObjectFactory passwordFor: client).
	
	self assert: (interface list: cart) isEmpty
	! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/18/2019 20:52:20'!
test07ListingACartShowsAddedBooks

	|interface book1 book2 client cart|
	
	interface _ testObjectFactory createInterfaceWithMerchantProcessor: self.
	book1 _ testObjectFactory itemSellByTheStore.
	book2 _ testObjectFactory anotherItemSellByTheStore.
	client _ testObjectFactory validClientID.
	cart _ interface createCartWithClientID: client andPassword: (testObjectFactory passwordFor: client).
	interface add: 1 of: book1 to: cart.
	interface add: 2 of: book2 to: cart.
	self assert: (Dictionary new at: book1 put: 1; at: book2 put: 2; yourself) equals: (interface list: cart).


	! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/18/2019 20:52:35'!
test08CannotCheckoutANonExistentCart

	|interface|
	
	interface _ testObjectFactory createInterfaceWithMerchantProcessor: self.

	self should: [interface checkout: testObjectFactory invalidCartID 
		withCardNumber: testObjectFactory validCreditCardNumber 
		withExpirationDate: testObjectFactory futureDate 
		withOwner: testObjectFactory validOwner
	]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: Interface invalidCartIDErrorMessage equals: anError messageText.
	].	
	
	! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/18/2019 20:52:41'!
test09CheckoutOfValidCartMakesTheSaleWithCorrectCost

	|interface client cart book salesBook|
	
	salesBook _ OrderedCollection new.
	interface _ testObjectFactory createInterfaceWithSalesBook: salesBook andMerchantProcessor: self.
	client _ testObjectFactory validClientID.
	cart _ interface createCartWithClientID: client andPassword: (testObjectFactory passwordFor: client).
	book _ testObjectFactory itemSellByTheStore.
	interface add: 1 of: book to: cart.
	
	interface checkout: cart
		withCardNumber: testObjectFactory validCreditCardNumber
	 	withExpirationDate:  testObjectFactory futureDate
		withOwner: testObjectFactory validOwner.
	
	self assert: (OrderedCollection with: (Sale of: testObjectFactory itemSellByTheStorePrice)) equals: salesBook.! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/18/2019 20:52:46'!
test10CheckoutedCartCannotBeModified

	|interface cart|
	
	interface _ testObjectFactory createInterfaceWithMerchantProcessor: self.
	cart _ self createAndCheckoutACartUsing: interface.
	
	self should: [interface add: 1 of: testObjectFactory itemSellByTheStore to: cart.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: Interface invalidCartIDErrorMessage equals: anError messageText.
	].! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/18/2019 20:52:49'!
test11CheckoutedCartCannotBeListed

	|interface cart|
	
	interface _ testObjectFactory createInterfaceWithMerchantProcessor: self.
	cart _ self createAndCheckoutACartUsing: interface.
	
	self should: [interface list: cart.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: Interface invalidCartIDErrorMessage equals: anError messageText.
	].! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/18/2019 20:52:54'!
test12CannotListPurchasesOfNonExistentClient

	|interface|
	interface _ testObjectFactory createInterfaceWithMerchantProcessor: self.
	self should: [interface listPurchasesOf: testObjectFactory invalidClientID withPassword: 'pepito'.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: Interface invalidClientIDErrorMessage equals: anError messageText.
	]! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/18/2019 20:52:58'!
test13CannotListPurchasesOfClientUsingWrongPassword

	|interface|
	interface _ testObjectFactory createInterfaceWithMerchantProcessor: self.
	self should: [interface listPurchasesOf: testObjectFactory validClientID withPassword: 'pepito'.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: Interface incorrectPasswordErrorMessage equals: anError messageText.
	]! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/18/2019 20:53:02'!
test14ListingPurchasesOfClientShowsAllPurchases

	|interface book1 book2 client password cart cardNumber expirationDate owner|
	
	interface _ testObjectFactory createInterfaceWithMerchantProcessor: self.
	book1 _ testObjectFactory itemSellByTheStore.
	book2 _ testObjectFactory anotherItemSellByTheStore.
	client _ testObjectFactory validClientID.
	password _ testObjectFactory passwordFor: client.
	cardNumber _ testObjectFactory validCreditCardNumber.
	expirationDate _ testObjectFactory futureDate.
	owner _ testObjectFactory validOwner.
	
	cart _ interface createCartWithClientID: client andPassword: password.
	interface add: 1 of: book1 to: cart.
	interface add: 1 of: book2 to: cart.
	interface checkout: cart withCardNumber: cardNumber withExpirationDate: expirationDate withOwner: owner.
	
	cart _ interface createCartWithClientID: client andPassword: password.
	interface add: 2 of: book1 to: cart.
	interface checkout: cart withCardNumber: cardNumber withExpirationDate: expirationDate withOwner: owner.
	
	self assert: (Dictionary new at: book1 put: 3; at: book2 put: 1; yourself)
		equals: (interface listPurchasesOf: client withPassword: password).! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/18/2019 20:53:07'!
test15CannotListACartIf30MinutesPassedSinceLastUsed

	|interface cart|
	
	interface _ testObjectFactory createInterfaceWithMerchantProcessor: self.
	cart _ self createAndUseACartUsing: interface andAdvanceMinutes: 31.
	
	self should: [interface list: cart.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: Interface cartNoLongerValidErrorMessage equals: anError messageText.
	]! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/18/2019 20:53:12'!
test16CannotModifyACartIf30MinutesPassedSinceLastUsed

	|interface cart|
	
	interface _ testObjectFactory createInterfaceWithMerchantProcessor: self.
	cart _ self createAndUseACartUsing: interface andAdvanceMinutes: 31.
	
	self should: [interface add: 2 of: testObjectFactory anotherItemSellByTheStore to: cart.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: Interface cartNoLongerValidErrorMessage equals: anError messageText.
	]! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/18/2019 20:53:17'!
test17CannotCheckoutACartIf30MinutesPassedSinceLastUsed

	|salesBook interface cart|
	
	salesBook _ OrderedCollection new.
	interface _ testObjectFactory createInterfaceWithSalesBook: salesBook andMerchantProcessor: self.
	cart _ self createAndUseACartUsing: interface andAdvanceMinutes: 31.
	
	self should: [interface checkout: cart 
		withCardNumber: testObjectFactory validCreditCardNumber 
		withExpirationDate: testObjectFactory futureDate 
		withOwner: testObjectFactory validOwner
	]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: Interface cartNoLongerValidErrorMessage equals: anError messageText.
		self assert: salesBook isEmpty.
	]! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/18/2019 21:58:34'!
test18CartNotUsedFor30MinutesIsDeleted

	|interface cart|
	
	interface _ testObjectFactory createInterfaceWithMerchantProcessor: self.
	cart _ self createAndUseACartUsing: interface andAdvanceMinutes: 31.
	
	self should: [interface list: cart]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self should: [interface list: cart]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:aSecondError |
			self assert: Interface invalidCartIDErrorMessage equals: aSecondError messageText.
		]
	]! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/18/2019 21:59:57'!
test19CannotAddBookThatDoesNotBelongToEditorial

	"Test adicional. No se hace en el marco de TDD."
	|interface cart client|
	
	interface _ testObjectFactory createInterfaceWithMerchantProcessor: self.
	client _ testObjectFactory validClientID.
	cart _ interface createCartWithClientID: client andPassword: (testObjectFactory passwordFor: client).
	
	self should: [interface add: 1 of: testObjectFactory itemNotSellByTheStore to: cart.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: Cart invalidItemErrorMessage equals: anError messageText.
		self assert: (interface list: cart) isEmpty.
		].

	! !

!InterfaceTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:00:05'!
test20CannotAddBookWithQuantityLessThanOne

	"Test adicional. No se hace en el marco de TDD."
	|interface cart client|
	
	interface _ testObjectFactory createInterfaceWithMerchantProcessor: self.
	client _ testObjectFactory validClientID.
	cart _ interface createCartWithClientID: client andPassword: (testObjectFactory passwordFor: client).
	
	self should: [interface add: 0 of: testObjectFactory itemSellByTheStore to: cart.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: Cart invalidQuantityErrorMessage equals: anError messageText.
		self assert: (interface list: cart) isEmpty.
		].	


	! !


!InterfaceTest methodsFor: 'setUp/tearDown' stamp: 'DH 11/11/2019 20:08:50'!
setUp

	testObjectFactory := StoreTestObjectsFactory new.
	debitBehavior := [:anAmount :aCreditCard | ]
	! !


!InterfaceTest methodsFor: 'merchant processor protocol' stamp: 'DH 11/11/2019 20:10:23'!
debit: anAmount from: aCreditCard

	^debitBehavior value: anAmount value: aCreditCard ! !


!InterfaceTest methodsFor: 'utility' stamp: 'DH 11/18/2019 19:54:35'!
createAndCheckoutACartUsing: anInterface

	|client cart book|
	
	client _ testObjectFactory validClientID.
	cart _ anInterface createCartWithClientID: client andPassword: (testObjectFactory passwordFor: client).
	book _ testObjectFactory itemSellByTheStore.
	anInterface add: 1 of: book to: cart.
	
	anInterface checkout: cart
		withCardNumber: testObjectFactory validCreditCardNumber
	 	withExpirationDate:  testObjectFactory futureDate
		withOwner: testObjectFactory validOwner.
	
	^cart! !

!InterfaceTest methodsFor: 'utility' stamp: 'DH 11/18/2019 20:05:02'!
createAndUseACartUsing: anInterface andAdvanceMinutes: anAmountOfMinutes
	
	|stubTimeProvider client cart|
	
	stubTimeProvider _ testObjectFactory stubTimeProvider.
	client _ testObjectFactory validClientID.
	cart _ anInterface createCartWithClientID: client andPassword: (testObjectFactory passwordFor: client).
	anInterface add: 1 of: testObjectFactory itemSellByTheStore to: cart.
	stubTimeProvider advanceMinutes: anAmountOfMinutes.
	^cart! !


!classDefinition: #Cart category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'DH 11/18/2019 20:29:32'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'DH 11/18/2019 20:32:02'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


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


!Cart methodsFor: 'traversal' stamp: 'DH 11/16/2019 14:41:42'!
itemsDo: aBlock

	items do: aBlock! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'DH 11/18/2019 20:31:34'!
invalidItemErrorMessage

	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'DH 11/18/2019 20:32:42'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #CartStoreEntry category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
Object subclass: #CartStoreEntry
	instanceVariableNames: 'cart ownerID lastUsed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartStoreEntry methodsFor: 'initialization' stamp: 'DH 11/17/2019 14:41:03'!
initializeWithCart: aCart owner: aClientID andDateAndTime: aDateAndTime

	cart _ aCart.
	ownerID _ aClientID.
	lastUsed _ aDateAndTime.! !


!CartStoreEntry methodsFor: 'queries' stamp: 'DH 11/16/2019 15:17:29'!
cart

	^cart! !

!CartStoreEntry methodsFor: 'queries' stamp: 'DH 11/17/2019 14:41:32'!
lastTimeUsed

	^lastUsed! !

!CartStoreEntry methodsFor: 'queries' stamp: 'DH 11/16/2019 15:17:38'!
ownerID

	^ownerID! !


!CartStoreEntry methodsFor: 'modifiers' stamp: 'DH 11/17/2019 14:43:14'!
setLastTimeUsed: aDateAndTime

	lastUsed _ aDateAndTime! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartStoreEntry class' category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
CartStoreEntry class
	instanceVariableNames: ''!

!CartStoreEntry class methodsFor: 'instance creation' stamp: 'DH 11/17/2019 14:39:58'!
for: aCart ownedBy: aClientID createdOn: aDateAndTime

	^self new initializeWithCart: aCart owner: aClientID andDateAndTime: aDateAndTime.! !


!classDefinition: #Cashier category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
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

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
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


!classDefinition: #ClientStoreEntry category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
Object subclass: #ClientStoreEntry
	instanceVariableNames: 'password purchases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClientStoreEntry methodsFor: 'initialization' stamp: 'DH 11/16/2019 15:56:40'!
initializeWithPassword: aPassword

	password _ aPassword.
	purchases _ Dictionary new.! !


!ClientStoreEntry methodsFor: 'queries' stamp: 'DH 11/16/2019 15:21:03'!
password

	^password! !

!ClientStoreEntry methodsFor: 'queries' stamp: 'DH 11/16/2019 15:56:21'!
purchases

	^purchases! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClientStoreEntry class' category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
ClientStoreEntry class
	instanceVariableNames: ''!

!ClientStoreEntry class methodsFor: 'instance creation' stamp: 'DH 11/16/2019 15:46:34'!
forClientWithPassword: aPassword

	^self new initializeWithPassword: aPassword! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'DH 11/11/2019 19:28:44'!
initializeWithNumber: aCreditCardNumber owner: anOwnerName expiringOn: aMonth

	aCreditCardNumber size = 16 ifFalse: [self error: self class invalidCreditCardNumberErrorMessage.].
	number _ aCreditCardNumber. 
	owner _ anOwnerName.
	expiration _ aMonth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'DH 11/11/2019 19:26:01'!
newWithNumber: aCreditCardNumber owner: anOwnerName expiringOn: aMonth 
	
	^self new initializeWithNumber: aCreditCardNumber owner: anOwnerName expiringOn: aMonth! !


!CreditCard class methodsFor: 'error messages' stamp: 'DH 11/11/2019 19:29:19'!
invalidCreditCardNumberErrorMessage

	^'Credit card number does not have 16 digits.'! !


!classDefinition: #Interface category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
Object subclass: #Interface
	instanceVariableNames: 'clients carts lastCartID catalog salesBook timeProvider merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Interface methodsFor: 'initialization' stamp: 'DH 11/17/2019 14:35:44'!
initializeWith: aClientDictionary
salesBook: aSalesBook
timeProvider: aTimeProvider
catalog: aCatalog
andMerchantProcessor: aMerchantProcessor

	clients _ aClientDictionary.
	carts _ Dictionary new.
	lastCartID _ 0.
	catalog _ aCatalog.
	salesBook _ aSalesBook.
	timeProvider _ aTimeProvider.
	merchantProcessor _ aMerchantProcessor.! !


!Interface methodsFor: 'cart operations' stamp: 'DH 11/17/2019 18:37:02'!
add: aNumberOfBooks of: aBookISBN to: aCartID

	|cartInfo|
	cartInfo _ self validateAndGetInfoFromCartWithID: aCartID.
	cartInfo cart add: aNumberOfBooks of: aBookISBN.
	cartInfo setLastTimeUsed: timeProvider now.! !

!Interface methodsFor: 'cart operations' stamp: 'DH 11/17/2019 18:41:54'!
checkout: aCartID withCardNumber: aCardNumber withExpirationDate: aMonth withOwner: anOwner
	
	|cartInfo creditCard cashier|
	cartInfo _ self validateAndGetInfoFromCartWithID: aCartID.
	creditCard _ CreditCard newWithNumber: aCardNumber owner: anOwner  expiringOn: aMonth.
	cashier _ Cashier
		toCheckout: cartInfo cart
		charging: creditCard
		throught: merchantProcessor
		on: timeProvider now
		registeringOn: salesBook.
	
	cashier checkOut.
	self registerPurchasesFor: cartInfo ownerID madeWith: cartInfo cart.
	self removeCart: aCartID.! !

!Interface methodsFor: 'cart operations' stamp: 'DH 11/18/2019 22:06:36'!
createCartWithClientID: aClientID andPassword: aPassword

	self getInfoFromClientWithID: aClientID validatingPassword: aPassword.
	lastCartID _ lastCartID + 1.
	carts at: lastCartID put: (self cartStoreEntryForNewCartWithOwner: aClientID).
	^lastCartID! !

!Interface methodsFor: 'cart operations' stamp: 'DH 11/17/2019 18:38:59'!
list: aCartID

	|cartInfo cartItemsWithQuantities|
	cartInfo _ self validateAndGetInfoFromCartWithID: aCartID.
	cartItemsWithQuantities _ Dictionary new.
	self update: cartItemsWithQuantities withItemsFrom: cartInfo cart.
	cartInfo setLastTimeUsed: timeProvider now.
	^cartItemsWithQuantities! !


!Interface methodsFor: 'client operations' stamp: 'DH 11/16/2019 16:04:31'!
listPurchasesOf: aClientID withPassword: aPassword

	|clientInfo|
	clientInfo _ self getInfoFromClientWithID: aClientID validatingPassword: aPassword.
	^clientInfo purchases.! !


!Interface methodsFor: 'cart operations - private' stamp: 'DH 11/16/2019 13:46:11'!
removeCart: aCartID

	carts removeKey: aCartID.! !

!Interface methodsFor: 'cart operations - private' stamp: 'DH 11/18/2019 21:59:23'!
validateAndGetInfoFromCartWithID: aCartID

	|cartInfo minutesSinceLastUsed|
	cartInfo _ carts at: aCartID ifAbsent: [self error: self class invalidCartIDErrorMessage.].
	minutesSinceLastUsed _ (timeProvider now - cartInfo lastTimeUsed) totalMinutes.
	minutesSinceLastUsed >= 30 ifTrue: [
		self removeCart: aCartID.
		self error: self class cartNoLongerValidErrorMessage.
	].
	^cartInfo! !


!Interface methodsFor: 'client operations - private' stamp: 'DH 11/16/2019 16:02:08'!
getInfoFromClientWithID: aClientID validatingPassword: aPassword

	|clientInfo|
	clientInfo _ clients at: aClientID ifAbsent: [self error: self class invalidClientIDErrorMessage.].
	clientInfo password = aPassword ifFalse: [self error: self class incorrectPasswordErrorMessage.].
	^clientInfo! !

!Interface methodsFor: 'client operations - private' stamp: 'DH 11/17/2019 18:41:29'!
registerPurchasesFor: aClientID madeWith: aCart

	|clientPurchases|
	clientPurchases _ (clients at: aClientID) purchases.
	self update: clientPurchases withItemsFrom: aCart.! !


!Interface methodsFor: 'utility - private' stamp: 'DH 11/18/2019 22:06:52'!
cartStoreEntryForNewCartWithOwner: aClientID

	^CartStoreEntry for: (Cart acceptingItemsOf: catalog) ownedBy: aClientID createdOn: timeProvider now! !

!Interface methodsFor: 'utility - private' stamp: 'DH 11/16/2019 15:54:16'!
update: aDictionary withItemsFrom: aCart

	aCart itemsDo: [:item | | oldQuantity |
		oldQuantity _ aDictionary at: item ifAbsent: [aDictionary at: item put: 0.].
		aDictionary at: item put: oldQuantity + 1.
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Interface class' category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
Interface class
	instanceVariableNames: ''!

!Interface class methodsFor: 'errorMessages' stamp: 'DH 11/7/2019 20:29:02'!
bookNotFromEditorialErrorMessage

	^ 'Book does not belong to editorial.'! !

!Interface class methodsFor: 'errorMessages' stamp: 'DH 11/7/2019 21:00:10'!
cannotAddLessThanOneBookToCartErrorMessage

	^ 'Cannot add less than one book to cart.'! !

!Interface class methodsFor: 'errorMessages' stamp: 'DH 11/17/2019 14:50:46'!
cartNoLongerValidErrorMessage

	^'30 minutes or more passed since cart was used.'! !

!Interface class methodsFor: 'errorMessages' stamp: 'DH 11/7/2019 19:38:47'!
incorrectPasswordErrorMessage

	^ 'Incorrect password.'! !

!Interface class methodsFor: 'errorMessages' stamp: 'DH 11/7/2019 20:23:19'!
invalidCartIDErrorMessage

	^ 'Cart ID does not exist.'! !

!Interface class methodsFor: 'errorMessages' stamp: 'DH 11/7/2019 20:45:47'!
invalidClientIDErrorMessage

	^ 'Invalid client ID.'! !


!Interface class methodsFor: 'instance creation' stamp: 'DH 11/17/2019 14:35:02'!
newWithClients: aClientDictionary
salesBook: aSalesBook
timeProvider: aTimeProvider
catalog: aCatalog
andMerchantProcessor: aMerchantProcessor

	^ self new
	initializeWith: aClientDictionary
	salesBook: aSalesBook
	timeProvider: aTimeProvider
	catalog: aCatalog
	andMerchantProcessor: aMerchantProcessor! !


!classDefinition: #Sale category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
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


!Sale methodsFor: 'comparison' stamp: 'DH 11/11/2019 20:53:21'!
= anotherSale

	^total = anotherSale total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'stubTimeProvider'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'DH 11/11/2019 17:51:24'!
anotherItemSellByTheStore
	
	^ 'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'DH 11/11/2019 18:04:46'!
anotherItemSellByTheStorePrice
	
	^20! !

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

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'DH 11/11/2019 17:54:37'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'DH 11/11/2019 18:26:49'!
invalidCartID
	
	^ -8! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DH 11/17/2019 14:06:46'!
expiredCreditCard
	
	^CreditCard
	newWithNumber: '1234567891011120'
	owner: self validOwner
	expiringOn: self pastDate! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DH 11/17/2019 14:06:57'!
notExpiredCreditCard
	
	^CreditCard
	newWithNumber: '1234567891011120'
	owner: self validOwner
	expiringOn: self futureDate! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DH 11/14/2019 18:47:09'!
validCreditCardNumber
	
	^'1234567890123456'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DH 11/14/2019 18:47:12'!
validOwner

	^'Juan Juan'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'DH 11/17/2019 13:43:43'!
initialize

	stubTimeProvider := StubTimeProvider newWithActualDateAndTime.! !


!StoreTestObjectsFactory methodsFor: 'date and time' stamp: 'DH 11/17/2019 14:05:20'!
futureDate

	^Month month: self today monthIndex year: self today yearNumber + 1! !

!StoreTestObjectsFactory methodsFor: 'date and time' stamp: 'DH 11/17/2019 14:07:21'!
pastDate

	^Month month: self today monthIndex year: self today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'date and time' stamp: 'DH 11/17/2019 13:40:14'!
stubTimeProvider
	
	^stubTimeProvider! !

!StoreTestObjectsFactory methodsFor: 'date and time' stamp: 'DH 11/17/2019 14:04:35'!
today
	
	^stubTimeProvider now! !


!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'DH 11/7/2019 19:55:51'!
anotherValidClientID

	^8128! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'DH 11/18/2019 22:02:34'!
clientsWithPasswords

	|clients|
	clients _ Dictionary new.
	clients at: self validClientID put: (ClientStoreEntry forClientWithPassword: 'flan').
	clients at: self anotherValidClientID put: (ClientStoreEntry forClientWithPassword: 'rosebud').
	^clients! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'DH 11/14/2019 18:46:14'!
invalidClientID
	
	^42! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'DH 11/16/2019 15:39:52'!
passwordFor: aClientID

	^(self clientsWithPasswords at: aClientID) password! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'DH 11/14/2019 18:46:08'!
validClientID
	
	^123456! !


!StoreTestObjectsFactory methodsFor: 'interface' stamp: 'DH 11/14/2019 18:46:39'!
createInterfaceWithMerchantProcessor: aMerchantProcessor
		
	^self createInterfaceWithSalesBook: OrderedCollection new andMerchantProcessor: aMerchantProcessor! !

!StoreTestObjectsFactory methodsFor: 'interface' stamp: 'DH 11/17/2019 14:38:20'!
createInterfaceWithSalesBook: aSalesBook andMerchantProcessor: aMerchantProcessor
		
	^Interface
	newWithClients: self clientsWithPasswords
	salesBook: aSalesBook
	timeProvider: stubTimeProvider
	catalog: self defaultCatalog
	andMerchantProcessor: aMerchantProcessor ! !


!classDefinition: #TimeProvider category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
Object subclass: #TimeProvider
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TimeProvider methodsFor: 'query time' stamp: 'DH 11/17/2019 14:09:45'!
now

	^self subclassResponsibility! !


!classDefinition: #StubTimeProvider category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
TimeProvider subclass: #StubTimeProvider
	instanceVariableNames: 'dateAndTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StubTimeProvider methodsFor: 'initialization' stamp: 'DH 11/17/2019 14:11:00'!
initializeWithActualDateAndTime

	dateAndTime _ DateAndTime now! !


!StubTimeProvider methodsFor: 'query time' stamp: 'DH 11/17/2019 14:11:12'!
now

	^dateAndTime! !


!StubTimeProvider methodsFor: 'time manipulation' stamp: 'DH 11/17/2019 14:19:09'!
advanceDays: anAmountOfDays

	dateAndTime _ DateAndTime 
		year: dateAndTime yearNumber
		month: dateAndTime monthIndex
		day: dateAndTime dayOfMonth + anAmountOfDays
		hour: dateAndTime hour
		minute: dateAndTime minute
		second: dateAndTime second! !

!StubTimeProvider methodsFor: 'time manipulation' stamp: 'DH 11/17/2019 18:14:39'!
advanceMinutes: anAmountOfMinutes

	dateAndTime _ DateAndTime 
		year: dateAndTime yearNumber
		month: dateAndTime monthIndex
		day: dateAndTime dayOfMonth
		hour: dateAndTime hour
		minute: dateAndTime minute + anAmountOfMinutes
		second: dateAndTime second! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StubTimeProvider class' category: #TusLibros stamp: 'DH 11/18/2019 22:07:39'!
StubTimeProvider class
	instanceVariableNames: ''!

!StubTimeProvider class methodsFor: 'instance creation' stamp: 'DH 11/17/2019 14:10:39'!
newWithActualDateAndTime

	^self new initializeWithActualDateAndTime! !
