//
//  ChatVC.m
//  FirChatSample
//
//  Created by webskitters on 14/07/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import "ChatVC.h"
#import "ChatCell.h"
#import "ImageChatCell.h"

@interface ChatVC (){
     NSString *strLastMessage;
}

@end

@implementation ChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ref = [[FIRDatabase database] reference];
    self.storage = [FIRStorage storage];
    _tblChatList.tableFooterView = [UIView new];
    _arr_message =[NSMutableArray new];
    
    _strUniqueID = @"123456";
    
    [self setNumberPadToTextField];
    
    _textFieldMsg.layer.borderColor = [UIColor blackColor].CGColor;
    _textFieldMsg.layer.borderWidth = 1.0;
    
    [SVProgressHUD showWithStatus:@"loading" maskType:SVProgressHUDMaskTypeClear];
    [self retriveMessageFromFireBase];


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setNumberPadToTextField
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
   
    self.textFieldMsg.inputAccessoryView  = numberToolbar;
   
}


#pragma --
#pragma doneWithNumberPad
-(void)doneWithNumberPad
{
    [self.textFieldMsg resignFirstResponder];
    
   self.textFieldMsg.text = [self.textFieldMsg.text isEqualToString:@""]?@"Write Something here...":self.textFieldMsg.text;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:TRUE];
    
    self.vwBottomConstraint.constant = self.vwBottomConstraint.constant - 300;
    self.tblBottomConstraint.constant = self.tblBottomConstraint.constant + 300;
    
    [UIView commitAnimations];

    
        
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    if([textView.text isEqualToString:@"Write Something here..."])
        textView.text = @"";
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:TRUE];
    
    self.vwBottomConstraint.constant = self.vwBottomConstraint.constant + 300;
    self.tblBottomConstraint.constant = self.tblBottomConstraint.constant - 300;

    
   
    
    NSIndexPath *index=[NSIndexPath indexPathForRow:[_arr_message count]-1 inSection:0];
    //                    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[_arrOfChatContent count]-1 inSection:0]];
    //                    [_chatTableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationTop];
    // [_tblMessage insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    
    if (_arr_message.count>0) {
        [_tblChatList endUpdates];
        [_tblChatList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_arr_message.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
    
    //    CGRect frame = _tblMessage.frame;
    //    frame.size.height=frame.size.height-240;
    //    _tblMessage.frame = frame;
    [UIView commitAnimations];
    
    
    
    return YES;
}


#pragma mark - fetch receive message
-(void)retriveMessageFromFireBase{
    
    // NSDictionary *dict=nil;
    //    NSString *userID = [FIRAuth auth].currentUser.uid;
    //    if (userID==nil) {
    //        return;
    //    }
    
    // [hud setOpacity:0.3f];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
    [[[_ref child:@"Messages"] child:_strUniqueID] observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        if(![snapshot isKindOfClass:[NSNull null]]){
            
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:snapshot.value[@"message"],@"message",snapshot.value[@"senddate"],@"senddate",snapshot.value[@"sender_id"],@"sender_id",snapshot.value[@"receiver_id"],@"receiver_id",snapshot.value[@"SenderName"],@"SenderName",snapshot.value[@"type"],@"type",snapshot.value[@"photo_url"],@"photo_url",snapshot.value[@"msgstatus"],@"msgstatus",snapshot.value[@"image_url"],@"image_url",nil];
            
            NSLog(@"%@",snapshot.value);
            [_arr_message addObject:dict];
            
            [UIView setAnimationsEnabled:NO];
            [_tblChatList beginUpdates];
            
            NSIndexPath *index=[NSIndexPath indexPathForRow:[_arr_message count]-1 inSection:0];
            [_tblChatList insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
            [_tblChatList endUpdates];
            [UIView setAnimationsEnabled:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                if( _tblChatList.contentSize.height>_tblChatList.bounds.size.height)
                {
                    
                    if(_arr_message.count>1)
                    {
                        if([_tblChatList contentSize].height > _tblChatList.bounds.size.height)
                        {
                            [_tblChatList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_arr_message.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                        }
                    }
                    
                }
            });
            
        }
        if([_arr_message count]<=1)
            
            [_tblChatList reloadData];
        
    }];
    
    [_tblChatList reloadData];
    
}



- (IBAction)msgSendAction:(id)sender {
    
    NSString *newString = [_textFieldMsg.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    BOOL emptyLogin = newString.length == 0;
    
    if (emptyLogin ||[newString isEqualToString:@"Write Something here..."]) {
        
        return;
    }
    long timestamp = [[NSDate date] timeIntervalSince1970];
    NSString *strSender= _strSenderName;
    NSString *strReceiver= _strReceiverName;

    
    
     NSString *strTime = [self GetCurrentTimeStamp];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:_strSenderID,@"sender_id",newString,@"message",_strReceiverID,@"receiver_id",strSender,@"SenderName",strReceiver,@"ReceiverName",strTime,@"senddate",@"text",@"type",@"",@"photo_url",@"",@"image_url",@"read",@"msgstatus", nil];
    
    [[[[_ref child:@"Messages"] child:_strUniqueID] childByAutoId] setValue:dict withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        
        if (error) {
            
            NSLog(@"Data could not be saved.");
            
        } else {
            // NSLog(@"Data saved successfully.ids are %@ - %@",[self senderId],[self reciverId]);
            
            // [self retriveMessageFromFireBase];
            strLastMessage = newString;
            _textFieldMsg.text = @"Write Something here...";
            
            [self doneClicked];
            
        }
        
    }];


}


-(void)saveImageToFirbase:(UIImage *)sentImage{
    [SVProgressHUD showWithStatus:@"Uploading" maskType:SVProgressHUDMaskTypeClear];
    
    NSData *imageData = UIImageJPEGRepresentation(sentImage, 0.2);
    
    if (imageData == nil) {
        return;
    }
    else {
        FIRStorageReference *storageRef = [_storage reference];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        
        NSDate *now = [NSDate date];
        NSString *strNowTime = [formatter stringFromDate:now];
        
        // Create a reference to 'images/mountains.jpg'
        FIRStorageReference *riversRef = [storageRef child:[NSString stringWithFormat:@"images/123456/img_%@.jpg",strNowTime]];
        
        // Upload the file to the path "images/rivers.jpg"
        [riversRef putData:imageData metadata:nil completion:^(FIRStorageMetadata *metadata,NSError *error) {
            if (error != nil) {
                [SVProgressHUD dismiss];
                // Uh-oh, an error occurred!
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                NSURL *downloadURL = metadata.downloadURL;
                NSLog(@"%@",downloadURL);
                [self sendImageURLToFireBase:downloadURL.absoluteString];
            }
        }];


    }
}



-(void)sendImageURLToFireBase:(NSString *)URL{
    strLastMessage = @"Photo";
    
    long timestamp = [[NSDate date] timeIntervalSince1970];
    NSString *strSender= _strSenderName;
    NSString *strReceiver= _strReceiverName;
    NSString *strTime = [self GetCurrentTimeStamp];
    
    //NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[Utility getObjectForKey:FACEBOOKID],@"sender_id",@"",@"message",_strReceiverId,@"receiver_id",strName,@"name",strTime,@"msgTime",@"url",@"type",URL,@"photoUrl",[Utility getObjectForKey:PROFILE_PIC],@"imageUrl",@"",@"msgstatus", nil];
    
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:_strSenderID,@"sender_id",@"",@"message",_strReceiverID,@"receiver_id",strSender,@"SenderName",strReceiver,@"ReceiverName",strTime,@"senddate",@"url",@"type",URL,@"photo_url",@"",@"image_url",@"read",@"msgstatus", nil];
    
    [[[[_ref child:@"Messages"] child:_strUniqueID] childByAutoId] setValue:dict withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        
        if (error) {
            
            NSLog(@"Data could not be saved.");
            
        } else {
            
            //  strLastMessage = newString;
            
            // [self doneClicked];
           
        }
        [SVProgressHUD dismiss];
        
    }];
    
}


-(void)doneClicked{
    if([_textFieldMsg.text isEqualToString:@""])
        _textFieldMsg.text = @"Write Something here...";
    [_textFieldMsg resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:TRUE];
    
    self.vwBottomConstraint.constant = self.vwBottomConstraint.constant - 300;
    self.tblBottomConstraint.constant = self.tblBottomConstraint.constant + 300;
    
    [UIView commitAnimations];
}


- (NSString *)GetCurrentTimeStamp
{
    
    long long milliseconds = (long long)([[NSDate date] timeIntervalSince1970] * 1000.0);
    
    NSString *strTimeStamp = [NSString stringWithFormat:@"%lld",milliseconds];
    NSLog(@"The Timestamp is = %@",strTimeStamp);
    return strTimeStamp;
}





#pragma --
#pragma mark - TableView Delegate And Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arr_message.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[[_arr_message objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"url"]){
        static NSString *MyIdentifier = @"ImageChatCell";
        
        ImageChatCell *cell = (ImageChatCell*)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        cell.lblName.text = [[_arr_message objectAtIndex:indexPath.row] objectForKey:@"SenderName"];

        
        [Utility loadCellImage:cell.postedImg imageUrl:[[_arr_message objectAtIndex:indexPath.row] valueForKey:@"photo_url"]];
        
        
        NSTimeInterval interval=[[[_arr_message objectAtIndex:indexPath.row] objectForKey:@"senddate"] integerValue];
        cell.lblTime.text = [self timeString:interval];
        cell.lblDate.text = [self dateString:interval];
        
        return cell;
    }
    else{
        static NSString *MyIdentifier = @"ChatCell";
        
        ChatCell *cell = (ChatCell*)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        cell.lblName.text = [[_arr_message objectAtIndex:indexPath.row] objectForKey:@"SenderName"];
        
        if ([[[_arr_message objectAtIndex:indexPath.row] objectForKey:@"sender_id"] isEqualToString:_strSenderID]){
            cell.lblMsg.text = [[_arr_message objectAtIndex:indexPath.row] objectForKey:@"message"];
            cell.lblMsg.textColor = [UIColor greenColor];
        }
        
        else {
            cell.lblMsg.text = [[_arr_message objectAtIndex:indexPath.row] objectForKey:@"message"];
            cell.lblMsg.textColor = [UIColor blueColor];
            
        }
        
        cell.lblMsg.lineBreakMode = NSLineBreakByWordWrapping;
        cell.lblMsg.numberOfLines = 0;
        
        
        NSTimeInterval interval=[[[_arr_message objectAtIndex:indexPath.row] objectForKey:@"senddate"] integerValue];
        cell.lblTime.text = [self timeString:interval];
        cell.lblDate.text = [self dateString:interval];
        
        return cell;

    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[[_arr_message objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"url"]){
       return 180.0;
    }else{
       return 90.0;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([[[_arr_message objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"url"]){
        return 180.0;
    }
    return UITableViewAutomaticDimension;
}


-(NSString *)timeString:(NSTimeInterval)timeInterval

{
    
    if(timeInterval>0.0)
        
    {
        NSDate *date=[NSDate dateWithTimeIntervalSince1970:(timeInterval+3600)/1000];
        
        //    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        [dateFormat setDateStyle:NSDateFormatterMediumStyle];
        
        //    [dateFormat setDateFormat:@"hh:mm a"];
        
        [dateFormat setDateFormat:@"hh:mm a"];
        
        return [dateFormat stringFromDate:date];
        
    }
    
    return @"";
    
}


-(NSString *)dateString:(NSTimeInterval)timeInterval

{
    
    if(timeInterval>0.0)
        
    {
        NSDate *date=[NSDate dateWithTimeIntervalSince1970:(timeInterval+3600)/1000];
        
        //    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        [dateFormat setDateStyle:NSDateFormatterMediumStyle];
        
        //    [dateFormat setDateFormat:@"hh:mm a"];
        
        [dateFormat setDateFormat:@"dd-MMM-yyyy"];
        
        return [dateFormat stringFromDate:date];
        
    }
    
    return @"";
    
}


- (IBAction)btnUploadImageAction:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Choose Options" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Take Photo From camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        NSLog(@"You pressed button one");
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = NO;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:NULL];
        }
        else {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@""
                                          message:@"Camera is not available here"
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
        
    }];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Import Photo From Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"You pressed button two");
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];

}


#pragma mark - Image Picker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    [self saveImageToFirbase:[info objectForKey:UIImagePickerControllerOriginalImage]];
    
}













@end
