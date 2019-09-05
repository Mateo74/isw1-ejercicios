!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'damian y mateo 9/2/2019 21:47:27'!
failEvaluating: aClosureThatShouldFail
withError: anError
andDo: aClosureThatHandlesError

	[ aClosureThatShouldFail value.
	self fail ]
		on: anError 
		do: aClosureThatHandlesError! !

!CustomerBookTest methodsFor: 'testing' stamp: 'damian y mateo 9/2/2019 19:41:33'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertThat: [customerBook addCustomerNamed: 'John Lennon'] takesLessThan: 50*millisecond! !

!CustomerBookTest methodsFor: 'testing' stamp: 'damian y mateo 9/2/2019 19:46:47'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWithOneCustomer: paulMcCartney .
	
	self assertThat: [customerBook removeCustomerNamed: paulMcCartney.] takesLessThan: 100*millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'damian y mateo 9/2/2019 21:48:05'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self failEvaluating: [ customerBook addCustomerNamed: '' ] withError: Error andDo: 
	[ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'damian y mateo 9/2/2019 21:48:34'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self newCustomerBookWithOneCustomer: johnLennon.

	self failEvaluating: [ customerBook removeCustomerNamed: 'Paul McCartney'.]
		withError: NotFound 
		andDo: [ :anError | self assertThat: customerBook hasExactlyOneCustomerNamed: johnLennon ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'damian y mateo 9/2/2019 20:47:13'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook _ self newCustomerBookWithOneSuspendedCustomer: paulMcCartney.
	
	self assertThat: customerBook hasActive: 0 suspended: 1 andTotal: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'damian y mateo 9/2/2019 20:47:41'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.

	customerBook _ self newCustomerBookWithOneSuspendedCustomer: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThat: customerBook hasActive: 0 suspended: 0 andTotal: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'damian y mateo 9/2/2019 21:49:30'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook _ self newCustomerBookWithOneCustomer: johnLennon.
	
	self failEvaluating: [ customerBook suspendCustomerNamed: 'Paul McCartney'. ]
		withError: CantSuspend 
		andDo: [ :anError | self assertThat: customerBook hasExactlyOneCustomerNamed: johnLennon ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'damian y mateo 9/2/2019 21:49:25'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.

	customerBook _ self newCustomerBookWithOneSuspendedCustomer: johnLennon.

	self failEvaluating: [ customerBook suspendCustomerNamed: johnLennon. ]
		withError: CantSuspend 
		andDo: [ :anError | self assertThat: customerBook hasExactlyOneCustomerNamed: johnLennon ].! !


!CustomerBookTest methodsFor: 'assertions' stamp: 'damian y mateo 9/2/2019 20:44:23'!
assertThat: aCustomerBook
hasActive: anAmountOfActive
suspended: anAmountOfSuspended
andTotal: anAmountOfCustomers

	self assert: aCustomerBook numberOfActiveCustomers = anAmountOfActive.
	self assert: aCustomerBook numberOfSuspendedCustomers = anAmountOfSuspended.
	self assert: aCustomerBook numberOfCustomers = anAmountOfCustomers.! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'damian y mateo 9/2/2019 19:58:26'!
assertThat: aCustomerBook hasExactlyOneCustomerNamed: aName

	self assert: aCustomerBook numberOfCustomers = 1.
	self assert: (aCustomerBook includesCustomerNamed: aName).! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'damian y mateo 9/2/2019 19:47:13'!
assertThat: aClosure takesLessThan: anAmountOfTime

	|millisecondsBeforeRunning millisecondsAfterRunning|
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < anAmountOfTime! !


!CustomerBookTest methodsFor: 'create customer books' stamp: 'damian y mateo 9/2/2019 19:17:12'!
newCustomerBookWithOneCustomer: aName

	|customerBook|
	customerBook _ CustomerBook new.
	customerBook addCustomerNamed: aName.
	^customerBook! !

!CustomerBookTest methodsFor: 'create customer books' stamp: 'damian y mateo 9/2/2019 19:22:47'!
newCustomerBookWithOneSuspendedCustomer: aName

	|customerBook|
	customerBook _ self newCustomerBookWithOneCustomer: aName.
	customerBook suspendCustomerNamed: aName.
	^customerBook! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'damian y mateo 9/2/2019 21:05:18'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'damian y mateo 9/2/2019 21:08:12'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'damian y mateo 9/2/2019 21:02:12'!
removeCustomerNamed: aName 

	active remove: aName ifAbsent:
	[
		suspended remove: aName ifAbsent: [^NotFound signal].
	].
	^aName
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:10'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists.'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty.'! !
