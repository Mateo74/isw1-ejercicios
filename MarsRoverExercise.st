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


!classDefinition: #MarsRover category: #MarsRoverExercise!
Object subclass: #MarsRover
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/3/2019 21:13:53'!
do: aCommandSequence! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'damian y mateo 10/3/2019 21:20:01'!
initializeAt: aPosition
	
	position := aPosition.! !

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
