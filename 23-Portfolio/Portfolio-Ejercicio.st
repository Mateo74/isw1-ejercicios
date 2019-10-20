!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'testing' stamp: 'damian y mateo 10/17/2019 19:15:07'!
test01NewPortfolioHasZeroBalance

	|portfolio|
	portfolio _ Portfolio new.
	
	self assert: 0 equals: portfolio balance.
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'damian y mateo 10/17/2019 19:16:36'!
test02NewPortfolioHasNoTransactions

	|portfolio|
	portfolio _ Portfolio new.
	
	self assert: 0 equals: portfolio transactions size.
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/20/2019 19:22:54'!
test03PortfolioAddsAccountAndHasZeroBalance

	|portfolio account|
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	
	portfolio add: account.
	
	self assert: (portfolio has: account).
	self assert: 0 equals: portfolio balance.
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/20/2019 19:22:55'!
test04PortfolioWithOneAccountHasBalanceEqualToAccountBalance

	|portfolio account|
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	
	portfolio add: account.
	Deposit register: 100 on: account.
	Withdraw register: 20 on: account.
	 
	
	self assert: account balance equals: portfolio balance.
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/20/2019 19:22:55'!
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

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/20/2019 19:22:54'!
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

!PortfolioTest methodsFor: 'testing' stamp: 'damian y mateo 10/17/2019 20:15:01'!
test07NewPortfolioHasNoTransactions

	|portfolio transaction|
	portfolio _ Portfolio new.
	
	transaction _ Deposit for: 100.
	
	self deny: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/20/2019 19:22:54'!
test08hasRegisteredAccounts

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

!PortfolioTest methodsFor: 'testing' stamp: 'damian y mateo 10/17/2019 20:17:05'!
test09NewPortfolioHasEmptyListOfTransactions

	|portfolio|
	portfolio _ Portfolio new.

	
	self assert: portfolio transactions isEmpty.! !

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/20/2019 19:22:55'!
test10hasRegisteredAccounts

"Después vemos"

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

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/20/2019 19:22:55'!
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

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/20/2019 17:13:19'!
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

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/20/2019 19:22:54'!
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

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/20/2019 17:32:33'!
test14CannotAddPortfolioThatAlreadyExistsIndirectly

	|portfolio portfolio2 portfolio3|
	portfolio _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolio3 _ Portfolio new.
	
	portfolio2 add: portfolio3.
	portfolio add: portfolio2.
	
	self should: [portfolio add: portfolio3.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Portfolio ItemAlreadyExistsErrorMessage.
		].		! !

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/20/2019 19:22:54'!
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

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/20/2019 19:22:55'!
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

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/20/2019 19:22:54'!
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

!Item methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 17:34:58'!
balance

	self subclassResponsibility ! !

!Item methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 17:35:23'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Item methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 17:35:40'!
transactions

	self subclassResponsibility! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Item subclass: #Portfolio
	instanceVariableNames: 'elements parentList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'private' stamp: 'mm 10/20/2019 18:08:50'!
anyParentHas: anItem

	parentList ifEmpty: [^ self hasIndirectly: anItem].
	^ (parentList findFirst: [:aPortfolio | aPortfolio anyParentHas: anItem]) isZero not.! !

!Portfolio methodsFor: 'private' stamp: 'mm 10/20/2019 19:03:52'!
canAdd: anItem

	"(self hasIndirectly: anItem) ifTrue: [self error: self class ItemAlreadyExistsErrorMessage]."
	^ (self anyParentHas: anItem) not and: (anItem children allSatisfy: [:item | (self anyParentHas: item) not]).! !

!Portfolio methodsFor: 'private' stamp: 'mm 10/20/2019 19:01:34'!
children
	
	^ elements copy! !

!Portfolio methodsFor: 'private' stamp: 'mm 10/20/2019 17:25:33'!
hasIndirectly: anItem
	
	^ (self has: anItem) or: ((elements findFirst: [:item | item hasIndirectly: anItem]) isZero not)! !

!Portfolio methodsFor: 'private' stamp: 'mm 10/20/2019 17:52:58'!
registerParent: aPortfolio

	parentList add: aPortfolio.! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 19:04:04'!
add: anItem

	"(self hasIndirectly: anItem) ifTrue: [self error: self class ItemAlreadyExistsErrorMessage]."
	(self canAdd: anItem) ifFalse: [self error: self class ItemAlreadyExistsErrorMessage].
	anItem registerParent: self.
	elements add: anItem.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 17:09:10'!
balance

	^ elements sum: [:anItem | anItem balance] ifEmpty: [0].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 17:09:15'!
has: anItem
	
	^ elements includes: anItem.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/17/2019 19:59:21'!
hasRegistered: aTransaction

	^self transactions includes: aTransaction! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 17:52:37'!
initialize

	elements   _ OrderedCollection new.
	parentList _ OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 17:09:31'!
transactions

	|transactions|
	transactions _ OrderedCollection new.
	elements do: [:anItem| transactions addAll: anItem transactions].
	^transactions! !

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

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 15:44:41'!
balance

	"^transactions sum: [ :aTransaction | aTransaction value ] ifEmpty: [ 0 ]"
	|balance|
	balance _ 0.
	transactions do: [:transaction | balance _ transaction updateBalance: balance].
	^balance! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 19:01:16'!
children

	^ OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 17:26:08'!
hasIndirectly: anItem

	^ false
! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 15:44:24'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 15:45:00'!
initialize

	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 15:45:18'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 17:47:22'!
registerParent: aPortfolio! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 15:45:29'!
transactions 

	^ transactions copy! !
