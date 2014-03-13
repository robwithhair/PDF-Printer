//
//  RHArguments.m
//  PDF Printer
//
//  Created by Robert Harrison on 13/03/2014.
//  Copyright (c) 2014 Robert Harrison. All rights reserved.
//

#import "RHArguments.h"

@implementation RHArguments

- (id)initWithCArray:(const char **)array ofLength:(int) length{
    self = [super init];
    self.cArguments = array;
    self.argc = length;
    self.duplexMode = kPMDuplexNone;
    self.fileManager = [[NSFileManager alloc] init];
    NSMutableArray * tmpary = [NSMutableArray arrayWithCapacity: length];
    for (int i = 0; i < length; i++){
        [tmpary addObject: [NSString stringWithCString: array[i] encoding:NSUTF8StringEncoding]];
    }
    self.arguments = [[NSArray alloc] initWithArray:tmpary];
    [self setupProperties];
    return self;
}

- (void) setupProperties {
    NSUInteger length = [self.arguments count];
    NSMutableArray * files = [[NSMutableArray alloc] init];
    for (NSUInteger x = 1; x < length; x++){
        NSString *string = [self.arguments objectAtIndex:x];
        if ([string isEqualToString:@"-duplexNoTumble"]){
            self.duplexMode = kPMDuplexNoTumble;
        }
        else if ([string isEqualToString:@"-duplexTumble"]){
            self.duplexMode = kPMDuplexTumble;
        }
        else if ([string isEqualToString:@"-file"]){
            x++;
            [self addFile:[self.arguments objectAtIndex:x] toArray:files];
        }
        else {
            [self addFile:string toArray:files];
        }
    }
    self.files = [NSArray arrayWithArray:files];
}

- (void) addFile: (NSString*)filePath toArray: (NSMutableArray*) array {
    if (![self.fileManager fileExistsAtPath:filePath]) NSLog(@"File does not exist at path: %@", filePath);
    else if (![self.fileManager isReadableFileAtPath:filePath]) NSLog(@"Cannot read file at path: %@", filePath);
    [array addObject:filePath];
}

- (NSString *) description {
    return [NSString stringWithFormat:@"Raw Arguments = %@, \nDuplex Mode = %u, Files = %@", [self.arguments description], (unsigned int)self.duplexMode, [self.files description]];
}

+ (RHArguments *) newArgumentsForCArray: (const char**)array ofLength: (int)length {
    return [[RHArguments alloc] initWithCArray:array ofLength:length];
}

@end
