!classDefinition: #TusLibrosTest category: #TusLibros stamp: 'mm 10/31/2019 11:52:19'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'mm 10/31/2019 09:50:38'!
test01NewCartIsEmpty

	self assert: Cart new isEmpty.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'mm 10/31/2019 11:12:48'!
test02CartWithOneItemIsNotEmpty

	|carrito libro|
	
	carrito _ Cart new.
	libro _ Book new.
	carrito add: libro.
	self deny: carrito isEmpty.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'mm 10/31/2019 11:15:04'!
test03CartContainsAddedItem

	|carrito libro1|
	
	carrito _ Cart new.
	libro1 _ Book new.
	carrito add: libro1.
	
	self assert: (carrito contains: libro1).
! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'mm 10/31/2019 11:14:23'!
test04CartWithSeveralItemsContainsThoseItems

	|carrito libro1 libro2 libro3 libro4|
	
	carrito _ Cart new.
	libro1 _ Book new.
	libro2 _ Book new.
	libro3 _ Book new.
	libro4 _ Book new.
	carrito add: libro1.
	carrito add: libro2.
	carrito add: libro3.
	
	self assert: (carrito contains: libro1).
	self assert: (carrito contains: libro2).
	self assert: (carrito contains: libro3).
	self deny:   (carrito contains: libro4).! !


!classDefinition: #Book category: #TusLibros stamp: 'mm 10/31/2019 11:52:19'!
Object subclass: #Book
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #Cart category: #TusLibros stamp: 'mm 10/31/2019 11:52:19'!
Object subclass: #Cart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'mm 10/31/2019 11:11:33'!
add: aBook

	books add: aBook.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'mm 10/31/2019 11:12:38'!
contains: aBook

	^books includes: aBook.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'mm 10/31/2019 11:11:11'!
initialize

	books _ OrderedCollection new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'mm 10/31/2019 11:11:49'!
isEmpty

	^books isEmpty.! !
