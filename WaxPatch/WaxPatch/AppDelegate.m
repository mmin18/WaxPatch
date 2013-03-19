//
//  AppDelegate.m
//  WaxPatch
//
//  Created by Yimin Tu on 12-8-4.
//  Copyright (c) 2012年 dianping.com. All rights reserved.
//

#import "AppDelegate.h"
#import "lauxlib.h"
#import "wax.h"
#import "ZipArchive.h"
#import "MainViewController.h"

#define WAX_PATCH_URL @"http://raw.github.com/mmin18/WaxPatch/master/patch/patch.zip"

@implementation AppDelegate

@synthesize window = _window;

- (id)init {
    if(self = [super init]) {
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *dir = [doc stringByAppendingPathComponent:@"lua"];
        [[NSFileManager defaultManager] removeItemAtPath:dir error:NULL];
        [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:NULL];
        
        NSString *pp = [[NSString alloc ] initWithFormat:@"%@/?.lua;%@/?/init.lua;", dir, dir];
        setenv(LUA_PATH, [pp UTF8String], 1);
    }
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[MainViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    [[[UIAlertView alloc] initWithTitle:@"WaxPatch" message:@"This is the obj-c impl of a simple table view. Press [Load] button to load the wax patch and run from lua." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Load", nil] show];
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == [alertView firstOtherButtonIndex]) {
        // you probably want to change this url before run
        NSURL *patchUrl = [NSURL URLWithString:WAX_PATCH_URL];
        NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:patchUrl] returningResponse:NULL error:NULL];
        if(data) {
            NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            
            NSString *patchZip = [doc stringByAppendingPathComponent:@"patch.zip"];
            [data writeToFile:patchZip atomically:YES];
            
            NSString *dir = [doc stringByAppendingPathComponent:@"lua"];
            [[NSFileManager defaultManager] removeItemAtPath:dir error:NULL];
            [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:NULL];
            
            ZipArchive *zip = [[ZipArchive alloc] init];
            [zip UnzipOpenFile:patchZip];
            [zip UnzipFileTo:dir overWrite:YES];
            
            NSString *pp = [[NSString alloc ] initWithFormat:@"%@/?.lua;%@/?/init.lua;", dir, dir];
            setenv(LUA_PATH, [pp UTF8String], 1);
            wax_start("patch", nil);
            
            // reinit MainViewController again
            self.window.rootViewController = [[MainViewController alloc] init];
            [self.window makeKeyAndVisible];
        } else {
            [[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Fail to download wax patch from %@", patchUrl] delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
        }
    }
}

@end
