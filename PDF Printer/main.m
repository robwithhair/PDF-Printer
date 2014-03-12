//
//  main.m
//  PDF Printer
//
//  Created by Robert Harrison on 12/03/2014.
//  Copyright (c) 2014 Robert Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Quartz/Quartz.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSUserDefaults *args = [NSUserDefaults standardUserDefaults];
        NSLog(@"boolArg   = %d", [args boolForKey:@"duplex"]);
        //NSLog(@"intArg    = %ld", (long)[args integerForKey:@"intArg"]);
        //NSLog(@"floatArg  = %f", [args floatForKey:@"floatArg"]);
        NSLog(@"PDF Filepath = %@", [args stringForKey:@"file"]);
        // insert code here...
        NSLog(@"My first objective C program");
        
        
    }
    return 0;
}

/*#import <Quartz/Quartz.h>

- (void)printPDF:(NSURL *)fileURL {
    
    // Create the print settings.
    NSPrintInfo *printInfo = [NSPrintInfo sharedPrintInfo];
    [printInfo setTopMargin:0.0];
    [printInfo setBottomMargin:0.0];
    [printInfo setLeftMargin:0.0];
    [printInfo setRightMargin:0.0];
    [printInfo setHorizontalPagination:NSFitPagination];
    [printInfo setVerticalPagination:NSFitPagination];
    
    // Create the document reference.
    PDFDocument *pdfDocument = [[[PDFDocument alloc] initWithURL:fileURL] autorelease];
    
    // Invoke private method.
    // NOTE: Use NSInvocation because one argument is a BOOL type. Alternately, you could declare the method in a category and just call it.
    BOOL autoRotate = YES;
    NSMethodSignature *signature = [PDFDocument instanceMethodSignatureForSelector:@selector(getPrintOperationForPrintInfo:autoRotate:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:@selector(getPrintOperationForPrintInfo:autoRotate:)];
    [invocation setArgument:&printInfo atIndex:2];
    [invocation setArgument:&autoRotate atIndex:3];
    [invocation invokeWithTarget:pdfDocument];
    
    // Grab the returned print operation.
    NSPrintOperation *op = nil;
    [invocation getReturnValue:&op];
    
    // Run the print operation without showing any dialogs.
    [op setShowsPrintPanel:NO];
    [op setShowsProgressPanel:NO];
    [op runOperation];*/