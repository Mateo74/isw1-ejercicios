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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 21:55:47'!
test01
		|stack finder set|
		stack _ OOStack new.
		finder _ SentenceFinderByPrefix new.
		set _ Set with: 'hola mundo'.
		
		stack push: 'hola mundo'.
		stack push: 'hOlA mundo'.
		stack push: 'chau mundo'.
		stack push: 'Hola mundo'.
		stack push: 'hoa mundo'.
		stack push: 'h'.
		stack push: ''.

		self assert: set = (finder find: 'hola' in: stack).! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topContainer size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 20:26:47'!
initialize

	topContainer := EmptyStackElementContainer new.
	size := 0! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 21:22:04'!
isEmpty
	
	"^topContainer hasElement not."
	^size = 0! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 21:18:35'!
pop

	|topElement|
	topElement := self top.
	topContainer := topContainer previous.
	size := size - 1.
	^topElement
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 21:17:53'!
push: anElement
	
	|newTop|
	newTop := NonEmptyStackElementContainer newWithElement: anElement andPrevious: topContainer.
	topContainer := newTop.
	size := size + 1! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 20:24:23'!
size

	^size! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 20:24:54'!
top

	^topContainer element! !

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

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 21:48:23'!
esPrefijo: unPrefijo de: unString

	^unPrefijo size <= unString and: unPrefijo = (unString copyFrom: 1 to: unPrefijo size)! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 21:50:25'!
find: aPrefix in: aStack

	|anotherStack res|
	anotherStack _ OOStack new.
	res _ Set new.
	[aStack isEmpty] whileFalse: [
		anotherStack push: aStack pop. 
		(self esPrefijo: aPrefix de: anotherStack top) ifTrue: [res add: anotherStack top].
		].
	[anotherStack isEmpty] whileFalse: [
		aStack push: anotherStack pop. 
		].
	^res! !


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


!classDefinition: #NonEmptyStackElementContainer category: #'Stack-Exercise'!
StackElementContainer subclass: #NonEmptyStackElementContainer
	instanceVariableNames: 'element previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NonEmptyStackElementContainer methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 20:36:51'!
element

	^element! !

!NonEmptyStackElementContainer methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 20:36:35'!
hasElement

	^true! !

!NonEmptyStackElementContainer methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 20:34:59'!
initializeWithElement: anElement andPrevious: aContainer

	element := anElement.
	previous := aContainer.! !

!NonEmptyStackElementContainer methodsFor: 'as yet unclassified' stamp: 'damian y mateo 9/16/2019 21:25:00'!
previous

	^previous! !

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
