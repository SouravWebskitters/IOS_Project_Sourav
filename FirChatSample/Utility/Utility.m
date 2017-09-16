//
// Utility.m

// Class created by XCoder001 on 23rd January,2015 at AMS Technologies....... :)
//


#import "Utility.h"
#import "UIImageView+WebCache.h"

@implementation Utility

#pragma mark - NSUserDefaults 😄😄 ▶︎▶︎
#pragma mark - 

#pragma mark Get User Defaults
+ (NSUserDefaults *)getUserDefault
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    return userDefaults;
}

#pragma mark Sync User Defaults
+ (void)syncUserDefault : (NSUserDefaults *)userDefaults
{
    [userDefaults synchronize];
}
#pragma mark Save object in User Defaulr 😄😄 ▶︎▶︎
+ (void)saveObjectInUserDefaults :(id)object forKey :(NSString *)key
{
    NSUserDefaults *userDef = [Utility getUserDefault];
    
    [userDef setObject:object forKey:key];
    
    [Utility syncUserDefault:userDef];
}

#pragma mark Remove object From User Default

+ (void)removeObjectFromUserDefaultsForKey:(NSString *)key {
    
     NSUserDefaults *userDef = [Utility getUserDefault];
    
     [userDef removeObjectForKey:key];
    
     [Utility syncUserDefault:userDef];
}


#pragma mark 😔
+(BOOL)isRememberLogin
{
    NSUserDefaults *userDef = [Utility getUserDefault];
    
    if ([userDef valueForKey:@"remember"] != NULL)
    {
        if ((BOOL)[userDef valueForKey:@"remember"] == YES)
        {
            return YES;
        }
        else
            return NO;
    }
    else
        return NO;
}





+(void)isRememberUser :(NSString *)strEmail withPassword :(NSString *)strPass withTag :(BOOL)tag
{
    if (tag == YES)
    {
        NSUserDefaults *userDef = [Utility getUserDefault];
        [userDef setValue:strEmail forKey:@"email"];
        [userDef setValue:strPass forKey:@"pass"];
        [userDef setValue:[NSNumber numberWithBool:tag] forKey:@"remember"];
     }
    else
    {
        NSUserDefaults *userDef = [Utility getUserDefault];
        [userDef setValue:strEmail forKey:@""];
        [userDef setValue:strPass forKey:@""];
        [userDef setValue:[NSNumber numberWithBool:tag] forKey:@"remember"];

    }
    
}
#pragma mark get Object for key   😄 ▶︎▶︎
+ (id)getObjectForKey :(NSString *)key
{
    id object;
    
    NSUserDefaults *userDef = [Utility getUserDefault];
    
    object = [userDef objectForKey:key];
    
    return object;
}

#pragma mark UserCountry 😊

+(void)saveUserCountry :(NSArray *)arrCountry withId:(NSString *)cid forKey:(NSString *)key
{
    for (NSDictionary *dict in arrCountry) {
        if ([cid isEqualToString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]]])
        {
            [Utility saveObjectInUserDefaults:dict[@"country_name"] forKey:key];
            break;
        }
    }
}

+(void)saveUserState:(NSArray *)arrState withId:(NSString *)sid forKey:(NSString *)key
{
    for (NSDictionary *dict in arrState)
    {
        if ([sid isEqualToString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]]])
        {
            [Utility saveObjectInUserDefaults:dict[@"state_name"] forKey:key];
            break;
        }
    }
  
}




/*+(BOOL)checkForUserLoggedIn
{
    NSDictionary *dictUseDetails = (NSDictionary *)[self getObjectForKey:userDetails];

    if ([dictUseDetails valueForKey:@"first_name"] == nil) {
        return false;
    }
    
    return true;
    
}*/








#pragma mark - Get Device ID (Incomplete) 😄 ▶︎
#pragma mark - 
+ (NSString *)getDeviceID
{
    return @"";//[UIDevice currentDevice].uniqueIdentifier;
}

#pragma mark - Get applicationDocumentsDirectory 😄 ▶︎
#pragma mark - 
+ (NSString *) applicationDocumentsDirectory 
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

#pragma mark - Get applicationLibraryDirectory 😄 ▶︎
#pragma mark -
//returns Application document directory path
+ (NSString *) applicationLibraryDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

#pragma mark - dateFromString 😄 ▶︎
#pragma mark - 
+ (NSDate*) dateFromString:(NSString*)aStr withDateFormat :(NSDateFormatter *)formatter
{
    if([aStr length] > 0)
    {
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        //[dateFormatter setDateFormat:@"YY-MM-dd HH:mm:ss a"];
        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];//[NSTimeZone localTimeZone]];//
        NSDate   *aDate = [formatter dateFromString:aStr];
        return aDate;
    }
    
    return [NSDate date];
}

#pragma mark - StringFromDate 😄 ▶︎
#pragma mark -
+ (NSString *)stringFromDate :(NSDate *)date withDateFormat :(NSDateFormatter *)formatter
{
    NSString *strDate;
    
    strDate = [formatter stringFromDate:date];
    
    return strDate;
    
    
}

#pragma mark - appendStringWithSapce 😄 ▶︎
#pragma mark -
+ (NSString *) appendStringWithSapce:(NSString*)str1 str2:(NSString *)str2
{
    return [NSString stringWithFormat:@"%@ %@", str1, str2];
}

#pragma mark - Show Alert message 😄 ▶︎
#pragma mark -
+ (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alert show];
}

#pragma mark - isValidEmail 😄 ▶︎
#pragma mark - 
+ (BOOL) isValidEmail:(NSString *)emailString 
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailString];

}

+ (BOOL)validateEmailWithString:(NSString*)checkString
{
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:checkString];
}
#pragma mark - getAppDelegate 😄 ▶︎
#pragma mark - 
+ (AppDelegate *)getAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark - showSubViewAddAnimation 😄 ▶︎
#pragma mark - 
+ (void)showBottomToTopAnimation : (UIView *)view
{
    CGRect frame  = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    
    float y = [[UIScreen mainScreen] bounds].size.height;
    
    view.frame = CGRectMake(0, y, view.frame.size.width, view.frame.size.height);
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         view.frame = frame;
                     }];
}

#pragma mark - showSubViewRemoveAnimation 😄 ▶︎
#pragma mark - 
+ (void)showTopToBottomAnimation : (UIView *)view
{
    float y = [[UIScreen mainScreen] bounds].size.height;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         view.frame = CGRectMake(0, y, view.frame.size.width, view.frame.size.height);
                     } completion:^(BOOL finished) {
                         [view removeFromSuperview];
                     }];
}

#pragma mark - getRoundView 😄 ▶︎
#pragma mark - 
+ (void)getRoundView : (UIView *)view andBorderWidth : (int)borderWidth borderColor : (UIColor *)borderColor
{
    view.layer.cornerRadius = view.frame.size.width / 2;
    view.layer.masksToBounds = true;
    if (borderWidth > 0)
    {
        view.layer.borderWidth = borderWidth;
        view.layer.borderColor = borderColor.CGColor;
    }
}

#pragma mark - Color conversion 😄 ▶︎▶︎▶︎
#pragma mark - 

#pragma mark Color from RGB

+ (UIColor *)getColorWithRed : (float)r green : (float)g blue : (float)b andOpacity : (float)opacity
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:opacity];
}

#pragma mark Color from HEX code
+ (UIColor *) getColorFromHexString:(NSString *)hexString
{
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

#pragma mark - convertImageFromView 😄 ▶︎
#pragma mark - 
+ (UIImage *)convertImageFromView :(UIView *)view
{
    CGRect rect = [view bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size, true, 1.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - getVCWithIdentifier 😄 ▶︎
#pragma mark - 
+ (UIViewController *)getVCWithIdentifier : (NSString *)identifier andStoryBoardName :
(NSString *)storyBoardName
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    
    UIViewController *viewController = (UIViewController *)[storyBoard instantiateViewControllerWithIdentifier:identifier];
    return viewController;
}
#pragma mark - ImageConverter 😄 ▶︎
#pragma mark -
+ (void)loadCellImage:(UIImageView* )imageView imageUrl:(NSString* )imageURL
{
    if (imageURL) {
        [[imageView viewWithTag:99] removeFromSuperview];
        
        __block UIActivityIndicatorView *activityIndicator;
        __weak UIImageView *weakImageView = imageView;
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]
                     placeholderImage:nil
                              options:SDWebImageProgressiveDownload
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 if (!activityIndicator) {
                                     [weakImageView addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]];
                                     activityIndicator.tag = 99;
                                     activityIndicator.center = weakImageView.center;
                                     [activityIndicator startAnimating];
                                 }
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                [activityIndicator removeFromSuperview];
                                activityIndicator = nil;
                            }];
    }
}

+ (void)loadImage:(UIImageView* )imageView imageUrl:(NSString* )imageURL array:(NSMutableArray *)arr_photos
{
    if (imageURL) {
        [[imageView viewWithTag:99] removeFromSuperview];
        
        __block UIActivityIndicatorView *activityIndicator;
        __weak UIImageView *weakImageView = imageView;
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]
                     placeholderImage:nil
                              options:SDWebImageProgressiveDownload
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 if (!activityIndicator) {
                                     [weakImageView addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]];
                                     activityIndicator.tag = 99;
                                     activityIndicator.center = weakImageView.center;
                                     [activityIndicator startAnimating];
                                 }
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                [arr_photos addObject:image];
                                [activityIndicator removeFromSuperview];
                                activityIndicator = nil;
                            }];
    }
}

#pragma mark - Resize the View To fit various Screen Size 😄 ▶︎
#pragma mark - 


#pragma mark - UITextField Validation Check 😄 ▶︎
#pragma mark -
+ (BOOL)checkEmptyLength:(UITextField *)textfield
{
    NSString* aString= textfield.text;
    NSString *newString = [aString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    BOOL emptyLogin = newString.length>8;
    if (textfield.tag==10) {
        emptyLogin = newString.length==13;
    }
     
    return emptyLogin;
}


+ (BOOL)istextEmpty:(UITextField *)textfield withError:(NSString*)message
{
    NSString* aString= textfield.text;
    NSString *newString = [aString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    BOOL emptyLogin = newString.length == 0;
    textfield.layer.borderWidth=1.0;
    textfield.layer.borderColor = emptyLogin ? [UIColor redColor].CGColor : [UIColor clearColor].CGColor;
    if (emptyLogin) {
        textfield.text=@"";
        textfield.placeholder=message;
        [textfield setValue:[UIColor redColor]
                 forKeyPath:@"_placeholderLabel.textColor"];
        [textfield becomeFirstResponder];
    }

    return emptyLogin;
}


+ (BOOL)istextViewEmpty:(UITextView *)textView withError:(NSString*)message
{
    NSString* aString= textView.text;
    if ([aString isEqualToString:@"Address"]) {
        aString=@"";
    }
    else if ([aString isEqualToString:@"Your content goes here"]) {
        aString=@"";
    }
    NSString *newString = [aString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    BOOL emptyLogin = newString.length == 0;
    textView.layer.borderWidth=1.0;
    textView.layer.borderColor = emptyLogin ? [UIColor redColor].CGColor : [UIColor clearColor].CGColor;
    if (emptyLogin) {
        textView.text=message;
        textView.textColor = [UIColor redColor];
        //[textView becomeFirstResponder];
    }else{
        textView.textColor = [UIColor whiteColor];
    }
    
    return emptyLogin;
}

#pragma mark - scaleImageAndReframImageView 😄 ▶︎
#pragma mark - 
+ (CGRect)scaleImageAndReframImageView:(UIImage *)image forMaxResolution :(int)maxResolution keepImageViewWidthSame :(bool)keepImageWidth
{
    CGImageRef imgRef = image.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGRect bounds = CGRectMake(0, 0, maxResolution, height);
    
    // Settings 1 [It keeps the width same as the image view width and changes the height of the image]
    if (keepImageWidth)
    {
        CGFloat ratio = maxResolution / width;
        bounds.size.height = bounds.size.height * ratio;
    }
    
    // Settings 2 [It changes both the height and widt of the image based on the maxResolution]
    else
    {
        if (width > maxResolution || height > maxResolution) 
        {
            CGFloat ratio = width / height;
            if (ratio > 1) 
            {
                bounds.size.width = maxResolution; bounds.size.height = bounds.size.width / ratio;
            }
            else 
            {
                bounds.size.height = maxResolution; bounds.size.width = bounds.size.height * ratio;
            }
        }
    }
    
    /* // Open this function if you need the resized image(imageFinal).
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageFinal = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    */
    
    return bounds;
}

#pragma mark - Set Round Corner for Menu View 😄 ▶︎
#pragma mark - 
+ (void)setRoundCornerForMenuView :(UIView *)viewMenu withCornerRadius:(float)cornerRadius
{
    viewMenu.layer.cornerRadius = cornerRadius;
    viewMenu.layer.masksToBounds = true;
    
    for (UIView *view in viewMenu.subviews) 
    {
        view.layer.cornerRadius = 3.0;
        view.layer.masksToBounds = true;
    }
}

#pragma mark - setTitleWithUnderLine
#pragma mark - 
+(void)setTitleWithUnderLine : (NSString *)strTtile withTextColor : (UIColor *)textColor forButton : (UIButton *)btn
{
    // underline Download button
    NSMutableAttributedString* strDownload = [[NSMutableAttributedString alloc] initWithString:strTtile];
    
    // workaround for bug in UIButton - first char needs to be underlined for some reason!
    [strDownload addAttribute:NSUnderlineStyleAttributeName
                        value:@(NSUnderlineStyleSingle)
                        range:(NSRange){0,1}];
    
    [strDownload addAttribute:NSUnderlineStyleAttributeName
                        value:@(NSUnderlineStyleSingle)
                        range:(NSRange){0,[strDownload length]}];
    [strDownload addAttribute:NSForegroundColorAttributeName
                        value:textColor range:(NSRange){0,[strDownload length]}];
    
    //NSForegroundColorAttributeName
    [btn setAttributedTitle:strDownload forState:UIControlStateNormal];
}

+(void)addTextFieldPadding : (UITextField*)textField
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 20)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}




#pragma mark - Formatted Date

+(NSString *) getFormatedDateForReciptPrint:(NSString *)date
{
    NSString *update_dt=date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateT = [dateFormatter dateFromString:update_dt];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yy"];
    NSString *dateString = [formatter stringFromDate:dateT];
    return dateString;
}

+(NSString *) getFormatedForTime:(NSString *)date
{
    NSString *update_dt=date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateT = [dateFormatter dateFromString:update_dt];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
   [formatter setDateFormat:@"hh:mm a"];
    NSString *dateString = [formatter stringFromDate:dateT];
    return dateString;
}

+(NSString *) getFormatedForDate:(NSString *)date
{
    NSString *update_dt=date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateT = [dateFormatter dateFromString:update_dt];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yy"];
    NSString *dateString = [formatter stringFromDate:dateT];
    return dateString;
}
+(NSString *) stringByStrippingHTML {
    NSRange r;
    NSString *s = [self copy] ;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}
#pragma mark-
#pragma mark-UIImageCompressed
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - Formatted Price

+(NSString*)getPriceFormateStyle : (float) value
{
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMinimumFractionDigits:2];
    [numberFormatter setMaximumFractionDigits:2];
    NSString *theString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:value]];
    NSLog(@"The string: %@", theString);
    
    
    return theString;
    
}
#pragma mark-
#pragma mark-Cell Expandable
+(CGFloat)getLabelHeight:(NSString*)text Width:(CGFloat)width Font:(UIFont*)font{
    CGFloat height =0.0;
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    
    NSMutableAttributedString *attrComment = [[NSMutableAttributedString alloc] initWithString:text attributes:attributesDictionary];
    CGSize maximumLabelSize = CGSizeMake(width,CGFLOAT_MAX);
    height = [attrComment boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    return height;
}

+(CGSize)getLabelActualHeight:(NSString *)text Width:(CGFloat)width Font:(UIFont *)font{
    
    CGSize height ;
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    
    NSMutableAttributedString *attrComment = [[NSMutableAttributedString alloc] initWithString:text attributes:attributesDictionary];
    CGSize maximumLabelSize = CGSizeMake(width,CGFLOAT_MAX);
    height = [attrComment boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return height;
}

#pragma mark-
#pragma mark-Set Placeholder of UITextfield
+(UITextField *)changeUItextFieldColor:(UITextField *)textField{
    textField.layer.borderWidth=1.0;
    textField.layer.borderColor=[UIColor whiteColor].CGColor;
    [textField setValue:[UIColor whiteColor]
              forKeyPath:@"_placeholderLabel.textColor"];
    return textField;
}
#pragma mark-
#pragma mark-Set border color of UIButton
+(UIButton *)changeUIButtonColor:(UIButton *)btn{
    btn.layer.borderWidth=1.0;
    btn.layer.borderColor=[UIColor whiteColor].CGColor;
    return btn;
}
#pragma mark-
#pragma mark-Set border color of UIView
+(UIView *)changeUIViewColor:(UIView *)Vw{
    Vw.layer.borderWidth=1.0;
    Vw.layer.borderColor=[UIColor whiteColor].CGColor;
    return Vw;
}
@end
