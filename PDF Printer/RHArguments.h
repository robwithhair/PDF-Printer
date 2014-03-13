//
//  RHArguments.h
//  PDF Printer
//
//  Created by Robert Harrison on 13/03/2014.
//  Copyright (c) 2014 Robert Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ApplicationServices/ApplicationServices.h>

@interface RHArguments : NSObject
@property const char ** cArguments;
@property int argc;
@property NSArray *arguments;
@property NSArray *files;
@property NSFileManager *fileManager;

@property PMDuplexMode duplexMode;

- (id)initWithCArray: (const char**)array ofLength:(int) length;
+ (RHArguments *) newArgumentsForCArray: (const char**)array ofLength: (int)length;
- (NSString *) description;
@end
