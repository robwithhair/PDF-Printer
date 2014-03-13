//
//  main.m
//  PDF Printer
//
//  Created by Robert Harrison on 12/03/2014.
//  Copyright (c) 2014 Robert Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <Quartz/Quartz.h>
#import <ApplicationServices/ApplicationServices.h>


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSUserDefaults *args = [NSUserDefaults standardUserDefaults];
        NSLog(@"boolArg   = %d", [args boolForKey:@"duplex"]);
        //NSLog(@"intArg    = %ld", (long)[args integerForKey:@"intArg"]);
        //NSLog(@"floatArg  = %f", [args floatForKey:@"floatArg"]);
        NSLog(@"PDF Filepath = %@", [args stringForKey:@"file"]);
        NSURL *fileURL = [NSURL URLWithString:[args stringForKey:@"file"]];
        NSLog(@"Filepath = %@", [fileURL absoluteURL]);
        // insert code here...
        NSLog(@"My first objective C program");
        
        // Create the print settings.
        NSPrintInfo *printInfo = [NSPrintInfo sharedPrintInfo];

        NSSize pageSize;
        pageSize.width = 631;
        pageSize.height = 841.9;
        //[printInfo setPaperName:@"A4.Photo"];
        [printInfo setPaperSize:pageSize];
        
        [printInfo setTopMargin:3.6];
        [printInfo setBottomMargin:3.6];
        [printInfo setLeftMargin:3.6];
        [printInfo setRightMargin:3.6];
        
        [printInfo setHorizontalPagination:NSFitPagination];
        [printInfo setVerticalPagination:NSFitPagination];
        PMPrintSettings printSettings = [printInfo PMPrintSettings];
        PMDuplexMode duplexMode = kPMDuplexNoTumble;
        PMSetDuplex(printSettings, duplexMode);
        
        PMPrintSession session = [printInfo PMPrintSession];
        PMPrinter currentPrinter = NULL;
        (void)PMSessionGetCurrentPrinter(session, &currentPrinter);
        CFArrayRef paperList = NULL;
        (void)PMPrinterGetPaperList(currentPrinter, &paperList);
        CFStringRef description = CFCopyDescription(paperList);
        NSLog(@"paper sizes = %@", description);
        PMPaper paper = NULL;
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
        PMPaperMargins margins;
        margins.bottom = 0;
        margins.left = 0;
        margins.right = 0;
        margins.top = 0;
        PMPaperCreateCustom(currentPrinter, uuidStr, uuidStr, 595.29, 841.89, &margins, &paper);
        PMPageFormat theChosenPageFormat = NULL;
        (void)PMCreatePageFormatWithPMPaper(&theChosenPageFormat, paper);
        PMPageFormat originalFormat = [printInfo PMPageFormat];
        (void)PMCopyPageFormat(theChosenPageFormat, originalFormat);
        [printInfo updateFromPMPageFormat];
        
        [printInfo updateFromPMPrintSettings];
        NSLog(@"paperName  = %@", [printInfo paperName]);
        NSLog(@"Scaling Factor  = %f", [printInfo scalingFactor]);
        NSLog(@"paperSize = %f width %f height", [printInfo paperSize].width, [printInfo paperSize].height);
        NSLog(@"Page Bounds = %f x %f", [printInfo imageablePageBounds].size.width, [printInfo imageablePageBounds].size.height);
         NSLog(@"Page origin = %f x %f", [printInfo imageablePageBounds].origin.x, [printInfo imageablePageBounds].origin.y);
        
        // Create the document reference.
        PDFDocument *pdfDocument = [[PDFDocument alloc] initWithURL:fileURL];
        
        //- (NSPrintOperation *) printOperationForPrintInfo: (NSPrintInfo *) printInfo scalingMode: (PDFPrintScalingMode) scaleMode autoRotate: (BOOL) doRotate;
        
        BOOL autoRotate = YES;
        PDFPrintScalingMode scale = kPDFPrintPageScaleNone; // see PDFDocument.h
        NSPrintOperation *op = [pdfDocument printOperationForPrintInfo: printInfo scalingMode: scale autoRotate: autoRotate];
        // Invoke private method.
        // NOTE: Use NSInvocation because one argument is a BOOL type. Alternately, you could declare the method in a category and just call it.
        
        /*NSMethodSignature *signature = [PDFDocument instanceMethodSignatureForSelector:@selector(printOperationForPrintInfo:scalingMode:autoRotate:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setSelector:@selector(printOperationForPrintInfo:scalingMode:autoRotate:)];
        [invocation setArgument:&printInfo atIndex:2];
        [invocation setArgument:&scale atIndex:3];
        [invocation setArgument:&autoRotate atIndex:4];
        [invocation invokeWithTarget:pdfDocument];*/
        
        // Grab the returned print operation.
        /*NSPrintOperation *op = nil;
        [invocation getReturnValue:&op];*/
        
        // Run the print operation without showing any dialogs.
        //[op setShowsPrintPanel:NO];
        //[op setShowsProgressPanel:NO];
        [op runOperation];
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