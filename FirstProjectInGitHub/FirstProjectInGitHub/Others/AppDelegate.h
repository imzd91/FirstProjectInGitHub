//
//  AppDelegate.h
//  FirstProjectInGitHub
//
//  Created by zd on 2018/5/15.
//  Copyright © 2018年 zd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

