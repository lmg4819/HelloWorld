//
//  AppDelegate.m
//  HelloWordl
//
//  Created by lmg on 2019/4/28.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "AppDelegate.h"
#import "BinaryTreeNode.h"
#import "YYDiskCache.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/*
             4
      2           6
   1    3      5     7
 
 
 
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    BinaryTreeNode *treeNode = [BinaryTree createTreeWithValues:@[@4,@2,@1,@3,@6,@5,@7]];
    NSMutableArray *results = [NSMutableArray array];
//    [BinaryTree inOrderTraverseTree:treeNode handle:^(BinaryTreeNode * _Nonnull treeNode) {
//        [results addObject:@(treeNode.value)];
//    }];
    
    BinaryTreeNode *invertNode = [BinaryTree invertBinaryTree:treeNode];
    
    [BinaryTree levelTraverseTree:invertNode handle:^(BinaryTreeNode * _Nonnull treeNode) {
        [results addObject:@(treeNode.value)];
    }];
    
    NSLog(@"层序遍历结果：%@", [results componentsJoinedByString:@","]);
    @try {
        
    } @catch (NSException *exception) {
        NSLog(@"---%@---",exception);
    } @finally {
        
    }
    
    NSString *string = @"hellojsafhdksjafdsa";
    NSString *subString = @"mjjjjj";
    [string rangeOfString:subString];
    
    
    int array[] = {1,2,3,1,1,4};
    int length = sizeof(array) / sizeof(int);
    if (length == 1) {

    }
    
//    const char *stringChars = [string UTF8String];
//    const char *subStringChars = [subString UTF8String];
//
//    int len = (int)strlen(stringChars);
//    int subLen = (int)strlen(subStringChars);
//    int i=0,j=0;
//    while (j < subLen-1 && i< (len-1)) {
//        if (stringChars[i] == subStringChars[j]) {
//            i++;
//            j++;
//        }else{
//            j=0;
//            i++;
//        }
//    }
//    if (j == subLen -1) {
//        NSLog(@"------%d------",i-j);
//    }else{
//        NSLog(@"-1");
//    }
    
    
    
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
