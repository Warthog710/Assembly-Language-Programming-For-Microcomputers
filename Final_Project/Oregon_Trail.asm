; Final Project - Oregon Trail.
; Group 7.

;Group Participants:
;- Quinn Roemer
;- Luke Noramczyk
;- Nickolas Lohn 
;- Cody Clark
;- Ahmad Furmoli
;- Nabil Furmoli

;********************************************************************************

.586
.MODEL FLAT

INCLUDE io.h

.STACK 4096

.DATA

;********************************************************************************
;*							    randGen Variables 		     					*
;********************************************************************************

randSeed		DWORD ?
lastRand		DWORD 0
divide			DWORD 11
randMult		DWORD 1
oneHundred		DWORD 100



;********************************************************************************
;*							    DWORD Variables 		     					*
;********************************************************************************

wagHealth		DWORD 0
foodCount		DWORD 0
oxenCount		DWORD 0
peopleCount		DWORD 5
randNumber		DWORD ?
FUND			DWORD 1000
dDayCount		DWORD 0
DayCount		DWORD 0

;********************************************************************************
;*						     Multiple Line Strings				         		*
;********************************************************************************

strDesertIn		BYTE	"The sun beats down on a rocky, arid landscape.",0dh, 0ah, 
						"Hopefully the caravan is well prepared for the trail ahead.",0

strDesertOut	BYTE	"You have finally left the desert behind you.",0dh, 0ah, 
						"Onward!",0

strDehy			BYTE	"The sun and the heat are are oppressive out here on the trail.",0dh, 0ah, 
						"You worry the oxen won't make it without extra water.",0dh, 0ah,
						"20lbs of supplies should be enough, but it's a lot to ask.",0dh, 0ah,
						"Enter (in whole pounds) the amount of supplies you want to ration for the oxen.",0

strMainMenu		BYTE	"This is the game of OREGON TRAIL ",0dh, 0ah,
						"To start the journey you have a 1000 gold coins to spend on provisions", 0dh, 0ah,
						"----------------------------------------------------------------------", 0dh, 0ah,
						"Enter a 1 to buy a Wagon", 0dh, 0ah, 
						"Enter a 2 to buy food", 0dh, 0ah,
						"Enter a 3 to buy Oxen", 0dh, 0ah,
						"Enter a 0 to Quit Menu / START THE JOURNEY!", 0

strRocks		BYTE	"As the caravan crosses into the shadow of a rocky cliff face there is a low rumble",0dh, 0ah,
						"followed by a roar as a rockslide crashes into the caravan.",0

strRock2		BYTE	"What luck! It wasn't as bad as it could have been.",0dh, 0ah,
						"Your wagon has taken 30 damage and you lost 1 of the oxen.",0

strBlock		BYTE	"You are stopped in a narrow canyon. A large boulder blocks the path forward.",0dh, 0ah,
						"You can spend the day and resources trying to move it out of the way.",0dh, 0ah,
						"Or you can spend extra days to backtrack out of the canyon.",0

strBlockInput	BYTE	"Enter 1 to move the boulder at the cost of supplies.",0dh, 0ah, 
						"Enter 2 to backtrack out of the canyon and go around.", 0

strCacti		BYTE	"As your wagon moves across the desert, you notice a large number of cacti in this area.",0dh, 0ah,
						"You've heard they might be edible. Would you like to try gathering a few for supplies?", 0

strCactiInput	BYTE	"Enter 1 to keep on moving.",0dh,0ah,
						"Enter 2 to try collecting some of the cacti.", 0

strWreck		BYTE	"As you move through the desert, something catches your eye on the horizon.", 0dh, 0ah,
						"As you near it, you find an abandoned, damaged wagon.", 0dh, 0ah,
						"You may be able to salvage some of the gear here.", 0

strWreckInput	BYTE	"Enter 1 to scrap the wagon for repairs.",0dh,0ah,
						"Enter 2 to search for any useable supplies.",0

strWagon		BYTE	"Option #1: Higher quality wagon. Health is: 400, Cost is: 400",0dh, 0ah, 
						"Option #2: Lower quality wagon. Health is: 300, Cost is: 200",0
				
strFood			BYTE	"Option #1: Buy 500lbs of food. Cost is: 400  ", 0dh, 0ah,
						"Option #2: Buy 250lbs of food. Cost is: 200	", 0

strOxen			BYTE	"Option #1: Buy 20 head of Oxen. Cost is: 400", 0dh, 0ah,
						"Option #2: Buy 10 head of Oxen. Cost is: 200", 0

strEveryFine	BYTE	"As the sky turns red from the sunset you let out a huge sigh of relief.", 0dh, 0ah,
						"You bed down for a peaceful night.", 0
	
strLostIn1		BYTE	"You've been moving westward all day after losing the trail", 0dh, 0ah,
						"and have hit a small stream cutting its way across the landscape.", 0dh, 0ah,
						"Do you continue forward or follow the stream?",0

strLostIn2		BYTE	"You've been moving for most of the day after losing the trail", 0dh, 0ah,
						"and a small bluff blocks the way westward for the wagon.", 0dh, 0ah,
						"Do you follow it North or South?",0

strLostD1		BYTE	"You cross the stream, choosing to head West in the hopes of finding",0dh,0ah,
						"the trail again. After another day of travel, there still is no sign.", 0dh, 0ah,
						"You can see hills in the distance, or a small lake to the northwest.",0

strLostD2		BYTE	"As you head southward another day, hoping to find a trail of some kind, you",0dh,0ah,
						"can see the green tops of a forest just over the next ridge, or do you", 0dh, 0ah,
						"keep heading down into the grassland?",0

strLostD3		BYTE	"You decide to follow the stream to the northwest in hopes of finding",0dh,0ah,
						"a trailhead. After another day of travel, you haven't seen any sign",0dh,0ah,
						"of other people having been through here.",0dh,0ah,
						"Do you head for downstream or continue following the stream up?",0

strLostD4		BYTE	"You find yourself among a number of small gulleys after a day of",0dh,0ah,
						"travel, with little to show for it. Do you follow the gulleys down",0dh,0ah,
						"or keep heading to the high ground? ",0

strLostHills	BYTE	"You find yourself among a number of rocky hills, hoping to have",0dh,0ah,
						"a better vantage point. You see no signs of an obvious trail",0dh,0ah,
						"from here. You do see what looks to be a small cave and the green",0dh,0ah,
						"canopy of a forest over the next ridge. Do you investigate the",0dh,0ah,
						"cave or head for the forest?",0

strLostForest	BYTE	"The forest is fairly dense and you've made slow progress navigating",0dh,0ah,
						"the trees. You've found a cave system in the area, and every few",0dh,0ah,
						"miles or so, you think you catch a glimpse of a lake.",0
						
strLostLake		BYTE	"A small, shimmering lake opens up before you. As you look around",0dh,0ah,
						"hoping to find the signs of other travelers, you don't find much.",0dh,0ah,
						"After a day of trailing the edge of the lake, you notice the lake",0dh,0ah,
						"sits between a large grassland and rocky hills.",0

strLostGrass	BYTE	"As the wagon rolls over the grassy hills, yours is the only trail",0dh,0ah,
						"around. As the sun sets on an uneventful day of travel, you can see",0dh,0ah,
						"a series of hills to the northwest and a forest to the west.",0

strLostCave		BYTE	"At the mouth of the cave, you find a number of old, clay pots",0dh,0ah,
						"and arrowheads, but no one has been here for a very long time.",0dh,0ah,
						"After a day of exploring the cave, you pull the wagon around.",0dh,0ah,
						"Do you head for the lake you can see nearby, or keep heading west?",0

strLostEnd		BYTE	"After your days in the wilderness, you finally find wagon tracks",0dh,0ah,
						"and soon enough, a proper trail. You're finally back on the road",0dh,0ah,
						"to Oregon.",0

strLostShort	BYTE	"After a day or so, you manage to find signs of other wagon tracks",0dh,0ah,
						"and eventually, the proper trail. In the next settlement you learn",0dh,0ah,
						"your route throught the wilderness shaved 3 days off your",0dh,0ah,
						"journey to Oregon!",0

playerVictory	BYTE	"After a long and arduous journey you finally make it to Oregon.", 0dh, 0ah,
						"Congrats! You've won the game.", 0

LostHum1 		BYTE	"The aliens capture one of your partners! Who knows what for!!!", 0dh, 0ah,
						 "Number of people left is...", 0

lostAnimal1		BYTE	"The aliens took one of the oxen. Maybe their hungry?", 0dh, 0ah,
						"Number of oxen left..." , 0

lostAnimal2		BYTE	"The aliens took two of the oxen. Maybe their hungry?", 0dh, 0ah,
						"Number of oxen left..." , 0

lostAnimal3		BYTE	"The aliens took three of the oxen. Maybe their hungry?", 0dh, 0ah,
						"Number of oxen left..." , 0

lostAnimal4		BYTE	"The aliens took four of the oxen. Maybe their hungry?", 0dh, 0ah,
						"Number of oxen left..." , 0

scen9Intro		BYTE	"As you make camp for the night you see a group of green skinned individuals walk toward you.",
						" They brandish a weapons...", 0

humDisease		BYTE	"Unfortunately, you have encountered a very dangoures disease called Ebola.", 0dh, 0ah,
						"(A virus that causes severe bleeding, organ failure, and can lead to death)", 0

humDisease0		BYTE	"Your party member successfully overcame the disease and has survived.", 0dh, 0ah,
						"The number of people left is...", 0

humDisease2		BYTE	"The disease killed one of your party members. You seem them writhe in agony as they breath their last. May God bless their soul.", 0dh, 0ah,
						"Number of people left is...", 0

humDisease3		BYTE	"The disease spread and killed two of your party members. You bury them along the trail. May God bless their souls.", 0dh, 0ah,
						"Number of people left is...", 0

humDisease1		BYTE	"The disease killed one of your party members. However, their death is a peaceful one. May God bless their soul.", 0dh, 0ah,
						"Number of people left is...", 0


scen6Intro		BYTE	"As you are travelling the trails towards Oregon a member of your party keels over in pain.",
						" It is apparent that they are seriously ill... Possibly fatally.", 0

scen8Intro		BYTE	"As you are traveling in the dark of the forest you hear a shrill howl.", 0dh, 0ah,
						"Take cover! The wolves are attacking!", 0

;********************************************************************************
;*						      Single Line Strings				         		*
;********************************************************************************

desertIn2			BYTE	"You yoke the oxen and prepare for another day of crossing the desert before you.",0

supplyPrompt		BYTE    "Please enter a number (in whole lbs) of supplies:", 0
supplyFault			BYTE	"You do not have enough supplies to do that! Try again.", 0
currentSupply		BYTE	"You current supply value is:", 0
dehyBadLbl			BYTE	"Heat and dehydration take their toll, you've lost 2 oxen.", 0
dehyMidLbl			BYTE	"You make the supplies stretch as far as you can, but 1 oxen perishes in the heat.", 0
dehyBestLbl			BYTE	"The heat and terrain have been daunting, but the oxen seem to be alright.",0

rock1Lbl			BYTE	"The wagon has taken 50 damage, you've lost 30 supplies, 2 of the oxen, and sadly someone has died.",0

strblockLbl			BYTE	"Enter 1 to move the boulder at the cost of supplies; Enter 2 to backtrack out of the canyon and go around.", 0
block1Lbl			BYTE	"It takes the rest of the day, but you manage to move the boulder by using 20 lbs of supplies.", 0
block2Lbl			BYTE	"You backtrack out of the canyon but the detour has added 3 days to the trip.",0

cactiLbl			BYTE	"Enter 1 to keep on moving. Enter 2 to try collecting some of the cacti.", 0
cactiPassLbl		BYTE	"You decide it isn't worth the effor and move on down the trail.", 0
cactus1Lbl			BYTE	"They don't taste too bad. You collect the large pads off the cacti and manage to add 30lbs of food to your stores.", 0
cactus2Lbl			BYTE	"A few hours after eating the cacti, someone becomes violently sick. You throw out what you've collected.", 0

wreckLbl			BYTE	"Enter 1 to scrap the wagon for repairs. Enter 2 to search for any useable supplies.", 0
wreck1Lbl			BYTE	"You find of several functional wagon wheels and canvas among the wrecked wagon. Your wagon gains 30 health.", 0
wreck2Lbl			BYTE	"You find a number of helpful tools and other supplies among the wreckage. You gain 20lbs worth.", 0

welcomeLbl			BYTE	"Welcome!", 0
genericLbl			BYTE	"Oregon Trail", 0

strBegin			BYTE	"THE JOUNEY BEGINS!", 0

currentFUND			BYTE	"Funds are equal to: ",0
	
prompt1				BYTE    "Please enter a menu number:", 0
prompt2				BYTE	"Choose from option #1 or #2", 0
prompt3				BYTE	"Choose from option #1 or #2", 0
prompt4				BYTE	"Choose from option #1 or #2", 0

notEnoughMoney		BYTE "You do not have enough money to purchase that.", 0
alreadyBought		BYTE "You have already bought an item in that category.", 0
itemMissing			BYTE "You forgot to purchase something!", 0

playerFail			BYTE "Game over!", 0

peopleDead			BYTE "All of your people have died...", 0
oxenDead			BYTE "All of your oxen have died...", 0
foodGone			BYTE "All of your food is gone...", 0
wagGone				BYTE "Your wagon has been destroyed...", 0

sevenPart1			BYTE "One of your oxen is sick. Will you kill it to stop the disease from spreading?", 0
sevenPart2			BYTE "0 for yes, 1 for no.", 0
sevenChoice0		BYTE "You killed the sick ox.", 0
sevenOutcome1Lbl	BYTE "The sick ox got better.", 0
sevenOutcome2Lbl	BYTE "The sick ox perished.", 0
sevenOutcome3Lbl	BYTE "The sickness spread! You lose 5 oxen.", 0

tenPart1			BYTE "A thief appears! Give him 20 lbs of food or fight?", 0
tenPart2			BYTE "0 to give food, 1 to fight.", 0
tenChoice0			BYTE "You gave him 20 lbs of food.", 0
tenOutcome1Lbl		BYTE "You chased the thief off without losing anything.", 0
tenOutcome2Lbl		BYTE "The thief stole 20 lbs of food and escaped.", 0
tenOutcome3Lbl		BYTE "The thief killed someone and ran away with 20 lbs of food!", 0

turnProgressed		BYTE "A turn has progressed. 10 lbs of food has been consumed.", 0
peopleLeft			BYTE "People left:", 0
oxenLeft			BYTE "Oxen left:", 0
foodLeft			BYTE "Food left:", 0
wagHealthLeft		BYTE "Wagon Health:", 0
turnLeft			BYTE "Turn(s) left:", 0

blizzardIntro		BYTE "Your party has gotten caught in a heavy blizzard!", 0
blizzard1			BYTE "Your party has successfully navigated the blizzard! You lose nothing!", 0
blizzard2			BYTE "Your party got lost in the blizzard! You lose 20 lbs of supplies.", 0
blizzard3			BYTE "Your party fared horribly in the blizzard. +1 turn, -2 oxen, -20 lbs of supplies.", 0

riverCrossingI		BYTE "Your party has come across a river that needs to be crossed.", 0
riverCrossing1		BYTE "Your party has crossed the river without accident. You lose nothing!", 0
riverCrossing2		BYTE "Your party has crossed the river. However, your wagon took damage. -100 health points.", 0
riverCrossing3		BYTE "You crossed the river... But someone drowned!!! -1 people, -100 wagon health.", 0

brokenWheelI		BYTE "Your wagon has broken a wheel and lost 25 health.", 0
brokenWheel1		BYTE "Your prove adept at repairing your wagon. -10 food supplies.", 0
brokenWheel2		BYTE "You are terrible at reparing your wagon. You have lost 1 turn, -20 food supplies.", 0

lostIn1Lbl			BYTE	"1 to keep going. 2 to follow the stream.",0
lostIn2Lbl			BYTE	"1 to head South. 2 to head North.",0

lostD1Lbl			BYTE	"1 for the hills. 2 to the lake.",0
lostD3Lbl			BYTE	"1 to go downstream. 2 to head up.",0
lostD2Lbl			BYTE	"1 to go to forest. 2 for meadow.",0
lostD4Lbl			BYTE	"1 to head down. 2 to head up.",0

lostForestLbl		BYTE	"1 for Cave. 2 for Lake",0
lostHillLbl			BYTE	"1 for Forest. 2 for Cave",0
lostLakeLbl			BYTE	"1 for Hills. 2 Grassland",0
lostCaveLbl			BYTE	"1 for Lake. 2 for Grassland",0
lostGrassLbl		BYTE	"1 for Forest. 2 for Hills",0

lostHum				BYTE "Unfortunatly, you have been attacked by a group of aliens.", 0
LostHum0 			BYTE "Fortunatly all the people and oxen are safe. It seems they only wanted to talk.", 0

humLost				BYTE "Unfortunatly, you have been attacked by a group of wolfs that are desperate for food.", 0
humLost0			BYTE "Fortunatly all people are alive , number of people left is.", 0
humLost1 			BYTE "The wolfs ate one of your partners, number of people left is.", 0
humLost2 			BYTE "The wolfs ate two of your partners , number of people left is .", 0
animLost0			BYTE "Fortunatly all Oxes are alive, number of oxes left is",0
animLost1			BYTE "The wolfs ate one of your oxes, number of oxes left is",0
animLost2			BYTE "The wolfs ate one of your oxes, number of oxes left is",0
animLost3			BYTE "The wolfs ate two of your oxes, number of oxes left is",0
animLost4			BYTE "The wolfs ate two of your oxes, number of oxes left is",0
animLost5			BYTE "The wolfs ate three of your oxes, number of oxes left is",0
animLost6			BYTE "The wolfs ate three of your oxes, number of oxes left is",0

;********************************************************************************
;*						      Empty Character Arrays			         		*
;********************************************************************************

string				BYTE    40 DUP (?)
val					BYTE    11 DUP (?), 0
leftHum				BYTE	11 DUP (?)
leftAnim			BYTE	11 DUP (?)
humLeft				BYTE	11 DUP (?), 0
animLeft			BYTE	11 DUP (?), 0

;********************************************************************************
;*						       End of .data section			            		*
;********************************************************************************

;********************************************************************************
;*									 Code start	                        		*
;********************************************************************************

.CODE
_MainProc PROC

;********************************************************************************
;*				     Grabbing Garbage Data to use as seed.			       		*
;********************************************************************************

mov		eax, edx									;Moving garbage data in EDX to EAX.
mov		edx, 0										;Setting EDX to 0.
div		oneHundred									;Diving the value in EAX by 100.
mov		randSeed, eax								;Storing the value in EAX in randSeed.


;********************************************************************************
;*		   This section of code contains the logic for the main menu			*
;*																				*
;*							Written by: Luke Noramczyk							*
;*							Modified by: Quinn Roemer							*
;********************************************************************************

mainMenu:	output welcomeLbl, strMainMenu			;Outputting the main menu.
			input   prompt1, string, 40				;Asking the user to input their choice.
			atod    string							;Converting their choice into hex and storing in EAX.
			
			cmp		eax, 1							;If the choice is 1 this code will execute.
			je		Wagon							;Jumping to Wagon.

			cmp		eax, 2							;If the choice is 2 this code will execute.
			je		Food							;Jumping to Food.

			cmp		eax, 3							;If the choice is 3 this code will execute.
			je		Oxen							;Jumping to Live.

			cmp		eax, 0							;If the choice is 0 this code will execute.
			jz		Check							;Jumping to Check.

			jmp		mainMenu						;If nothing works the code will jump back to mainMenu.

;********************************************************************************
;*		   This section of code contains the logic for the wagon choice 		*
;********************************************************************************
			
Wagon:		cmp			wagHealth,0					;If the wagHealth is zero this code will continue.
			jg			alreadyPurchased			;If the wagHealth is greater than zero this code will jump to alreadyPurchased.	
			
			output		welcomeLbl, strWagon		;Ouputting the wagon choice menu.
			input		prompt2, string, 40			;Asking the user to input their choice.
			atod		string						;Converting their choice into hex and storing in EAX.						

			cmp			eax, 1						;Comparing the user's choice to 1.
			je			Wag1						;If the user's choice is 1 the code will jump to Wag1.
			jmp			Wag2						;If the user's choice is not 1 the code will jump to Wag2.

			Wag1:									;Wag1 code start.
					cmp FUND, 400					;Comparing the user's fund to the cost of the wagon.
					jl noMoney						;If the user does not have enough money jumping to noMoney.

					mov				ebx,FUND		;Moving FUND into EBX.
					sub				ebx,400			;Subtracting 400 from EBX.
					mov				FUND,ebx		;Moving the remaining value in EBX back into fund.
					dtoa			val,ebx			;Converting the value in EBX to a string and storing in val.
					output			currentFUND,val	;Outputting the user's current balance.
					mov				wagHealth,400	;Setting wagHealth to 400.

					jmp				mainMenu		;Jumping back to the mainMenu.

			Wag2:									;Wag2 code start.
					cmp FUND, 200					;Comparing the user's fund to the cost of the wagon.
					jl noMoney						;If the user does not have enough money jumping to noMoney.

					mov				ebx,FUND		;Moving FUND into EBX.
					sub				ebx,200			;Subtracting 300 from EBX.
					mov				FUND,ebx		;Moving the remaining value in EBX back into fund.
					dtoa			val,ebx			;Converting the value in EBX to a string and storing in val.
					output			currentFUND,val	;Outputting the user's current balance.
					mov				wagHealth,300	;Setting wagHealth to 300.

					jmp				mainMenu		;Jumping back to the mainMenu.

;********************************************************************************
;*		   This section of code contains the logic for the food choice 		    *
;********************************************************************************				
			
Food:			cmp			foodCount,0				;If the foodCount is zero this code will continue.
				jg			alreadyPurchased		;If the foodCount is greater than zero this code will jump to alreadyPurchased.	
							
				output		welcomeLbl, strFood		;Outputting the food choice menu.
				input		prompt3, string, 40		;Asking the user to input their choice.
				atod		string					;Converting the user's choice into hex and storing in EAX.

				cmp			eax, 1					;Comparing the user's choice to 1.
				je			Food1					;If the user's choice is 1, jumping to Food1.
				jmp			Food2					;If the user's choice is not 1, jumping to Food2.

				Food1:								;Food1 code start.

					cmp	FUND, 400					;Comparing the user's fund to the cost of the food.
					jl noMoney						;If the user does not have enough money jumping to noMoney.

					mov				ebx,FUND		;Moving fund into EBX.
					sub				ebx,400			;Subtracting 400 from EBX.
					mov				FUND,ebx		;Moving the remaining value in EBX back into fund.
					dtoa			val,ebx			;Converting the value in EBX to a string and storing in val.
					output			currentFUND,val	;Outputting the user's current balance.
					mov				foodCount,500	;Setting foodCount to 500.

					jmp				mainMenu		;Jumping back to the mainMenu.
										
				Food2:								;Food2 code start.
									
					cmp	FUND, 200					;Comparing the user's fund to the cost of the food.
					jl noMoney						;If the user does not have enough money jumping to noMoney.

					mov				ebx,FUND		;Moving fund into EBX.
					sub				ebx,200			;Subtracting 300 from EBX.
					mov				FUND,ebx		;Moving the remaining value in EBX back into fund.
					dtoa			val,ebx			;Converting the value in EBX to a string and storing in val.
					output			currentFUND,val	;Outputting the user's current balance.
					mov				foodCount,250	;Setting foodCount to 250.

					jmp				mainMenu		;Jumping back to the mainMenu.

;********************************************************************************
;*		   This section of code contains the logic for the Oxen choice 		    *
;********************************************************************************	
										
Oxen:			cmp			oxenCount,0				;If the oxenCount is zero this code will continue.
				jg			alreadyPurchased		;If the oxenCount is greater than zero this code will jump to alreadyPurchased.		
							
				output		welcomeLbl, strOxen		;Outputting the oxen choice menu.
				input		prompt4, string, 40		;Asking the user to input their choice.
				atod		string					;Converting the user's choice into hex and storing in EAX.

				cmp			eax, 1					;Comparing the user's choice to 1.
				je			liveStock1				;If the user's choice is 1, jumping to liveStock1
				jmp			liveStock2				;If the user's choice is not 1, jumping to liveStock2.

				liveStock1:							;liveStock1 code start.

					cmp	FUND, 400					;Comparing the user's fund to the cost of the oxen.
					jl noMoney						;If the user does not have enough money jumping to noMoney.

					mov				ebx,FUND		;Moving fund into EBX.
					sub				ebx,400			;Subtracting 400 from EBX.
					mov				FUND,ebx		;Moving the remaining value in EBX back into fund.
					dtoa			val,ebx			;Converting the value in EBX to a string and storing in val.
					output			currentFUND,val	;Outputting the user's current balance.
					mov				oxenCount,20	;Setting oxenCount to 20.

					jmp				mainMenu		;Jumping back to the mainMenu.

				liveStock2:							;liveStock2 code start.

					cmp	FUND, 200					;Comparing the user's fund to the cost of the oxen.
					jl noMoney						;If the user does not have enough money jumping to noMoney.

					mov				ebx,FUND		;Moving fund into EBX.
					sub				ebx,200			;Subtracting 200 from EBX.
					mov				FUND,ebx		;Moving the remaining value in EBX back into fund.
					dtoa			val,ebx			;Converting the value in EBX to a string and storing in val.
					output			currentFUND,val	;Outputting the user's current balance.
					mov				oxenCount,10	;Setting oxenCount to 10.

					jmp				mainMenu		;Jumping back to the mainMenu.

;********************************************************************************
;*		      This section of code contains the logic for the Check				*
;*																				*
;*		Note: This is called after the the main menu completes. It makes sure	*
;*			  that the user bought at least one option for everything.			*  
;********************************************************************************	

Check:												;Check code start.
					
		cmp		foodCount, 0						;Comparing foodCount to 0.
		je		missingItem							;If foodCount is 0, jumping to missingItem.
					
		cmp		wagHealth, 0						;Comparing wagHealth to 0.
		je		missingItem							;If the wagHealth is 0, jumping to missingItem.
					
		cmp		oxenCount, 0						;Comparing oxenCount to 0.
		je		missingItem							;If the oxenCount is 0, jumping to missingItem.
					
		jmp		Main								;Jumping to the main function.

;********************************************************************************
;*		      This section of code contains the logic for no money				*
;*																				*
;*		   Note: This is called if the user does not have enough money			*
;*		         to purchase something. 									    *
;********************************************************************************	

noMoney:											;noMoney code start.

		output	 welcomeLbl, notEnoughMoney			;Outputting the not enough money message.
		jmp		 mainMenu							;Jumping back to the mainMenu.

;********************************************************************************
;*		  This section of code contains the logic for already purchased			*
;*																				*
;*		  Note: This is called if the user has already purchased something.     *
;********************************************************************************

alreadyPurchased:									;alreadyPurchased code start.

		output  welcomeLbl, alreadyBought			;Outputting the already bought message.
		jmp		mainMenu							;Jumping back to the mainMenu.

;********************************************************************************
;*		  This section of code contains the logic for a missing item			*
;*																				*
;*		  Note: This is called if the user has forgot to purchase something.    *
;********************************************************************************

missingItem:										;missingItem code start.
										
		output	welcomeLbl, itemMissing				;Outputting the item missing message.
		jmp		mainMenu							;Jumping back to the mainMenu.


;********************************************************************************
;*		 This section of code contains the logic for the Main Function			*
;*																				*
;*							Written By: Quinn Roemer		        			*
;********************************************************************************

Main:												;Main code start.
		output	welcomeLbl, strBegin				;Outputting "THE JOURNEY BEGINS!"
		mov		ecx, 15 							;Moving 15 into ECX.  
													;Note: This controls the number of turns.
								
		oregonLoop:

				cmp		 peopleCount, 0				;Comparing peopleCount to 0.
				jle		 lostPeople					;If peopleCount is less than or equal 0, jumping to lostPeople.

				cmp		 oxenCount, 0				;Comparing oxenCount to 0.
				jle		 lostOxen					;If oxenCount is less than or equal 0, jumping to lostOxen.

				cmp		 wagHealth, 0				;Comparing wagHealth to 0.
				jle		 lostWag					;If wagHealth is less than or equal 0, jumping to lostWag.

				cmp		 foodCount, 0				;Comparing foodCount to 0.
				jle		 lostFood					;If foodCount is less than or equal 0, jumping to lostFood.

				cmp		 ecx, 0						;Comparing the value stored in ECX to 0.
				jle		 playerWin					;If ECX is less than or equal 0, jumping to playerWin.

				mov		divide, 11					;Setting divide to 11, this will give me a range of 0-10 in the randGen.
				
				call	randGen						;Calling randGen, the random number will be returned in EDX.

				jmp		Scenarios					;Jumping to scenarios.

		loopStart:									;loopStart code start.	

				loop	oregonLoop					;Loop back to oregonLoop.

		Scenarios:									;Scenarios code start.
			
				cmp edx, 0							;Comparing EDX to 0.
				je scenario0						;Jumping to scenario0 if EDX equals 0.

				cmp edx, 1							;Comparing EDX to 1.
				je scenario1						;Jumping to scenario1 if EDX equals 1.

				cmp edx, 2							;Comparing EDX to 2.
				je scenario2						;Jumping to scenario2 if EDX equals 2.

				cmp edx, 3							;Comparing EDX to 3.
				je scenario3						;Jumping to scenario3 if EDX equals 3.

				cmp edx, 4							;Comparing EDX to 4.
				je scenario4						;Jumping to scenario4 if EDX equals 4.

				cmp edx, 5							;Comparing EDX to 5.
				je scenario5						;Jumping to scenario5 if EDX equals 5.

				cmp edx, 6							;Comparing EDX to 6.
				je scenario6						;Jumping to scenario6 if EDX equals 6.

				cmp edx, 7							;Comparing EDX to 7.
				je scenario7						;Jumping to scenario7 if EDX equals 7.

				cmp edx, 8							;Comparing EDX to 8.
				je scenario8						;Jumping to scenario8 if EDX equals 8.

				cmp edx, 9							;Comparing EDX to 9.
				je scenario9						;Jumping to scenario if EDX equals 9.

				cmp edx, 10							;Comparing EDX to 10.
				je scenario10						;Jumping to scenario10 if EDX equals 10.

				jmp loopStart						;If no scenario triggers the program will jump to loopStart.

;********************************************************************************
;*	This section of code contains the logic for all of the scenario functions   *
;********************************************************************************

;********************************************************************************
;*								   Scenario Zero								*
;*																				*
;*							Written by: Nickolas Lohn							*
;********************************************************************************

scenario0:
	Desert:												; Begin Desert Scenario

			output		genericLbl, strDesertIn			; Introduces player entered the desert scenario
			jmp			dRand							; jumps over message for 2nd and 3rd days

	GoAway:	output		genericLbl, strDesertOut
			jmp turnEnd									; leaves scenario
	Clear:	mov dDayCount, 0							; resets counter before leaving
			jmp GoAway
	dDay2:	
			cmp			dDayCount, 2					; checks to see if you have had 3 events in scenario																			
			jg			Clear							; jumps to reset counter before leaving

			output		genericLbl, desertIn2			; message displayed before 2nd and 3rd days in the desert
			jmp			dRand

	dRand:	mov			divide, 5						; produces 5 options
			call		randGen							; calls random generator

			cmp			edx, 0
			je			Dehy

			cmp			edx, 1			
			je			Rocks

			cmp			edx, 2
			je			Block

			cmp			edx, 3
			je			Cacti

			cmp			edx, 4
			je			Wreck

			jmp			dRand

Dehy:													; Begins Dehydration event

			output		genericLbl, strDehy				; Displays Dehydration Introduction
	Supply:	input		supplyPrompt, string, 40		; Player inputs amount of supplies to spend
			atod		string							; converts input and stores in EAX

			cmp			eax, foodCount					; Check the players input against the remaining supplies.
			jg			SupplyError

			cmp			eax, 9							; if player spent <10 supplies,
			jle			DehyBad							; jumps to bad option

			cmp			eax, 19							; if player spent 10-19 supplies,
			jle			DehyOk							; jumps to mid option

			cmp			eax, 20							; if player spent 20 or more supplies,
			jge			DehyBest										; jumps to best option

				SupplyError:	output		genericLbl, supplyFault		; displays error if user doesn't have enough
								mov			ebx, foodCount
								dtoa		string, ebx
								output		genericLbl, string			; displays reminder of current count
								jmp			Supply						; jumps back to input

				DehyBad:		output		genericLbl, dehyBadLbl		; User got worst outcome (spent <10 supplies)
								sub			oxenCount, 2				; subtracts 2 oxen from count
								sub			foodCount, eax
								inc dDayCount							; jumps to start and increments day counter
								jmp dDay2
			
				DehyOk:			output		genericLbl, dehyMidLbl		; User got middle outcome (spent 10 to 19 supplies)
								sub			oxenCount, 1
								sub			foodCount, eax
								inc dDayCount							; jumps to start and increments day counter
								jmp dDay2
			
				DehyBest:		output		genericLbl, dehyBestLbl		; User got best outcome (spent 20+ supplies)
								sub			foodCount, eax
								inc dDayCount							; jumps to start and increments day counter
								jmp dDay2

Rocks:													; Begins Rockslide event

		output		genericLbl, strRocks				; displays Rockslide event intro

rRand:	mov			divide, 2							; two possible options in rockslide
		call		randGen

		cmp			edx, 0								; compares random number and jumps to the worse option
		je			Rock1

		cmp			edx, 1								; compares random number and jumps to the better option
		je			Rock2

		jmp			rRand

			Rock1:
						output			genericLbl, rock1Lbl			; displays rockslide result
						sub				oxenCount, 2					; oxen damage
						sub				foodCount, 30					; supply damage
						sub				wagHealth, 50					; wagon damage
						sub				peopleCount, 1					; people damage
						inc dDayCount									; jumps to start and increments day counter
						jmp dDay2

			Rock2:
						output			genericLbl, strRock2			; displays rockslide result message
						sub				wagHealth, 30					; wagon damage
						sub				oxenCount, 1					; oxen damage
						inc dDayCount									; jumps to start and increments day counter
						jmp dDay2

Block: 																	; Begins Blocked Canyon event

	output		genericLbl, strBlock					; Displays Blocked Canyon event intro
	output		genericLbl, strBlockInput
	input		prompt2, string, 40						; asks player for their choice
	atod		string									; converts input and stores in EAX

	cmp			eax, 1
	je			Block1									; jumps to the unblock option
	
				output genericLbl, block2Lbl			; displays long way around message
				;*****edx day counter + 3*****			; moves time 3 days
				inc dDayCount							; jumps to start and increments day counter
				jmp dDay2
	Block1:		
				output genericLbl, block1Lbl			; displays the move boulder message
				sub foodCount, 20						; decreases supplies
				inc dDayCount							; jumps to start and increments day counter
				jmp dDay2

Cacti: 													; Begins Cactus event

	output		genericLbl, strCacti					; displays Cactus event intro
	output		genericLbl, strCactiInput
	input		prompt2, string, 40						; asks player for their choice
	atod		string									; converts input and stores in EAX

	cmp			eax, 1
	je			NoCacti

	mov			divide, 10															
	call		randGen									; calls random to provide 1 in 10 chance of bad cactus

		cmp			edx, 9								; jumps to bad option if you got a 9, otherwise skips
		je			CactiBad

		output			genericLbl, cactus1Lbl			; displays cactus collection message
		add				foodCount, 30					; adds to supplies
		inc dDayCount									; jumps to start and increments day counter
		jmp dDay2

	CactiBad:
				output genericLbl, cactus2Lbl
				inc dDayCount							; jumps to start and increments day counter
				jmp dDay2

	NoCacti:
				output genericLbl, cactiPassLbl
				inc dDayCount							; jumps to start and increments day counter
				jmp dDay2

Wreck: 													; Begins Wrecked Wagon event

	output		genericLbl, strWreck					; displays Wrecked Wagon event
	output		genericLbl, strWreckInput
	input		strWreckInput, string, 40				; user inputs choice
	atod		string									; converts input and stores in EAX

	cmp			eax, 1									; checks option selection
	je			Wreck1									; jumps to Wreck 1 option if chosen

	output		genericLbl, wreck2Lbl					; displays supply message
	add			foodCount, 20							; adds to supplies
	inc dDayCount										; jumps to start and increments day counter
	jmp dDay2

	Wreck1:
			output		genericLbl, wreck1Lbl			; displays wagon health message
			add			wagHealth, 30					; adds to wagon health
			inc dDayCount								; jumps to start and increments day counter
			jmp dDay2	

;********************************************************************************
;*							  End of Scenario Zero								*
;********************************************************************************

;********************************************************************************
;*								   Scenario One									*
;*																				*
;*							Written by: Luke Noramczyk							*
;********************************************************************************

scenario1:											;Scenario 1 code start.				
	output genericLbl, blizzardIntro				;Outputting scenario event message.
	mov divide, 3									;Moving 3 into divide.
	call randGen									;Calling randGen procedure.
	cmp edx, 1										;Comparing the value held in EDX to 1.
	jl blizzardOne									;If less than 1 jumping to blizzardOne.
	je blizzardTwo									;If equal jumping to blizzardTwo.
	jmp blizzardThree								;Jumping to blizzardThree.

	blizzardOne:									;blizzardOne code start.
		output genericLbl, blizzard1				;Outputting message.
		jmp turnEnd									;Jumping to turnEnd.

	blizzardTwo:									;blizzardTwo code start.
		output genericLbl, blizzard2				;Outputting message.
		sub		foodCount, 20						;Subtracting twenty from the foodCount.
		jmp turnEnd									;Jumping to turnEnd,

	blizzardThree:									;blizzardThree code start.
		output genericLbl, blizzard3				;Outputting message.
		sub		foodCount, 20						;Subracting twenty from the foodCount.
		sub		oxenCount, 2						;Subtracting two from the oxenCount.
		inc		ecx									;Incrementing ECX.
		jmp turnEnd									;Jumping to turnEnd.

;********************************************************************************
;*							  End of Scenario One								*
;********************************************************************************

;********************************************************************************
;*								   Scenario Two									*
;*																				*
;*							Written by: Luke Noramczyk							*
;********************************************************************************

scenario2:											;Scenario 2 code start.
	output genericLbl, riverCrossingI				;Outputting scenery event message.
	mov divide, 3									;Moving 3 to divide.
	call randGen									;Calling randGen procedure.
	cmp edx, 1										;Comparing the value in EDX to 1.
	jl riverCrossingOne								;If less than 1 jumping to riverCrossingOne.
	je riverCrossingTwo								;If equal to 1 jumping to riverCrossingTwo.
	jmp riverCrossingThree							;Jumping to riverCrossingThree.

	riverCrossingOne:								;riverCrossingOne code start.
		output genericLbl, riverCrossing1			;Outputting message.
		jmp turnEnd									;Jumping to turnEnd

	riverCrossingTwo:								;riverCrossingTwo code start.
		output genericLbl, riverCrossing2			;Outputting message.
		sub		wagHealth, 100						;Subtracting 100 health from the wagon.
		jmp turnEnd									;Jumping to turnEnd

	riverCrossingThree:								;riverCrossingThree code start.
		output genericLbl, riverCrossing3			;Outputting message.
		sub		wagHealth, 100						;Subracting 100 health from the wagon.
		dec		peopleCount							;Decrementing peopleCount.
		jmp turnEnd									;Jumping to turnEnd

;********************************************************************************
;*							  End of Scenario Two								*
;********************************************************************************

;********************************************************************************
;*								   Scenario Three								*
;*																				*
;*							Written by: Luke Noramczyk							*
;********************************************************************************

scenario3:											;Scenario 3 code start.	
	output genericLbl, brokenWheelI					;Outputting scenery event message.
	sub	wagHealth, 25								;Subtracting 25 health from the wagon.
	mov divide, 2									;Moving 2 to divide.
	call randGen									;Calling randGen.
	cmp edx, 1										;Comparing the value in EDX to 1.
	jl brokenWheelOne								;If less than one jumping to brokenWheelOne.
	jmp brokenWheelTwo								;Else, jumping to brokenWheelTwo.

	brokenWheelOne:									;brokenWheelOne code start.
		output genericLbl, brokenWheel1				;Outputting message.
		sub	foodCount, 10							;Subtracting 10 from the foodCount.
		jmp turnEnd									;Jumping to the turnEnd.

	brokenWheelTwo:									;brokenWheelTwo code start.
		output genericLbl, brokenWheel2				;Outputting message.
		sub		foodCount, 20						;Subtracting twenty from the food count.
		inc	ecx										;Incrementing the turn counter.
		jmp turnEnd									;Jumping to turnEnd.

;********************************************************************************
;*							  End of Scenario Three								*
;********************************************************************************

;********************************************************************************
;*								   Scenario Four								*
;*																				*
;*							Written by: Quinn Roemer							*
;********************************************************************************

scenario4:
	dec	ecx									;Reducing turn counter by 1.
	output genericLbl, strEveryFine			;Informing user that everything is fine.
	jmp turnEnd								;Jumping to turnEnd

;********************************************************************************
;*							  End of Scenario Four								*
;********************************************************************************

;********************************************************************************
;*								   Scenario Five								*
;*																				*
;*							Written by: Nickolas Lohn							*
;********************************************************************************

scenario5:

	Lost:										; Begin Lost Scenario
		mov		DayCount, 0						; resets internal counter used in case of shortcut option
		
		mov		divide, 2						; chooses 2 different starts
		call	randGen											

		cmp		edx, 0											
		je		LostIn1											

		cmp		edx, 1											
		je		LostIn2											

		LostIn1:								; Start 1 - stream
			output	genericLbl, strLostIn1
			input	LostIn1Lbl, string, 40
			atod	string
			cmp		eax, 1
			je		LostD1						; options from stream
			jmp		LostD3

		LostIn2:								; Start 2 - bluff
			output	genericLbl, strLostIn2		; description
			input	LostIn2Lbl, string, 40		; input choices
			atod	string
			cmp		eax, 1
			je		LostD2						; options for bluff
			jmp		LostD4

		LostD1:									; Cross stream options
			inc		DayCount									
			;inc		ecx							; makes journey longer a day								
			output	genericLbl, strLostD1		; description
			input	lostD1Lbl, string, 40		; input choices
			atod	string
			cmp		eax, 1
			je		LostHills					; jump to hills
			jmp		LostLake					; jump to lake

		LostD2:									; Follow down bluff options
			inc		DayCount
			;inc		ecx							; makes journey longer a day
			output	genericLbl, strLostD2		; description
			input	lostD2Lbl, string, 40		; input
			atod	string
			cmp		eax, 1
			je		LostForest					; jump to forest
			jmp		LostGrass					; jump to grassland

		LostD3:									; Follow stream options
			inc		DayCount
			;inc		ecx							; makes journey longer a day
			output	genericLbl, strLostD3		; description
			input	lostD3Lbl, string, 40		; input
			atod	string
			cmp		eax, 1
			je		LostLake					; jump to lake
			jmp		LostForest					; jump to forest

		LostD4:									; Follow up bluff options
			inc		DayCount
			;inc		ecx							; makes journey longer a day
			output	genericLbl, strLostD4		; description
			input	lostD4Lbl, string, 40		; input
			atod	string
			cmp		eax, 1
			je		LostGrass					; jump to grassland
			jmp		LostHills					; jump to hills
									
		LostForest:
			mov		divide, 15					; 1/15 chance to find the trail
			mov		eax, DayCount				; modified by the amount of days wandering
			sub		divide, eax					; before calling randGen
			call	randGen										
			cmp		edx, 0	
			je		LostEnd						; finally hit the number, you leave scenario

			inc		DayCount
			;inc		ecx							; makes journey longer a day
			output	genericLbl, strLostForest	; description
			input	lostForestLbl, string, 40	; input
			atod	string
			cmp		eax, 1
			je		LostCave					; jump to cave
			jmp		LostLake					; jump to lake
			
		LostCave:
			mov		divide, 15					; 1/15 chance to find the trail
			mov		eax, DayCount				; modified by the amount of days wandering
			sub		divide, eax					; before calling randGen
			call	randGen
			cmp		edx, 0
			je		LostEnd						; finally hit the number, leave scenario

			inc		DayCount
			;inc		ecx							; makes journey longer a day
			output	genericLbl, strLostCave		; description
			input	lostCaveLbl, string, 40		; input
			atod	string
			cmp		eax, 1
			je		LostLake					; jump to lake
			jmp		LostGrass					; jump to grassland

		LostGrass:
			mov		divide, 15					; 1/15 chance to find the trail
			mov		eax, DayCount				; modified by the amount of days wandering
			sub		divide, eax					; before calling randGen
			call	randGen
			cmp		edx, 0
			je		LostEnd						; finally hit the number, leave scenario

			inc		DayCount
			;inc		ecx							; makes journey longer a day
			output	genericLbl, strLostGrass	; description
			input	lostGrassLbl, string, 40	; input
			atod	string
			cmp		eax, 1
			je		LostForest					; jump to forest
			jmp		LostHills					; jump to hills

		LostLake:
			mov		divide, 15					; 1/15 chance to find the trail
			mov		eax, DayCount				; modified by the amount of days wandering
			sub		divide, eax					; before calling randGen
			call	randGen
			cmp		edx, 0
			je		LostEnd						; finally hit the number, leave scenario

			inc		DayCount
			;inc		ecx							; makes journey longer a day
			output	genericLbl, strLostLake		; description
			input	lostLakeLbl, string, 40		; input
			atod	string
			cmp		eax, 1
			je		LostHills					; jump to hills
			jmp		LostGrass					; jump to grassland

		LostHills:
			mov		divide, 15					; 1/15 chance to find the trail
			mov		eax, DayCount				; modified by the amount of days wandering
			sub		divide, eax					; before calling randGen
			call	randGen
			cmp		edx, 0
			je		LostEnd						; finally hit the number, leave scenario

			inc		DayCount
			;inc		ecx							; makes journey longer a day
			output	genericLbl, strLostHills	; description
			input	lostHillLbl, string, 40		; input
			atod	string
			cmp		eax, 1
			je		LostForest					; jump to forest
			jmp		LostCave					; jump to cave

		Shortcut:
			output	genericLbl, strLostShort	; shortcut message
			sub		ecx, DayCount				; removes days off external counter
			sub		ecx, 3						; removes extra 3 for shortcut
			jmp		turnEnd						; leave scenario

		LostEnd:
			add ecx, 2							;Adding 2 turns to the turn counter.
			mov divide, 20						; 5% chance to get the shortcut option
			call randGen						; calls for random
			cmp edx, 1
			je Shortcut							; jumps to shortcut if you luck out
			output	genericLbl, strLostEnd		; displays normal exit message if not
			jmp turnEnd							; leave scenario

;********************************************************************************
;*							  End of Scenario Five								*
;********************************************************************************

;********************************************************************************
;*								   Scenario Six									*
;*																				*
;*							 Written by: Nabil Furmoli							*
;********************************************************************************

scenario6:										;Scenario 6 code start.
output genericLbl, scen6Intro					;Outputting scenario Intro.
output genericLbl, humDisease					;Outputting message.

mov divide, 4									;Moving 4 to divide.		
call randGen									;Calling randGen

	cmp edx, 0									;Comparing the value in EDX to 0.
	je humDis0									;If equal jumping to humDis0.

	cmp edx, 1									;Comparing the value in EDX to 1.
	je humDis1									;If equal jumping to humDis1.

	cmp edx, 2									;Comparing the value in EDX to 2.
	je humDis2									;If equal jumping to humDis2.

	jmp humDis3									;Else, jumping to humDis3.

humDis0:										;humDis0 code start.
	dtoa humLeft, peopleCount					;Converting peopleCount to ASCII
	output genericLbl, humDisease0				;Outputting message.
	output genericLbl, humLeft					;Outputting number of people left.
	jmp Dexit									;Jumping to Dexit.

humDis1:										;humDis1 code start.
	dec peopleCount								;Decrementing peopleCount.
	dtoa humLeft, peopleCount					;Converting peopleCount to ASCII.
	output genericLbl, humDisease1				;Outputting message.
	output genericLbl, humLeft					;Outputting number of people left.
	jmp Dexit									;Jumping to Dexit.

humDis2:										;humDis2 code start.
	dec peopleCount								;Decrementing peopleCount.
	dtoa humLeft, peopleCount					;Converting peopleCount to ASCII.
	output genericLbl, humDisease2				;Outputting message.
	output genericLbl, humLeft					;Outputting number of people left.
	jmp Dexit									;Jumping to Dexit.

humDis3:										;humDis3 code start.
	sub peopleCount, 2							;Subtracting two from the peopleCount.
	dtoa humLeft, peopleCount					;Converting peopleCount to ASCII.
	output genericLbl, humDisease3				;Outputting message.
	output genericLbl, humLeft					;Outputting the number of people left.
	jmp Dexit									;Jumping to Dexit.

Dexit:											;Dexit code start.
	jmp turnEnd									;Jumping to turnEnd.

;********************************************************************************
;*							     End of Scenario Six		 					*
;********************************************************************************

;********************************************************************************
;*								   Scenario Seven								*
;*																				*
;*							   Written by: Cody Clark							*
;********************************************************************************

scenario7:										;Scenario 7 code start.
	output		genericLbl, sevenPart1			;Outputting scenario event message.
	input		sevenPart2, string, 40			;Reading input.
	atod		string							;Converting to HEX and storing in EAX.
	cmp			eax, 0							;Comparing EAX to 0.
	je			sevenPicked0					;If equal jumping to sevenPicked0.
	jmp			sevenPicked1					;Else, jumping to sevenPicked1.

sevenPicked0:									;sevenPicked0 code start.
		output		genericLbl, sevenChoice0	;Outputting message.
		dec			oxenCount					;Decrementing oxenCount.
		jmp			turnEnd						;Jumping to turnEnd.

sevenPicked1:									;sevenPicked1 code start.
		mov			divide, 3					;Moving 3 to divide.
		call		randGen						;Calling randGen.
		cmp			edx, 1						;Comparing EDX to 1.
		jl			sevenOutcome1				;If less than 1, jumping to sevenOutcome1.
		je			sevenOutcome2				;If equal, jumping to sevenOutcome2.
		jmp			sevenOutcome3				;Else, jumping to sevenOutcome3.

sevenOutcome1:									;sevenOutcome1 code start.
		output	genericLbl, sevenOutcome1Lbl	;Outputting message.
		jmp			turnEnd						;Jumping to turnEnd.

sevenOutcome2:									;sevenOutcome2 code start.
		output	genericLbl, sevenOutcome2Lbl	;Outputting message.
		dec			oxenCount					;Decrementing oxenCount.
		jmp			turnEnd						;Jumping to turnEnd.

sevenOutcome3:									;sevenOutcome3 code start.
		output	genericLbl, sevenOutcome3Lbl	;Outputting message.
		mov			eax, oxenCount				;Moving oxenCount to EAX.
		sub			eax, 5						;Subtracting 5 from the value in EAX.
		mov			oxenCount, eax				;Moving the value in EAX to oxenCount.
		jmp			turnEnd						;Jumping to turnEnd.

;********************************************************************************
;*							  End of Scenario Seven								*
;********************************************************************************

;********************************************************************************
;*								   Scenario Eight								*
;*																				*
;*							   Written by: Nabil Furmoli						*
;********************************************************************************

scenario8:										;Scenario 8 code start.
output genericLbl, scen8Intro					;Outputting scenery event message.
output genericLbl, humLost						;Outputting message.

mov divide, 11									;Moving 11 to divide.
call randGen									;Calling randGen procedure.

	cmp edx, 0									;Comparing the value in EDX to 0.
	je case0									;If equal, jumping to case0.

	cmp edx, 1									;Comparing the valude in EDX to 1.
	je case1									;If equal, jumping to case1.

	cmp edx, 2									;Comparing the valude in EDX to 2.
	je case2									;If equal, jumping to case2.

	cmp edx, 3									;Comparing the valude in EDX to 3.
	je case3									;If equal, jumping to case3.

	cmp edx, 4									;Comparing the valude in EDX to 4.
	je case4									;If equal, jumping to case4.

	cmp edx, 5									;Comparing the valude in EDX to 5.
	je case5									;If equal, jumping to case5.

	cmp edx, 6									;Comparing the valude in EDX to 6.
	je case6									;If equal, jumping to case6.

	cmp edx, 7									;Comparing the valude in EDX to 7.
	je case7									;If equal, jumping to case7.

	cmp edx, 8									;Comparing the valude in EDX to 8.
	je case8									;If equal, jumping to case8.

	cmp edx, 9									;Comparing the valude in EDX to 9.
	je case9									;If equal, jumping to case9.

	jmp case10									;Else, jumping to case10.


case0:											;case 0 code start.	
	dtoa humLeft, peopleCount					;Converting peopleCount to ASCII.
	output humLost0, humLeft					;Outputting message.
	dtoa animLeft, oxenCount					;Converting oxenCount to ASCII.
	output animLost0, animLeft					;Outputting message.
	jmp exit									;Jumping to exit.

case1:											;case 1 code start.	
	sub oxenCount, 1							;Subtracting 1 from the oxenCount.
	dtoa humLeft, peopleCount					;Converting peopleCount to ASCII.
	output humLost0, humLeft					;Outputting message.
	dtoa animLeft, oxenCount					;Converting oxenCount to ASCII.
	output animLost1, animLeft					;Outputting message.
	jmp exit									;Jumping to exit.

case2:											;case 2 code start.	
	sub oxenCount, 2							;Subtracting 2 from the oxenCount.
	dtoa humLeft, peopleCount					;Converting peopleCount to ASCII.
	output humLost0, humLeft					;Outputting message.
	dtoa animLeft, oxenCount					;Converting oxenCount to ASCII.
	output animLost3, animLeft					;Outputting message.
	jmp exit									;Jumping to exit.

case3:											;case 3 code start.	
	sub oxenCount, 3							;Subtracting 3 from the oxenCount
	dtoa humLeft, peopleCount					;Converting peopleCount to ASCII.
	output humLost0, humLeft					;Outputting message.
	dtoa animLeft, oxenCount					;Converting oxenCount to ASCII.
	output animLost6, animLeft					;Outputting message.
	jmp exit									;Jumping to exit.

case4:											;case 4 code start.	
	dec peopleCount								;Decrementing peopleCount.
	dtoa humLeft, peopleCount					;Converting peopleCount to ASCII.
	output humLost1, humLeft					;Outputting message.
	dtoa animLeft, oxenCount					;Converting oxenCount to ASCII.
	output animLost0, animLeft					;Outputting message.
	jmp exit									;Jumping to exit.

case5:											;case 5 code start.	
	dec peopleCount								;Decrementing peopleCount.
	sub oxenCount, 1							;Subtracting 1 from the oxenCount.
	dtoa humLeft, peopleCount					;Converting peopleCount to ASCII.
	output humLost1, humLeft					;Outputting message.
	dtoa animLeft, oxenCount					;Converting oxenCount to ASCII.
	output animLost1, animLeft					;Outputting message.
	jmp exit									;Jumping to exit.

case6:											;case 6 code start.	
	dec peopleCount								;Decrementing peopleCount.
	sub oxenCount, 2							;Subtracting 2 from the oxenCount.
	dtoa humLeft, peopleCount					;Converting peopleCount to ASCII.
	output humLost1, humLeft					;Outputting message.
	dtoa animLeft, oxenCount					;Converting oxenCount to ASCII.
	output animLost3, animLeft					;Outputting message.
	jmp exit									;Jumping to exit.

case7:											;case 7 code start.	
	dec peopleCount								;Decrementing peopleCount.
	sub oxenCount, 3							;Subtracting 3 from the oxenCount.
	dtoa humLeft, peopleCount					;Converting peopleCount to ASCII.
	output humLost1, humLeft					;Outputting message.
	dtoa animLeft, oxenCount					;Converting oxenCount to ASCII.
	output animLost5, animLeft					;Outputting message.
	jmp exit									;Jumping to exit.

case8:											;case 8 code start.	
	sub peopleCount, 2							;Subtracting 2 from peopleCount.
	dtoa humLeft, peopleCount					;Converting peopleCount to ASCII.
	output humLost2, humLeft					;Outputting message.
	dtoa animLeft, oxenCount					;Converting oxenCount to ASCII.
	output animLost0, animLeft					;Outputting message.
	jmp exit									;Jumping to exit.

case9:											;case 9 code start.	
	sub peopleCount, 2							;Subtracting 2 from the peopleCount.
	sub oxenCount, 1							;Subtracting 1 from the oxenCount.
	dtoa humLeft, peopleCount					;Converting peopleCount to ASCII.
	output humLost1, humLeft					;Outputting message.
	dtoa animLeft, oxenCount					;Converting oxenCount to ASCII.
	output animLost2, animLeft					;Outputting message.
	jmp exit

case10:											;case 10 code start.	
	sub peopleCount, 2							;Subtracting 2 from the peopleCount.
	sub oxenCount, 2							;Subtracting 2 from the oxenCount.
	dtoa humLeft, peopleCount					;Converting peopleCount to ASCII.
	output humLost2, humLeft					;Outputting message.
	dtoa animLeft, oxenCount					;Converting oxenCount to ASCII.
	output animLost3, animLeft					;Outputting message.
	jmp exit									;Jumping to exit.

exit:											;exit code start.
	jmp turnEnd									;Jumping to turnEnd.

;********************************************************************************
;*							  End of Scenario Eight								*
;********************************************************************************

;********************************************************************************
;*								  Scenario Nine									*
;*																				*
;*							 Written by: Ahmad Furmoli							*
;******************************************************************************** 

scenario9:
	output genericLbl, scen9Intro				;Outputting scenery event message.

	mov divide, 6								;Moving 6 to divide.
	call randGen								;Calling randGen procedure.

	cmp edx, 0									;Comparing 0 to EDX.
	je Acase0									;If equal, jumping to Acase0.

	cmp edx, 1									;Comparing 1 to EDX.
	je Acase1									;If equal, jumping to Acase1.

	cmp edx, 2									;Comparing 2 to EDX.
	je Acase2									;If equal, jumping to Acase2.

	cmp edx, 3									;Comparing 3 to EDX.
	je Acase3									;If equal, jumping to Acase3.

	cmp edx, 4									;Comparing 4 to EDX.
	je Acase4									;If equal, jumping to Acase4.

	jmp Acase5									;Else, jumping to Acase5.

Acase0:											;Acase0 code start.
	output genericLbl, lostHum0					;Outputting message.
	jmp Aexit									;Jumping to Aexit.

Acase1:											;Acase1 code start.
	dec peopleCount								;Decrementing peopleCount.
	output genericLbl, lostHum1					;Outputting message.
	dtoa humLeft, peopleCount					;Converting peopleCount to ASCII.
	output genericLbl, humLeft					;Outputting message.
	jmp Aexit									;Jumping to Aexit.

Acase2:											;Acase2 code start.
	dec oxenCount								;Decrementing oxenCount.
	dtoa animLeft, oxenCount					;Converting oxenCount to ASCII.
	output genericLbl, lostAnimal1				;Outputting message.
	output genericLbl, animLeft					;Outputting message.
	jmp Aexit									;Jumping to Aexit.

Acase3:											;Acase3 code start.
	sub oxenCount, 2							;Subtracting 2 from the oxenCount.
	dtoa animLeft, oxenCount					;Converting oxenCount to ASCII.
	output genericLbl, lostAnimal2				;Outputting message.
	output genericLbl, animLeft					;Outputting message.
	jmp Aexit									;Jumping to Aexit.

Acase4:											;Acase4 code start.
	sub oxenCount, 3							;Subtracting 3 from the oxenCount.
	dtoa animLeft, oxenCount					;Converting oxenCount to ASCII.
	output genericLbl, lostAnimal3				;Outputting message.
	output genericLbl, animLeft					;Outputting message.
	jmp Aexit									;Jumping to Aexit.

Acase5:											;Acase5 code start.
	sub oxenCount, 4							;Subtracting 4 from the oxenCount.
	dtoa animLeft, oxenCount					;Converting oxenCount to ASCII.
	output genericLbl, lostAnimal4				;Outputting message.
	output genericLbl, animLeft					;Outputting message.
	jmp Aexit									;Jumping to Aexit.

Aexit:											;Aexit code start.
	jmp turnEnd									;Jumping to turnEnd.

;********************************************************************************
;*								  Scenario Ten									*
;*																				*
;*							 Written by: Cody Clark								*
;********************************************************************************

scenario10:										;Scenario 10 code start.
	output		genericLbl, tenPart1			;Outputting message.
	input		tenPart2, string, 40			;Reading input.
	atod		string							;Converting value to HEX and storing in EAX.
	cmp			eax, 0							;Comparing EAX to 0.
	je			tenPicked0						;If equal, jumping to tenPicked0
	jmp			tenPicked1						;Else, jumping to tenPicked1.

tenPicked0:										;tenPicked0 code start.
		output		genericLbl, tenChoice0		;Outputting message.
		sub			foodCount, 20				;Subtracting 20 from the foodCount.
		jmp			turnEnd

tenPicked1:										;tenPicked1 code start.
		mov			divide, 3					;Moving 3 to divide.
		call		randGen						;Calling ranGen procedure.
		cmp			edx,	1					;Comparing value in EDX to 1.
		jl			tenOutcome1					;If less, jumping to tenOutcome1.
		je			tenOutcome2					;If equal, jumping to tenOutcome2.
		jmp			tenOutcome3					;Else, jumping to tenOutcome3.

tenOutcome1:									;tenOutcome1 code start.
		output		genericLbl, tenOutcome1Lbl	;Outputting message.
		jmp			turnEnd						;Jumping to turnEnd.

tenOutcome2:									;tenOutcome2 code start.
		output		genericLbl, tenOutcome2Lbl	;Outputting message.
		sub			foodCount, 20				;Subtracting 20 from the foodCount.
		jmp			turnEnd						;Jumping to turnEnd.

tenOutcome3:									;tenOutcome3 code start.
		output		genericLbl, tenOutcome3Lbl	;Outputting message.
		sub			foodCount, 20				;Subtracting 20 from the foodCount.
		dec			peopleCount					;Decrementing peopleCount.
		jmp			turnEnd						;Jumping to turnEnd.

;********************************************************************************
;*							  End of Scenario Ten								*
;********************************************************************************

;********************************************************************************
;*		     This section contains the code for the end of the turn.			*
;*																				*
;*							Written By: Quinn Roemer							*
;********************************************************************************

turnEnd:
		sub foodCount, 10						;Reducing food amount by 10.

		output	genericLbl, turnProgressed		;Outputting that a turn has progressed.

		dtoa	string, peopleCount				;Outputting number of people left.
		output	peopleLeft, string
				
		dtoa	string, oxenCount				;Outputting number of oxen left.
		output	oxenLeft, string

		dtoa	string, foodCount				;Outputting amount of food left.
		output	foodLeft, string

		dtoa	string, wagHealth				;Outputting wagon health.
		output	wagHealthLeft, string

		mov		eax, ecx						;Outputting number of turns left.
		dec		eax
		dtoa	string, eax						
		output	turnLeft, string		

		jmp		loopStart						;Jumping to loopStart.

;********************************************************************************
;*			   This section of code contains the logic for all of the			*
;*							   player lost conditions							*
;*																				*
;*							  Written By: Quinn Roemer	        				*
;********************************************************************************

lostPeople:										;lostPeople code start.
	output genericLbl, peopleDead				;Informing the player that all of there people have died.
	jmp playerLost								;Jumping to playerLost.

lostOxen:										;lostOxen code start.
	output genericLbl, oxenDead					;Informing the player that all of there oxen have died.
	jmp playerLost								;Jumping to playerLost.

lostFood:										;lostFood code start.
	output genericLbl, foodGone					;Informing the player that all of there food is gone.
	jmp playerLost								;Jumping to playerLost

lostWag:										;lostWag code start.
	output genericLbl, wagGone					;Informing the player that their wagon's health is gone.
	jmp playerLost								;Jumping to playerLost.

;********************************************************************************
;*	 This section of code contains the logic for the lose or win game ends.		*
;*																				*
;*							Written By: Quinn Roemer							*
;********************************************************************************

playerWin:										;playerWin code start.
	output genericLbl, playerVictory			;Informing the player of their victory.
	jmp Quit									;Jumping to Quit.

playerLost:										;playerLost code start.
	output genericLbl, playerFail				;Informing the player of their lost.
	jmp Quit									;Jumping to Quit.

;********************************************************************************
;*	     This section of code contains the logic for quiting the program		*
;*																				*
;*							Written By: Quinn Roemer							*
;********************************************************************************

Quit:											;Quit code start.
	mov eax, 0									;Setting EAX to 0.
	ret											;Returning.

_MainProc ENDP									;MainProc End.

;********************************************************************************
;*  	  This section contains the code for the random number generator		*
;*  																			*
;*			Note: This randGen uses the formula ((a * seed) + b) % mod.			*
;*																				*
;*	 To get a number within a certain range set divide to one above the range	*
;*								 before calling.								*
;*																				*
;*	 Please call this procedure before storing values in EAX. It erases the		*
;*							  current value of EAX.								*
;*																				*
;*     After calling this procedure your random number will be stored in EDX.	*
;*																				*
;*							Written By: Quinn Roemer							*
;********************************************************************************

randGen PROC									;Begin randGen procedure.

mov		eax, randSeed							;Move the value in randSeed to EAX.

mul		randMult								;Multiply by the value in randMult.
inc		randMult								;Increment randMult.

add		eax, lastRand							;Add the value in lastRand to EAX.

rol eax, 2										;Moving the value in EAX left 2 places.

mov		randSeed, eax							;Move the value in EAX to randSeed.

mov		edx, 0									;Set EDX to 0.

div		divide									;Dividing EAX my the divisor held in divide.

mov		lastRand, edx							;Moving the value in EDX to lastRand.

ret												;Returning.

randGen ENDP									;End of randGen

END												;End of Program.