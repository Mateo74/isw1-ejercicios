!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Exercise'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 12:28:05'!
putPiecesToFinishGame: aTerniLapilliGame

	aTerniLapilliGame putXAt: 0@0.
	aTerniLapilliGame putOAt: 1@0.
	aTerniLapilliGame putXAt: 0@1.
	aTerniLapilliGame putOAt: 2@0.
	aTerniLapilliGame putXAt: 0@2.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 16:53:01'!
test01IsPlayingXWhenGameStarts

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self assert: terniLapilli isPlayingX.
	self deny: terniLapilli isPlayingO.! !

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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 16:55:18'!
test04XCannotMoveTwiceInARow

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 0@0.
	self should: [terniLapilli  putXAt: 1@0.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:
	[
		:anError | 
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 16:57:19'!
test06ThereCannotBeTwoPiecesInTheSamePosition

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 0@0.
	self should: [terniLapilli putOAt: 0@0.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:
	[
		:anError | 
		self assert: anError messageText equals: TerniLapilli positionTakenTwiceErrorMessage.
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 17:06:07'!
test09CannotPutXOutOfBoard

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self should: [terniLapilli  putXAt: 3@1.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:
	[
		:anError | 
		self assert: anError messageText equals: TerniLapilli piecePutOutOfBoardErrorMessage.
		"self deny: (terniLapilli XAt: 3@1)."
	]
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 17:06:59'!
test10CannotPutOOutOfBoard

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 0@0.
	self should: [terniLapilli  putOAt: -2@0.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:
	[
		:anError | 
		self assert: anError messageText equals: TerniLapilli piecePutOutOfBoardErrorMessage.
		"self deny: (terniLapilli XAt: 3@1)."
	]
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 17:46:28'!
test11PuttingAnXThatAlignsThreeXVerticallyMakesPlayerXWin

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 0@0.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putOAt: 2@1.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 0@1.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putOAt: 2@2.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 0@2.
	self assert: terniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 18:42:03'!
test12PuttingAnXThatAlignsThreeXHorizontallyMakesPlayerXWin

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 1@1.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putOAt: 0@0.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 2@1.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putOAt: 2@0.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 0@1.
	self assert: terniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 19:28:38'!
test13PuttingAnXThatAlignsThreeXDiagonallyIncreasingMakesPlayerXWin

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 2@2.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putOAt: 1@0.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 0@0.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putOAt: 0@1.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 1@1.
	self assert: terniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:10:13'!
test14PuttingAnXThatAlignsThreeXDiagonallyDecreasingMakesPlayerXWin

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 0@2.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putOAt: 1@0.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 2@0.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putOAt: 0@1.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 1@1.
	self assert: terniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:13:56'!
test15PuttingAnOThatAlignsThreeOVerticallyMakesPlayerOWin

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 1@1.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 0@0.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 2@1.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 0@1.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 2@2.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 0@2.
	self assert: terniLapilli hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:14:15'!
test16PuttingAnOThatAlignsThreeOHorizontallyMakesPlayerOWin

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 2@2.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 1@1.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 0@0.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 2@1.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 2@0.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 0@1.
	self assert: terniLapilli hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:14:28'!
test17PuttingAnOThatAlignsThreeODiagonallyIncreasingMakesPlayerOWin

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 1@2.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 2@2.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 1@0.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 0@0.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 0@1.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 1@1.
	self assert: terniLapilli hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:16:01'!
test18PuttingAnOThatAlignsThreeODiagonallyDecreasingMakesPlayerOWin

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self deny: terniLapilli hasPlayerOWon.	
	terniLapilli  putXAt: 0@0.
	
	self deny: terniLapilli hasPlayerOWon.

	terniLapilli putOAt: 0@2.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 1@0.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 2@0.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 0@1.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 1@1.
	self assert: terniLapilli hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 12:24:34'!
test19CannotPutAnXWhenGameIsOver

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self putPiecesToFinishGame: terniLapilli.
	
	self should: [terniLapilli putXAt: 1@1.] raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: TerniLapilli gameIsOverErrorMessage equals: anError messageText.
		self deny: (terniLapilli XAt: 1@1).
	]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 12:30:10'!
test20CannotPutAnOWhenGameIsOver

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self putPiecesToFinishGame: terniLapilli.
	
	self should: [terniLapilli putOAt: 1@1.] raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: TerniLapilli gameIsOverErrorMessage equals: anError messageText.
		self deny: (terniLapilli OAt: 1@1).
	]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 13:42:20'!
test21XCannotPutAPieceFourTimes

	|terniLapilli|
	terniLapilli := TerniLapilli new.	terniLapilli putXAt: 0@0.
	terniLapilli putOAt: 0@1.
	terniLapilli putXAt: 0@2.
	terniLapilli putOAt: 1@0.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 1@2.
	
	self should: [terniLapilli putXAt: 2@0.] raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: TerniLapilli noPiecesLeftErrorMessage equals: anError messageText.
		self deny: (terniLapilli XAt: 2@0).
	]
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 13:42:00'!
test22OCannotPutAPieceFourTimes

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 0@0.
	terniLapilli putOAt: 0@1.
	terniLapilli putXAt: 0@2.
	terniLapilli putOAt: 1@0.
	terniLapilli putXAt: 1@1.
	
	self should: [terniLapilli putOAt: 1@2] raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: TerniLapilli noPiecesLeftErrorMessage equals: anError messageText.
		self deny: (terniLapilli OAt: 1@2).
	]
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/15/2019 22:48:01'!
test23XCannotMoveAPieceWhenNotPlaying

	|terniLapilli|
	terniLapilli := TerniLapilli new.	terniLapilli putXAt: 0@0.
	terniLapilli putOAt: 0@1.
	terniLapilli putXAt: 0@2.
	terniLapilli putOAt: 1@0.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 1@2.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:18:35'!
test24OCannotMoveAPieceWhenNotPlaying

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:20:09'!
test25XCannotMoveAPieceBeforePuttingThreePieces

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:20:59'!
test26OCannotMoveAPieceBeforePuttingThreePieces

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:23:08'!
test27CannotMoveAnXToAnOcuppiedPosition

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:23:20'!
test28CannotMoveAnOToAnOcuppiedPosition

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:24:35'!
test29CannotMoveAnXOutOfTheBoard

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:24:46'!
test30CannotMoveAnOOutOfTheBoard

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:25:49'!
test31PieceMovedByXIsAtTheRightPlace

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:25:54'!
test32PieceMovedByOIsAtTheRightPlace

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:26:56'!
test33MovingAnXThatAlignsThreeXVerticallyMakesPlayerXWin

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 0@0.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putOAt: 2@1.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 0@1.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putOAt: 2@2.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 0@2.
	self assert: terniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:27:13'!
test34MovingAnXThatAlignsThreeXHorizontallyMakesPlayerXWin

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 1@1.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putOAt: 0@0.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 2@1.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putOAt: 2@0.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 0@1.
	self assert: terniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:27:30'!
test35MovingAnXThatAlignsThreeXDiagonallyIncreasingMakesPlayerXWin

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 2@2.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putOAt: 1@0.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 0@0.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putOAt: 0@1.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 1@1.
	self assert: terniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:27:43'!
test36MovingAnXThatAlignsThreeXDiagonallyDecreasingMakesPlayerXWin

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 0@2.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putOAt: 1@0.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 2@0.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putOAt: 0@1.
	self deny: terniLapilli hasPlayerXWon.
	terniLapilli putXAt: 1@1.
	self assert: terniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:27:58'!
test37MovingAnOThatAlignsThreeOVerticallyMakesPlayerOWin

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 1@1.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 0@0.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 2@1.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 0@1.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 2@2.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 0@2.
	self assert: terniLapilli hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:28:15'!
test38MovingAnOThatAlignsThreeOHorizontallyMakesPlayerOWin

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 2@2.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 1@1.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 0@0.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 2@1.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 2@0.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 0@1.
	self assert: terniLapilli hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:28:33'!
test39MovingAnOThatAlignsThreeODiagonallyIncreasingMakesPlayerOWin

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 1@2.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 2@2.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 1@0.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 0@0.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 0@1.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 1@1.
	self assert: terniLapilli hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:28:53'!
test40MovingAnOThatAlignsThreeODiagonallyDecreasingMakesPlayerOWin

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self deny: terniLapilli hasPlayerOWon.	
	terniLapilli  putXAt: 0@0.
	
	self deny: terniLapilli hasPlayerOWon.

	terniLapilli putOAt: 0@2.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 1@0.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 2@0.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putXAt: 0@1.
	self deny: terniLapilli hasPlayerOWon.
	terniLapilli putOAt: 1@1.
	self assert: terniLapilli hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:47:10'!
test41CannotMoveAnXWhenGameIsOver

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/14/2019 09:47:20'!
test42CannotMoveAnOWhenGameIsOver

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'isPlayingX piecesPutByX piecesPutByO wonX wonO playerOWon playerXWon'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 17:21:01'!
OAt: aPosition

	^piecesPutByO includes: aPosition.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 17:20:41'!
XAt: aPosition

	^piecesPutByX includes: aPosition.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 19:02:28'!
hasPlayerOWon

	^(self piecesAlignedVertically: piecesPutByO) or:
	(self piecesAlignedHorizontally: piecesPutByO) or:
	(self piecesAlignedDiagonallyAndIncreasing: piecesPutByO) or:
	(self piecesAlignedDiagonallyAndDecreasing: piecesPutByO).

	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 19:02:51'!
hasPlayerXWon

	^(self piecesAlignedVertically: piecesPutByX) or:
	(self piecesAlignedHorizontally: piecesPutByX) or:
	(self piecesAlignedDiagonallyAndIncreasing: piecesPutByX) or:
	(self piecesAlignedDiagonallyAndDecreasing: piecesPutByX).! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 19:03:02'!
initialize

	isPlayingX := true.
	piecesPutByX := Set new.
	piecesPutByO := Set new.
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 18:55:19'!
isInBoard: aPosition

	^aPosition x >= 0 and: aPosition x <= 2 and: aPosition y >= 0 and: aPosition y <= 2.
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

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 19:25:58'!
piecesAlignedDiagonallyAndDecreasing: aSetOfPieces

	aSetOfPieces size = 3 ifFalse: [^false].
	^aSetOfPieces allSatisfy: [:position | 2 - position x = position y]! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 19:25:53'!
piecesAlignedDiagonallyAndIncreasing: aSetOfPieces

	aSetOfPieces size = 3 ifFalse: [^false].
	^aSetOfPieces allSatisfy: [:position | position x = position y]! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 19:25:20'!
piecesAlignedHorizontally: aSetOfPieces

	|somePosition|
	aSetOfPieces size = 3 ifFalse: [^false].
	somePosition := aSetOfPieces detect: [:anyPosition | true].
	^aSetOfPieces allSatisfy: [:position | position y = somePosition y]! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 19:25:36'!
piecesAlignedVertically: aSetOfPieces

	|somePosition|
	aSetOfPieces size = 3 ifFalse: [^false].
	somePosition := aSetOfPieces detect: [:anyPosition | true].
	^aSetOfPieces allSatisfy: [:position | position x = somePosition x]! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 17:24:48'!
putOAt: aPosition

	self isPlayingX ifTrue: [self error: self class playerCannotMoveErrorMessage.].
	(self isInBoard: aPosition) ifFalse: [self error: self class piecePutOutOfBoardErrorMessage].
	((self XAt: aPosition) or: (self OAt: aPosition)) ifTrue: [self error: self class positionTakenTwiceErrorMessage.].
	piecesPutByO add: aPosition.
	isPlayingX := true.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/11/2019 19:03:26'!
putXAt: aPosition

	self isPlayingX ifFalse: [self error: self class playerCannotMoveErrorMessage.].
	(self isInBoard: aPosition) ifFalse: [self error: self class piecePutOutOfBoardErrorMessage].
	((self XAt: aPosition) or: (self OAt: aPosition)) ifTrue: [self error: self class positionTakenTwiceErrorMessage.].
	piecesPutByX add: aPosition.
	isPlayingX := false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Exercise'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'errorMessage' stamp: 'DH 10/14/2019 12:26:09'!
gameIsOverErrorMessage

	^'Jugada hecha luego de haber terminado el juego.'! !

!TerniLapilli class methodsFor: 'errorMessage' stamp: 'DH 10/14/2019 13:45:02'!
noPiecesLeftErrorMessage

	^'Ficha puesta por cuarta vez.'! !

!TerniLapilli class methodsFor: 'errorMessage' stamp: 'damian y mateo 10/11/2019 17:08:12'!
piecePutOutOfBoardErrorMessage

	^'Ficha puesta fuera del tablero'! !

!TerniLapilli class methodsFor: 'errorMessage' stamp: 'damian y mateo 10/10/2019 18:28:56'!
playerCannotMoveErrorMessage

	^'No es el turno del jugador'! !

!TerniLapilli class methodsFor: 'errorMessage' stamp: 'damian y mateo 10/11/2019 16:58:30'!
positionTakenTwiceErrorMessage

	^'Posicion del tablero marcada por segunda vez.'! !
