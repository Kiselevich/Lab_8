//
//  ViewController.h
//  Lab_8.1
//
//  Created by Admin on 07.06.17.
//  Copyright © 2017 Oleg Kiselevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *cityFrom;
@property (strong, nonatomic) IBOutlet UITextField *cityTo;


@end

