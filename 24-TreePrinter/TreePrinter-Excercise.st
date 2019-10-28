!classDefinition: #PortfolioTest category: #'TreePrinter-Excercise'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TreePrinter-Excercise'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'TreePrinter-Excercise'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TreePrinter-Excercise'!

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


!classDefinition: #ReportTest category: #'TreePrinter-Excercise'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TreePrinter-Excercise'!

!ReportTest methodsFor: 'tests' stamp: 'DH 10/28/2019 06:27:53'!
test01AccountSummaryForEmptyAccountIsEmpty

	|account|
	account _ ReceptiveAccount new.
	self assert: 'Balance = 0. ' equals: (self accountSummaryOf: account).! !

!ReportTest methodsFor: 'tests' stamp: 'DH 10/28/2019 06:38:58'!
test02AccountSummaryForEmptyPortfolioIsEmpty

	|portfolio|
	portfolio _ Portfolio new.
	self assert: (self accountSummaryOf: portfolio) isEmpty.! !

!ReportTest methodsFor: 'tests' stamp: 'DH 10/28/2019 06:28:30'!
test03AccountSummaryForAccountWithOneTransactionShowsTheTransaction

	|account|
	account _ ReceptiveAccount new.
	Deposit register: 68 on: account.  
	self assert: 'Depósito por 68. Balance = 68. ' equals: (self accountSummaryOf: account).! !

!ReportTest methodsFor: 'tests' stamp: 'DH 10/28/2019 06:28:41'!
test04AccountSummaryForAccountWithManyTransactionsShowsTheTransactions

	|account|
	account _ ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Transfer from: account to: ReceptiveAccount new for: 20.
	Transfer from: ReceptiveAccount new to: account for: 30. 
	self assert: 'Depósito por 100. Extracción por 50. Salida por transferencia de 20. Entrada por transferencia de 30. Balance = 60. '
	equals: (self accountSummaryOf: account).! !

!ReportTest methodsFor: 'tests' stamp: 'DH 10/28/2019 06:40:46'!
test05AccountSummaryForPortfolioWithOneAccountIsAccountSummaryOfAccount

	|portfolio account|
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	
	portfolio add: account.

	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.

	self assert: 'Depósito por 100. Extracción por 50. Balance = 50. '
	equals: (self accountSummaryOf: portfolio).! !

!ReportTest methodsFor: 'tests' stamp: 'DH 10/28/2019 06:28:52'!
test06AccountSummaryForPortfolioWithManyAccountsIsUnionOfSummariesOfAccounts

	|portfolio account1 account2|
	portfolio _ Portfolio new.
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	portfolio add: account1.
	portfolio add: account2.
	
	Deposit register: 100 on: account1.
	Withdraw register: 30 on: account2.
	Withdraw register: 50 on: account1.
	
	self assert: 'Depósito por 100. Extracción por 50. Balance = 50. Extracción por 30. Balance = -30. '
	equals: (self accountSummaryOf: portfolio).! !

!ReportTest methodsFor: 'tests' stamp: 'DH 10/28/2019 06:28:57'!
test07AccountSummaryForPortfolioWithAccountsAndPortfoliosIsUnionOfSummariesOfAccounts

	|portfolio1  portfolio2 account1 account2|
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	portfolio1 add: account1.
	portfolio2 add: account2.
	portfolio1 add: portfolio2.
	
	Deposit register: 100 on: account1.
	Withdraw register: 30 on: account2.
	Withdraw register: 50 on: account1.
	
	self assert: 'Depósito por 100. Extracción por 50. Balance = 50. Extracción por 30. Balance = -30. '
	equals: (self accountSummaryOf: portfolio1).! !

!ReportTest methodsFor: 'tests' stamp: 'DH 10/28/2019 06:49:29'!
test08TransferNetForEmptyAccountIsZero

	|account|
	account _ ReceptiveAccount new.
	self assert: 0 equals: (self transferNetOf: account).! !

!ReportTest methodsFor: 'tests' stamp: 'DH 10/28/2019 06:50:09'!
test09TransferNetForEmptyPortfolioIsZero

	|portfolio|
	portfolio _ Portfolio new.
	self assert: 0 equals: (self transferNetOf: portfolio).! !

!ReportTest methodsFor: 'tests' stamp: 'DH 10/28/2019 06:53:04'!
test10TransferNetForAccountWithOneDepositByTransferShowsTheTransferValue

	|account|
	account _ ReceptiveAccount new.	Transfer from: ReceptiveAccount new to: account for: 50.

	self assert: 50 equals: (self transferNetOf: account).! !

!ReportTest methodsFor: 'tests' stamp: 'DH 10/28/2019 06:54:07'!
test11TransferNetForAccountWithOneWithdrawByTransferShowsTheNegativeTransferValue

	|account|
	account _ ReceptiveAccount new.	Transfer from: account to: ReceptiveAccount new for: 70.

	self assert: -70 equals: (self transferNetOf: account).! !

!ReportTest methodsFor: 'tests' stamp: 'DH 10/28/2019 06:56:44'!
test12TransferNetForAccountWithManyTransactionsShowsTransferNet

	|account|
	account _ ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Transfer from: account to: ReceptiveAccount new for: 20.
	Transfer from: ReceptiveAccount new to: account for: 30.
	
	self assert: 10 equals: (self transferNetOf: account).! !


!ReportTest methodsFor: 'reports' stamp: 'DH 10/28/2019 06:47:40'!
accountSummaryOf: anAccount

	^(AccountSummary for: anAccount) value! !

!ReportTest methodsFor: 'reports' stamp: 'DH 10/28/2019 06:47:54'!
transferNetOf: anAccount

	^(TransferNet for: anAccount) value! !


!classDefinition: #TransferTest category: #'TreePrinter-Excercise'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TreePrinter-Excercise'!

!TransferTest methodsFor: 'tests' stamp: 'damian y mateo 10/21/2019 19:38:08'!
test01TransferAffectsBalanceOfAccounts
	
	|account1 account2|
	
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	Transfer from: account1 to: account2 for: 100.
	
	self assert: -100 equals: account1 balance.
	self assert:  100 equals: account2 balance.! !

!TransferTest methodsFor: 'tests' stamp: 'damian y mateo 10/24/2019 19:01:00'!
test02ValueOfTransferIsCorrect
	
	|account1 account2 transfer|
	
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	transfer _ Transfer from: account1 to: account2 for: 100.
	
	self assert: 100 equals: transfer value! !

!TransferTest methodsFor: 'tests' stamp: 'damian y mateo 10/21/2019 20:25:39'!
test03TransferTransactionsAreCreated
	
	|account1 account2 transfer transferDeposit transferWithdraw|
	
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	transfer _ Transfer from: account1 to: account2 for: 100.
	transferDeposit _ transfer depositByTransfer.	
	transferWithdraw _ transfer withdrawByTransfer.
	
	self assert: (account1 hasRegistered: transferWithdraw).
	self assert: (account2 hasRegistered: transferDeposit)! !

!TransferTest methodsFor: 'tests' stamp: 'damian y mateo 10/21/2019 20:23:50'!
test04TransferValueMustBeGreaterThanZero
	
	|account1 account2|
	
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	self should: [Transfer from: account1 to: account2 for: -50]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: Transfer nonPositiveTransferErrorMessage equals: anError messageText.
			self assert: account1 transactions isEmpty.
			self assert: account2 transactions isEmpty.
		] 
	! !


!classDefinition: #Account category: #'TreePrinter-Excercise'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TreePrinter-Excercise'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'report' stamp: 'DH 10/26/2019 14:29:09'!
accept: aReport
	
	^self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'TreePrinter-Excercise'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TreePrinter-Excercise'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'report' stamp: 'DH 10/26/2019 17:52:19'!
accept: aReport

	aReport visitPortfolio: self! !

!Portfolio methodsFor: 'report' stamp: 'DH 10/26/2019 14:34:00'!
childrenAccept: aReport

	accounts do: [:account | account accept: aReport.]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'TreePrinter-Excercise'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'TreePrinter-Excercise'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TreePrinter-Excercise'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'report' stamp: 'DH 10/26/2019 17:52:10'!
accept: aReport

	aReport visitReceptiveAccount: self! !

!ReceptiveAccount methodsFor: 'report' stamp: 'DH 10/26/2019 14:36:43'!
transactionsAccept: aReport

	transactions do: [:transaction | transaction accept: aReport.]! !


!classDefinition: #AccountTransaction category: #'TreePrinter-Excercise'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TreePrinter-Excercise'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report' stamp: 'DH 10/26/2019 14:38:12'!
accept: aReport

	^self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'TreePrinter-Excercise'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'TreePrinter-Excercise'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TreePrinter-Excercise'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report' stamp: 'DH 10/26/2019 17:54:42'!
accept: aReport

	aReport visitDepositTransaction: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'TreePrinter-Excercise'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #DepositByTransfer category: #'TreePrinter-Excercise'!
AccountTransaction subclass: #DepositByTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TreePrinter-Excercise'!

!DepositByTransfer methodsFor: 'initialization' stamp: 'damian y mateo 10/21/2019 20:18:57'!
initializeWith: aTransfer

	transfer _ aTransfer! !


!DepositByTransfer methodsFor: 'balance' stamp: 'damian y mateo 10/21/2019 20:22:23'!
affectBalance: aBalance

	^aBalance + transfer value! !


!DepositByTransfer methodsFor: 'value' stamp: 'DH 10/26/2019 11:09:51'!
value

	^transfer value! !


!DepositByTransfer methodsFor: 'transfer' stamp: 'damian y mateo 10/21/2019 20:20:03'!
transfer

	^transfer! !


!DepositByTransfer methodsFor: 'report' stamp: 'DH 10/26/2019 17:54:50'!
accept: aReport

	aReport visitDepositByTransferTransaction: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositByTransfer class' category: #'TreePrinter-Excercise'!
DepositByTransfer class
	instanceVariableNames: ''!

!DepositByTransfer class methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/21/2019 20:21:10'!
fromTransfer: aTransfer

	^self new initializeWith: aTransfer! !


!classDefinition: #Withdraw category: #'TreePrinter-Excercise'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TreePrinter-Excercise'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'DH 10/26/2019 17:54:57'!
accept: aReport

	aReport visitWithdrawTransaction: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'TreePrinter-Excercise'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #WithdrawByTransfer category: #'TreePrinter-Excercise'!
AccountTransaction subclass: #WithdrawByTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TreePrinter-Excercise'!

!WithdrawByTransfer methodsFor: 'balance' stamp: 'damian y mateo 10/21/2019 20:22:42'!
affectBalance: aBalance

	^aBalance - transfer value! !


!WithdrawByTransfer methodsFor: 'value' stamp: 'DH 10/26/2019 11:11:13'!
value

	^transfer value! !


!WithdrawByTransfer methodsFor: 'initialization' stamp: 'damian y mateo 10/21/2019 20:19:29'!
initializeWith: aTransfer

	transfer _ aTransfer! !


!WithdrawByTransfer methodsFor: 'transfer' stamp: 'damian y mateo 10/21/2019 20:20:15'!
transfer

	^transfer! !


!WithdrawByTransfer methodsFor: 'report' stamp: 'DH 10/26/2019 17:55:02'!
accept: aReport

	aReport visitWithdrawByTransferTransaction: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawByTransfer class' category: #'TreePrinter-Excercise'!
WithdrawByTransfer class
	instanceVariableNames: ''!

!WithdrawByTransfer class methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/21/2019 20:21:19'!
fromTransfer: aTransfer

	^self new initializeWith: aTransfer! !


!classDefinition: #Report category: #'TreePrinter-Excercise'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TreePrinter-Excercise'!

!Report methodsFor: 'initialization' stamp: 'damian y mateo 10/24/2019 19:10:05'!
initializeFor: anAccount

	account _ anAccount! !


!Report methodsFor: 'value' stamp: 'DH 10/26/2019 17:49:16'!
asString

	^self subclassResponsibility ! !


!Report methodsFor: 'visit' stamp: 'DH 10/26/2019 15:13:05'!
visitDepositByTransferTransaction: aDepositByTransfer

	^self subclassResponsibility! !

!Report methodsFor: 'visit' stamp: 'DH 10/26/2019 15:04:43'!
visitDepositTransaction: aDeposit

	^self subclassResponsibility! !

!Report methodsFor: 'visit' stamp: 'DH 10/26/2019 15:04:04'!
visitPortfolio: aPortfolio

	^self subclassResponsibility! !

!Report methodsFor: 'visit' stamp: 'DH 10/26/2019 15:04:13'!
visitReceptiveAccount: aReceptiveAccount

	^self subclassResponsibility! !

!Report methodsFor: 'visit' stamp: 'DH 10/26/2019 15:13:17'!
visitWithdrawByTransferTransaction: aWithdrawByTransfer

	^self subclassResponsibility! !

!Report methodsFor: 'visit' stamp: 'DH 10/26/2019 15:13:24'!
visitWithdrawTransaction: aWithdraw

	^self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: #'TreePrinter-Excercise'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'damian y mateo 10/24/2019 19:08:36'!
for: anAccount

	^self new initializeFor: anAccount! !


!classDefinition: #AccountSummary category: #'TreePrinter-Excercise'!
Report subclass: #AccountSummary
	instanceVariableNames: 'reportAsString'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TreePrinter-Excercise'!

!AccountSummary methodsFor: 'visit' stamp: 'DH 10/28/2019 06:33:51'!
visitDepositByTransferTransaction: aDepositByTransfer

	reportAsString _ reportAsString, (self depositByTransferLine: aDepositByTransfer)! !

!AccountSummary methodsFor: 'visit' stamp: 'DH 10/28/2019 06:34:04'!
visitDepositTransaction: aDeposit

	reportAsString _ reportAsString, (self depositLine: aDeposit)! !

!AccountSummary methodsFor: 'visit' stamp: 'DH 10/28/2019 06:35:46'!
visitPortfolio: aPortfolio

	aPortfolio childrenAccept: self! !

!AccountSummary methodsFor: 'visit' stamp: 'DH 10/28/2019 06:38:02'!
visitReceptiveAccount: aReceptiveAccount

	aReceptiveAccount transactionsAccept: self.
	reportAsString _ reportAsString, (self balanceLineWithBalance: aReceptiveAccount balance).! !

!AccountSummary methodsFor: 'visit' stamp: 'DH 10/28/2019 06:34:11'!
visitWithdrawByTransferTransaction: aWithdrawByTransfer

	reportAsString _ reportAsString, (self withdrawByTransferLine: aWithdrawByTransfer)! !

!AccountSummary methodsFor: 'visit' stamp: 'DH 10/28/2019 06:34:17'!
visitWithdrawTransaction: aWithdraw

	reportAsString _ reportAsString, (self withdrawLine: aWithdraw)! !


!AccountSummary methodsFor: 'summary lines' stamp: 'DH 10/28/2019 06:38:27'!
balanceLineWithBalance: aBalance

	^self reportLineWithText: 'Balance = ' andValue: aBalance.! !

!AccountSummary methodsFor: 'summary lines' stamp: 'DH 10/28/2019 06:26:23'!
depositByTransferLine: aDepositByTransfer

	^self reportLineWithText: 'Entrada por transferencia de ' andValue: aDepositByTransfer value! !

!AccountSummary methodsFor: 'summary lines' stamp: 'DH 10/28/2019 06:26:08'!
depositLine: aDeposit

	^self reportLineWithText: 'Depósito por ' andValue: aDeposit value.! !

!AccountSummary methodsFor: 'summary lines' stamp: 'DH 10/28/2019 06:31:36'!
reportLineWithText: aReportLineText andValue: aReportLineValue

	^aReportLineText, aReportLineValue asString, '. '! !

!AccountSummary methodsFor: 'summary lines' stamp: 'DH 10/28/2019 06:26:30'!
withdrawByTransferLine: aWithdrawByTransfer

	^self reportLineWithText: 'Salida por transferencia de ' andValue: aWithdrawByTransfer value! !

!AccountSummary methodsFor: 'summary lines' stamp: 'DH 10/28/2019 06:26:16'!
withdrawLine: aWithdraw

	^self reportLineWithText: 'Extracción por ' andValue: aWithdraw value.! !


!AccountSummary methodsFor: 'value' stamp: 'DH 10/28/2019 06:47:16'!
value

	account accept: self.
	"reportAsString _ reportAsString, self balanceLine."
	^reportAsString ! !


!AccountSummary methodsFor: 'initialization' stamp: 'DH 10/26/2019 17:53:53'!
initializeFor: anAccount

	super initializeFor: anAccount.
	reportAsString _ String new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: #'TreePrinter-Excercise'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'as yet unclassified' stamp: 'DH 10/26/2019 17:10:17'!
for: anAccount

	^self new initializeFor: anAccount! !


!classDefinition: #TransferNet category: #'TreePrinter-Excercise'!
Report subclass: #TransferNet
	instanceVariableNames: 'transferNetValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TreePrinter-Excercise'!

!TransferNet methodsFor: 'value' stamp: 'DH 10/28/2019 06:46:44'!
value

	account accept: self.
	^transferNetValue! !


!TransferNet methodsFor: 'visit' stamp: 'DH 10/28/2019 06:45:33'!
visitDepositByTransferTransaction: aDepositByTransfer

	transferNetValue _ transferNetValue + aDepositByTransfer value! !

!TransferNet methodsFor: 'visit' stamp: 'DH 10/28/2019 06:46:00'!
visitDepositTransaction: aDeposit

	! !

!TransferNet methodsFor: 'visit' stamp: 'DH 10/28/2019 06:44:50'!
visitPortfolio: aPortfolio

	aPortfolio childrenAccept: self! !

!TransferNet methodsFor: 'visit' stamp: 'DH 10/28/2019 06:44:35'!
visitReceptiveAccount: aReceptiveAccount

	aReceptiveAccount transactionsAccept: self! !

!TransferNet methodsFor: 'visit' stamp: 'DH 10/28/2019 06:45:46'!
visitWithdrawByTransferTransaction: aWithdrawByTransfer

	transferNetValue _ transferNetValue - aWithdrawByTransfer value! !

!TransferNet methodsFor: 'visit' stamp: 'DH 10/28/2019 06:45:55'!
visitWithdrawTransaction: aWithdraw

	! !


!TransferNet methodsFor: 'initialization' stamp: 'DH 10/28/2019 06:44:03'!
initializeFor: anAccount

	super initializeFor: anAccount.
	transferNetValue _ 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: #'TreePrinter-Excercise'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'DH 10/28/2019 06:41:35'!
for: anAccount

	^self new initializeFor: anAccount! !


!classDefinition: #Transfer category: #'TreePrinter-Excercise'!
Object subclass: #Transfer
	instanceVariableNames: 'withdrawByTransfer depositByTransfer value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TreePrinter-Excercise'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/21/2019 20:23:25'!
depositByTransfer

	^depositByTransfer! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/21/2019 20:18:08'!
initializeFrom: aSourceAccount to: aDestinationAccount for: aValue
	
	|deposit withdraw|
	aValue > 0 ifFalse: [self error: self class nonPositiveTransferErrorMessage.].
	deposit _ DepositByTransfer fromTransfer: self.
	withdraw _ WithdrawByTransfer fromTransfer: self.
	aSourceAccount register: withdraw.
	aDestinationAccount register: deposit.
	depositByTransfer _ deposit.
	withdrawByTransfer _ withdraw.
	value _ aValue.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/21/2019 20:23:11'!
value

	^value! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/21/2019 20:23:34'!
withdrawByTransfer

	^withdrawByTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'TreePrinter-Excercise'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/21/2019 20:14:21'!
from: aSourceAccount to: aDestinationAccount for: aValue

	^Transfer new initializeFrom: aSourceAccount to: aDestinationAccount for: aValue.! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/21/2019 20:16:27'!
nonPositiveTransferErrorMessage

	^ 'Transfer value must be positive'! !
