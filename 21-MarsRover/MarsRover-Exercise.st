!classDefinition: #MarsRoverTest category: #'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:39:29'!
test01RoverDoesNotChangeDirectionIfNoCommandsGiven

	|rover|
	rover := MarsRover at: 0@0.
	rover do: ''.
	self assert: #N equals: rover direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:40:14'!
test02RoverPointsEastWhenPoinitngNorthAndTurningRight

	|rover|
	rover := MarsRover at: 0@0.
	rover do: 'r'.
	self assert: #E equals: rover direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:40:42'!
test03RoverPointsSouthWhenPoinitngEastAndTurningRight

	|rover|
	rover := MarsRover at: 0@0.
	rover do: 'rr'.
	self assert: #S equals: rover direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:41:00'!
test04RoverPointsWestWhenPoinitngSouthAndTurningRight

	|rover|
	rover := MarsRover at: 0@0.
	rover do: 'rrr'.
	self assert: #W equals: rover direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:42:05'!
test05RoverPointsNorthWhenPoinitngWestAndTurningRight

	|rover|
	rover := MarsRover at: 0@0.
	rover do: 'rrrr'.
	self assert: #N equals: rover direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:42:46'!
test06RoverPointsWestWhenPoinitngNorthAndTurningLeft

	|rover|
	rover := MarsRover at: 0@0.
	rover do: 'l'.
	self assert: #W equals: rover direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:43:19'!
test07RoverPointsSouthWhenPoinitngWestAndTurningLeft

	|rover|
	rover := MarsRover at: 0@0.
	rover do: 'll'.
	self assert: #S equals: rover direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:45:06'!
test08RoverPointsEastWhenPoinitngSouthAndTurningLeft

	|rover|
	rover := MarsRover at: 0@0.
	rover do: 'lll'.
	self assert: #E equals: rover direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:43:58'!
test09RoverPointsNorthWhenPoinitngEastAndTurningLeft

	|rover|
	rover := MarsRover at: 0@0.
	rover do: 'llll'.
	self assert: #N equals: rover direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:51:40'!
test10RoverDoesNotChangePositionIfNoCommandsGiven

	|rover|
	rover := MarsRover at: 0@0.
	rover do: ''.
	self assert: 0@0 equals: rover position.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:51:54'!
test10RoverInDifferentPositionDoesNotChangePositionIfNoCommandsGiven

	|rover|
	rover := MarsRover at: 48@-95.
	rover do: ''.
	self assert: 48@-95 equals: rover position.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:46:22'!
test10RoverMovesNorthWhenPointingNorthAndMovingForward

	|rover|
	rover := MarsRover at: 0@0.
	rover do: 'f'.
	self assert: 0@1 equals: rover position.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:46:57'!
test11RoverMovesEastWhenPointingEastAndMovingForward

	|rover|
	rover := MarsRover at: 0@0.
	rover do: 'rf'.
	self assert: 1@0 equals: rover position.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:47:17'!
test12RoverMovesSouthWhenPointingSouthAndMovingForward

	|rover|
	rover := MarsRover at: 0@0.
	rover do: 'rrf'.
	self assert: 0@-1 equals: rover position.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:47:35'!
test13RoverMovesEastWhenPointingEastAndMovingForward

	|rover|
	rover := MarsRover at: 0@0.
	rover do: 'rrrf'.
	self assert: -1@0 equals: rover position.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:48:01'!
test14RoverMovesSouthWhenPointingNorthAndMovingBackward

	|rover|
	rover := MarsRover at: 0@0.
	rover do: 'b'.
	self assert: 0@-1 equals: rover position.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:48:27'!
test15RoverMovesWestWhenPointingEastAndMovingBackward

	|rover|
	rover := MarsRover at: 0@0.
	rover do: 'rb'.
	self assert: -1@0 equals: rover position.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:49:57'!
test16RoverMovesNorthWhenPointingSouthAndMovingBackward

	|rover|
	rover := MarsRover at: 0@0.
	rover do: 'rrb'.
	self assert: 0@1 equals: rover position.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:50:14'!
test17RoverMovesEastWhenPointingWestAndMovingBackward

	|rover|
	rover := MarsRover at: 0@0.
	rover do: 'rrrb'.
	self assert: 1@0 equals: rover position.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:52:58'!
test18RoverExecutesSeveralCommands

	|rover|
	rover := MarsRover at: 0@0.
	rover do: 'rffflblbbbbfllb'.
	self assert: 5@-1 equals: rover position.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'damian y mateo 10/10/2019 16:50:38'!
test19RoverStopsExecutingCommandsWhenAnInvalidOneIsFound

	|rover|
	rover := MarsRover at: 10@5.
	self should:
	[
		rover do: 'ffffk3&*2Gffblr'.
	] raise: Error - MessageNotUnderstood withExceptionDo:
	[
		:anError |
		self assert: MarsRover invalidCommandErrorMessage equals: anError messageText.
		self assert: rover position equals: 10@9.
	].! !


!classDefinition: #Direction category: #'MarsRover-Exercise'!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!Direction methodsFor: 'rotations' stamp: 'damian y mateo 10/9/2019 19:16:17'!
rotateLeft
	^self subclassResponsibility ! !

!Direction methodsFor: 'rotations' stamp: 'damian y mateo 10/9/2019 19:16:21'!
rotateRight
	^self subclassResponsibility ! !


!Direction methodsFor: 'representation' stamp: 'damian y mateo 10/9/2019 19:34:02'!
descriptiveSymbol
	
	^self subclassResponsibility ! !

!Direction methodsFor: 'representation' stamp: 'damian y mateo 10/9/2019 19:19:37'!
unitaryVectorAsPoint
	^self subclassResponsibility ! !


!classDefinition: #EastDirection category: #'MarsRover-Exercise'!
Direction subclass: #EastDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!EastDirection methodsFor: 'rotations' stamp: 'damian y mateo 10/9/2019 19:16:42'!
rotateLeft
	^NorthDirection new! !

!EastDirection methodsFor: 'rotations' stamp: 'damian y mateo 10/9/2019 19:16:52'!
rotateRight
	^SouthDirection new! !


!EastDirection methodsFor: 'representation' stamp: 'damian y mateo 10/9/2019 19:34:16'!
descriptiveSymbol
	
	^#E! !

!EastDirection methodsFor: 'representation' stamp: 'damian y mateo 10/9/2019 19:20:04'!
unitaryVectorAsPoint
	^1@0! !


!classDefinition: #NorthDirection category: #'MarsRover-Exercise'!
Direction subclass: #NorthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!NorthDirection methodsFor: 'representation' stamp: 'damian y mateo 10/9/2019 19:34:25'!
descriptiveSymbol
	
	^#N! !

!NorthDirection methodsFor: 'representation' stamp: 'damian y mateo 10/9/2019 19:20:22'!
unitaryVectorAsPoint
	^0@1! !


!NorthDirection methodsFor: 'rotations' stamp: 'damian y mateo 10/9/2019 19:17:16'!
rotateLeft
	^WestDirection new! !

!NorthDirection methodsFor: 'rotations' stamp: 'damian y mateo 10/9/2019 19:17:24'!
rotateRight
	^EastDirection new! !


!classDefinition: #SouthDirection category: #'MarsRover-Exercise'!
Direction subclass: #SouthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!SouthDirection methodsFor: 'representation' stamp: 'damian y mateo 10/9/2019 19:34:36'!
descriptiveSymbol
	
	^#S! !

!SouthDirection methodsFor: 'representation' stamp: 'damian y mateo 10/9/2019 19:20:37'!
unitaryVectorAsPoint
	^0@-1! !


!SouthDirection methodsFor: 'rotations' stamp: 'damian y mateo 10/9/2019 19:17:48'!
rotateLeft
	^EastDirection new! !

!SouthDirection methodsFor: 'rotations' stamp: 'damian y mateo 10/9/2019 19:17:57'!
rotateRight
	^WestDirection new! !


!classDefinition: #WestDirection category: #'MarsRover-Exercise'!
Direction subclass: #WestDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!WestDirection methodsFor: 'representation' stamp: 'damian y mateo 10/9/2019 19:34:57'!
descriptiveSymbol
	
	^#W! !

!WestDirection methodsFor: 'representation' stamp: 'damian y mateo 10/9/2019 19:20:49'!
unitaryVectorAsPoint
	^-1@0! !


!WestDirection methodsFor: 'rotations' stamp: 'damian y mateo 10/9/2019 19:18:17'!
rotateLeft
	^SouthDirection new! !

!WestDirection methodsFor: 'rotations' stamp: 'damian y mateo 10/9/2019 19:18:29'!
rotateRight
	^NorthDirection new! !


!classDefinition: #MarsRover category: #'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction commandImplementations'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'queries' stamp: 'damian y mateo 10/9/2019 19:36:50'!
direction

	^direction descriptiveSymbol! !

!MarsRover methodsFor: 'queries' stamp: 'damian y mateo 10/3/2019 21:20:17'!
position

	^position! !


!MarsRover methodsFor: 'command execution' stamp: 'damian y mateo 10/9/2019 18:48:08'!
do: aCommandSequence

	aCommandSequence do: [:aCommand | self executeCommand: aCommand].

	! !

!MarsRover methodsFor: 'command execution' stamp: 'damian y mateo 10/9/2019 18:51:42'!
executeCommand: aCommand

	(commandImplementations at: aCommand ifAbsent: 
	[
		self error: self class invalidCommandErrorMessage.
	]) value
	! !


!MarsRover methodsFor: 'initialization' stamp: 'damian y mateo 10/9/2019 19:42:28'!
initializeAt: aPosition
	
	position := aPosition.
	direction := NorthDirection new.
	
	commandImplementations := Dictionary new.
	commandImplementations  at: $f put: [position := position + direction unitaryVectorAsPoint.].
	commandImplementations  at: $b put: [position := position - direction unitaryVectorAsPoint.].
	commandImplementations at: $l put: [direction := direction rotateLeft.].
	commandImplementations  at: $r put: [direction := direction rotateRight.].
	! !

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
