    //
//  TidBitViewController.m
//  HarryPotter
//
//  Created by Alexei Rudak on 25/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseAppViewController.h"
#import "CatchPhraseGame.h"


@implementation BaseAppViewController

@synthesize resumeView,endGameView,imInfoMainView,imInfoFinalView,isMainAnimating,isFinalAnimating;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // For Time Over, Game Over
	imInfoFinalView = [[UIImageView alloc] initWithFrame:CGRectMake(138, 160, 204, 27)];
	[imInfoFinalView setHidden:YES];
	[imInfoFinalView setAlpha:1.0f];
}

-(IBAction) backToMenu
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    if(![endGameView superview]) {
        endGameView.frame = AVMakeRectWithAspectRatioInsideRect(self.view.bounds.size, self.view.bounds);
        [self.view addSubview:endGameView];
    }
}

-(IBAction) onReturnToMenu
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    [[CatchPhraseGame sharedInstance] endGame];
    
    if([endGameView superview])
        [endGameView removeFromSuperview];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction) onCancelReturningToMenu
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    if([endGameView superview])
        [endGameView removeFromSuperview];
}

-(void) hideLoadingHUD
{
	//	[HUD hide:YES];
	if(HUD!=nil)
	{
		[HUD removeFromSuperview];
		[HUD release];
		HUD = nil;
	}
}

-(void) showLoadingHUD
{
	// The hud will dispable all input on the view (use the higest view possible in the view hierarchy)
	if(HUD == nil)
	{
		HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
		
		//HUD.graceTime = 0.5;
		//HUD.minShowTime = 5.0;
		
		// Add HUD to screen
		[self.navigationController.view addSubview:HUD];
		
		// Regisete for HUD callbacks so we can remove it from the window at the right time
		HUD.delegate = self;
		
		// Show the HUD while the provided method executes in a new thread
		//[HUD showWhileExecuting:selector onTarget:self withObject:nil animated:YES];
		[HUD show:YES];
	}
	
}

-(void) showLoadingMessage:(NSString*) msgText
{
	UIActivityIndicatorView* indicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
										   UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	
	indicator.center = CGPointMake(142, 70 );
	
	if(!modalAlertView)
	{
		modalAlertView = [[UIAlertView alloc] initWithTitle:msgText
													message:nil
												   delegate:self
										  cancelButtonTitle:nil 
										  otherButtonTitles:nil];
	}
	
	
	[modalAlertView addSubview:indicator];
	[modalAlertView show];
	
	[indicator startAnimating];
	
}

-(void) hideLoadingMessage
{
	if(modalAlertView)
	{
		[modalAlertView dismissWithClickedButtonIndex:0 animated:NO];
		[modalAlertView release];
		modalAlertView  = nil;
	}
}

-(void) stopAllAnimations{
	[imInfoFinalView.layer removeAllAnimations];
	[imInfoMainView.layer removeAllAnimations];
}

-(void) guessAnimationFinished{
	isMainAnimating = NO;
	[imInfoMainView setHidden:YES];
	[imInfoMainView setAlpha:1.0f];
}

-(void) timerAnimationFinished{
	isFinalAnimating = NO;
	[imInfoFinalView setHidden:YES];
	[imInfoFinalView setAlpha:1.0f];
}

-(void) gameoverAnimationFinished{
	isFinalAnimating = NO;
	[imInfoFinalView setHidden:YES];
	[imInfoFinalView setAlpha:1.0f];
}

-(void) guessFadeOutFinalAnimation{
	[UIView beginAnimations:@"anim1" context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:1.0f];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(guessAnimationFinished)];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[imInfoMainView setAlpha:0.0f];
	[UIView commitAnimations];
}

-(void) timerFadeOutFinalAnimation{
	[UIView beginAnimations:@"anim2" context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:3.0f];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(timerAnimationFinished)];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[imInfoFinalView setAlpha:0.0f];
	[UIView commitAnimations];
}

-(void) gameoverFadeOutFinalAnimation{
	[UIView beginAnimations:@"anim3" context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:3.0f];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(gameoverAnimationFinished)];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[imInfoFinalView setAlpha:0.0f];
	[UIView commitAnimations];
}



-(void) startInfoImageAnimation:(NSInteger)type inView:(UIView*)inView{
	
    animType = type;
    animInRect = CGRectMake((inView.frame.size.width - 204)/2, 
                            (inView.frame.size.height- 27)/2, 204 ,27);
	
    switch(type){
        case 1: // GUESS AGAIN
            if(!isMainAnimating){
                
                isMainAnimating = YES;
                
                [imInfoMainView setFrame:animInRect];
                
                if(![imInfoMainView superview])
                    [inView addSubview:imInfoMainView];
                
                [imInfoMainView setHidden:NO];
                [imInfoMainView setImage:[UIImage imageNamed:@"Text_GuessAgain.png"]];
                
                [self performSelector:@selector(guessFadeOutFinalAnimation) withObject:nil afterDelay:0.1f];
            }
            break;
        case 2:
            if(!isFinalAnimating){
                
                isFinalAnimating = YES;
                
                [imInfoFinalView setFrame:CGRectMake((inView.frame.size.width - 204)/2, 
                                                     (inView.frame.size.height- 27)/2, 204 ,27)];
                
                if(![imInfoFinalView superview])
                    [inView addSubview:imInfoFinalView];
                
                
                [imInfoFinalView setHidden:NO];
                
                [imInfoFinalView setImage:[UIImage imageNamed:@"Text_OutOfTime.png"]];
                
                [self performSelector:@selector(timerFadeOutFinalAnimation) withObject:nil afterDelay:3.0f];
                
            }
            
            break;
        case 3:
            if(!isFinalAnimating){
                
                isFinalAnimating = YES;
                
                [imInfoFinalView setFrame:animInRect];
                
                if(![imInfoFinalView superview])
                    [inView addSubview:imInfoFinalView];
                
                
                [imInfoFinalView setHidden:NO];
                
                [imInfoFinalView setImage:[UIImage imageNamed:@"Text_GameOver.png"]];
                
                [self performSelector:@selector(gameoverFadeOutFinalAnimation) withObject:nil afterDelay:3.0f];
            }
            
            break;
        default:
            break;
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (BOOL)shouldAutorotate
{
    
    
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
} 
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
