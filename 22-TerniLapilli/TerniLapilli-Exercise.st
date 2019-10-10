!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Exercise'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 17:46:08'!
test01IsPlayingXWhenGameStarts

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self assert: terniLapilli isPlayingX.
	self assert: terniLapilli isPlayingO not.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 20:14:55'!
test02OCannotMoveWhenGameStarts

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self should: [terniLapilli putOAt: 0@0.]
	raise: Error - MessageNotUnderstood
	withExceptionDo:
	[
		:anError |
		self assert: anError messageText equals: TerniLapilli playerCannotMoveErrorMessage.
		self deny: (terniLapilli OAt: 0@0).
	]
		
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 18:30:10'!
test03IsPlayingOAfterXMakesAMove

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 0@0.
	self assert: terniLapilli isPlayingO.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 20:14:14'!
test04XCannotMoveTwiceInARow

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 0@0.
	self should: [terniLapilli  putXAt: 1@0.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
				self assert: anError messageText equals: TerniLapilli playerCannotMoveErrorMessage.
				self deny: (terniLapilli XAt: 1@0).
			]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 18:37:01'!
test05IsPlayingXAfterOMakesAMove

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 0@0.
	terniLapilli putOAt: 1@0.

	self assert: terniLapilli isPlayingX.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 20:15:50'!
test06ThereCannotBeTwoPiecesInTheSamePosition

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 0@0.
	self should: [terniLapilli putOAt: 0@0.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: TerniLapilli positionTakenErrorMessage.
			self deny: (terniLapilli OAt: 0@0).
		].

! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 20:21:44'!
test07PiecePutByXIsAtTheRightPlace

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 1@2.
	self assert: (terniLapilli XAt: 1@2).
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 20:23:26'!
test08PiecePutByOIsAtTheRightPlace

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 1@2.
	terniLapilli  putOAt: 0@1.
	self assert: (terniLapilli OAt: 0@1).
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 20:25:56'!
test09PiecePutByOIsAtTheRightPlace

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 1@2.
	terniLapilli  putOAt: 0@1.
	self assert: (terniLapilli OAt: 0@1).
! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'isPlayingX tablero board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 20:18:27'!
OAt: aPosition

	^(board at: aPosition) = #O.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 20:18:55'!
XAt: aPosition

	^(board at: aPosition) = #X.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 17:26:41'!
hasPlayerOWon

	

	

	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 17:26:30'!
hasPlayerXWon

	

	

	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 19:39:54'!
initialize

	isPlayingX := true.
	board := Dictionary new.
	board at: 0@0 put: #Nothing.
	board at: 1@0 put: #Nothing.
	board at: 2@0 put: #Nothing.
	board at: 0@1 put: #Nothing.
	board at: 1@1 put: #Nothing.
	board at: 2@1 put: #Nothing.
	board at: 0@2 put: #Nothing.
	board at: 1@2 put: #Nothing.
	board at: 2@2 put: #Nothing.
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 17:35:29'!
isOver

	^false! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 18:33:17'!
isPlayingO

	^isPlayingX not.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 18:41:44'!
isPlayingX

	^isPlayingX! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 19:40:18'!
putOAt: aPosition

	self isPlayingX ifTrue: [self error: self class playerCannotMoveErrorMessage.].
	(board at: aPosition) = #Nothing ifFalse: [self error: self class positionTakenErrorMessage.].
	board at: aPosition put: #O.
	isPlayingX := true.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/10/2019 19:40:29'!
putXAt: aPosition

	isPlayingX ifFalse: [self error: self class playerCannotMoveErrorMessage].
	(board at: aPosition) = #Nothing ifFalse: [self error: self class positionTakenErrorMessage.].
	board at: aPosition put: #X.
	isPlayingX := false.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Exercise'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'errorMessage' stamp: 'damian y mateo 10/10/2019 18:28:56'!
playerCannotMoveErrorMessage

	^'No es el turno del jugador'! !

!TerniLapilli class methodsFor: 'errorMessage' stamp: 'damian y mateo 10/10/2019 18:48:29'!
positionTakenErrorMessage

	^''! !
