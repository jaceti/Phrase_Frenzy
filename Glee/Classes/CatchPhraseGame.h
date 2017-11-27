//
//  VelveetaGame.h
//  Velveeta
//
//  Created by Alexei Rudak on 09/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SimpleAudioEngine.h"

#define ROUND_UPDATE_INTERVAL 1.0f/8
//#define ROUND_UPDATE_INTERVAL 1.0f/80
#define ROUND_TIME 60

typedef enum {
	MCTimer = 0,
	MCsoundWrongAnswer,
	MCsoundButtonClick,
	MCsoundPopup,
    MCsoundBeep1,
    MCsoundBeep2,
    MCBUZZ1,
    MCBUZZ2,
    MCBUZZ_OHNO,
    MCBUZZ_WOMAN_SCREAM
} MCsounds; 

@class Question;

@protocol CatchPhraseGameDelegate
- (void) timeIsUp;
- (void) questionWasGenerated:(Question*)question;
- (void) roundTimerCalled:(NSInteger) second;
@end

@interface CatchPhraseGame : NSObject 
{
    
    NSInteger gamePlayedCount;
    BOOL fifthGamePlayed;
    BOOL reviewed;
    
    // Music playing
    
    MCsounds buzzerSoundPlaying;
    BOOL soundEnable;
    
    NSMutableArray *allWordsArray;
    
	NSMutableArray *questionArray;
    NSMutableArray *repeatedArray;
    NSMutableArray *gameQuestions;
	
	Question *currentQuestion;
	NSInteger currentQuestionIndex;
	
	BOOL gameInProgress;
    BOOL isPause;
    
	
	NSTimer *roundTimer;
    NSInteger roundSecondsPassed;
	
    NSString *team1Name;
    NSString *team2Name;
    
    NSInteger pointsToWin;
    NSInteger selectedCategoryIndex;
    NSInteger buzzerSoundIndex;
    
    NSInteger cumulativeGamesPlayedNumber;
    
    NSInteger team1Score;
    NSInteger team2Score;
    
    NSMutableArray *categoriesArray;
    NSMutableArray *buzzerSoundsArray;
    
    id<CatchPhraseGameDelegate>delegate;
    
    NSInteger part1,part2,part3,part4;
    NSInteger sndDelim;
    
    ALuint soundEffectID;
}

@property (nonatomic, assign) NSInteger gamePlayedCount;
@property (nonatomic, assign) BOOL fifthGamePlayed;
@property (nonatomic, assign) BOOL reviewed;

@property (nonatomic, assign) ALuint soundEffectID;
@property (nonatomic, assign) NSInteger roundSecondsPassed;
@property (nonatomic, assign) NSInteger part1,part2,part3,part4;

// Music playing

@property (nonatomic, assign) BOOL soundEnable;
@property (nonatomic, retain) NSMutableArray *allWordsArray;
@property (nonatomic, retain) NSMutableArray *repeatedArray;
@property (nonatomic, retain) NSMutableArray *gameQuestions;
@property (nonatomic, retain) NSMutableArray *questionArray;
@property (nonatomic, retain) Question *currentQuestion;
@property (nonatomic, assign) NSInteger currentQuestionIndex;

@property (nonatomic, assign) NSInteger secondsPassed;
@property (nonatomic, assign) NSInteger globalSecondsPassed;
@property (nonatomic, assign) BOOL gameInProgress;

@property (nonatomic, assign) BOOL gameCompleted;
@property (nonatomic, assign) BOOL wasPreviousAnswerCorrect;

@property (nonatomic, retain) NSString *team1Name;
@property (nonatomic, retain) NSString *team2Name;

@property (nonatomic, assign) NSInteger pointsToWin;
@property (nonatomic, assign) NSInteger selectedCategoryIndex;
@property (nonatomic, assign) NSInteger buzzerSoundIndex;

@property (nonatomic, assign) NSInteger cumulativeGamesPlayedNumber;

@property (nonatomic, assign) NSInteger team1Score;
@property (nonatomic, assign) NSInteger team2Score;

@property (nonatomic, retain) NSMutableArray *categoriesArray;
@property (nonatomic, retain) NSMutableArray *buzzerSoundsArray;

@property (nonatomic, assign) id<CatchPhraseGameDelegate>delegate;

@property (nonatomic, assign) NSTimer *roundTimer;

@property (nonatomic, assign) BOOL isPause;
@property (nonatomic, assign) MCsounds buzzerSoundPlaying;


+ (CatchPhraseGame *) sharedInstance;

-(NSString*) getTeamDefaultName:(NSInteger) teamNumber;

-(NSString*) getCategoryNameByCurrentIndex;
-(NSString*) getBuzzerSoundByCurrentIndex;


-(NSString*) getWinnerTeamName;

-(void) initGame;

-(void) startNewGame;
-(void) nextRound;
-(void) nextClue;
-(void) endRound;
-(void) endGame;

-(void) loadGameData;
-(void) saveGameData;

-(void) saveUserProperties;
-(void) loadUserProperties;

- (void)playSound:(MCsounds)snd;
- (void)playSound2:(MCsounds)snd;
- (void)stopSounds;

-(void) playSoundByIndex:(NSInteger) index;
-(NSInteger) playSoundSAE:(NSString*) file;
-(void)stopSoundSAE:(ALuint)snd;
-(void)stopSoundsSAE;

- (BOOL) isGameWon;

-(void) startRoundTimer;
-(void) stopRoundTimer;

@end
