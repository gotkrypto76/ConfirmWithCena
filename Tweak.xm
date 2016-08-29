#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVAudioPlayer.h>
#include <objc/runtime.h>

AVAudioPlayer *audioPlayer;
NSString *soundPath;
NSURL *soundURL;
NSString *settingsPath = @"/var/mobile/Library/Preferences/pw.virulent.cwc.plist";

%hook SBIconController
-(void)uninstallIcon:(id)arg1 animate:(char)arg2  { 
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];
	BOOL enableLoudAudio = [prefs objectForKey:@"enableLoudAudio"] ? [[prefs objectForKey:@"enableLoudAudio"] boolValue] : NO;
	
	if(enableLoudAudio) {
		soundPath = [[NSBundle bundleWithPath:@"/Library/Application Support/ConfirmWithCena/"] pathForResource:@"Nag_Loud" ofType:@"wav"];
	} else {
		soundPath = [[NSBundle bundleWithPath:@"/Library/Application Support/ConfirmWithCena/"] pathForResource:@"Nag" ofType:@"wav"];
	}
	soundURL = [[NSURL alloc] initFileURLWithPath:soundPath];

    if([className isEqual:@"SBApplicationIcon"]) {
		audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
		audioPlayer.numberOfLoops = 0;
		audioPlayer.volume = 1;
		[audioPlayer play];

		UIAlertController * alert = [UIAlertController 
			alertControllerWithTitle:@"Are you sure about that?" 
			message:nil
			preferredStyle:UIAlertControllerStyleAlert];
	
		UIAlertAction* yesButton = [UIAlertAction
							 actionWithTitle:@"Yes"
							 style:UIAlertActionStyleDefault
							 handler:^(UIAlertAction * action)
							 {
								 %orig;
							 }];

		UIAlertAction* noButton = [UIAlertAction
							 actionWithTitle:@"No"
							 style:UIAlertActionStyleDefault
							 handler:^(UIAlertAction * action)
							{
								 //Do nothing
							}];
	   [alert addAction:yesButton];
	   [alert addAction:noButton];
	   [self presentViewController:alert animated:YES completion:nil];
	} else {
    	%orig;
    }
}
%end
