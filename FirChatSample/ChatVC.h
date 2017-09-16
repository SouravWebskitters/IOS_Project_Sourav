//
//  ChatVC.h
//  FirChatSample
//
//  Created by webskitters on 14/07/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "Utility.h"
@import Firebase;
#import <Firebase.h>

@interface ChatVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblChatList;

@property (weak, nonatomic) IBOutlet UIView *bottomMsgView;
@property (weak, nonatomic) IBOutlet UITextView *textFieldMsg;


@property (strong, nonatomic) NSString *strReceiverName;
@property (strong, nonatomic) NSString *strSenderName;
@property (strong, nonatomic) NSString *strSenderID;
@property (strong, nonatomic) NSString *strReceiverID;
@property (strong, nonatomic) NSString *strUniqueID;

@property (strong,nonatomic) NSMutableArray *arr_message;
@property (strong, nonatomic) FIRAuthStateDidChangeListenerHandle handle;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRStorage *storage;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *vwBottomConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tblBottomConstraint;


- (IBAction)btnUploadImageAction:(id)sender;
- (IBAction)msgSendAction:(id)sender;


@end
