//
//  ViewController.m
//  UserNotificationDemo
//
//  Created by jinren on 12/12/18.
//  Copyright © 2018 jinren. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

//#import<MobileCoreServices/MobileCoreServices.h>
@import MobileCoreServices;

@interface ViewController ()
@property (strong, nonatomic) void(^showNoti)(void);
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (IBAction)showNotiWithAction:(id)sender {

    self.showNoti = ^void(){
        UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
        content.title = @"Calling";
        content.body = @"QiQi is Calling";
        content.categoryIdentifier = @"Call_Cate";
        NSString *path = [[NSBundle mainBundle] pathForResource:@"file" ofType:@"png"];
        
        NSURL* url = [NSURL fileURLWithPath:path];
        NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:2];
        dict[UNNotificationAttachmentOptionsTypeHintKey] = (NSString*)kUTTypeJPEG;
        dict[UNNotificationAttachmentOptionsThumbnailHiddenKey] = @YES;
        UNNotificationAttachment* attach = [UNNotificationAttachment attachmentWithIdentifier:@"file" URL:url options:dict error:nil];
        content.attachments = @[attach];
        UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"inComingCall" content:content trigger:nil];
        
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            NSLog(@"show Notification");
        }];
    };
    
}

- (IBAction)showNotiwithReply:(id)sender {
    
    self.showNoti = ^void(){
        UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
        content.title = @"Calling";
        content.body = @"Hi";
        content.categoryIdentifier = @"PhotoPreview";//@"Reply_Cate";
        NSString *path = [[NSBundle mainBundle] pathForResource:@"file" ofType:@"png"];
        
        NSURL* url = [NSURL fileURLWithPath:path];
        NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:2];
        dict[UNNotificationAttachmentOptionsTypeHintKey] = (NSString*)kUTTypeJPEG;
        dict[UNNotificationAttachmentOptionsThumbnailHiddenKey] = @YES;
        UNNotificationAttachment* attach = [UNNotificationAttachment attachmentWithIdentifier:@"file" URL:url options:dict error:nil];
        content.attachments = @[attach];
        UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"inComingCall" content:content trigger:nil];
        
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            NSLog(@"show Notification");
        }];
    };
}

- (void)onEnterBackground
{
    self.showNoti();
}

- (void)onEnterForeground
{
    self.showNoti = nil;
}

@end
