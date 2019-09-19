!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'finder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'damian y mateo 9/18/2019 20:06:24'!
test01EmptyResult

	|stack|
	stack := OOStack new.
	
	stack push: 'hola'.
	stack push: 'a stack'.
	stack push: 'aR'.
	
	self assert: (finder find: 'ar' in: stack) isEmpty! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'damian y mateo 9/18/2019 20:04:53'!
test02EmptyResultWithLongPrefix

	|stack|
	stack := OOStack new.
	
	stack push: 'hola'.
	stack push: 'a stack'.
	stack push: 'a Queue'.
	
	self assert: (finder find: 'aVeryLongPrefix' in: stack) isEmpty! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'damian y mateo 9/18/2019 20:06:02'!
test03EmptyStack

	|stack|
	stack := OOStack new.
	
	self assert: (finder find: 'aprefix' in: stack) isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'damian y mateo 9/18/2019 20:09:31'!
test04PrefixEqualToOneString

	|stack|
	stack := OOStack new.
	
	stack push: 'chau'.
	stack push: 'anArray'.
	stack push: 'anavltree'.
	
	self assert: ( (finder find: 'anArray' in: stack) = (Set with: 'anArray') )! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'damian y mateo 9/18/2019 20:13:36'!
test05PrefixOfSeveralStrings

	|stack|
	stack := OOStack new.
	
	stack push: 'spiderman'.
	stack push: 'Spider'.
	stack push: 'spiderwoman'.
	stack push: 'spider Spider'.
	stack push: 'something'.
	
	self assert: ( (finder find: 'spider' in: stack)
		 = (Set with: 'spiderman' with: 'spiderwoman' with: 'spider Spider') )! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'damian y mateo 9/18/2019 20:24:12'!
test06StackIsNotChanged

	|stack|
	stack := OOStack new.
	
	stack push: 'red'.
	stack push: 'red flag'.
	stack push: 're'.
	stack push: 'blue'.
	
	finder find: 'red' in: stack.
	
	self assert: stack top = 'blue'.
	stack pop.
	self assert: stack top = 're'.
	stack pop.
	self assert: stack top = 'red flag'.
	stack pop.
	self assert: stack top = 'red'.
	stack pop.
	self assert: stack isEmpty! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'D 9/18/2019 23:40:21'!
test07CannotUsePrefixWithSpaces

	self
		should: [finder find: 'hello world' in: OOStack new]
		raise: Error
		withExceptionDo: [
			:anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixWithSpacesErrorDescription.
		]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'D 9/18/2019 23:41:01'!
test08CannotUseEmptyPrefix

	self
		should: [finder find: '' in: OOStack new]
		raise: Error
		withExceptionDo: [
			:anError |
			self assert: anError messageText = SentenceFinderByPrefix emptyPrefixErrorDescription .
		]! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'damian y mateo 9/18/2019 19:35:21'!
setUp

	finder := SentenceFinderByPrefix new.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topContainer size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'modifiers' stamp: 'damian y mateo 9/18/2019 16:42:37'!
pop

	|topElement|
	topElement := self top.
	topContainer := topContainer previousContainer.
	size := size - 1.
	^topElement
	! !

!OOStack methodsFor: 'modifiers' stamp: 'damian y mateo 9/16/2019 21:17:53'!
push: anElement
	
	|newTop|
	newTop := NonEmptyStackElementContainer newWithElement: anElement andPrevious: topContainer.
	topContainer := newTop.
	size := size + 1! !


!OOStack methodsFor: 'queries' stamp: 'damian y mateo 9/18/2019 16:42:04'!
isEmpty

	^size = 0! !

!OOStack methodsFor: 'queries' stamp: 'damian y mateo 9/16/2019 20:24:23'!
size

	^size! !

!OOStack methodsFor: 'queries' stamp: 'damian y mateo 9/18/2019 16:43:45'!
top

	^topContainer containedElement! !


!OOStack methodsFor: 'initialization' stamp: 'damian y mateo 9/18/2019 16:41:36'!
initialize

	topContainer := EmptyStackElementContainer new.
	size := 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'strings' stamp: 'mm 9/19/2019 16:06:47'!
assertHasNoSpaces: aPrefix

	aPrefix indexOf: $  ifAbsent: [^self].
	self error: self class prefixWithSpacesErrorDescription.
	! !

!SentenceFinderByPrefix methodsFor: 'strings' stamp: 'mm 9/19/2019 16:06:37'!
assertIsNotEmpty: aPrefix

	aPrefix isEmpty ifTrue: [self error: self class emptyPrefixErrorDescription ]
	! !

!SentenceFinderByPrefix methodsFor: 'strings' stamp: 'damian y mateo 9/18/2019 19:13:06'!
is: aPrefix aPrefixOf: aString

	|prefixSize stringSize|
	prefixSize := aPrefix size.
	stringSize := aString size.
	^aPrefix = ( aString copyFrom: 1 to: (prefixSize min: stringSize) )! !


!SentenceFinderByPrefix methodsFor: 'find' stamp: 'mm 9/19/2019 16:07:25'!
find: aPrefix in: aStack

	|visitedStrings matches|
	
	self assertHasNoSpaces: aPrefix.
	self assertIsNotEmpty: aPrefix.
	
	visitedStrings _ OOStack new.
	matches _ Set new.
	[aStack isEmpty] whileFalse: [
		visitedStrings push: aStack pop. 
		(self is: aPrefix aPrefixOf: visitedStrings top) ifTrue: [matches add: visitedStrings top].
		].
	[visitedStrings isEmpty] whileFalse: [
		aStack push: visitedStrings pop. 
		].
	^matches! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/18/2019 19:18:28'!
emptyPrefixErrorDescription

	^'Given prefix is empty'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/18/2019 19:17:59'!
prefixWithSpacesErrorDescription

	^'Given prefix contains spaces'! !


!classDefinition: #StackElementContainer category: #'Stack-Exercise'!
Object subclass: #StackElementContainer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #EmptyStackElementContainer category: #'Stack-Exercise'!
StackElementContainer subclass: #EmptyStackElementContainer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStackElementContainer methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 20:28:19'!
element

	self error: OOStack stackEmptyErrorDescription ! !

!EmptyStackElementContainer methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 20:38:02'!
hasElement

	^false! !

!EmptyStackElementContainer methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 20:28:34'!
previous

	self error: OOStack stackEmptyErrorDescription ! !


!EmptyStackElementContainer methodsFor: 'accessors' stamp: 'damian y mateo 9/18/2019 16:39:52'!
containedElement

	self error: OOStack stackEmptyErrorDescription ! !

!EmptyStackElementContainer methodsFor: 'accessors' stamp: 'damian y mateo 9/18/2019 16:40:58'!
previousContainer

	self error: OOStack stackEmptyErrorDescription ! !


!classDefinition: #NonEmptyStackElementContainer category: #'Stack-Exercise'!
StackElementContainer subclass: #NonEmptyStackElementContainer
	instanceVariableNames: 'containedElement previousContainer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NonEmptyStackElementContainer methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 20:36:51'!
element

	^element! !

!NonEmptyStackElementContainer methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 20:36:35'!
hasElement

	^true! !

!NonEmptyStackElementContainer methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 21:25:00'!
previous

	^previous! !


!NonEmptyStackElementContainer methodsFor: 'accessors' stamp: 'damian y mateo 9/18/2019 16:38:13'!
containedElement

	^containedElement! !

!NonEmptyStackElementContainer methodsFor: 'accessors' stamp: 'damian y mateo 9/18/2019 16:40:45'!
previousContainer

	^previousContainer! !


!NonEmptyStackElementContainer methodsFor: 'initialization' stamp: 'damian y mateo 9/18/2019 16:39:23'!
initializeWithElement: anElement andPrevious: aPreviousContainer

	containedElement := anElement.
	previousContainer := aPreviousContainer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NonEmptyStackElementContainer class' category: #'Stack-Exercise'!
NonEmptyStackElementContainer class
	instanceVariableNames: ''!

!NonEmptyStackElementContainer class methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 20:36:02'!
newWithElement: anElement andPrevious: aContainer

	|newContainer|
	newContainer := self new.
	newContainer initializeWithElement: anElement andPrevious: aContainer.
	^newContainer! !
