!classDefinition: #CartTest category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
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

!CartTest methodsFor: 'tests' stamp: 'mm 12/1/2019 16:44:05'!
test09AddingAndRemovingABookLeavesCartEmpty

	| cart book |
	
	cart := testObjectsFactory createCart.
	book := testObjectsFactory itemSellByTheStore.
	
	cart add: book.

	cart remove: book.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'mm 12/1/2019 16:49:35'!
test09CannotRemoveItemThatWasNotAdded

	| cart book |
	
	cart := testObjectsFactory createCart.
	book := testObjectsFactory itemSellByTheStore.
	
	self should: [cart remove: book]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [ :anError |
				self assert: Cart itemNotInCartErrorMessage equals: anError messageText.
				self assert: cart isEmpty.
			]! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
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


!classDefinition: #PurchaseSystemTest category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
TestCase subclass: #PurchaseSystemTest
	instanceVariableNames: 'testObjectFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:46:04'!
test01CannotCreateCartWithInvalidClientID

	|purchaseSystem|
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	self should: [purchaseSystem createCartWithClientID: testObjectFactory invalidClientID andPassword: 'pepito'.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: PurchaseSystem invalidClientIDErrorMessage equals: anError messageText.
		]! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:46:12'!
test02CannotCreateCartWithIncorrectPassword

	|purchaseSystem|
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	self should: [purchaseSystem createCartWithClientID: testObjectFactory validClientID andPassword: 'pepito'.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: PurchaseSystem incorrectPasswordErrorMessage equals: anError messageText.
		]! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:46:20'!
test03IDsOfTwoCreatedCartsAreDifferent

	|purchaseSystem clientID1 clientID2 cartID1 cartID2|
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	clientID1 _ testObjectFactory validClientID.
	clientID2 _ testObjectFactory anotherValidClientID.
	cartID1 _ purchaseSystem createCartWithClientID: clientID1 andPassword: (testObjectFactory passwordFor: clientID1).
	cartID2 _ purchaseSystem createCartWithClientID: clientID2 andPassword: (testObjectFactory passwordFor: clientID2).
	
	self deny: cartID1 = cartID2.
	! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:46:32'!
test04CannotAddBookToNonExistentCart

	|purchaseSystem book|
	
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	book _ testObjectFactory itemSellByTheStore.
	
	self should: [purchaseSystem add: 1 of: book to: testObjectFactory invalidCartID.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: PurchaseSystem invalidCartIDErrorMessage equals: anError messageText
	].
	! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:46:38'!
test05CannotListANonExistentCart

	|purchaseSystem|
	
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	
	self should: [purchaseSystem list: testObjectFactory invalidCartID.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: PurchaseSystem invalidCartIDErrorMessage equals: anError messageText
		].
	! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:46:46'!
test06ListingAnEmptyCartResultsInEmptyList

	|purchaseSystem client cart|
	
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	client _ testObjectFactory validClientID.
	cart _ purchaseSystem createCartWithClientID: client andPassword: (testObjectFactory passwordFor: client).
	
	self assert: (purchaseSystem list: cart) isEmpty
	! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:46:58'!
test07ListingACartShowsAddedBooks

	|purchaseSystem book1 book2 client cart|
	
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	book1 _ testObjectFactory itemSellByTheStore.
	book2 _ testObjectFactory anotherItemSellByTheStore.
	client _ testObjectFactory validClientID.
	cart _ purchaseSystem createCartWithClientID: client andPassword: (testObjectFactory passwordFor: client).
	purchaseSystem add: 1 of: book1 to: cart.
	purchaseSystem add: 2 of: book2 to: cart.
	self assert: (Dictionary new at: book1 put: 1; at: book2 put: 2; yourself) equals: (purchaseSystem list: cart).


	! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:47:06'!
test08CannotCheckoutANonExistentCart

	|purchaseSystem|
	
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.

	self should: [purchaseSystem checkout: testObjectFactory invalidCartID 
		withCardNumber: testObjectFactory validCreditCardNumber 
		withExpirationDate: testObjectFactory futureDate 
		withOwner: testObjectFactory validOwner
	]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: PurchaseSystem invalidCartIDErrorMessage equals: anError messageText.
	].	
	
	! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:47:16'!
test09CheckoutOfValidCartMakesTheSaleWithCorrectCost

	|purchaseSystem client cart book salesBook|
	
	salesBook _ OrderedCollection new.
	purchaseSystem _ testObjectFactory createPurchaseSystemWithSalesBook: salesBook andMerchantProcessor: self.
	client _ testObjectFactory validClientID.
	cart _ purchaseSystem createCartWithClientID: client andPassword: (testObjectFactory passwordFor: client).
	book _ testObjectFactory itemSellByTheStore.
	purchaseSystem add: 1 of: book to: cart.
	
	purchaseSystem checkout: cart
		withCardNumber: testObjectFactory validCreditCardNumber
	 	withExpirationDate:  testObjectFactory futureDate
		withOwner: testObjectFactory validOwner.
	
	self assert: (OrderedCollection with: (Sale of: testObjectFactory itemSellByTheStorePrice)) equals: salesBook.! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:47:23'!
test10CheckoutedCartCannotBeModified

	|purchaseSystem cart|
	
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	cart _ self createAndCheckoutACartUsing: purchaseSystem.
	
	self should: [purchaseSystem add: 1 of: testObjectFactory itemSellByTheStore to: cart.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: PurchaseSystem invalidCartIDErrorMessage equals: anError messageText.
	].! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:47:30'!
test11CheckoutedCartCannotBeListed

	|purchaseSystem cart|
	
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	cart _ self createAndCheckoutACartUsing: purchaseSystem.
	
	self should: [purchaseSystem list: cart.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: PurchaseSystem invalidCartIDErrorMessage equals: anError messageText.
	].! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:47:39'!
test12CannotListPurchasesOfNonExistentClient

	|purchaseSystem|
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	self should: [purchaseSystem listPurchasesOf: testObjectFactory invalidClientID withPassword: 'pepito'.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: PurchaseSystem invalidClientIDErrorMessage equals: anError messageText.
	]! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:47:44'!
test13CannotListPurchasesOfClientUsingWrongPassword

	|purchaseSystem|
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	self should: [purchaseSystem listPurchasesOf: testObjectFactory validClientID withPassword: 'pepito'.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: PurchaseSystem incorrectPasswordErrorMessage equals: anError messageText.
	]! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:47:59'!
test14ListingPurchasesOfClientShowsAllPurchases

	|purchaseSystem book1 book2 client password cart cardNumber expirationDate owner|
	
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	book1 _ testObjectFactory itemSellByTheStore.
	book2 _ testObjectFactory anotherItemSellByTheStore.
	client _ testObjectFactory validClientID.
	password _ testObjectFactory passwordFor: client.
	cardNumber _ testObjectFactory validCreditCardNumber.
	expirationDate _ testObjectFactory futureDate.
	owner _ testObjectFactory validOwner.
	
	cart _ purchaseSystem createCartWithClientID: client andPassword: password.
	purchaseSystem add: 1 of: book1 to: cart.
	purchaseSystem add: 1 of: book2 to: cart.
	purchaseSystem checkout: cart withCardNumber: cardNumber withExpirationDate: expirationDate withOwner: owner.
	
	cart _ purchaseSystem createCartWithClientID: client andPassword: password.
	purchaseSystem add: 2 of: book1 to: cart.
	purchaseSystem checkout: cart withCardNumber: cardNumber withExpirationDate: expirationDate withOwner: owner.
	
	self assert: (Dictionary new at: book1 put: 3; at: book2 put: 1; yourself)
		equals: (purchaseSystem listPurchasesOf: client withPassword: password).! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:48:07'!
test15CannotListACartIf30MinutesPassedSinceLastUsed

	|purchaseSystem cart|
	
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	cart _ self createAndUseACartUsing: purchaseSystem andAdvanceMinutes: 31.
	
	self should: [purchaseSystem list: cart.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: PurchaseSystem cartNoLongerValidErrorMessage equals: anError messageText.
	]! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:48:15'!
test16CannotModifyACartIf30MinutesPassedSinceLastUsed

	|purchaseSystem cart|
	
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	cart _ self createAndUseACartUsing: purchaseSystem andAdvanceMinutes: 31.
	
	self should: [purchaseSystem add: 2 of: testObjectFactory anotherItemSellByTheStore to: cart.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: PurchaseSystem cartNoLongerValidErrorMessage equals: anError messageText.
	]! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:48:25'!
test17CannotCheckoutACartIf30MinutesPassedSinceLastUsed

	|salesBook purchaseSystem cart|
	
	salesBook _ OrderedCollection new.
	purchaseSystem _ testObjectFactory createPurchaseSystemWithSalesBook: salesBook andMerchantProcessor: self.
	cart _ self createAndUseACartUsing: purchaseSystem andAdvanceMinutes: 31.
	
	self should: [purchaseSystem checkout: cart 
		withCardNumber: testObjectFactory validCreditCardNumber 
		withExpirationDate: testObjectFactory futureDate 
		withOwner: testObjectFactory validOwner
	]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: PurchaseSystem cartNoLongerValidErrorMessage equals: anError messageText.
		self assert: salesBook isEmpty.
	]! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:48:34'!
test18CartNotUsedFor30MinutesIsDeleted

	|purchaseSystem cart|
	
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	cart _ self createAndUseACartUsing: purchaseSystem andAdvanceMinutes: 31.
	
	self should: [purchaseSystem list: cart]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self should: [purchaseSystem list: cart]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:aSecondError |
			self assert: PurchaseSystem invalidCartIDErrorMessage equals: aSecondError messageText.
		]
	]! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:48:41'!
test19CannotAddBookThatDoesNotBelongToEditorial

	"Test adicional. No se hace en el marco de TDD."
	|purchaseSystem cart client|
	
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	client _ testObjectFactory validClientID.
	cart _ purchaseSystem createCartWithClientID: client andPassword: (testObjectFactory passwordFor: client).
	
	self should: [purchaseSystem add: 1 of: testObjectFactory itemNotSellByTheStore to: cart.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: Cart invalidItemErrorMessage equals: anError messageText.
		self assert: (purchaseSystem list: cart) isEmpty.
		].

	! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 11/18/2019 22:48:51'!
test20CannotAddBookWithQuantityLessThanOne

	"Test adicional. No se hace en el marco de TDD."
	|purchaseSystem cart client|
	
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	client _ testObjectFactory validClientID.
	cart _ purchaseSystem createCartWithClientID: client andPassword: (testObjectFactory passwordFor: client).
	
	self should: [purchaseSystem add: 0 of: testObjectFactory itemSellByTheStore to: cart.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: Cart invalidQuantityErrorMessage equals: anError messageText.
		self assert: (purchaseSystem list: cart) isEmpty.
		].	


	! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 12/1/2019 00:37:23'!
test21CatalogIsReturnedCorrectly
	
	|purchaseSystem|
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	self assert: testObjectFactory defaultCatalog equals: purchaseSystem catalog! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'mm 12/1/2019 17:04:24'!
test22CannotRemoveBookFromNonExistentCart

	|purchaseSystem book|

	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	book _ testObjectFactory itemSellByTheStore.
	
	self should: [purchaseSystem remove: book from: testObjectFactory invalidCartID.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: PurchaseSystem invalidCartIDErrorMessage equals: anError messageText
	].
	! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'mm 12/1/2019 17:12:56'!
test23AddingAndRemovingBookLeavesCartEmpty

	|purchaseSystem client cart book|
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	book _ testObjectFactory itemSellByTheStore.
	client _ testObjectFactory validClientID.
	cart _ purchaseSystem createCartWithClientID: client andPassword: (testObjectFactory passwordFor: client).
		
	purchaseSystem add: 1 of: book to: cart. 
	purchaseSystem remove: book from: cart.
	
	self assert: (purchaseSystem list: cart) isEmpty.
	! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 12/3/2019 20:45:22'!
test24TotalSpentOfClientThatDidNotMakeAnyPurchaseIsZero

	|purchaseSystem client|
	
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	client _ testObjectFactory validClientID.
	self assert: 0 equals: (purchaseSystem totalSpentBy: client withPassword: (testObjectFactory passwordFor: client)).
	! !

!PurchaseSystemTest methodsFor: 'tests' stamp: 'DH 12/3/2019 20:46:37'!
test25MakingAPurchaseAffectsClientTotalSpent

	|purchaseSystem client cart book|
	
	purchaseSystem _ testObjectFactory createPurchaseSystemWithMerchantProcessor: self.
	client _ testObjectFactory validClientID.
	cart _ purchaseSystem createCartWithClientID: client andPassword: (testObjectFactory passwordFor: client).
	book _ testObjectFactory itemSellByTheStore.
	purchaseSystem add: 1 of: book to: cart.
	
	purchaseSystem checkout: cart
		withCardNumber: testObjectFactory validCreditCardNumber
	 	withExpirationDate:  testObjectFactory futureDate
		withOwner: testObjectFactory validOwner.
	
	self
		assert: testObjectFactory itemSellByTheStorePrice
		equals: (purchaseSystem totalSpentBy: client withPassword: (testObjectFactory passwordFor: client)).! !


!PurchaseSystemTest methodsFor: 'setUp/tearDown' stamp: 'DH 11/11/2019 20:08:50'!
setUp

	testObjectFactory := StoreTestObjectsFactory new.
	debitBehavior := [:anAmount :aCreditCard | ]
	! !


!PurchaseSystemTest methodsFor: 'merchant processor protocol' stamp: 'DH 11/11/2019 20:10:23'!
debit: anAmount from: aCreditCard

	^debitBehavior value: anAmount value: aCreditCard ! !


!PurchaseSystemTest methodsFor: 'utility' stamp: 'DH 11/18/2019 22:45:37'!
createAndCheckoutACartUsing: aPurchaseSystem

	|client cart book|
	
	client _ testObjectFactory validClientID.
	cart _ aPurchaseSystem createCartWithClientID: client andPassword: (testObjectFactory passwordFor: client).
	book _ testObjectFactory itemSellByTheStore.
	aPurchaseSystem add: 1 of: book to: cart.
	
	aPurchaseSystem checkout: cart
		withCardNumber: testObjectFactory validCreditCardNumber
	 	withExpirationDate:  testObjectFactory futureDate
		withOwner: testObjectFactory validOwner.
	
	^cart! !

!PurchaseSystemTest methodsFor: 'utility' stamp: 'DH 11/18/2019 22:45:45'!
createAndUseACartUsing: aPurchaseSystem andAdvanceMinutes: anAmountOfMinutes
	
	|stubTimeProvider client cart|
	
	stubTimeProvider _ testObjectFactory stubTimeProvider.
	client _ testObjectFactory validClientID.
	cart _ aPurchaseSystem createCartWithClientID: client andPassword: (testObjectFactory passwordFor: client).
	aPurchaseSystem add: 1 of: testObjectFactory itemSellByTheStore to: cart.
	stubTimeProvider advanceMinutes: anAmountOfMinutes.
	^cart! !


!classDefinition: #Cart category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
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


!Cart methodsFor: 'total' stamp: 'DH 12/1/2019 00:34:52'!
total

	^ items sum: [ :anItem | (catalog at: anItem) price ]! !


!Cart methodsFor: 'traversal' stamp: 'DH 11/16/2019 14:41:42'!
itemsDo: aBlock

	items do: aBlock! !


!Cart methodsFor: 'adding-removing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding-removing' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

!Cart methodsFor: 'adding-removing' stamp: 'mm 12/1/2019 16:56:32'!
remove: anItem

	self assertIsValidItem: anItem.
	
	(items includes: anItem) ifFalse: [self error: self class itemNotInCartErrorMessage.].
	
	items remove: anItem.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
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

!Cart class methodsFor: 'error messages' stamp: 'mm 12/1/2019 16:53:15'!
itemNotInCartErrorMessage

	^ 'Cannot remove an item that is not in cart'! !


!classDefinition: #CartStoreEntry category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
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

!classDefinition: 'CartStoreEntry class' category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
CartStoreEntry class
	instanceVariableNames: ''!

!CartStoreEntry class methodsFor: 'instance creation' stamp: 'DH 11/17/2019 14:39:58'!
for: aCart ownedBy: aClientID createdOn: aDateAndTime

	^self new initializeWithCart: aCart owner: aClientID andDateAndTime: aDateAndTime.! !


!classDefinition: #Cashier category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
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

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
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


!classDefinition: #CatalogEntry category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
Object subclass: #CatalogEntry
	instanceVariableNames: 'title author price'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CatalogEntry methodsFor: 'initialization' stamp: 'DH 12/1/2019 00:16:46'!
initializeWithTitle: aBookTitle author: anAuthor price: aPrice.

	title _ aBookTitle.
	author _ anAuthor.
	price _ aPrice.! !


!CatalogEntry methodsFor: 'queries' stamp: 'DH 12/1/2019 00:17:36'!
author

	^author! !

!CatalogEntry methodsFor: 'queries' stamp: 'DH 12/1/2019 00:17:43'!
price

	^price! !

!CatalogEntry methodsFor: 'queries' stamp: 'DH 12/1/2019 00:17:29'!
title

	^title! !


!CatalogEntry methodsFor: 'comparing' stamp: 'DH 12/1/2019 00:42:14'!
= aCatalogEntry

	^title = aCatalogEntry title
	and: author = aCatalogEntry author
	and: price = aCatalogEntry price.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CatalogEntry class' category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
CatalogEntry class
	instanceVariableNames: ''!

!CatalogEntry class methodsFor: 'instance creation' stamp: 'DH 12/1/2019 00:16:11'!
forBookWithTitle: aBookTitle author: anAuthor price: aPrice

	^self new initializeWithTitle: aBookTitle author: anAuthor price: aPrice.! !


!classDefinition: #ClientStoreEntry category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
Object subclass: #ClientStoreEntry
	instanceVariableNames: 'password purchases totalSpent cardNumber cardOwner cardExpirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClientStoreEntry methodsFor: 'initialization' stamp: 'DH 12/4/2019 22:43:17'!
initializeWithPassword: aPassword
cardNumber: aCardNumber
cardOwner: aName
cardExpirationDate: aMonth

	password _ aPassword.
	cardNumber _ aCardNumber.
	cardOwner _ aName.
	cardExpirationDate _ aMonth.
	purchases _ Dictionary new.
	totalSpent _ 0.! !


!ClientStoreEntry methodsFor: 'queries' stamp: 'DH 12/4/2019 22:59:39'!
cardExpirationDate

	^cardExpirationDate! !

!ClientStoreEntry methodsFor: 'queries' stamp: 'DH 12/4/2019 22:59:24'!
cardNumber

	^cardNumber! !

!ClientStoreEntry methodsFor: 'queries' stamp: 'DH 12/4/2019 22:59:30'!
cardOwner

	^cardOwner! !

!ClientStoreEntry methodsFor: 'queries' stamp: 'DH 11/16/2019 15:21:03'!
password

	^password! !

!ClientStoreEntry methodsFor: 'queries' stamp: 'DH 11/16/2019 15:56:21'!
purchases

	^purchases! !

!ClientStoreEntry methodsFor: 'queries' stamp: 'DH 12/3/2019 20:21:21'!
totalSpent

	^totalSpent! !


!ClientStoreEntry methodsFor: 'update' stamp: 'DH 12/3/2019 20:23:20'!
updateTotalSpentBy: anAmountSpent

	totalSpent _ totalSpent + anAmountSpent.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClientStoreEntry class' category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
ClientStoreEntry class
	instanceVariableNames: ''!

!ClientStoreEntry class methodsFor: 'instance creation' stamp: 'DH 12/4/2019 23:37:40'!
forClientWithPassword: aPassword

	^self new
		initializeWithPassword: aPassword
		cardNumber: '1234567891011120'
		cardOwner: 'Unused name'
		cardExpirationDate: (Month month: 5 year: 2020).! !

!ClientStoreEntry class methodsFor: 'instance creation' stamp: 'DH 12/4/2019 22:44:26'!
forClientWithPassword: aPassword
cardNumber: aCardNumber
cardOwner: aName
cardExpirationDate: aMonth

	^self new
		initializeWithPassword: aPassword
		cardNumber: aCardNumber
		cardOwner: aName
		cardExpirationDate: aMonth.! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'DH 11/29/2019 23:59:59'!
initializeWithNumber: aCreditCardNumber owner: anOwnerName expiringOn: aMonth

	(self isACreditCardNumber: aCreditCardNumber) ifFalse: [self error: self class invalidCreditCardNumberErrorMessage.].
	number _ aCreditCardNumber. 
	owner _ anOwnerName.
	expiration _ aMonth! !


!CreditCard methodsFor: 'private' stamp: 'DH 11/29/2019 23:59:23'!
isACreditCardNumber: aString

	^aString size = 16 and: (aString allSatisfy: [:character | character isDigit])! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'DH 11/11/2019 19:26:01'!
newWithNumber: aCreditCardNumber owner: anOwnerName expiringOn: aMonth 
	
	^self new initializeWithNumber: aCreditCardNumber owner: anOwnerName expiringOn: aMonth! !


!CreditCard class methodsFor: 'error messages' stamp: 'DH 11/11/2019 19:29:19'!
invalidCreditCardNumberErrorMessage

	^'Credit card number does not have 16 digits.'! !


!classDefinition: #PurchaseSystem category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
Object subclass: #PurchaseSystem
	instanceVariableNames: 'clients carts lastCartID catalog salesBook timeProvider merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PurchaseSystem methodsFor: 'initialization' stamp: 'DH 11/29/2019 20:16:08'!
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


!PurchaseSystem methodsFor: 'cart operations' stamp: 'DH 11/29/2019 19:50:20'!
add: aNumberOfBooks of: aBookISBN to: aCartID

	|cartInfo|
	cartInfo _ self validateAndGetInfoFromCartWithID: aCartID.
	cartInfo cart add: aNumberOfBooks of: aBookISBN.
	cartInfo setLastTimeUsed: timeProvider now.! !

!PurchaseSystem methodsFor: 'cart operations' stamp: 'DH 12/4/2019 23:05:39'!
checkout: aCartID
	
	|cartInfo clientInfo|
	cartInfo _ self validateAndGetInfoFromCartWithID: aCartID.
	clientInfo _ clients at: cartInfo ownerID.
	self
		checkout: aCartID
		withCardNumber: clientInfo cardNumber
		withExpirationDate: clientInfo cardExpirationDate
		withOwner: clientInfo cardOwner.! !

!PurchaseSystem methodsFor: 'cart operations' stamp: 'DH 12/3/2019 20:35:16'!
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
	self updateTotalSpentOf: cartInfo ownerID by: cartInfo cart total.
	self removeCart: aCartID.! !

!PurchaseSystem methodsFor: 'cart operations' stamp: 'DH 11/29/2019 19:48:44'!
createCartWithClientID: aClientID andPassword: aPassword

	self getInfoFromClientWithID: aClientID validatingPassword: aPassword.
	lastCartID _ lastCartID + 1.
	carts at: lastCartID put: (self cartStoreEntryForNewCartWithOwner: aClientID).
	^lastCartID! !

!PurchaseSystem methodsFor: 'cart operations' stamp: 'DH 11/29/2019 19:49:43'!
list: aCartID

	|cartInfo cartItemsWithQuantities|
	cartInfo _ self validateAndGetInfoFromCartWithID: aCartID.
	cartItemsWithQuantities _ Dictionary new.
	self update: cartItemsWithQuantities withItemsFrom: cartInfo cart.
	cartInfo setLastTimeUsed: timeProvider now.
	^cartItemsWithQuantities! !

!PurchaseSystem methodsFor: 'cart operations' stamp: 'mm 12/1/2019 17:14:28'!
remove: aBookISBN from: aCartID

	|cartInfo|
	cartInfo _ self validateAndGetInfoFromCartWithID: aCartID.
	cartInfo cart remove: aBookISBN.
	cartInfo setLastTimeUsed: timeProvider now.! !


!PurchaseSystem methodsFor: 'client operations' stamp: 'DH 11/29/2019 23:52:05'!
listPurchasesOf: aClientID withPassword: aPassword

	|clientInfo|
	clientInfo _ self getInfoFromClientWithID: aClientID validatingPassword: aPassword.
	^clientInfo purchases.! !

!PurchaseSystem methodsFor: 'client operations' stamp: 'DH 12/3/2019 20:43:30'!
totalSpentBy: aClientID withPassword: aPassword

	|clientInfo|
	clientInfo _ self getInfoFromClientWithID: aClientID validatingPassword: aPassword.
	^clientInfo totalSpent.! !


!PurchaseSystem methodsFor: 'catalog' stamp: 'DH 12/1/2019 00:29:11'!
catalog

	^catalog! !


!PurchaseSystem methodsFor: 'cart operations - private' stamp: 'DH 11/16/2019 13:46:11'!
removeCart: aCartID

	carts removeKey: aCartID.! !

!PurchaseSystem methodsFor: 'cart operations - private' stamp: 'DH 12/1/2019 13:10:31'!
validateAndGetInfoFromCartWithID: aCartID

	|cartInfo minutesSinceLastUsed|
	cartInfo _ carts at: aCartID ifAbsent: [self error: self class invalidCartIDErrorMessage.].
	minutesSinceLastUsed _ (timeProvider now - cartInfo lastTimeUsed) totalMinutes.
	minutesSinceLastUsed >= 30 ifTrue: [
		self removeCart: aCartID.
		self error: self class cartNoLongerValidErrorMessage.
	].
	^cartInfo! !


!PurchaseSystem methodsFor: 'client operations - private' stamp: 'DH 11/29/2019 19:49:04'!
getInfoFromClientWithID: aClientID validatingPassword: aPassword

	|clientInfo|
	clientInfo _ clients at: aClientID ifAbsent: [self error: self class invalidClientIDErrorMessage.].
	clientInfo password = aPassword ifFalse: [self error: self class incorrectPasswordErrorMessage.].
	^clientInfo! !

!PurchaseSystem methodsFor: 'client operations - private' stamp: 'DH 11/29/2019 19:49:12'!
registerPurchasesFor: aClientID madeWith: aCart

	|clientPurchases|
	clientPurchases _ (clients at: aClientID) purchases.
	self update: clientPurchases withItemsFrom: aCart.! !

!PurchaseSystem methodsFor: 'client operations - private' stamp: 'DH 12/3/2019 20:36:14'!
updateTotalSpentOf: aClientID by: anAmountSpent

	(clients at: aClientID) updateTotalSpentBy: anAmountSpent.! !


!PurchaseSystem methodsFor: 'utility - private' stamp: 'DH 11/29/2019 19:51:17'!
cartStoreEntryForNewCartWithOwner: aClientID

	^CartStoreEntry for: (Cart acceptingItemsOf: catalog) ownedBy: aClientID createdOn: timeProvider now! !

!PurchaseSystem methodsFor: 'utility - private' stamp: 'DH 11/29/2019 19:51:25'!
update: aDictionary withItemsFrom: aCart

	aCart itemsDo: [:item | | oldQuantity |
		oldQuantity _ aDictionary at: item ifAbsent: [aDictionary at: item put: 0.].
		aDictionary at: item put: oldQuantity + 1.
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchaseSystem class' category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
PurchaseSystem class
	instanceVariableNames: ''!

!PurchaseSystem class methodsFor: 'errorMessages' stamp: 'DH 11/7/2019 20:29:02'!
bookNotFromEditorialErrorMessage

	^ 'Book does not belong to editorial.'! !

!PurchaseSystem class methodsFor: 'errorMessages' stamp: 'DH 11/7/2019 21:00:10'!
cannotAddLessThanOneBookToCartErrorMessage

	^ 'Cannot add less than one book to cart.'! !

!PurchaseSystem class methodsFor: 'errorMessages' stamp: 'DH 11/17/2019 14:50:46'!
cartNoLongerValidErrorMessage

	^'30 minutes or more passed since cart was used.'! !

!PurchaseSystem class methodsFor: 'errorMessages' stamp: 'DH 11/7/2019 19:38:47'!
incorrectPasswordErrorMessage

	^ 'Incorrect password.'! !

!PurchaseSystem class methodsFor: 'errorMessages' stamp: 'DH 11/7/2019 20:23:19'!
invalidCartIDErrorMessage

	^ 'Cart ID does not exist.'! !

!PurchaseSystem class methodsFor: 'errorMessages' stamp: 'DH 11/7/2019 20:45:47'!
invalidClientIDErrorMessage

	^ 'Invalid client ID.'! !


!PurchaseSystem class methodsFor: 'instance creation' stamp: 'DH 11/17/2019 14:35:02'!
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


!classDefinition: #Sale category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
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

!classDefinition: 'Sale class' category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
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

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'DH 12/1/2019 00:33:56'!
defaultCatalog
	
	^Dictionary new
		at: self itemSellByTheStore put: 
			(CatalogEntry forBookWithTitle: 'Title 1' author: 'Author 1' price: self itemSellByTheStorePrice);
		at: self anotherItemSellByTheStore put:
			(CatalogEntry forBookWithTitle: 'Title 2' author: 'Author 2' price: self anotherItemSellByTheStorePrice);
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

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'DH 12/4/2019 22:45:45'!
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


!StoreTestObjectsFactory methodsFor: 'purchase system' stamp: 'DH 11/18/2019 22:45:10'!
createPurchaseSystemWithMerchantProcessor: aMerchantProcessor
		
	^self createPurchaseSystemWithSalesBook: OrderedCollection new andMerchantProcessor: aMerchantProcessor! !

!StoreTestObjectsFactory methodsFor: 'purchase system' stamp: 'DH 11/18/2019 22:45:09'!
createPurchaseSystemWithSalesBook: aSalesBook andMerchantProcessor: aMerchantProcessor
		
	^PurchaseSystem
	newWithClients: self clientsWithPasswords
	salesBook: aSalesBook
	timeProvider: stubTimeProvider
	catalog: self defaultCatalog
	andMerchantProcessor: aMerchantProcessor ! !


!classDefinition: #TimeProvider category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
Object subclass: #TimeProvider
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TimeProvider methodsFor: 'query time' stamp: 'DH 11/17/2019 14:09:45'!
now

	^self subclassResponsibility! !


!classDefinition: #RealTimeProvider category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
TimeProvider subclass: #RealTimeProvider
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RealTimeProvider methodsFor: 'query time' stamp: 'DH 11/19/2019 19:01:50'!
now

	^DateAndTime now! !


!classDefinition: #StubTimeProvider category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
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

!classDefinition: 'StubTimeProvider class' category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
StubTimeProvider class
	instanceVariableNames: ''!

!StubTimeProvider class methodsFor: 'instance creation' stamp: 'DH 11/17/2019 14:10:39'!
newWithActualDateAndTime

	^self new initializeWithActualDateAndTime! !


!classDefinition: #TusLibrosServerController category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
Object subclass: #TusLibrosServerController
	instanceVariableNames: 'webServer port purchaseSystem timeProvider clients catalog salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosServerController methodsFor: 'initialization' stamp: 'DH 12/4/2019 23:13:14'!
initializeWith: aPortNumber

	timeProvider _ RealTimeProvider new.
	clients _ self clients.
	catalog _ self catalog.
	salesBook _ OrderedCollection new.
	merchantProcessor _ self.
	purchaseSystem _ PurchaseSystem
		newWithClients: clients
		salesBook: salesBook
		timeProvider: timeProvider
		catalog: catalog
		andMerchantProcessor: merchantProcessor.
	

	port _ aPortNumber.
	webServer := WebServer new listenOn: aPortNumber.
	
	webServer addService: '/createCart' action: [:request | | clientID password cartID |
		self validate: request has: 'clientID' and: 'password'.
		clientID _ self getAsInteger: 'clientID' from: request.
		password _ request fields at: 'password'.
		self onError: [cartID _ purchaseSystem createCartWithClientID: clientID andPassword: password.] 
			sendErrorMessageOn: request.
		self sendResponseWithBody: cartID on: request.
	].

	webServer addService: '/addToCart' action: [:request | | cartID bookIsbn quantity |
		self validate: request has: 'cartID' has: 'bookIsbn' and: 'quantity'.
		cartID _ self getAsInteger: 'cartID' from: request.
		bookIsbn _ request fields at: 'bookIsbn'.
		quantity _ self getAsInteger: 'quantity' from: request.
		self onError: [purchaseSystem add: quantity of: bookIsbn to: cartID]
			 sendErrorMessageOn: request.
		self sendResponseWithBody: 'Items successfully added' on: request.
	].

	webServer addService: '/listCart' action: [:request | | cartID cartItems |
		self validate: request has: 'cartID'.
		cartID _ self getAsInteger: 'cartID' from: request.
		self onError: [cartItems _ purchaseSystem list: cartID] sendErrorMessageOn: request.
		self sendResponseWithBody: cartItems on: request.
	].

	webServer addService: '/checkoutCart' action: [:request | | cartID ccn cced cco |
		self validate: request has: 'cartID' has: 'ccn' has: 'cced' and: 'cco'.
		cartID _ self getAsInteger: 'cartID' from: request.
		ccn _ request fields at: 'ccn'.
		cced _ self getAsMonthAndYear: 'cced' from: request.
		cco _ request fields at: 'cco'.
		self onError: [
			purchaseSystem
				checkout: cartID
				withCardNumber: ccn
				withExpirationDate: cced
				withOwner: cco
			]
			sendErrorMessageOn: request.
			
		self sendResponseWithBody: 'Checkout successful' on: request.
	].

	webServer addService: '/listPurchases' action: [:request | | clientID password purchases |
		self validate: request has: 'clientID' and: 'password'.
		clientID _ self getAsInteger: 'clientID' from: request.
		password _ request fields at: 'password'.
		self onError: [purchases _ purchaseSystem listPurchasesOf: clientID withPassword: password.]
			sendErrorMessageOn: request.
			
		self sendResponseWithBody: purchases on: request.
	].

	webServer addService: '/catalog' action: [:request |
		self sendResponseWithBody: (self serialize: purchaseSystem catalog) on: request.
	].

	webServer addService: '/removeFromCart' action: [:request | | cartID bookIsbn |
		self validate: request has: 'cartID' and: 'bookIsbn'.
		cartID _ self getAsInteger: 'cartID' from: request.
		bookIsbn _ request fields at: 'bookIsbn'.
		self onError: [purchaseSystem remove: bookIsbn from: cartID]
			 sendErrorMessageOn: request.
		self sendResponseWithBody: 'Items successfully removed' on: request.
	].

	webServer addService: '/totalSpent' action: [:request | | clientID password totalSpent |
		self validate: request has: 'clientID' and: 'password'.
		clientID _ self getAsInteger: 'clientID' from: request.
		password _ request fields at: 'password'.
		self onError: [totalSpent _ purchaseSystem totalSpentBy: clientID withPassword: password.]
			sendErrorMessageOn: request.
			
		self sendResponseWithBody: totalSpent on: request.
	].

	webServer addService: '/checkoutCartWithDefaultCard' action: [:request | | cartID |
		self validate: request has: 'cartID'.
		cartID _ self getAsInteger: 'cartID' from: request.
		self onError: [purchaseSystem checkout: cartID]
			sendErrorMessageOn: request.
			
		self sendResponseWithBody: 'Checkout successful' on: request.
	].! !


!TusLibrosServerController methodsFor: 'responses' stamp: 'DH 11/29/2019 19:26:25'!
onError: aBlock sendErrorMessageOn: aRequest

	aBlock on: Error do: [:anError |
		self sendErrorResponseWithMessage: anError messageText on: aRequest
	].
! !

!TusLibrosServerController methodsFor: 'responses' stamp: 'DH 11/29/2019 19:24:05'!
sendErrorResponseWithMessage: anErrorMessage on: aRequest

	self
		sendResponseWithBody: (Dictionary new at: 'error_message' put: anErrorMessage; yourself)
		on: aRequest
	
	! !

!TusLibrosServerController methodsFor: 'responses' stamp: 'DH 11/29/2019 20:03:01'!
sendResponseWithBody: aResponseBody on: aRequest
	
	|fullBody|
	fullBody _ Dictionary new at: 'response' put: aResponseBody; yourself.
	fullBody _ WebUtils jsonEncode: fullBody.
	aRequest
		send200Response: fullBody asUtf8
		contentType: 'application/json; charset=utf-8'
		do: [ :resp | resp headerAt: 'Access-Control-Allow-Origin' put: '*'.].! !


!TusLibrosServerController methodsFor: 'as yet unclassified' stamp: 'DH 11/29/2019 19:18:15'!
debit: anAmount from: aCreditCard

	! !

!TusLibrosServerController methodsFor: 'as yet unclassified' stamp: 'DH 11/21/2019 20:41:06'!
destroy
	
	webServer ifNotNil: [webServer destroy].! !

!TusLibrosServerController methodsFor: 'as yet unclassified' stamp: 'DH 11/21/2019 19:30:33'!
port

	^port! !

!TusLibrosServerController methodsFor: 'as yet unclassified' stamp: 'DH 11/21/2019 19:29:19'!
stopListening
	
	webServer stopListener.
	^'Stopped listening from port: ', self port asString! !


!TusLibrosServerController methodsFor: 'validations' stamp: 'DH 11/29/2019 19:55:33'!
fieldsOf: aRequest areExactly: aCollectionOfFields

	^aRequest fields size = aCollectionOfFields size 
	and: (aCollectionOfFields allSatisfy: [:aField | aRequest fields includesKey: aField])! !

!TusLibrosServerController methodsFor: 'validations' stamp: 'DH 11/29/2019 23:44:02'!
hasDigitsOnly: aString

	^aString allSatisfy: [:character | character isDigit]! !

!TusLibrosServerController methodsFor: 'validations' stamp: 'DH 11/29/2019 19:32:38'!
validate: aRequest has: aField

	self validate: aRequest hasExactly: (OrderedCollection with: aField).! !

!TusLibrosServerController methodsFor: 'validations' stamp: 'DH 11/29/2019 19:35:00'!
validate: aRequest has: aField and: aSecondField

	self
		validate: aRequest
		hasExactly: (OrderedCollection with: aField with: aSecondField).! !

!TusLibrosServerController methodsFor: 'validations' stamp: 'DH 11/29/2019 19:35:06'!
validate: aRequest has: aField has: aSecondField and: aThirdField

	self
		validate: aRequest
		hasExactly: (OrderedCollection with: aField with: aSecondField with: aThirdField).! !

!TusLibrosServerController methodsFor: 'validations' stamp: 'DH 11/29/2019 19:34:40'!
validate: aRequest has: aField has: aSecondField has: aThirdField and: aFourthField

	self
		validate: aRequest
		hasExactly: (OrderedCollection with: aField with: aSecondField with: aThirdField with: aFourthField).! !

!TusLibrosServerController methodsFor: 'validations' stamp: 'DH 11/29/2019 19:32:13'!
validate: aRequest hasExactly: aCollectionOfFields

	(self fieldsOf: aRequest areExactly: aCollectionOfFields) ifFalse: [aRequest send400Response.]! !

!TusLibrosServerController methodsFor: 'validations' stamp: 'DH 11/29/2019 23:45:17'!
validate: aField isIntegerOn: aRequest

	|fieldValue|
	fieldValue _ aRequest fields at: aField.
	(self hasDigitsOnly: fieldValue) ifFalse: [aRequest send400Response.]! !

!TusLibrosServerController methodsFor: 'validations' stamp: 'DH 11/29/2019 23:46:36'!
validate: aField isMonthAndYearOn: aRequest

	|fieldValue|
	fieldValue _ aRequest fields at: aField.
	(fieldValue size = 6 and: (self hasDigitsOnly: fieldValue)) ifFalse: [aRequest send400Response.]! !


!TusLibrosServerController methodsFor: 'data' stamp: 'DH 12/1/2019 00:14:59'!
catalog

	^Dictionary new
		at: '1111' put: (CatalogEntry forBookWithTitle: 'Book 1' author: 'Author 1' price: 20);
		at: '2222' put: (CatalogEntry forBookWithTitle: 'Book 2' author: 'Author 2' price: 25);
		at: '3333' put: (CatalogEntry forBookWithTitle: 'Book 3' author: 'Author 3' price: 33);
		yourself.! !

!TusLibrosServerController methodsFor: 'data' stamp: 'DH 12/4/2019 23:37:59'!
clients

	^Dictionary new
		at: 1 put: (ClientStoreEntry
			forClientWithPassword: 'flan'
			cardNumber: '1111111111111111'
			cardOwner: 'Flan'
			cardExpirationDate: (Month month: 5 year: 2022));
		at: 2 put: (ClientStoreEntry
			forClientWithPassword: 'rosebud'
			cardNumber: '1234567891011120' 
			cardOwner: 'Rosebud'
			cardExpirationDate: (Month month: 2 year: 2023));
		yourself! !


!TusLibrosServerController methodsFor: 'value retrieval' stamp: 'DH 11/29/2019 19:47:47'!
getAsInteger: anIntegerField from: aRequest

	self validate: anIntegerField isIntegerOn: aRequest.
	^(aRequest fields at: anIntegerField) asInteger! !

!TusLibrosServerController methodsFor: 'value retrieval' stamp: 'DH 11/29/2019 23:31:25'!
getAsMonthAndYear: aMonthAndYearField from: aRequest

	|fieldValue monthPart yearPart|
	self validate: aMonthAndYearField isMonthAndYearOn: aRequest.
	fieldValue _ aRequest fields at: aMonthAndYearField.
	monthPart _ fieldValue copyFrom: 1 to: 2.
	yearPart _ fieldValue copyFrom: 3 to: 6.
	^Month month: monthPart asInteger year: yearPart asInteger.! !


!TusLibrosServerController methodsFor: 'serialization' stamp: 'DH 12/1/2019 01:33:30'!
serialize: aCatalog

	^aCatalog collect: [:catalogEntry |
		Dictionary new
			at: 'title' put: catalogEntry title;
			at: 'author' put: catalogEntry author;
			at: 'price' put: catalogEntry price;
			yourself.
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServerController class' category: #TusLibros stamp: 'DH 12/4/2019 23:48:15'!
TusLibrosServerController class
	instanceVariableNames: ''!

!TusLibrosServerController class methodsFor: 'instance creation' stamp: 'DH 11/19/2019 18:48:47'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber! !
