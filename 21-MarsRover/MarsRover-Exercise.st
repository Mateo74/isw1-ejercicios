!classDefinition: #MarsRoverTest category: #MarsRoverExercise!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/3/2019 20:23:39'!
assertThatRover: aRover IsFacing: aDirection InPosition: aPoint
	self assert: aRover direction equals: aDirection.
	self assert: aRover position equals: aPoint.! !

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

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'mm 10/8/2019 20:07:56'!
test04RoverMovesOneStepForward

	|rover|
	rover := MarsRover at: 4@9.
	rover do: 'f'.
	self assert: 4@10 equals: rover position.! !

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

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'mm 10/8/2019 20:30:30'!
test07RoverPointsNorthIfNoCommandsGiven

	|rover|
	rover := MarsRover at: -20@-40.
	rover do: ''.
	self assert: 'N' equals: rover direction.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'mm 10/8/2019 20:34:32'!
test08RoverPointsEastAfterTurningRightOnce

	|rover|
	rover := MarsRover at: -20@-40.
	rover do: 'r'.
	self assert: 'E' equals: rover direction.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'mm 10/8/2019 20:34:25'!
test09RoverPointsWestAfterTurningLeftOnce

	|rover|
	rover := MarsRover at: -20@-40.
	rover do: 'l'.
	self assert: 'W' equals: rover direction.! !


!classDefinition: #MarsRover category: #MarsRoverExercise!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'mm 10/8/2019 20:37:05'!
direction

	^direction! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'mm 10/8/2019 20:38:50'!
do: aCommandSequence

	aCommandSequence = 'f' ifTrue: [position := position + (0@1)].
	aCommandSequence = 'b' ifTrue: [position := position + (0@-1)].
	aCommandSequence = 'r' ifTrue: [direction := 'E'].
	aCommandSequence = 'l' ifTrue: [direction := 'W'].
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'mm 10/8/2019 20:36:50'!
initializeAt: aPosition
	
	position := aPosition.
	direction := 'N'.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/3/2019 21:20:17'!
position

	^position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRoverExercise!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/3/2019 21:19:11'!
at: aPosition
	
	^self new initializeAt: aPosition.
	
	! !
