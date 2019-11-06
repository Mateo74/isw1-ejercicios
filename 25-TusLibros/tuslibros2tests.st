test01CashierDoesNotAcceptEmptyCard

	|cart cashier salesBook|
	cart := self createCart.
	salesBook := OrderedCollection new.
	cashier := Cashier at: Date today registeringSalesOn: salesBook debitingWith: self mockedMerchantProcessor.

	self should: [Cashier checkout: cart with: self validCreditCard]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Cashier checkoutOfEmptyCartError.
		self assert: salesBook isEmpty.
	]
	

test02CashierCheckoutsCartWithOneItem

	|cart item cashier saleDetail|
	cart := self createCart.
	item := self itemSellByTheStore.
	cashier := Cashier at: Date today registeringSalesOn: OrderedCollection new.
	
	cart add: item.
	saleDetail := cashier checkout: cart with: self validCreditCard debitingWith: self mockedMerchantProcessor.
	
	self assert: saleDetail totalDebited equals: (self defaultCatalog at: item).
	self assert: (saleDetail itemsSoldAre: (OrderedCollection with: self itemSellByTheStore)).



test03CashierDoesNotAcceptExpiredCreditCard

	|cart cashier salesBook|
	cart := self createCart.
	salesBook := OrderedCollection new.
	cashier := Cashier at: self today registeringSalesOn: salesBook debitingWith: self mockedMerchantProcessor.

	cart add: self itemSellByTheStore.

	self should: [Cashier checkout: cart with: self expiredCreditCard]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Cashier expiredCreditCardError.
		self assert: salesBook isEmpty.
	]


test04CashierDoesNotAcceptCreditCardWithOwnerNameLengthGreaterThan30

	|cart cashier salesBook|
	cart := self createCart.
	salesBook := OrderedCollection new.
	cashier := Cashier at: Date today registeringSalesOn: salesBook debitingWith: self mockedMerchantProcessor.
	
	cart add: self itemSellByTheStore.

	self should: [Cashier checkout: cart with: self creditCardWithLongOwnerName]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Cashier creditCardWithTooLongOwnerNameError.
		self assert: salesBook isEmpty.
	]

test05CashierSalesAreRegisteredOnSalesBook

	|cart item cashier firstSaleDetail secondSaleDetail salesBook|
	salesBook := OrderedCollection new.
	cashier := Cashier at: Date today registeringSalesOn: salesBook debitingWith: self mockedMerchantProcessor.
	
	cart := self createCart.
	item := self itemSellByTheStore.
	cart add: item.
	firstSaleDetail := cashier checkout: cart with: self validCreditCard.
	
	cart := self createCart.
	item := self anotherItemSellByTheStore.
	cart add: item.
	secondSaleDetail := cashier checkout: cart with: self validCreditCard.
	
	self assert: (OrderedCollection with: firstSaleDetail with: secondSaleDetail) equals: salesBook


mockedMerchantProcessor

	^MockedMerchantProcessor new
	
