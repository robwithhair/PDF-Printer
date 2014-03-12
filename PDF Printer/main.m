//
//  main.m
//  PDF Printer
//
//  Created by Robert Harrison on 12/03/2014.
//  Copyright (c) 2014 Robert Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSUserDefaults *args = [NSUserDefaults standardUserDefaults];
        NSLog(@"boolArg   = %d", [args boolForKey:@"boolArg"]);
        NSLog(@"intArg    = %ld", (long)[args integerForKey:@"intArg"]);
        NSLog(@"floatArg  = %f", [args floatForKey:@"floatArg"]);
        NSLog(@"stringArg = %@", [args stringForKey:@"stringArg"]);
        // insert code here...
        NSLog(@"My first objective C program");
        
    }
    return 0;
}

