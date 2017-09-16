//
//  Utility.h

//Class created by XCoder001 on 23rd January,2015 at AMS Technologies....... :)
//
#import "AppDelegate.h"

@interface Utility : NSObject

+ (NSUserDefaults *)getUserDefault;

+ (void)syncUserDefault : (NSUserDefaults *)userDefaults;
+ (void)saveObjectInUserDefaults :(id)object forKey :(NSString *)key;
+ (void)removeObjectFromUserDefaultsForKey:(NSString *)key;
+(void)saveUserCountry :(NSArray *)arrCountry withId:(NSString *)cid forKey:(NSString *)key;

+(void)saveUserState:(NSArray *)arrState withId:(NSString *)sid forKey:(NSString *)key;

+ (void)loadCellImage:(UIImageView* )imageView imageUrl:(NSString* )imageURL;
+ (void)loadImage:(UIImageView* )imageView imageUrl:(NSString* )imageURL array:(NSMutableArray *)arr_photos;
+(BOOL)checkForUserLoggedIn;

+ (id)getObjectForKey :(NSString *)key;
+(NSString *) stringByStrippingHTML;
+ (NSString *) applicationDocumentsDirectory;
+ (NSString *) applicationLibraryDirectory;

+ (NSString *)getDeviceID;

+ (NSDate*) dateFromString:(NSString*)aStr withDateFormat :(NSDateFormatter *)formatter;
+ (NSString *)stringFromDate :(NSDate *)date withDateFormat :(NSDateFormatter *)formatter;

+ (NSString *) appendStringWithSapce:(NSString*)str1 str2:(NSString *)str2;

+ (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg;

+ (BOOL) isValidEmail:(NSString *)emailString;

+ (BOOL)validateEmailWithString:(NSString*)checkString;

+ (AppDelegate *)getAppDelegate;

+ (void)showBottomToTopAnimation : (UIView *)view;
+ (void)showTopToBottomAnimation : (UIView *)view;

+ (void)getRoundView : (UIView *)view andBorderWidth : (int)borderWidth borderColor : (UIColor *)borderColor;

+ (UIColor *)getColorWithRed : (float)r green : (float)g blue : (float)b andOpacity : (float)opacity;

+ (UIColor *) getColorFromHexString:(NSString *)hexString;

+ (UIImage *)convertImageFromView :(UIView *)view;

+ (UIView *)getViewAfterResize : (UIView *)baseView;

+ (UIViewController *)getVCWithIdentifier : (NSString *)identifier andStoryBoardName :
(NSString *)storyBoardName;


+ (CGRect)scaleImageAndReframImageView:(UIImage *)image forMaxResolution :(int)maxResolution keepImageViewWidthSame :(bool)keepImageWidth;

+ (void)setRoundCornerForMenuView :(UIView *)viewMenu withCornerRadius:(float)cornerRadius;

+(void)setTitleWithUnderLine : (NSString *)strTtile withTextColor : (UIColor *)textColor forButton : (UIButton *)btn;

+(void)isRememberUser :(NSString *)strEmail withPassword :(NSString *)strPass withTag :(BOOL)tag;
+(BOOL)isRememberLogin;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+(void)addTextFieldPadding : (UITextField*)textField;

+(NSString *) getFormatedDateForReciptPrint:(NSString *)date;
+(NSString *) getFormatedForTime:(NSString *)date;
+(NSString *) getFormatedForDate:(NSString *)date;

+(NSString*)getPriceFormateStyle : (float) value;
+ (BOOL)istextViewEmpty:(UITextView *)textView withError:(NSString*)message;
+ (BOOL)checkEmptyLength:(UITextField *)textfield;
+ (BOOL)istextEmpty:(UITextField *)textfield withError:(NSString*)message;
+(CGFloat)getLabelHeight:(NSString*)text Width:(CGFloat)width Font:(UIFont*)font;
+(CGSize)getLabelActualHeight:(NSString *)text Width:(CGFloat)width Font:(UIFont *)font;
+(UITextField *)changeUItextFieldColor:(UITextField *)textField;
+(UIButton *)changeUIButtonColor:(UIButton *)btn;
@end
