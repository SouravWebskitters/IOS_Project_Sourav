//
//  ImageChatCell.h
//  FirChatSample
//
//  Created by webskitters on 18/07/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postedImg;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@end
