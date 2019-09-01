!classDefinition: #I category: #Peano!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #Peano!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 20:02:15'!
* unNumeroDePeano

	^unNumeroDePeano! !

!I class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 20:01:25'!
+ unNumeroDePeano

	^unNumeroDePeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 20:39:43'!
/ unNumeroDePeano

	^I! !

!I class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 20:32:02'!
> unNumeroDePeano

	^false! !

!I class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 20:42:17'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.! !

!I class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 19:12:09'!
next

	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 19:08:16'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!I class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 20:01:32'!
valorAbsolutoDeRestaInversa: unNumeroDePeano

	^unNumeroDePeano previous! !


!classDefinition: 'II' category: #Peano!
DenotativeObject subclass: 'II'
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #Peano!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 20:03:13'!
* unNumeroDePeano

	^self previous * unNumeroDePeano + unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 20:00:33'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 20:00:40'!
- unNumeroDePeano

	^unNumeroDePeano valorAbsolutoDeRestaInversa: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 20:36:56'!
/ unNumeroDePeano
	
	unNumeroDePeano + unNumeroDePeano > self ifTrue: [^I].
	^(self - unNumeroDePeano) / unNumeroDePeano + I! !

!II class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 20:33:44'!
> unNumeroDePeano
	
	unNumeroDePeano == I ifTrue: [^true].
	^self previous > unNumeroDePeano previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 20:42:17'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 19:47:49'!
next

	next ifNil:
	[
		next := self cloneNamed: (self name, 'I').
		next previous: self
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 19:35:02'!
previous

	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 19:45:23'!
previous: otroNumeroDePeano

	previous := otroNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 19:15:05'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'D 9/1/2019 20:00:53'!
valorAbsolutoDeRestaInversa: unNumeroDePeano

	^self previous valorAbsolutoDeRestaInversa: unNumeroDePeano previous! !

I initializeAfterFileIn!
II initializeAfterFileIn!