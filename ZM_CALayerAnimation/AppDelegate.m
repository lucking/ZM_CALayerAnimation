//
//  AppDelegate.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/6.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

//获取程序的根目录 Documents路径
#define HomeDirectoryPath	NSHomeDirectory()

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window= [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor= [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    // 沙盒文件 路径
    NSLog(@"---> HomeDirectoryPath = %@ \n \n ",HomeDirectoryPath);
    
    RootViewController *firstVC = [[RootViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:firstVC];
    nav.hidesBottomBarWhenPushed= YES;
    self.window.rootViewController= nav;
    
    

    
    return YES;
}

-(void)test {
    NSLog(@"---> priceValue = %@ ",[self setUnit:@"72915584.00" withSmall:@"1"]);
}
//单位1
- (NSString *)setUnit:(NSString *)value withSmall:(NSString *)small {
    
    NSString *strUnit;
    CGFloat priceValue = [value doubleValue];
    //以下为中国标准显示
    if (priceValue >10000&&priceValue<100000000){
        strUnit = [NSString stringWithFormat:@"%.f万", priceValue/10000];
    }else{
        strUnit = [NSString stringWithFormat:@"%.1f亿", priceValue/100000000];
    }
    return strUnit;
}




- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
}
- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"ZM_CALayerAnimation"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
