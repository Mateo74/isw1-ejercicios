!classDefinition: #MarsRoverTest category: #'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/3/2019 21:26:23'!
test01RoverDoesNotChangePositionIfNoCommandsGiven

	|rover|
	rover := MarsRover at: 0@0.
	rover do: ''.
	self assert: 0@0 equals: rover position.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/3/2019 21:26:04'!
test02RoverDoesNotChangePositionIfNoCommandsGivenFromDifferentPosition

	|rover|
	rover := MarsRover at: 48@-95.
	rover do: ''.
	self assert: 48@-95 equals: rover position.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/3/2019 21:25:35'!
test03RoverMovesOneStepForward

	|rover|
	rover := MarsRover at: 8@8.
	rover do: 'f'.
	self assert: 8@9 equals: rover position.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 18:42:20'!
test04RoverMovesOneStepBackward

	|rover|
	rover := MarsRover at: 4@9.
	rover do: 'b'.
	self assert: 4@8 equals: rover position.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'mm 10/8/2019 20:08:35'!
test05RoverDoesNotAdvanceWhenTurningRight

	|rover|
	rover := MarsRover at: 25@-14.
	rover do: 'r'.
	self assert: 25@-14 equals: rover position.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'mm 10/8/2019 20:08:50'!
test06RoverDoesNotAdvanceWhenTurningLeft

	|rover|
	rover := MarsRover at: 51@-4.
	rover do: 'r'.
	self assert: 51@-4 equals: rover position.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:35:17'!
test07RoverPointsNorthIfNoCommandsGiven

	|rover|
	rover := MarsRover at: -20@-40.
	rover do: ''.
	self assert: #N equals: rover direction.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:35:29'!
test08RoverPointsEastAfterTurningRightOnce

	|rover|
	rover := MarsRover at: -20@-40.
	rover do: 'r'.
	self assert: #E equals: rover direction.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:35:34'!
test09RoverPointsWestAfterTurningLeftOnce

	|rover|
	rover := MarsRover at: -20@-40.
	rover do: 'l'.
	self assert: #W equals: rover direction.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:35:40'!
test10RoverPointsSouthAfterTurningRightTwice

	|rover|
	rover := MarsRover at: -20@-40.
	rover do: 'rr'.
	self assert: #S equals: rover direction.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:35:48'!
test11RoverPointsSouthAfterTurningLeftTwice

	|rover|
	rover := MarsRover at: -20@-40.
	rover do: 'll'.
	self assert: #S equals: rover direction.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:36:07'!
test12RoverMovesWestAfterTurningLeftAndMovingForward

	|rover|
	rover := MarsRover at: -20@-40.
	rover do: 'lf'.
	self assert: (-21@-40) equals: rover position.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:36:14'!
test13RoverMovesEastAfterTurningRightAndMovingForward

	|rover|
	rover := MarsRover at: -20@-40.
	rover do: 'rf'.
	self assert: (-19@-40) equals: rover position.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:36:19'!
test14RoverMovesNorthAfterTurningLeftTwiceAndMovingBackward

	|rover|
	rover := MarsRover at: -20@-40.
	rover do: 'llb'.
	self assert: (-20@-39) equals: rover position.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:36:24'!
test15RoverMovesNorthAfterTurningRightTwiceAndMovingBackward

	|rover|
	rover := MarsRover at: -20@-40.
	rover do: 'rrb'.
	self assert: (-20@-39) equals: rover position.! !


!classDefinition: #Direction category: #'MarsRover-Exercise'!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!Direction methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:34:02'!
descriptiveSymbol
	
	^self subclassResponsibility ! !

!Direction methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:16:17'!
rotateLeft
	^self subclassResponsibility ! !

!Direction methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:16:21'!
rotateRight
	^self subclassResponsibility ! !

!Direction methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:19:37'!
unitaryVectorAsPoint
	^self subclassResponsibility ! !


!classDefinition: #EastDirection category: #'MarsRover-Exercise'!
Direction subclass: #EastDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!EastDirection methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:34:16'!
descriptiveSymbol
	
	^#E! !

!EastDirection methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:16:42'!
rotateLeft
	^NorthDirection new! !

!EastDirection methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:16:52'!
rotateRight
	^SouthDirection new! !

!EastDirection methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:20:04'!
unitaryVectorAsPoint
	^1@0! !


!classDefinition: #NorthDirection category: #'MarsRover-Exercise'!
Direction subclass: #NorthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!NorthDirection methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:34:25'!
descriptiveSymbol
	
	^#N! !

!NorthDirection methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:17:16'!
rotateLeft
	^WestDirection new! !

!NorthDirection methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:17:24'!
rotateRight
	^EastDirection new! !

!NorthDirection methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:20:22'!
unitaryVectorAsPoint
	^0@1! !


!classDefinition: #SouthDirection category: #'MarsRover-Exercise'!
Direction subclass: #SouthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!SouthDirection methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:34:36'!
descriptiveSymbol
	
	^#S! !

!SouthDirection methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:17:48'!
rotateLeft
	^EastDirection new! !

!SouthDirection methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:17:57'!
rotateRight
	^WestDirection new! !

!SouthDirection methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:20:37'!
unitaryVectorAsPoint
	^0@-1! !


!classDefinition: #WestDirection category: #'MarsRover-Exercise'!
Direction subclass: #WestDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!WestDirection methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:34:57'!
descriptiveSymbol
	
	^#W! !

!WestDirection methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:18:17'!
rotateLeft
	^SouthDirection new! !

!WestDirection methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:18:29'!
rotateRight
	^NorthDirection new! !

!WestDirection methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:20:49'!
unitaryVectorAsPoint
	^-1@0! !


!classDefinition: #MarsRover category: #'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction commandImplementations'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:36:50'!
direction

	^direction descriptiveSymbol! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 18:48:08'!
do: aCommandSequence

	aCommandSequence do: [:aCommand | self executeCommand: aCommand].

	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 18:51:42'!
executeCommand: aCommand

	(commandImplementations at: aCommand ifAbsent: 
	[
		self error: self class invalidCommandErrorMessage.
	]) value
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:42:28'!
initializeAt: aPosition
	
	position := aPosition.
	direction := NorthDirection new.
	
	commandImplementations := Dictionary new.
	commandImplementations  at: $f put: [position := position + direction unitaryVectorAsPoint.].
	commandImplementations  at: $b put: [position := position - direction unitaryVectorAsPoint.].
	commandImplementations at: $l put: [direction := direction rotateLeft.].
	commandImplementations  at: $r put: [direction := direction rotateRight.].
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/3/2019 21:20:17'!
position

	^position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/3/2019 21:19:11'!
at: aPosition
	
	^self new initializeAt: aPosition.
	
	! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/9/2019 19:22:37'!
invalidCommandErrorMessage

	^'Invalid command'! !
