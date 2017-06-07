//
//  ViewController.m
//  Lab_8.2
//
//  Created by Admin on 07.06.17.
//  Copyright © 2017 Oleg Kiselevich. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *registrationView;
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *seg;
@property (strong, nonatomic) IBOutlet UITextField *loginLTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordLTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[_loginView setHidden:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)segment:(id)sender {
   
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    NSInteger select = seg.selectedSegmentIndex;
    
    if(select == 0)
    {
        [_loginView setHidden:NO];
        [_registrationView setHidden:YES];
    }
    
    if(select == 1)
    {
        [_loginView setHidden:YES];
        [_registrationView setHidden:NO];
    }
}
- (IBAction)logIN:(id)sender
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if([user objectForKey:@"login"] != nil || [user objectForKey:@"pass"] != nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"CloseZone"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil];
        [alert show];

    }
}

- (IBAction)signUp:(id)sender {
    if(![_loginLTF.text isEqualToString:@""] || [_passwordLTF.text isEqualToString:@""] )
    {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:_loginLTF.text forKey:@"login"];
        [user setObject:_passwordLTF.text forKey:@"password"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info"
                                                        message:@"Successfuly"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


@end
