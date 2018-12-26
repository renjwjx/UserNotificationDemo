//
//  NotificationViewController.m
//  photoPreview
//
//  Created by jinren on 12/26/18.
//  Copyright © 2018 jinren. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification {
    self.label.text = notification.request.content.body;
    UNNotificationAttachment* attachment = (UNNotificationAttachment*)[notification.request.content.attachments firstObject];
    NSURL* url =  url = attachment.URL;
    UIImage* image = [UIImage imageWithContentsOfFile:url.path];
//    self.img.image = image;
}

@end
