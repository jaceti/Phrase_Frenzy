//
//  VelveetaGame.m
//  Velveeta
//
//  Created by Alexei Rudak on 09/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CatchPhraseGame.h"
#import "CJSONDeserializer.h"
#import "Question.h"
#import "VSUtils.h"
#import <GameKit/GameKit.h>
#import "CatchPhraseAppDelegate.h"




@implementation CatchPhraseGame

static CatchPhraseGame *sharedInstance = nil;
@synthesize gamePlayedCount;
@synthesize soundEffectID;
@synthesize gameQuestions;
@synthesize roundSecondsPassed;
@synthesize roundTimer;
@synthesize part1,part2,part3,part4;
// Music playing

@synthesize soundEnable;
@synthesize buzzerSoundPlaying;

@synthesize questionArray;
@synthesize currentQuestionIndex;
@synthesize secondsPassed;
@synthesize globalSecondsPassed;
@synthesize currentQuestion;
@synthesize gameInProgress;

@synthesize team1Name;
@synthesize team2Name;

@synthesize pointsToWin;
@synthesize selectedCategoryIndex;
@synthesize buzzerSoundIndex;

@synthesize team1Score;
@synthesize team2Score;

@synthesize categoriesArray;
@synthesize buzzerSoundsArray;

@synthesize delegate;
@synthesize isPause;
@synthesize repeatedArray;
@synthesize allWordsArray;
@synthesize fifthGamePlayed;
@synthesize reviewed;


@synthesize cumulativeGamesPlayedNumber;



+ (CatchPhraseGame *)sharedInstance 
{
	@synchronized(self) {
		if (sharedInstance == nil)
			sharedInstance = [[self alloc] init]; 
	}
	return sharedInstance;
}

-(id)init
{
	if(self = [super init])
	{
		questionArray = [[NSMutableArray alloc] init];
		allWordsArray  = [[NSMutableArray alloc] init];
        gameQuestions = [[NSMutableArray alloc] init];
        categoriesArray =  [[[NSMutableArray alloc] init] retain];
        
        buzzerSoundsArray = [[NSMutableArray arrayWithObjects:@"Alarm", @"Alarm clock", @"Bell", @"Bullet",@"Buzzer",@"Chimpanzee",@"Dog barking",@"Foghorn",@"Glass breaking",@"Kids",@"Music riff",@"Oh no!",@"Rooster",@"School bell",@"Scream",@"Sheep",@"Siren",@"Squeaky toy",@"Thunder",@"UFO",@"Random", nil] retain];
        
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sound_alarm.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sound_alarmclock.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sound_bell.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sound_bullet.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sound_buzzer.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sound_chimp.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sound_dogbark.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sound_foghorn.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sound_glassbreak.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sound_kids.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sound_rockriff.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"OhNo.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sound_rooster.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sound_schoolbell.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"Scream.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sound_sheep.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sound_siren.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sound_squeaktoy.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sound_thunder.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sound_ufo.mp3"];
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"Timer_01.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"SFX_Bloop_03_Up.wav"];
        
        
        [self loadGameData];
	}
	return self;
}

-(NSString*) getTeamDefaultName:(NSInteger) teamNumber
{
    if(teamNumber == 1)
        return (team1Name == nil) ? @"Team 1":team1Name;
    else if(teamNumber == 2)
        return (team2Name == nil) ? @"Team 2":team2Name;
    else return nil;
}



-(NSString*) getWinnerTeamName
{
    if(team1Score >= pointsToWin)
        return team1Name;
    
    if(team2Score >= pointsToWin)
        return team2Name;
    
    return nil;
}

- (void)dealloc 
{
    [questionArray release];
    [repeatedArray release];
    [gameQuestions release];
    [categoriesArray release];
    [buzzerSoundsArray release];
    
    [super dealloc];
}

-(void) initGame
{
    //pointsToWin = 7;
    //selectedCategoryIndex = 0;
    //buzzerSoundIndex = 0;
    team1Score = team2Score = 0;
    buzzerSoundPlaying = -1;
}

-(NSString*) getCategoryNameByCurrentIndex
{
    return [categoriesArray objectAtIndex:selectedCategoryIndex];
}

-(NSString*) getBuzzerSoundByCurrentIndex
{
    return [buzzerSoundsArray objectAtIndex:buzzerSoundIndex];
}

-(void) playTest:(NSString*) file 
{
    if(file!=nil)
    {
        //if(soundEffectID!=0)
        //    [[SimpleAudioEngine sharedEngine] stopEffect:soundEffectID];
        
        soundEffectID = [[SimpleAudioEngine sharedEngine] playEffect:file];
    }
}

-(NSInteger) playSoundSAE:(NSString*) file
{
    //[self performSelectorInBackground:@selector(playTest:) withObject:file];
    soundEffectID = [[SimpleAudioEngine sharedEngine] playEffect:file];
    return soundEffectID;
   
}

-(void)stopSoundsSAE
{
    [[SimpleAudioEngine sharedEngine] stopEffect:soundEffectID];
}

-(void)stopSoundSAE:(ALuint)snd
{
    [[SimpleAudioEngine sharedEngine] stopEffect:snd];
    
}

- (void)playSound:(MCsounds)snd {
	
    
    soundEnable = YES;
    
    if(soundEnable)
    {
        NSString *path = nil;
        
        switch (snd) {
            case MCBUZZ1:
                //path = [[NSBundle mainBundle] pathForResource:@"Buzzer_1" ofType:@"wav"];
                [self playSoundSAE:@"Buzzer_1.wav"];
                break;
            case MCBUZZ2:
                //path = [[NSBundle mainBundle] pathForResource:@"Buzzer_2" ofType:@"wav"];
                [self playSoundSAE:@"Buzzer_2.wav"];
                break;
            case MCBUZZ_OHNO:
                path = [[NSBundle mainBundle] pathForResource:@"OhNo" ofType:@"wav"];
                break;
            case MCBUZZ_WOMAN_SCREAM:
                //path = [[NSBundle mainBundle] pathForResource:@"Scream" ofType:@"wav"];
                [self playSoundSAE:@"Scream.wav"];
                break;
            case MCTimer:
                //path = [[NSBundle mainBundle] pathForResource:@"Timer_01" ofType:@"wav"];
                [self playSoundSAE:@"Timer_01.wav"];
                break;
            case MCsoundWrongAnswer:
                path = [[NSBundle mainBundle] pathForResource:@"SFX_Answer_Wrong" ofType:@"aif"];
                break;
            case MCsoundButtonClick:
                //path = [[NSBundle mainBundle] pathForResource:@"SFX_ButtonBeep_01" ofType:@"aif"];
                [self playSoundSAE:@"SFX_Bloop_03_Up.wav"];
                break;
            default:
                break;
        }
        
        
    }
	
}


-(void) nextRound
{
    roundSecondsPassed = 0;
    
    part1 = arc4random() % 10;
    part2 = arc4random() % 10;
    part3 = arc4random() % 10;
    part4 = arc4random() % 12;
    
    part1 = part1+15;
    part2 = part1+(part2+15);
    part3 = part2+(part3+15);
    part4 = part3 + (part4 + 3);
    
    [self nextClue];
    [self startRoundTimer];
}
-(void) nextClue
{
    /*
    NSMutableArray *repeatedQuestionsForCertainCategory = [[NSMutableArray alloc] init];
    for(NSString *word in repeatedArray)
    {
        if(selectedCategoryIndex)
            [repeatedQuestionsForCertainCategory addObject:word];
    }
    
    if([repeatedQuestionsForCertainCategory count] >= [gameQuestions count])
    {
        [repeatedArray removeAllObjects];
    }*/
    
    /*
    if([repeatedArray count] >= [questionArray count])
    {
        [repeatedArray removeAllObjects];
    }
    else 
    {
        
        NSArray *allIDs = [gameQuestions valueForKeyPath:@"categoryIndex"];
        for(NSNumber *cat in allIDs)
        {
            NSLog(@"%i",[cat intValue]);
        }
        
        if(![allIDs containsObject:question.identifier])
        {
            [questionArray addObject:question];
        }
        
        
        if( == [gameQuestions count])
        {
            [repeatedArray removeAllObjects];
        }
    }*/
    
    BOOL found = NO;
    for (int a = 0; a < [gameQuestions count];a++)
    {
        int rnd = arc4random() % [gameQuestions count];
        Question *question = [gameQuestions objectAtIndex:rnd];
        if(![repeatedArray containsObject:question.text])
        {
            self.currentQuestion = question;
            [repeatedArray addObject:question.text];
            found = YES;
            break;
        }
    }
    
    if(found == NO)
    {
        NSArray *allIDs = [gameQuestions valueForKeyPath:@"text"];
        [repeatedArray removeObjectsInArray:allIDs];
        
        int rnd = arc4random() % [gameQuestions count];
        Question *question = [gameQuestions objectAtIndex:rnd];
        
        self.currentQuestion = question;
        [repeatedArray addObject:question.text];
    }
    
    [self saveUserProperties];
   
    if([delegate respondsToSelector:@selector(questionWasGenerated:)])
    {
        [delegate questionWasGenerated:currentQuestion];
    }
}

-(void) endRound
{
    [self stopRoundTimer];
}

-(void) playSoundByIndex:(NSInteger) index
{
    NSLog(@"id = %i",soundEffectID);
    if(soundEffectID!=0)
    [self stopSoundSAE:soundEffectID];
    
    NSArray *sArray = [NSArray arrayWithObjects:@"sound_alarm.mp3", @"sound_alarmclock.mp3", @"sound_bell.mp3", @"sound_bullet.mp3",@"sound_buzzer.mp3",@"sound_chimp.mp3",@"sound_dogbark.mp3",@"sound_foghorn.mp3",@"sound_glassbreak.mp3",@"sound_kids.mp3",@"sound_rockriff.mp3",@"OhNo.wav",@"sound_rooster.mp3",@"sound_schoolbell.mp3",@"Scream.wav",@"sound_sheep.mp3",@"sound_siren.mp3",@"sound_squeaktoy.mp3",@"sound_thunder.mp3",@"sound_ufo.mp3", nil];
    
    NSString *soundFile = [sArray objectAtIndex:index];
    [self playSoundSAE:soundFile];
}

-(void) roundTimerCalled
{
    if(!isPause)
    {
        
        static int increment = 1;
        
        
        if(roundSecondsPassed < part1)
        {
            
            if(increment == 8)
                [self playSound:MCTimer];
        }
        else if (roundSecondsPassed >= part1 && roundSecondsPassed < part2)
        {
            
            if(increment == 4 || increment == 8)
            {
                [self playSound:MCTimer];
                //NSLog(@"increment =  %i , play",increment);
            }
            
                //NSLog(@"increment =  %i",increment);
        }
        else if (roundSecondsPassed >= part2 && roundSecondsPassed < part3)    
        {
            if(increment == 4 || increment == 8 || increment == 2 || increment == 6)
            {
                [self playSound:MCTimer];
            }
            
        }
        else if (roundSecondsPassed >= part3 && roundSecondsPassed < part4)  
        {
            [self playSound:MCTimer];
        }
        
        
        if(increment == 8)
        {
            increment = 1;
            
            roundSecondsPassed++;
            
            [delegate roundTimerCalled:120];
            
            if(roundSecondsPassed >= part4)
            {
                
                [self stopRoundTimer];
                
                /*
                NSArray *sArray = [NSArray arrayWithObjects:@"sound_alarm.mp3", @"sound_alarmclock.mp3", @"sound_bell.mp3", @"sound_bullet.mp3",@"sound_buzzer.mp3",@"sound_chimp.mp3",@"sound_dogbark.mp3",@"sound_foghorn.mp3",@"sound_glassbreak.mp3",@"sound_kids.mp3",@"sound_rockriff.mp3",@"OhNo.wav",@"sound_rooster.mp3",@"sound_schoolbell.mp3",@"Scream.wav",@"sound_sheep.mp3",@"sound_siren.mp3",@"sound_squeaktoy.mp3",@"sound_thunder.mp3",@"sound_ufo.mp3", nil];*/
                
                
                int playIndex = -1;
                if(buzzerSoundIndex == 20)
                {
                    playIndex = arc4random()%19;
                }
                else
                    playIndex = buzzerSoundIndex;
               
                /*
                NSString *soundFile = [sArray objectAtIndex:playIndex];
                [self playSoundSAE:soundFile];*/
                
                [self playSoundByIndex:playIndex];
                
                /*
                switch (buzzerSoundIndex) {
                    case 0:[self playSound:MCBUZZ1];break;
                    case 1:[self playSound:MCBUZZ2];break;
                    case 2:[self playSound:MCBUZZ_OHNO];break;
                    case 3:[self playSound:MCBUZZ_WOMAN_SCREAM];break;
                    default:
                        break;
                }*/
                
                
                [delegate timeIsUp];
                delegate = nil;
            }
        }
        else 
        {
            increment++;
        }
    }
}

-(void) startRoundTimer
{
    
	if(roundTimer == nil)
	{
		roundTimer = [NSTimer scheduledTimerWithTimeInterval:ROUND_UPDATE_INTERVAL target:self 
											   selector:@selector(roundTimerCalled) userInfo:nil repeats:YES];
    }
}

-(void) stopRoundTimer
{
    if([roundTimer isValid])
    {
        [roundTimer invalidate];
        roundTimer = nil;
    }
}

- (BOOL) isGameWon
{
    return ((team1Score >= pointsToWin) || (team2Score >= pointsToWin));
}

-(void) startNewGame
{
	if(!gameInProgress)
	{
		// Init
		secondsPassed = 0;
		gameInProgress = YES;
		currentQuestionIndex = 0;
        
        [gameQuestions removeAllObjects];
        //[repeatedArray removeAllObjects];
		
		srandom(time(NULL));
		NSUInteger count = [questionArray count];
		for (NSUInteger i = 0; i < count; ++i) {
			int nElements = count - i;
			int n = (random() % nElements) + i;
			[questionArray exchangeObjectAtIndex:i withObjectAtIndex:n];
		}
        
        
        if(selectedCategoryIndex == 0)
        {
            gameQuestions = [questionArray mutableCopy];
        }
        else 
        {
            for(Question *question in questionArray)
            {
                if(selectedCategoryIndex == question.categoryIndex)
                {
                    [gameQuestions addObject:question];
                    
                }
            }
        }
        
        for(Question *question in questionArray)
        {
            //if(selectedCategoryIndex == question.categoryIndex)
            {
                
                CGSize constraintExtra = CGSizeMake(440, 20000.0f);
                
                CGSize sizeQuestion = [question.text sizeWithFont:[UIFont fontWithName:@"Rockwell-Bold" size: 57] constrainedToSize:constraintExtra lineBreakMode:UILineBreakModeTailTruncation];
                
                //if(sizeQuestion.height > 136)
                //    NSLog(@"%f , %@",sizeQuestion.height,question.text);
            }
        }
        
	}
}

-(void) saveUserProperties
{
	//[[NSUserDefaults standardUserDefaults] setBool:soundEnable forKey:@"soundEnable"];
    [[NSUserDefaults standardUserDefaults] setObject:team1Name forKey:@"team1Name"];
    [[NSUserDefaults standardUserDefaults] setObject:team2Name forKey:@"team2Name"];
    
    //NSLog(@"%@",[CatchPhraseGame sharedInstance].team1Name);
    //NSLog(@"%@",[CatchPhraseGame sharedInstance].team2Name);
    
    [[NSUserDefaults standardUserDefaults] setInteger:pointsToWin forKey:@"pointsToWin"];
    [[NSUserDefaults standardUserDefaults] setInteger:pointsToWin forKey:@"pointsToWin"];
    
    [[NSUserDefaults standardUserDefaults] setInteger:selectedCategoryIndex forKey:@"selectedCategoryIndex"];
    [[NSUserDefaults standardUserDefaults] setInteger:buzzerSoundIndex forKey:@"buzzerSoundIndex"];
    
    [[NSUserDefaults standardUserDefaults] setInteger:gamePlayedCount forKey:@"gamePlayedCount"];
    [[NSUserDefaults standardUserDefaults] setBool:fifthGamePlayed forKey:@"fifthGamePlayed"];
    [[NSUserDefaults standardUserDefaults] setBool:reviewed forKey:@"reviewed"];
    
    [[NSUserDefaults standardUserDefaults] setObject:repeatedArray forKey:@"repeatedArray"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) loadUserProperties
{
    gamePlayedCount =  [[NSUserDefaults standardUserDefaults] integerForKey:@"gamePlayedCount"];
    fifthGamePlayed =  [[NSUserDefaults standardUserDefaults] boolForKey:@"gamePlayedCount"];
    reviewed  =  [[NSUserDefaults standardUserDefaults] boolForKey:@"reviewed"];
    
	team1Name =  [[NSUserDefaults standardUserDefaults] objectForKey:@"team1Name"];
    team2Name =  [[NSUserDefaults standardUserDefaults] objectForKey:@"team2Name"];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"pointsToWin"] == nil)
        pointsToWin = 7;
    else
        pointsToWin = [[NSUserDefaults standardUserDefaults] integerForKey:@"pointsToWin"];
    
    selectedCategoryIndex =  [[NSUserDefaults standardUserDefaults] integerForKey:@"selectedCategoryIndex"];
    buzzerSoundIndex =  [[NSUserDefaults standardUserDefaults] integerForKey:@"buzzerSoundIndex"];
    
    NSNumber *tempNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"cumulativeGamesPlayedNumber"];
    if(tempNumber!=nil)
    {
        cumulativeGamesPlayedNumber = [tempNumber intValue];
    }
    
    repeatedArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"repeatedArray"] mutableCopy];
    if(repeatedArray == nil)
        repeatedArray = [[NSMutableArray alloc] init];
}

-(void) endGame
{
    if([roundTimer isValid])
    {
        [roundTimer invalidate];
        roundTimer = nil;
    }
	
	gameInProgress = NO;
	
    team1Score = team2Score = 0;
    
}

-(void) loadGameData
{
	[self loadUserProperties];
	
	  questionArray = [[NSMutableArray alloc] init];
		
		NSData *returnData = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] 
															 stringByAppendingPathComponent:@"Database.json"]];
		NSError *error = nil;
		NSDictionary *rootDictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:returnData error:&error];
		
		
		if(error==nil)
		{
            [categoriesArray addObject:@"Everything"];
            
			NSArray *wordsJSON = [[rootDictionary objectForKey:@"words"] mutableCopy];
            
            
            for(NSDictionary *wordJSON in wordsJSON)
			{
                NSString *categoryName = [wordJSON objectForKey:@"category"];
                if(![categoriesArray containsObject:categoryName])
                {
                    [categoriesArray addObject:categoryName];
                }
            }
            
            for(NSDictionary *wordJSON in wordsJSON)
			{
                NSString *word  = [wordJSON objectForKey:@"word"];
                NSString *categoryName = [wordJSON objectForKey:@"category"];
                
                Question *question = [[Question alloc] init];
                question.text = word;
                
                
                
                for(int a=0;a<[categoriesArray count];a++)
                {
                    NSString *categoryTempName = [categoriesArray objectAtIndex:a];
                    if([categoryTempName isEqualToString:categoryName])
                    {
                        question.categoryIndex = a;
                        break;
                    }
                }
                
                [questionArray addObject:question];
                [question release];
                
            }
                			}
		

    
}
    



@end
