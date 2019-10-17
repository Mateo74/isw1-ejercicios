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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 19:28:36'!
test23XCannotMoveAPieceWhenNotPlaying

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 0@0.
	terniLapilli putOAt: 0@1.
	terniLapilli putXAt: 0@2.
	terniLapilli putOAt: 1@0.
	terniLapilli putXAt: 1@1.
	
	self should: [terniLapilli moveXFrom: 1@1 to: 2@1.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | 
		self assert: TerniLapilli notTheTurnOfPlayerErrorMessage equals: anError messageText.
		self deny: (terniLapilli XAt: 2@1).
	]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 19:28:26'!
test24OCannotMoveAPieceWhenNotPlaying

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 0@0.
	terniLapilli putOAt: 0@1.
	terniLapilli putXAt: 0@2.
	terniLapilli putOAt: 1@0.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 1@2.
	
	self should: [terniLapilli moveOFrom: 1@0 to: 2@0.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | 
		self assert: TerniLapilli notTheTurnOfPlayerErrorMessage equals: anError messageText.
		self deny: (terniLapilli OAt: 2@0).
	]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 19:31:49'!
test25XCannotMoveAPieceBeforePuttingThreePieces

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 0@0.
	terniLapilli putOAt: 0@1.
	self should: [terniLapilli moveXFrom: 0@0 to: 1@0.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: TerniLapilli cannotMoveBeforePuttingThreePiecesErrorMessage equals: anError messageText.
		self deny: (terniLapilli XAt: 1@0).
	]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 19:33:13'!
test26OCannotMoveAPieceBeforePuttingThreePieces

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 0@0.
	terniLapilli putOAt: 0@1.
	terniLapilli  putXAt: 0@2.
	self should: [terniLapilli moveOFrom: 0@1 to: 1@1.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: TerniLapilli cannotMoveBeforePuttingThreePiecesErrorMessage equals: anError messageText.
		self deny: (terniLapilli OAt: 1@1).
	]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 20:37:40'!
test27CannotMoveAnXToAnOcuppiedPosition

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 0@0.
	terniLapilli putOAt: 0@1.
	terniLapilli putXAt: 0@2.
	terniLapilli putOAt: 1@0.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 1@2.
	
	self should: [terniLapilli moveXFrom: 0@0 to: 1@1.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: TerniLapilli positionTakenTwiceErrorMessage equals: anError messageText.
		self deny: (terniLapilli XAt: 1@1).
	]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 20:37:48'!
test28CannotMoveAnOToAnOcuppiedPosition

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 0@0.
	terniLapilli putOAt: 0@1.
	terniLapilli putXAt: 0@2.
	terniLapilli putOAt: 1@0.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 1@2.
	terniLapilli moveXFrom: 1@1 to: 2@1.
	
	self should: [terniLapilli moveOFrom: 1@0 to: 0@0.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: TerniLapilli positionTakenTwiceErrorMessage equals: anError messageText.
		self deny: (terniLapilli OAt: 0@0).
	]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 19:41:44'!
test29CannotMoveAnXOutOfTheBoard

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 0@0.
	terniLapilli putOAt: 0@1.
	terniLapilli putXAt: 0@2.
	terniLapilli putOAt: 1@0.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 1@2.
	
	self should: [terniLapilli moveXFrom: 0@0 to: 0@-1.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: TerniLapilli pieceMovedOutOfBoardErrorMessage equals: anError messageText.
		self deny: (terniLapilli XAt: 0@-1).
	]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 19:42:53'!
test30CannotMoveAnOOutOfTheBoard

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 0@0.
	terniLapilli putOAt: 0@1.
	terniLapilli putXAt: 0@2.
	terniLapilli putOAt: 1@0.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 1@2.
	terniLapilli moveXFrom: 1@1 to: 2@1.
	
	self should: [terniLapilli moveOFrom: 1@2 to: 1@3.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: TerniLapilli pieceMovedOutOfBoardErrorMessage equals: anError messageText.
		self deny: (terniLapilli OAt: 1@3).
	]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 19:50:35'!
test31PieceMovedByXIsAtTheRightPlace

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 0@0.
	terniLapilli putOAt: 0@1.
	terniLapilli putXAt: 0@2.
	terniLapilli putOAt: 1@0.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 1@2.
	terniLapilli moveXFrom: 1@1 to: 2@1.
	
	self assert: (terniLapilli XAt: 2@1).
	self deny: (terniLapilli XAt: 1@1).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 19:45:27'!
test32PieceMovedByOIsAtTheRightPlace

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 0@0.
	terniLapilli putOAt: 0@1.
	terniLapilli putXAt: 0@2.
	terniLapilli putOAt: 1@0.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 1@2.
	terniLapilli moveXFrom: 1@1 to: 2@1.
	terniLapilli moveOFrom: 1@2 to: 2@2.
	
	self assert: (terniLapilli OAt: 2@2).
	self deny: (terniLapilli OAt: 1@2).! !

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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 19:49:33'!
test41CannotMoveAnXWhenGameIsOver

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	
	self putPiecesToFinishGame: terniLapilli.
	
	self should: [terniLapilli moveXFrom: 0@2 to: 1@2.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: TerniLapilli gameIsOverErrorMessage equals: anError messageText.
		self deny: (terniLapilli XAt: 1@2).
	]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 19:50:26'!
test42CannotMoveAnOWhenGameIsOver

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	
	self putPiecesToFinishGame: terniLapilli.
	
	self should: [terniLapilli moveOFrom: 2@0 to: 2@1.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: TerniLapilli gameIsOverErrorMessage equals: anError messageText.
		self deny: (terniLapilli OAt: 2@1).
	]! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'gameBoard isPlayingX'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 20:43:49'!
hasPlayerOWon

	^self state hasPlayerOWon! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 20:44:21'!
hasPlayerXWon

	^self state hasPlayerXWon! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 20:45:04'!
isOver

	^self state isOver! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 20:45:31'!
isPlayingO

	^isPlayingX not.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 20:45:38'!
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

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 20:46:11'!
putOAt: aPosition

	self state putOAt: aPosition! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/16/2019 20:46:24'!
putXAt: aPosition

	self state putXAt: aPosition! !


!TerniLapilli methodsFor: 'initialization' stamp: 'damian y mateo 10/16/2019 20:40:40'!
initialize

	gameBoard := TerniLapilliBoard new.
	isPlayingX := true.! !


!TerniLapilli methodsFor: 'queries' stamp: 'damian y mateo 10/16/2019 20:41:52'!
OAt: aPosition

	^gameBoard OAt: aPosition.! !

!TerniLapilli methodsFor: 'queries' stamp: 'damian y mateo 10/16/2019 20:42:11'!
XAt: aPosition

	^gameBoard XAt: aPosition.! !


!TerniLapilli methodsFor: 'private' stamp: 'damian y mateo 10/16/2019 21:13:56'!
putOAtWhenOPuttingPieces: aPosition

	gameBoard putOAt: aPosition.
	isPlayingX := true.! !

!TerniLapilli methodsFor: 'private' stamp: 'damian y mateo 10/16/2019 21:13:34'!
putXAtWhenXPuttingPieces: aPosition

	gameBoard putXAt: aPosition.
	isPlayingX := false.! !

!TerniLapilli methodsFor: 'private' stamp: 'damian y mateo 10/16/2019 20:47:04'!
state

	^TerniLapilliState stateFor: self! !

!TerniLapilli methodsFor: 'private' stamp: 'damian y mateo 10/16/2019 21:24:01'!
whenOIsMovingPiecesMoveOFrom: aPosition to: aNewPosition

	gameBoard moveOFrom: aPosition to: aNewPosition! !

!TerniLapilli methodsFor: 'private' stamp: 'damian y mateo 10/16/2019 21:26:53'!
whenXIsMovingPiecesMoveXFrom: aPosition to: aNewPosition

	gameBoard moveXFrom: aPosition to: aNewPosition! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Exercise'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'errorMessage' stamp: 'damian y mateo 10/16/2019 21:17:38'!
cannotMoveBeforePuttingThreePiecesErrorMessage

	^'Pieza movida antes de haber puesto tres piezas.'! !

!TerniLapilli class methodsFor: 'errorMessage' stamp: 'DH 10/14/2019 12:26:09'!
gameIsOverErrorMessage

	^'Jugada hecha luego de haber terminado el juego.'! !

!TerniLapilli class methodsFor: 'errorMessage' stamp: 'damian y mateo 10/16/2019 20:35:14'!
invalidPieceMovementErrorMessage

	^'Movimiento no permitido de una pieza.'! !

!TerniLapilli class methodsFor: 'errorMessage' stamp: 'DH 10/14/2019 13:45:02'!
noPiecesLeftErrorMessage

	^'Ficha puesta por cuarta vez.'! !

!TerniLapilli class methodsFor: 'errorMessage' stamp: 'damian y mateo 10/16/2019 20:33:11'!
notMovingTheCorrectPieceErrorMessage

	^'Se trato de mover una pieza desde una posicion vacía o donde hay una pieza del oponente.'! !

!TerniLapilli class methodsFor: 'errorMessage' stamp: 'damian y mateo 10/16/2019 19:25:48'!
notTheTurnOfPlayerErrorMessage

	^'No es el turno del jugador'! !

!TerniLapilli class methodsFor: 'errorMessage' stamp: 'damian y mateo 10/16/2019 19:22:33'!
pieceMovedOutOfBoardErrorMessage

	^'Ficha movida hacia fuera del tablero'! !

!TerniLapilli class methodsFor: 'errorMessage' stamp: 'damian y mateo 10/16/2019 19:22:44'!
piecePutOutOfBoardErrorMessage

	^'Ficha puesta fuera del tablero'! !

!TerniLapilli class methodsFor: 'errorMessage' stamp: 'damian y mateo 10/16/2019 19:22:58'!
positionTakenTwiceErrorMessage

	^'Posicion del tablero marcada por segunda vez.'! !


!classDefinition: #TerniLapilliBoard category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliBoard
	instanceVariableNames: 'positionsOfX positionsOfO'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliBoard methodsFor: 'moving' stamp: 'damian y mateo 10/16/2019 20:31:07'!
moveOFrom: aPositionOfO to: aNewPosition

	self makeMovementFrom: aPositionOfO to: aNewPosition in: positionsOfO.
	! !

!TerniLapilliBoard methodsFor: 'moving' stamp: 'damian y mateo 10/16/2019 20:30:51'!
moveXFrom: aPositionOfX to: aNewPosition

	self makeMovementFrom: aPositionOfX to: aNewPosition in: positionsOfX.
	! !


!TerniLapilliBoard methodsFor: 'putting' stamp: 'damian y mateo 10/16/2019 20:34:44'!
putOAt: aPosition

	self add: aPosition to: positionsOfO
		errorMessageWhenTaken: TerniLapilli positionTakenTwiceErrorMessage
		errorMessageWhenNotInBoard: TerniLapilli piecePutOutOfBoardErrorMessage.! !

!TerniLapilliBoard methodsFor: 'putting' stamp: 'damian y mateo 10/16/2019 20:34:39'!
putXAt: aPosition

	self add: aPosition to: positionsOfX
		errorMessageWhenTaken: TerniLapilli positionTakenTwiceErrorMessage
		errorMessageWhenNotInBoard: TerniLapilli piecePutOutOfBoardErrorMessage.! !


!TerniLapilliBoard methodsFor: 'queries' stamp: 'damian y mateo 10/16/2019 20:35:58'!
OAt: aPosition

	^positionsOfO includes: aPosition! !

!TerniLapilliBoard methodsFor: 'queries' stamp: 'damian y mateo 10/16/2019 20:39:03'!
XAt: aPosition

	^positionsOfX includes: aPosition! !

!TerniLapilliBoard methodsFor: 'queries' stamp: 'damian y mateo 10/16/2019 21:33:07'!
hasLessThanThreeO

	^positionsOfO size < 3! !

!TerniLapilliBoard methodsFor: 'queries' stamp: 'damian y mateo 10/16/2019 21:32:21'!
hasLessThanThreeX

	^positionsOfX size < 3! !

!TerniLapilliBoard methodsFor: 'queries' stamp: 'damian y mateo 10/16/2019 21:39:03'!
hasThreeAlignedO

	^self hasThreeAligned: positionsOfO! !

!TerniLapilliBoard methodsFor: 'queries' stamp: 'damian y mateo 10/16/2019 21:38:53'!
hasThreeAlignedX

	^self hasThreeAligned: positionsOfX! !


!TerniLapilliBoard methodsFor: 'initialization' stamp: 'damian y mateo 10/16/2019 19:53:14'!
initialize

	positionsOfX := Set new.
	positionsOfO := Set new.! !


!TerniLapilliBoard methodsFor: 'private' stamp: 'damian y mateo 10/16/2019 20:16:10'!
add: aPosition
to: aSetOfPositions
errorMessageWhenTaken: aPositionTakenErrorMessage
errorMessageWhenNotInBoard: aPositionNotInBoardErrorMessage

	(self isTaken: aPosition) ifTrue: [self error: aPositionTakenErrorMessage.].
	(self isInBoard: aPosition) ifFalse: [self error: aPositionNotInBoardErrorMessage.].
	aSetOfPositions add: aPosition.! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'damian y mateo 10/16/2019 20:30:22'!
allowedToMoveFrom: aPosition to: aNewPosition

	^true! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'damian y mateo 10/16/2019 21:37:08'!
hasThreeAligned: aSetOfPositions

	^(self hasThreeVerticallyAligned: aSetOfPositions)
	or: (self hasThreeHorizontallyAligned: aSetOfPositions)
	or: (self hasThreeDiagonallyIncreasingAligned: aSetOfPositions)
	or: (self hasThreeDiagonallyDecreasingAligned: aSetOfPositions)! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'damian y mateo 10/16/2019 21:35:27'!
hasThreeDiagonallyDecreasingAligned: aSetOfPositions

	^true! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'damian y mateo 10/16/2019 21:35:22'!
hasThreeDiagonallyIncreasingAligned: aSetOfPositions

	^true! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'damian y mateo 10/16/2019 21:35:02'!
hasThreeHorizontallyAligned: aSetOfPositions

	^true! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'damian y mateo 10/16/2019 21:34:38'!
hasThreeVerticallyAligned: aSetOfPositions

	^true! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'damian y mateo 10/16/2019 19:59:04'!
isInBoard: aPosition

	^0 <= aPosition x and: aPosition x <= 2 and: 0 <= aPosition y and: aPosition y <= 2.! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'damian y mateo 10/16/2019 19:59:53'!
isTaken: aPosition

	^(self XAt: aPosition) or: (self OAt: aPosition).! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'damian y mateo 10/16/2019 20:34:28'!
makeMovementFrom: aPosition to: aNewPosition in: aSetOfPositions

	aSetOfPositions remove: aPosition ifAbsent: [self error: TerniLapilli notMovingTheCorrectPieceErrorMessage.].
	(self allowedToMoveFrom: aPosition to: aNewPosition) ifFalse: [self error: TerniLapilli invalidPieceMovementErrorMessage.].
	self add: aNewPosition to: aSetOfPositions
		errorMessageWhenTaken: TerniLapilli positionTakenTwiceErrorMessage
		errorMessageWhenNotInBoard: TerniLapilli pieceMovedOutOfBoardErrorMessage.! !


!classDefinition: #TerniLapilliState category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'terniLapilliGame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:28:56'!
hasPlayerOWon

	^self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:29:02'!
hasPlayerXWon

	^self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:28:45'!
moveOFrom: aPosition to: aNewPosition

	^self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:28:42'!
moveXFrom: aPosition to: aNewPosition

	^self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 20:56:27'!
putOAt: aPosition

	^self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 20:56:24'!
putXAt: aPosition

	^self subclassResponsibility ! !


!TerniLapilliState methodsFor: 'initialization' stamp: 'damian y mateo 10/16/2019 20:55:09'!
initializeFor: aTerniLapilliGame

	terniLapilliGame := aTerniLapilliGame! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: #'TerniLapilli-Exercise'!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'instance creation' stamp: 'damian y mateo 10/16/2019 20:51:51'!
for: aTerniLapilliGame

	^self new initializeFor: aTerniLapilliGame! !


!TerniLapilliState class methodsFor: 'state detection' stamp: 'damian y mateo 10/16/2019 20:52:12'!
canHandle: aTerniLapilliGame

	^self subclassResponsibility! !

!TerniLapilliState class methodsFor: 'state detection' stamp: 'damian y mateo 10/16/2019 20:51:10'!
stateFor: aTerniLapilliGame

	^(self subclasses detect: [:aTerniLapilliStateClass | aTerniLapilliStateClass canHandle: aTerniLapilliGame]) for: aTerniLapilliGame ! !


!classDefinition: #OMovingPiecesState category: #'TerniLapilli-Exercise'!
TerniLapilliState subclass: #OMovingPiecesState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!OMovingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:20:58'!
hasPlayerOWon

	^false! !

!OMovingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:20:58'!
hasPlayerXWon

	^false! !

!OMovingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:24:12'!
moveOFrom: aPosition to: aNewPosition

	terniLapilliGame whenOIsMovingPiecesMoveOFrom: aPosition to: aNewPosition.! !

!OMovingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:22:13'!
moveXFrom: aPosition to: aNewPosition

	self error: TerniLapilli notTheTurnOfPlayerErrorMessage ! !

!OMovingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:22:54'!
putOAt: aPosition

	self error: TerniLapilli noPiecesLeftErrorMessage! !

!OMovingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:22:25'!
putXAt: aPosition

	self error: TerniLapilli notTheTurnOfPlayerErrorMessage ! !


!classDefinition: #OPuttingPiecesState category: #'TerniLapilli-Exercise'!
TerniLapilliState subclass: #OPuttingPiecesState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!OPuttingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:15:37'!
hasPlayerOWon

	^false! !

!OPuttingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:15:32'!
hasPlayerXWon

	^false! !

!OPuttingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:19:29'!
moveOFrom: aPosition to: aNewPosition

	self error: TerniLapilli cannotMoveBeforePuttingThreePiecesErrorMessage! !

!OPuttingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:19:22'!
moveXFrom: aPosition to: aNewPosition

	self error: TerniLapilli notTheTurnOfPlayerErrorMessage ! !

!OPuttingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:15:19'!
putOAt: aPosition

	terniLapilliGame putOAtWhenOPuttingPieces: aPosition! !

!OPuttingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:14:54'!
putXAt: aPosition

	self error: TerniLapilli notTheTurnOfPlayerErrorMessage! !


!classDefinition: #OWonState category: #'TerniLapilli-Exercise'!
TerniLapilliState subclass: #OWonState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!OWonState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:28:08'!
hasPlayerOWon

	^true! !

!OWonState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:28:13'!
hasPlayerXWon

	^false! !

!OWonState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:28:02'!
moveOFrom: aPosition to: aNewPosition

	self error: TerniLapilli gameIsOverErrorMessage ! !

!OWonState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:28:02'!
moveXFrom: aPosition to: aNewPosition

	self error: TerniLapilli gameIsOverErrorMessage ! !

!OWonState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:28:02'!
putOAt: aPosition

	self error: TerniLapilli gameIsOverErrorMessage  ! !

!OWonState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:28:02'!
putXAt: aPosition

	self error: TerniLapilli gameIsOverErrorMessage ! !


!classDefinition: #XMovingPiecesState category: #'TerniLapilli-Exercise'!
TerniLapilliState subclass: #XMovingPiecesState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!XMovingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:24:35'!
hasPlayerOWon

	^false! !

!XMovingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:24:35'!
hasPlayerXWon

	^false! !

!XMovingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:26:26'!
moveOFrom: aPosition to: aNewPosition

	self error: TerniLapilli notTheTurnOfPlayerErrorMessage! !

!XMovingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:26:03'!
moveXFrom: aPosition to: aNewPosition

	terniLapilliGame whenXIsMovingPiecesMoveXFrom: aPosition to: aNewPosition.! !

!XMovingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:25:31'!
putOAt: aPosition

	self error: TerniLapilli notTheTurnOfPlayerErrorMessage ! !

!XMovingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:25:27'!
putXAt: aPosition

	self error: TerniLapilli noPiecesLeftErrorMessage! !


!classDefinition: #XPuttingPiecesState category: #'TerniLapilli-Exercise'!
TerniLapilliState subclass: #XPuttingPiecesState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!XPuttingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:10:14'!
hasPlayerOWon

	^false! !

!XPuttingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:10:20'!
hasPlayerXWon

	^false! !

!XPuttingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:18:42'!
moveOFrom: aPosition to: aNewPosition

	self error: TerniLapilli notTheTurnOfPlayerErrorMessage ! !

!XPuttingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:18:17'!
moveXFrom: aPosition to: aNewPosition

	self error: TerniLapilli cannotMoveBeforePuttingThreePiecesErrorMessage! !

!XPuttingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:11:50'!
putOAt: aPosition

	self error: TerniLapilli notTheTurnOfPlayerErrorMessage! !

!XPuttingPiecesState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:12:54'!
putXAt: aPosition

	terniLapilliGame putXAtWhenXPuttingPieces: aPosition! !


!classDefinition: #XWonState category: #'TerniLapilli-Exercise'!
TerniLapilliState subclass: #XWonState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!XWonState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:27:11'!
hasPlayerOWon

	^false! !

!XWonState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:27:24'!
hasPlayerXWon

	^true! !

!XWonState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:27:39'!
moveOFrom: aPosition to: aNewPosition

	self error: TerniLapilli gameIsOverErrorMessage ! !

!XWonState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:27:44'!
moveXFrom: aPosition to: aNewPosition

	self error: TerniLapilli gameIsOverErrorMessage ! !

!XWonState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:27:48'!
putOAt: aPosition

	self error: TerniLapilli gameIsOverErrorMessage  ! !

!XWonState methodsFor: 'game operations' stamp: 'damian y mateo 10/16/2019 21:27:51'!
putXAt: aPosition

	self error: TerniLapilli gameIsOverErrorMessage ! !
