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

#import "RHArguments.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        RHArguments *arguments = [[RHArguments alloc] initWithCArray:argv ofLength:argc];
        //Optionally display arguments
        //NSLog(@"Arguments = %@", [arguments description]);
        
        // Create the print settings.
        NSPrintInfo *printInfo = [NSPrintInfo sharedPrintInfo];

        //Options for setting a paper size declared by the printer.  We aren't using that because it doesn't print pdf edge to edge.  It creates a broder and srinks it.  Set either point size Width x Height or paper name as shown in cups.
        //NSSize pageSize;
        //pageSize.width = 631;
        //pageSize.height = 841.9;
        //[printInfo setPaperName:@"A4.Photo"];
        //[printInfo setPaperSize:pageSize];
        
        // We now don't need to do this but we are.  May change the Horizontal Pagination, we'll see.
        [printInfo setTopMargin:0];
        [printInfo setBottomMargin:0];
        [printInfo setLeftMargin:0];
        [printInfo setRightMargin:0];
        [printInfo setHorizontalPagination:NSFitPagination];
        [printInfo setVerticalPagination:NSFitPagination];
        
        // Get current printer and PM print session
        PMPrintSession session = [printInfo PMPrintSession];
        PMPrinter currentPrinter = NULL;
        (void)PMSessionGetCurrentPrinter(session, &currentPrinter);
        
        /*
        //Use this code to show a list of the currently selected printer page size options  We won't use these, we'll make our own page size to ensure full bleed
        CFArrayRef paperList = NULL;
        (void)PMPrinterGetPaperList(currentPrinter, &paperList);
        CFStringRef description = CFCopyDescription(paperList);
        NSLog(@"paper sizes = %@", description);*/
        
        // Create our own custom paper - because defaults from printer do not allow edge to edge printing, so page is shrunk.
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

        // Set duplex mode from print settings
        PMPrintSettings printSettings = [printInfo PMPrintSettings];
        PMDuplexMode duplexMode = arguments.duplexMode;
        PMSetDuplex(printSettings, duplexMode);
        [printInfo updateFromPMPrintSettings];
        
        /* Optionally use the following to print out all the information about the page size - for debuging
        NSLog(@"paperName  = %@", [printInfo paperName]);
        NSLog(@"Scaling Factor  = %f", [printInfo scalingFactor]);
        NSLog(@"paperSize = %f width %f height", [printInfo paperSize].width, [printInfo paperSize].height);
        NSLog(@"Page Bounds = %f x %f", [printInfo imageablePageBounds].size.width, [printInfo imageablePageBounds].size.height);
        NSLog(@"Page origin = %f x %f", [printInfo imageablePageBounds].origin.x, [printInfo imageablePageBounds].origin.y);
        */
        
        for (NSUInteger x = 0; x < [arguments.files count]; x++){
            // Create the document reference.
            PDFDocument *pdfDocument = [[PDFDocument alloc] initWithData:[[NSData alloc] initWithContentsOfFile:[arguments.files objectAtIndex:x]]];
            if (pdfDocument == NULL) NSLog(@"Could Not Print File %@ an error occured\n", [arguments.files objectAtIndex:x]);
            if (pdfDocument != NULL) printf("Printing File: %s\n", [[arguments.files objectAtIndex:x] UTF8String]);
            //Select Auto Rotate Mode - for landscape pages
            BOOL autoRotate = YES;
            //Scale Down PDFs which are larger than Chosen Size
            PDFPrintScalingMode scale = kPDFPrintPageScaleDownToFit; // see PDFDocument.h
            // Create Print Operation
            NSPrintOperation *op = [pdfDocument printOperationForPrintInfo: printInfo scalingMode: scale autoRotate: autoRotate];
            // Run the print operation without showing any dialogs.
            [op setShowsPrintPanel:NO];
            [op setShowsProgressPanel:NO];
            [op runOperation];
        }
        

    }
    return 0;
}
