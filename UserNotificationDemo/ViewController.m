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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self performSelectorOnMainThread:@selector(showNotification) withObject:nil waitUntilDone:NO];
    [self performSelector:@selector(showNotification) withObject:nil afterDelay:3];
}

-(void)showNotification
{
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = @"Calling";
    content.body = @"QiQi is Calling";
    content.categoryIdentifier = @"Call_Cate";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"file" ofType:@"png"];
    
//    NSURL* url = [NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/pic/item/9825bc315c6034a84d0cf125c6134954082376a3.jpg"];
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
    
}

@end
