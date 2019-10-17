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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:07:09'!
test02OCannotMoveWhenGameStarts

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	
	self should: [terniLapilli putOAt: 0@0.]
	raise: Error - MessageNotUnderstood
	withExceptionDo:
	[
		:anError |
		self assert: anError messageText equals: TerniLapilli notTheTurnOfPlayerErrorMessage.
		self deny: (terniLapilli OAt: 0@0).
	]
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:07:36'!
test03IsPlayingOAfterXMakesAMove

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 0@0.
	
	self assert: terniLapilli isPlayingO.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:13:09'!
test04XCannotMoveTwiceInARow

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 0@0.
	
	self should: [terniLapilli  putXAt: 1@0.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:
	[
		:anError | 
		self assert: anError messageText equals: TerniLapilli notTheTurnOfPlayerErrorMessage.
		self deny: (terniLapilli XAt: 1@0).
	]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:13:27'!
test05IsPlayingXAfterOMakesAMove

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 0@0.
	terniLapilli putOAt: 1@0.

	self assert: terniLapilli isPlayingX.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:13:58'!
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
	].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:14:14'!
test07PiecePutByXIsAtTheRightPlace

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 1@2.
	self assert: (terniLapilli XAt: 1@2).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:14:35'!
test08PiecePutByOIsAtTheRightPlace

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 1@2.
	terniLapilli  putOAt: 0@1.
	
	self assert: (terniLapilli OAt: 0@1).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:15:13'!
test09CannotPutXOutOfBoard
	|terniLapilli|
	terniLapilli := TerniLapilli new.
	
	self should: [terniLapilli  putXAt: 3@1.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:
	[
		:anError | 
		self assert: anError messageText equals: TerniLapilli piecePutOutOfBoardErrorMessage.
		self deny: (terniLapilli XAt: 3@1).
	]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:15:50'!
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
		self deny: (terniLapilli XAt: -2@0).
	]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:16:20'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:16:39'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:16:59'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:17:23'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:17:50'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:18:23'!
test19CannotPutAnXWhenGameIsOver

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	
	self putPiecesToFinishGame: terniLapilli.

	self should: [terniLapilli putXAt: 1@1.] raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: TerniLapilli gameIsOverErrorMessage equals: anError messageText.
		self deny: (terniLapilli XAt: 1@1).
	]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:18:29'!
test20CannotPutAnOWhenGameIsOver

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	self putPiecesToFinishGame: terniLapilli.
	
	self should: [terniLapilli putOAt: 1@1.] raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: TerniLapilli gameIsOverErrorMessage equals: anError messageText.
		self deny: (terniLapilli OAt: 1@1).
	]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:05:38'!
test21XCannotPutAPieceFourTimes

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 0@0.
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:22:36'!
test22OCannotPutAPieceFourTimes

	|terniLapilli|
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 0@0.
	terniLapilli putOAt: 0@1.
	terniLapilli putXAt: 0@2.
	terniLapilli putOAt: 1@0.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 1@2.
	terniLapilli moveXFrom: 1@1 to: 2@1.
	
	self should: [terniLapilli putOAt: 2@0] raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: TerniLapilli noPiecesLeftErrorMessage equals: anError messageText.
		self deny: (terniLapilli OAt: 2@0).
	]! !

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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:30:30'!
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
		self assert: (terniLapilli XAt: 0@0).
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:37:52'!
test33MovingAnXThatAlignsThreeXVerticallyMakesPlayerXWin

	"Falto implementar"! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:38:08'!
test34MovingAnXThatAlignsThreeXHorizontallyMakesPlayerXWin

	"Falto implementar"! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:38:15'!
test35MovingAnXThatAlignsThreeXDiagonallyIncreasingMakesPlayerXWin

	"Falto implementar"! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:38:23'!
test36MovingAnXThatAlignsThreeXDiagonallyDecreasingMakesPlayerXWin

	"Falto implementar"! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:38:34'!
test37MovingAnOThatAlignsThreeOVerticallyMakesPlayerOWin

	"Falto implementar"! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:38:43'!
test38MovingAnOThatAlignsThreeOHorizontallyMakesPlayerOWin

	"Falto implementar"! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:38:53'!
test39MovingAnOThatAlignsThreeODiagonallyIncreasingMakesPlayerOWin

	"Falto implementar"! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DH 10/17/2019 00:39:04'!
test40MovingAnOThatAlignsThreeODiagonallyDecreasingMakesPlayerOWin

	"Falto implementar"! !

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
	instanceVariableNames: 'gameBoard shouldPlayX'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilli methodsFor: 'initialization' stamp: 'DH 10/17/2019 00:00:00'!
initialize

	gameBoard := TerniLapilliBoard new.
	shouldPlayX := true.! !


!TerniLapilli methodsFor: 'queries' stamp: 'damian y mateo 10/16/2019 20:41:52'!
OAt: aPosition

	^gameBoard OAt: aPosition.! !

!TerniLapilli methodsFor: 'queries' stamp: 'damian y mateo 10/16/2019 20:42:11'!
XAt: aPosition

	^gameBoard XAt: aPosition.! !

!TerniLapilli methodsFor: 'queries' stamp: 'DH 10/16/2019 23:51:50'!
hasPlayerOWon

	^gameBoard hasThreeAlignedO! !

!TerniLapilli methodsFor: 'queries' stamp: 'DH 10/16/2019 23:51:40'!
hasPlayerXWon

	^gameBoard hasThreeAlignedX! !

!TerniLapilli methodsFor: 'queries' stamp: 'DH 10/16/2019 23:52:15'!
isOver

	^self hasPlayerXWon or: self hasPlayerOWon! !

!TerniLapilli methodsFor: 'queries' stamp: 'DH 10/17/2019 00:00:16'!
isPlayingO

	^shouldPlayX not and: self isOver not! !

!TerniLapilli methodsFor: 'queries' stamp: 'DH 10/17/2019 00:00:26'!
isPlayingX

	^shouldPlayX and: self isOver not! !

!TerniLapilli methodsFor: 'queries' stamp: 'DH 10/16/2019 23:57:28'!
playerOHasPutThreePieces

	^gameBoard hasLessThanThreeO not! !

!TerniLapilli methodsFor: 'queries' stamp: 'DH 10/16/2019 23:57:21'!
playerXHasPutThreePieces

	^gameBoard hasLessThanThreeX not! !


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


!TerniLapilli methodsFor: 'putting' stamp: 'DH 10/17/2019 00:10:29'!
putOAt: aPosition

	self state putOAt: aPosition.
	shouldPlayX := true.! !

!TerniLapilli methodsFor: 'putting' stamp: 'DH 10/17/2019 00:10:20'!
putXAt: aPosition

	self state putXAt: aPosition.
	shouldPlayX := false! !


!TerniLapilli methodsFor: 'moving' stamp: 'DH 10/17/2019 00:24:25'!
moveOFrom: aPosition to: aNewPosition

	self state moveOFrom: aPosition to: aNewPosition.
	shouldPlayX := true! !

!TerniLapilli methodsFor: 'moving' stamp: 'DH 10/17/2019 00:24:02'!
moveXFrom: aPosition to: aNewPosition

	self state moveXFrom: aPosition to: aNewPosition.
	shouldPlayX := false! !

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


!TerniLapilliBoard methodsFor: 'putting' stamp: 'DH 10/17/2019 00:36:51'!
putOAt: aPosition

	self add: aPosition to: positionsOfO
		errorMessageWhenTaken: TerniLapilli positionTakenTwiceErrorMessage
		errorMessageWhenNotInBoard: TerniLapilli piecePutOutOfBoardErrorMessage
		onAnyErrorDo: []! !

!TerniLapilliBoard methodsFor: 'putting' stamp: 'DH 10/17/2019 00:36:40'!
putXAt: aPosition

	self add: aPosition to: positionsOfX
		errorMessageWhenTaken: TerniLapilli positionTakenTwiceErrorMessage
		errorMessageWhenNotInBoard: TerniLapilli piecePutOutOfBoardErrorMessage
		onAnyErrorDo: []! !


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


!TerniLapilliBoard methodsFor: 'private' stamp: 'DH 10/17/2019 00:35:24'!
add: aPosition
to: aSetOfPositions
errorMessageWhenTaken: aPositionTakenErrorMessage
errorMessageWhenNotInBoard: aPositionNotInBoardErrorMessage
onAnyErrorDo: aBlockToHandleError

	(self isTaken: aPosition) ifTrue: [
		aBlockToHandleError value.
		self error: aPositionTakenErrorMessage.
	].
	(self isInBoard: aPosition) ifFalse: [
		aBlockToHandleError value.
		self error: aPositionNotInBoardErrorMessage.
	].
	aSetOfPositions add: aPosition.! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'DH 10/17/2019 00:41:59'!
allowedToMoveFrom: aPosition to: aNewPosition

	"Falta implementar. Hay que ver que aNewPosition este a la derecha, izquierda, arriba o abajo de aPosition,
	o que aPosition sea 1@1 y aNewPosition no sea 1@1, o viceversa. No hace falta chequear que aNewPosition
	esté dentro del tablero, si pasa eso va a saltar despues."
	^true! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'damian y mateo 10/16/2019 21:37:08'!
hasThreeAligned: aSetOfPositions

	^(self hasThreeVerticallyAligned: aSetOfPositions)
	or: (self hasThreeHorizontallyAligned: aSetOfPositions)
	or: (self hasThreeDiagonallyIncreasingAligned: aSetOfPositions)
	or: (self hasThreeDiagonallyDecreasingAligned: aSetOfPositions)! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'DH 10/17/2019 00:12:26'!
hasThreeDiagonallyDecreasingAligned: aSetOfPositions

	^aSetOfPositions size = 3 and: (aSetOfPositions allSatisfy: [:aPosition | aPosition x = (2 - aPosition y)])! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'DH 10/16/2019 23:35:54'!
hasThreeDiagonallyIncreasingAligned: aSetOfPositions

	^aSetOfPositions size = 3 and: (aSetOfPositions allSatisfy: [:aPosition | aPosition x = aPosition y])! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'DH 10/16/2019 23:43:04'!
hasThreeHorizontallyAligned: aSetOfPositions

	^self theSet: aSetOfPositions hasThreePositionsWithSameCoordinate: #y! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'DH 10/16/2019 23:42:49'!
hasThreeVerticallyAligned: aSetOfPositions

	^self theSet: aSetOfPositions hasThreePositionsWithSameCoordinate: #x! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'damian y mateo 10/16/2019 19:59:04'!
isInBoard: aPosition

	^0 <= aPosition x and: aPosition x <= 2 and: 0 <= aPosition y and: aPosition y <= 2.! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'damian y mateo 10/16/2019 19:59:53'!
isTaken: aPosition

	^(self XAt: aPosition) or: (self OAt: aPosition).! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'DH 10/17/2019 00:36:22'!
makeMovementFrom: aPosition to: aNewPosition in: aSetOfPositions

	aSetOfPositions remove: aPosition ifAbsent: [self error: TerniLapilli notMovingTheCorrectPieceErrorMessage.].
	(self allowedToMoveFrom: aPosition to: aNewPosition) ifFalse: [
		aSetOfPositions add: aPosition.
		self error: TerniLapilli invalidPieceMovementErrorMessage.
	].
	self add: aNewPosition to: aSetOfPositions
		errorMessageWhenTaken: TerniLapilli positionTakenTwiceErrorMessage
		errorMessageWhenNotInBoard: TerniLapilli pieceMovedOutOfBoardErrorMessage
		onAnyErrorDo: [aSetOfPositions add: aPosition.]! !

!TerniLapilliBoard methodsFor: 'private' stamp: 'DH 10/17/2019 00:08:46'!
theSet: aSetOfPositions hasThreePositionsWithSameCoordinate: aCoordinateSymbol

	|somePosition|
	somePosition := aSetOfPositions detect: [:aPosition | true] ifNone: [^false].
	^aSetOfPositions size = 3 and:
		(aSetOfPositions allSatisfy: [:aPosition | (aPosition perform: aCoordinateSymbol) = (somePosition perform: aCoordinateSymbol)])! !


!classDefinition: #TerniLapilliState category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'terniLapilliGame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OMovingPiecesState class' category: #'TerniLapilli-Exercise'!
OMovingPiecesState class
	instanceVariableNames: ''!

!OMovingPiecesState class methodsFor: 'state detection' stamp: 'DH 10/17/2019 00:01:32'!
canHandle: aTerniLapilliGame

	^aTerniLapilliGame isPlayingO and: aTerniLapilliGame playerOHasPutThreePieces! !


!classDefinition: #OPuttingPiecesState category: #'TerniLapilli-Exercise'!
TerniLapilliState subclass: #OPuttingPiecesState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OPuttingPiecesState class' category: #'TerniLapilli-Exercise'!
OPuttingPiecesState class
	instanceVariableNames: ''!

!OPuttingPiecesState class methodsFor: 'state detection' stamp: 'DH 10/17/2019 00:02:26'!
canHandle: aTerniLapilliGame

	^aTerniLapilliGame isPlayingO and: aTerniLapilliGame playerOHasPutThreePieces not! !


!classDefinition: #OWonState category: #'TerniLapilli-Exercise'!
TerniLapilliState subclass: #OWonState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OWonState class' category: #'TerniLapilli-Exercise'!
OWonState class
	instanceVariableNames: ''!

!OWonState class methodsFor: 'state detection' stamp: 'DH 10/17/2019 00:02:51'!
canHandle: aTerniLapilliGame

	^aTerniLapilliGame hasPlayerOWon! !


!classDefinition: #XMovingPiecesState category: #'TerniLapilli-Exercise'!
TerniLapilliState subclass: #XMovingPiecesState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XMovingPiecesState class' category: #'TerniLapilli-Exercise'!
XMovingPiecesState class
	instanceVariableNames: ''!

!XMovingPiecesState class methodsFor: 'state detection' stamp: 'DH 10/17/2019 00:03:33'!
canHandle: aTerniLapilliGame

	^aTerniLapilliGame isPlayingX and: aTerniLapilliGame playerXHasPutThreePieces! !


!classDefinition: #XPuttingPiecesState category: #'TerniLapilli-Exercise'!
TerniLapilliState subclass: #XPuttingPiecesState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XPuttingPiecesState class' category: #'TerniLapilli-Exercise'!
XPuttingPiecesState class
	instanceVariableNames: ''!

!XPuttingPiecesState class methodsFor: 'state detection' stamp: 'DH 10/17/2019 00:03:52'!
canHandle: aTerniLapilliGame

	^aTerniLapilliGame isPlayingX and: aTerniLapilliGame playerXHasPutThreePieces not! !


!classDefinition: #XWonState category: #'TerniLapilli-Exercise'!
TerniLapilliState subclass: #XWonState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XWonState class' category: #'TerniLapilli-Exercise'!
XWonState class
	instanceVariableNames: ''!

!XWonState class methodsFor: 'state detection' stamp: 'DH 10/17/2019 00:03:11'!
canHandle: aTerniLapilliGame

	^aTerniLapilliGame hasPlayerXWon! !
