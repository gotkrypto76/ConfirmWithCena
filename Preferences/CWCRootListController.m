#include "CWCRootListController.h"

@implementation CWCRootListController

- (NSArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
    }
    
    return _specifiers;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)doDonate {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=8YWQJXXM2SCZG"]];
}

- (void)doRespring {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Please confirm your action."
                                 message:@"Would you like to respring your device?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    NSString *cmd = [NSString stringWithFormat:@"killall -9 SpringBoard"];
                                    const char *command = [cmd UTF8String];
                                    system(command);
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
}

@end
