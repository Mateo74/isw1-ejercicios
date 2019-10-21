!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'damian y mateo 10/17/2019 19:15:07'!
test01NewPortfolioHasZeroBalance

	|portfolio|
	portfolio _ Portfolio new.
	
	self assert: 0 equals: portfolio balance.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'DH 10/21/2019 00:28:26'!
test02PortfolioAddsAccountsAndRecognizesAddedAccounts

	|portfolio account1 account2 account3|
	portfolio _ Portfolio new.
	account1 _ ReceptiveAccount new.	account2 _ ReceptiveAccount new.	account3 _ ReceptiveAccount new.
	
	self add: account1 and: account2 to: portfolio andAssertInclusionButExclusionOf: account3.! !

!PortfolioTest methodsFor: 'tests' stamp: 'DH 10/21/2019 00:28:29'!
test03PortfolioAddsPortfoliosAndRecognizesAddedPortfolios

	|portfolio portfolio1 portfolio2 portfolio3|
	portfolio _ Portfolio new.
	portfolio1 _ Portfolio new.	portfolio2 _ Portfolio new.	portfolio3 _ Portfolio new.
	
	self add: portfolio1 and: portfolio2 to: portfolio andAssertInclusionButExclusionOf: portfolio3.! !

!PortfolioTest methodsFor: 'tests' stamp: 'DH 10/21/2019 00:28:32'!
test04PortfolioWithOneAccountHasBalanceEqualToAccountBalance

	|portfolio account|
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	
	portfolio add: account.
	Deposit register: 100 on: account.
	Withdraw register: 20 on: account.
	 
	
	self assert: account balance equals: portfolio balance.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'DH 10/21/2019 00:28:35'!
test05PortfolioWithSeveralAccountsHasBalanceEqualToSumOfBalances

	|portfolio account1 account2 account3| 
	portfolio _ Portfolio new.
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	account3 _ ReceptiveAccount new.
	
	portfolio add: account1.
	portfolio add: account2.
	portfolio add: account3.
	Deposit register: 100 on: account1.
	Withdraw register: 20 on: account2.
	Deposit register: 8 on: account3. 
	
	self assert: account1 balance + account2 balance + account3 balance equals: portfolio balance.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'DH 10/21/2019 00:28:38'!
test06PortfolioWithAccountsAndPortfolioHasBalanceEqualToSumOfElements

	|portfolio1 portfolio2 account1 account2 account3| 
	
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	account3 _ ReceptiveAccount new.
	
	portfolio1 add: account1.
	portfolio2 add: account2.
	portfolio2 add: account3.
	portfolio1 add: portfolio2.
	
	Deposit register: 100 on: account1.
	Withdraw register: 20 on: account2.
	Deposit register: 8 on: account3. 
	
	self assert: account1 balance + account2 balance + account3 balance equals: portfolio1 balance.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'DH 10/21/2019 00:28:42'!
test07NewPortfolioDoesNotRecognizeAnyTransaction

	|portfolio transaction|
	portfolio _ Portfolio new.
	
	transaction _ Deposit for: 100.
	
	self deny: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'DH 10/21/2019 00:28:51'!
test08PortfolioRecognizesTransactionsFromDifferentAccounts

	|portfolio1 portfolio2 account1 account2 account3 transaction1 transaction2 transaction3| 
	
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	account3 _ ReceptiveAccount new.
	
	portfolio1 add: account1.
	portfolio2 add: account2.
	portfolio2 add: account3.
	portfolio1 add: portfolio2.
	
	transaction1 _ Deposit register: 100 on: account1.
	transaction2 _ Withdraw register: 20 on: account2.
	transaction3 _ Deposit register: 8 on: account3. 
	
	self assert: (portfolio1 hasRegistered: transaction1).
	self assert: (portfolio1 hasRegistered: transaction2).
	self assert: (portfolio1 hasRegistered: transaction3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'DH 10/21/2019 00:29:15'!
test09NewPortfolioHasEmptyListOfTransactions

	|portfolio|
	portfolio _ Portfolio new.

	
	self assert: portfolio transactions isEmpty.! !

!PortfolioTest methodsFor: 'tests' stamp: 'DH 10/21/2019 00:29:23'!
test10PortfolioShowsTransactionsFromDifferentAccounts

	|portfolio1 portfolio2 account1 account2 account3 transaction1 transaction2 transaction3| 
	
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	account3 _ ReceptiveAccount new.
	
	portfolio1 add: account1.
	portfolio2 add: account2.
	portfolio2 add: account3.
	portfolio1 add: portfolio2.
	
	transaction1 _ Deposit register: 100 on: account1.
	transaction2 _ Withdraw register: 20 on: account2.
	transaction3 _ Deposit register: 8 on: account3. 

	self assert: (portfolio1 transactions includes: transaction1).
	self assert: (portfolio1 transactions includes: transaction2).
	self assert: (portfolio1 transactions includes: transaction3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'DH 10/21/2019 00:29:26'!
test11CannotAddSameAccountTwice

	|portfolio account|
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	
	portfolio add: account.
	
	self should: [portfolio add: account]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Portfolio ItemAlreadyExistsErrorMessage.
		].		! !

!PortfolioTest methodsFor: 'tests' stamp: 'DH 10/21/2019 00:29:29'!
test12CannotAddSamePortfolioTwice

	|portfolio portfolio2|
	portfolio _ Portfolio new.
	portfolio2 _ Portfolio new.
	
	portfolio add: portfolio2.
	
	self should: [portfolio add: portfolio2]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Portfolio ItemAlreadyExistsErrorMessage.
		].		! !

!PortfolioTest methodsFor: 'tests' stamp: 'DH 10/21/2019 00:29:31'!
test13CannotAddAccountThatAlreadyExistsIndirectly

	|portfolio portfolio2 account|
	portfolio _ Portfolio new.
	portfolio2 _ Portfolio new.
	account _ ReceptiveAccount new.
	
	portfolio2 add: account.
	portfolio add: portfolio2.
	
	self should: [portfolio add: account.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Portfolio ItemAlreadyExistsErrorMessage.
		].		! !

!PortfolioTest methodsFor: 'tests' stamp: 'mm 10/21/2019 15:47:44'!
test14CannotAddPortfolioThatAlreadyExistsIndirectly

	|portfolio1 portfolio2 portfolio3|
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolio3 _ Portfolio new.
	
	portfolio2 add: portfolio3.
	portfolio1 add: portfolio2.
	
	self should: [portfolio1 add: portfolio3.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Portfolio ItemAlreadyExistsErrorMessage.
		].		! !

!PortfolioTest methodsFor: 'tests' stamp: 'DH 10/21/2019 00:29:44'!
test15CannotAddAccountThatAlreadyExistsInParentPortfolio

	|portfolio portfolio2 account|
	portfolio _ Portfolio new.
	portfolio2 _ Portfolio new.
	account _ ReceptiveAccount new.
	
	portfolio add: account.
	portfolio add: portfolio2.
	
	self should: [portfolio2 add: account.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Portfolio ItemAlreadyExistsErrorMessage.
		].		! !

!PortfolioTest methodsFor: 'tests' stamp: 'DH 10/21/2019 00:29:48'!
test16CannotAddAccountThatAlreadyExistsInGrandparentPortfolio

	|portfolio portfolio2 portfolio3 account|
	portfolio _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolio3 _ Portfolio new.
	account _ ReceptiveAccount new.
	
	portfolio add: account.
	portfolio add: portfolio2.
	portfolio2 add: portfolio3.
	
	self should: [portfolio3 add: account.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Portfolio ItemAlreadyExistsErrorMessage.
		].		! !

!PortfolioTest methodsFor: 'tests' stamp: 'DH 10/21/2019 00:29:52'!
test17CannotAddPortfolioThatHasExistingAccount

	|portfolio portfolio2 account|
	portfolio _ Portfolio new.
	portfolio2 _ Portfolio new.
	account _ ReceptiveAccount new.
	
	portfolio add: account.
	portfolio2 add: account.
	
	self should: [portfolio add: portfolio2.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Portfolio ItemAlreadyExistsErrorMessage.
		].		! !

!PortfolioTest methodsFor: 'tests' stamp: 'mm 10/21/2019 15:31:28'!
test18CannotAddPortfolioWithExistingAccountTwoLevelsDown

	|portfolio portfolio2 portfolio3 account|
	portfolio _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolio3 _ Portfolio new.
	account _ ReceptiveAccount new.
	
	portfolio add: account.
	portfolio2 add: portfolio3.
	portfolio3 add: account.
	
	self should: [portfolio add: portfolio2.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Portfolio ItemAlreadyExistsErrorMessage.
		].		! !

!PortfolioTest methodsFor: 'tests' stamp: 'mm 10/21/2019 15:54:24'!
test19PortfolioCannotAddItself

	|portfolio|
	portfolio _ Portfolio new.

	self should: [portfolio add: portfolio.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Portfolio ItemAlreadyExistsErrorMessage.
		].		! !

!PortfolioTest methodsFor: 'tests' stamp: 'mm 10/21/2019 15:46:20'!
test20ItemsCanBeRepeatedButNotJoined

	|portfolio1 portfolio2 portfolio3 account|
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	
	portfolio3 _ Portfolio new.
	
	
	account _ ReceptiveAccount new.

	
	portfolio1 add: account.
	
	portfolio3 add: account.
	
	portfolio1 add: portfolio2.
	
	portfolio3 add: portfolio2.	
	self should: [portfolio2 add: account.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Portfolio ItemAlreadyExistsErrorMessage.
		].		! !


!PortfolioTest methodsFor: 'utility' stamp: 'DH 10/21/2019 00:19:03'!
add: aChildItem and: anotherChildItem to: aPortfolio andAssertInclusionButExclusionOf: aSeparateItem

	aPortfolio add: aChildItem.
	aPortfolio add: anotherChildItem.
	
	self assert: (aPortfolio has: aChildItem).
	self assert: (aPortfolio has: anotherChildItem).
	self deny: (aPortfolio has: aSeparateItem).! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mm 10/20/2019 19:22:55'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mm 10/20/2019 19:22:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mm 10/20/2019 19:22:54'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mm 10/20/2019 19:22:55'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mm 10/20/2019 19:22:54'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mm 10/20/2019 19:22:55'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mm 10/20/2019 19:22:54'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'damian y mateo 10/17/2019 19:05:05'!
updateBalance: aBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'damian y mateo 10/17/2019 18:42:47'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'damian y mateo 10/17/2019 19:04:27'!
updateBalance: aBalance

	^aBalance + value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'damian y mateo 10/17/2019 19:03:51'!
updateBalance: aBalance

	^aBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Item category: #'Portfolio-Ejercicio'!
Object subclass: #Item
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Item methodsFor: 'initialization' stamp: 'DH 10/20/2019 23:35:04'!
initialize

	^self subclassResponsibility ! !


!Item methodsFor: 'transactions' stamp: 'DH 10/20/2019 23:36:02'!
hasRegistered: aTransaction

	^self subclassResponsibility ! !

!Item methodsFor: 'transactions' stamp: 'DH 10/20/2019 23:36:19'!
transactions

	^self subclassResponsibility ! !


!Item methodsFor: 'balance' stamp: 'DH 10/20/2019 23:36:51'!
balance

	^self subclassResponsibility ! !


!Item methodsFor: 'private' stamp: 'DH 10/20/2019 23:37:42'!
children

	^self subclassResponsibility ! !

!Item methodsFor: 'private' stamp: 'DH 10/20/2019 23:37:53'!
hasIndirectly: anItem

	^self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Item subclass: #Portfolio
	instanceVariableNames: 'elements parentList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'private' stamp: 'DH 10/20/2019 23:45:58'!
anyParentHas: anItem

	parentList ifEmpty: [^ self hasIndirectly: anItem].
	^self someElementIn: parentList satisfies: [:aPortfolio | aPortfolio anyParentHas: anItem]! !

!Portfolio methodsFor: 'private' stamp: 'mm 10/21/2019 15:51:33'!
canAdd: anItem
	^ (self = anItem) not and: (self anyParentHas: anItem) not and: (anItem children allSatisfy: [:item | (self canAdd: item)]).! !

!Portfolio methodsFor: 'private' stamp: 'mm 10/20/2019 19:01:34'!
children
	
	^ elements copy! !

!Portfolio methodsFor: 'private' stamp: 'DH 10/20/2019 23:44:36'!
hasIndirectly: anItem
	^ (self has: anItem) or: (self someElementIn: elements satisfies: [:item | item hasIndirectly: anItem])! !

!Portfolio methodsFor: 'private' stamp: 'mm 10/20/2019 17:52:58'!
registerParent: aPortfolio

	parentList add: aPortfolio.! !

!Portfolio methodsFor: 'private' stamp: 'DH 10/20/2019 23:43:11'!
someElementIn: aCollectionOfItems satisfies: aBlock

	^(aCollectionOfItems findFirst: aBlock) isZero not! !


!Portfolio methodsFor: 'transactions' stamp: 'damian y mateo 10/17/2019 19:59:21'!
hasRegistered: aTransaction

	^self transactions includes: aTransaction! !

!Portfolio methodsFor: 'transactions' stamp: 'mm 10/20/2019 17:09:31'!
transactions

	|transactions|
	transactions _ OrderedCollection new.
	elements do: [:anItem| transactions addAll: anItem transactions].
	^transactions! !


!Portfolio methodsFor: 'balance' stamp: 'mm 10/20/2019 17:09:10'!
balance

	^ elements sum: [:anItem | anItem balance] ifEmpty: [0].! !


!Portfolio methodsFor: 'initialization' stamp: 'mm 10/20/2019 17:52:37'!
initialize

	elements   _ OrderedCollection new.
	parentList _ OrderedCollection new.! !


!Portfolio methodsFor: 'content' stamp: 'mm 10/20/2019 19:04:04'!
add: anItem

	"(self hasIndirectly: anItem) ifTrue: [self error: self class ItemAlreadyExistsErrorMessage]."
	(self canAdd: anItem) ifFalse: [self error: self class ItemAlreadyExistsErrorMessage].
	anItem registerParent: self.
	elements add: anItem.! !

!Portfolio methodsFor: 'content' stamp: 'mm 10/20/2019 17:09:15'!
has: anItem
	
	^ elements includes: anItem.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 15:53:08'!
AccountAlreadyExistsErrorMessage

	^ 'Account already exists'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 17:13:00'!
ItemAlreadyExistsErrorMessage

	^ 'Item already exists'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Item subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'private' stamp: 'mm 10/20/2019 19:01:16'!
children

	^ OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'private' stamp: 'mm 10/20/2019 17:26:08'!
hasIndirectly: anItem

	^ false
! !

!ReceptiveAccount methodsFor: 'private' stamp: 'mm 10/20/2019 17:47:22'!
registerParent: aPortfolio! !


!ReceptiveAccount methodsFor: 'initialization' stamp: 'mm 10/20/2019 15:45:00'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'mm 10/20/2019 15:44:24'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'mm 10/20/2019 15:45:18'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'mm 10/20/2019 15:45:29'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'mm 10/20/2019 15:44:41'!
balance

	"^transactions sum: [ :aTransaction | aTransaction value ] ifEmpty: [ 0 ]"
	|balance|
	balance _ 0.
	transactions do: [:transaction | balance _ transaction updateBalance: balance].
	^balance! !
