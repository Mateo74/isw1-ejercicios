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

!PortfolioTest methodsFor: 'testing' stamp: 'damian y mateo 10/17/2019 20:04:22'!
test03PortfolioAddsAccountAndHasZeroBalance

	|portfolio account|
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	
	portfolio add: account.
	
	self assert: (portfolio has: account).
	self assert: 0 equals: portfolio balance.
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'damian y mateo 10/17/2019 19:28:26'!
test04PortfolioWithOneAccountHasBalanceEqualToAccountBalance

	|portfolio account|
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	
	portfolio add: account.
	Deposit register: 100 on: account.
	Withdraw register: 20 on: account.
	 
	
	self assert: account balance equals: portfolio balance.
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'damian y mateo 10/17/2019 19:33:26'!
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

!PortfolioTest methodsFor: 'testing' stamp: 'damian y mateo 10/17/2019 20:02:29'!
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

!PortfolioTest methodsFor: 'testing' stamp: 'damian y mateo 10/17/2019 20:09:26'!
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

!PortfolioTest methodsFor: 'testing' stamp: 'damian y mateo 10/17/2019 20:18:29'!
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


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
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


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/17/2019 19:36:31'!
add: anAccount

	accounts add: anAccount.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/17/2019 19:43:04'!
balance

	^ accounts sum: [:anAccount | anAccount balance] ifEmpty: [0].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/17/2019 19:45:37'!
has: anAccount
	
	^ accounts includes: anAccount.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/17/2019 19:59:21'!
hasRegistered: aTransaction

	^self transactions includes: aTransaction! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/17/2019 19:35:44'!
initialize

	accounts _ OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/17/2019 19:54:25'!
transactions

	|transactions|
	transactions _ OrderedCollection new.
	accounts do: [:anAccount | transactions addAll: anAccount transactions].
	^transactions! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'damian y mateo 10/17/2019 19:09:52'!
balance

	"^transactions sum: [ :aTransaction | aTransaction value ] ifEmpty: [ 0 ]"
	|balance|
	balance _ 0.
	transactions do: [:transaction | balance _ transaction updateBalance: balance].
	^balance! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
