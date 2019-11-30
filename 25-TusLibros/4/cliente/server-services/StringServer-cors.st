!classDefinition: #StringGenius category: #StringServer!
Object subclass: #StringGenius
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StringServer'!

!StringGenius methodsFor: 'converting' stamp: 'NR 11/11/2019 16:14:06'!
firstLetter: aWord
	
	^aWord at:1! !

!StringGenius methodsFor: 'converting' stamp: 'NR 11/11/2019 17:20:09'!
substrings: aSentence
	
	^aSentence substrings! !

!StringGenius methodsFor: 'converting' stamp: 'NR 11/11/2019 16:14:58'!
toLowercase: aWord
	
	^aWord translateToLowercase! !

!StringGenius methodsFor: 'converting' stamp: 'NR 11/11/2019 16:14:47'!
toUppercase: aWord
	
	^aWord translateToUppercase! !

!StringGenius methodsFor: 'converting' stamp: 'NR 11/11/2019 16:44:40'!
vowels: aWord
	
	^aWord select: [:letter | letter isVowel]! !


!classDefinition: #StringServerController category: #StringServer!
Object subclass: #StringServerController
	instanceVariableNames: 'webServer port stringGenius hiList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StringServer'!

!StringServerController methodsFor: 'enabling services' stamp: 'NR 6/24/2019 06:51:52'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!StringServerController methodsFor: 'enabling services' stamp: 'NR 11/11/2019 15:54:12'!
startListening
	
	webServer startListener.

	^ 'Listening on port: ', self port asString.
	! !

!StringServerController methodsFor: 'enabling services' stamp: 'NR 11/11/2019 15:54:20'!
stopListening
	
	webServer stopListener.
	
	^'Stopped listening from port: ', self port asString! !


!StringServerController methodsFor: 'initialization' stamp: 'F 11/14/2019 15:26:29'!
initializeWith: aPortNumber

	hiList := self hiList.
	
	stringGenius := StringGenius new.
	
	port:= aPortNumber.
	
	webServer := WebServer new listenOn: aPortNumber.
	
	webServer addService: '/sayHi' action:[:request |	
		
		"request send200Response: (self sayRandomHi)"
		request send200Response: (self sayRandomHi asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		].
	
	webServer addService: '/substrings' action:[:request | |substringsAsJson sentence substrings |
		
		[sentence := (request fields at:'sentence').
		substrings := stringGenius substrings: sentence.
		substringsAsJson:= WebUtils jsonEncode: (substrings).
		"request send200Response: (substringsAsJson)"
		request send200Response: (substringsAsJson asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]].
	
	webServer addService: '/firstLetter' action:[:request | |letterAsJson word letter |
		
		[word := (request fields at:'word').
		letter := stringGenius firstLetter: word.
		letterAsJson:= WebUtils jsonEncode: (letter asString).
		"request send200Response: (letterAsJson)"
		request send200Response: (letterAsJson asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]].
	
	webServer addService: '/vowels' action:[:request | |vowelsAsJson word vowels |
		
		[word := (request fields at:'word').
		vowels := stringGenius vowels: word.
		vowelsAsJson:= WebUtils jsonEncode: (vowels).
		"request send200Response: (vowelsAsJson)"
		request send200Response: (vowelsAsJson asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]].
	
	webServer addService: '/toUppercase' action:[:request | |upperCasedWordAsJson word upperCasedWord |
		
		[word := (request fields at:'word').
		upperCasedWord := stringGenius toUppercase: word.
		upperCasedWordAsJson:= WebUtils jsonEncode: (upperCasedWord).
		"request send200Response: (upperCasedWordAsJson)"
		request send200Response: (upperCasedWordAsJson asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]].
	
! !

!StringServerController methodsFor: 'initialization' stamp: 'NR 11/11/2019 17:19:18'!
port
	"Use a random port to minimise chances of concurrently running test suites clashing."
	"^ port
		ifNil: [port := (10000 to: 50000) atRandom]"
	
	^port ifNil: [port:=8080].
	
	! !


!StringServerController methodsFor: 'private' stamp: 'NR 6/24/2019 07:16:54'!
hiList
	
	^OrderedCollection with: 'Hi!!' with: 'Hodor!!' with: 'I am Groot!!' with: 'My name is Homer Simp... Doh!!' with: 'I am inevitable...' with: 'Because Im Baaaatman!!'.
	
	! !

!StringServerController methodsFor: 'private' stamp: 'NR 6/24/2019 07:15:43'!
sayRandomHi
	
	^hiList at: (hiList size atRandom).
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StringServerController class' category: #StringServer!
StringServerController class
	instanceVariableNames: ''!

!StringServerController class methodsFor: 'as yet unclassified' stamp: 'NR 11/11/2019 15:43:02'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber.! !
