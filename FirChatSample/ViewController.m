//
//  ViewController.m
//  FirChatSample
//
//  Created by webskitters on 14/07/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnDoneAction:(id)sender {
    
    if([_txtName.text isEqualToString:@"Jeeban"] && [_txtPassword.text isEqualToString:@"12345"]){
      _strSenderID = @"101101101";
      _strReceiverID = @"102102102";
        
        ChatVC *chatvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatVC"];
        chatvc.strReceiverID = _strReceiverID;
        chatvc.strSenderID = _strSenderID;
        chatvc.strReceiverName = @"Sourav";
        chatvc.strSenderName = @"Jeeban";
        [self.navigationController pushViewController:chatvc animated:YES];
        
    }
    else if ([_txtName.text isEqualToString:@"Sourav"] && [_txtPassword.text isEqualToString:@"12345"]){
      _strSenderID = @"102102102";
      _strReceiverID = @"101101101";
        
        ChatVC *chatvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatVC"];
        chatvc.strReceiverID = _strReceiverID;
        chatvc.strSenderID = _strSenderID;
        chatvc.strReceiverName = @"Jeeban";
        chatvc.strSenderName = @"Sourav";
        [self.navigationController pushViewController:chatvc animated:YES];

    }
    
    else{
        [self showAlert:@"Invalid User"];
    }
}

#pragma -mark showAlert
-(void)showAlert : (NSString*)strMsg
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:strMsg
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
