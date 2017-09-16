//
//  ViewController.h
//  FirChatSample
//
//  Created by webskitters on 14/07/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatVC.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (strong, nonatomic) NSString *strSenderID;
@property (strong, nonatomic) NSString *strReceiverID;

- (IBAction)btnDoneAction:(id)sender;

@end

