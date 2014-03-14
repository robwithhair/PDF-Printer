PDF-Printer
===========

A command line Mac OSX tool for printing PDF's on full size in duplex mode
Based on the work of Dan Reese in this blog post http://www.danandcheryl.com/2010/05/how-to-print-a-pdf-file-using-cocoa
Written in Objective C / Cocoa for OSX

Usage: ./PDF\ Printer [-duplexTumble -duplexNoTumble] [/Absolute/Or/Relative/Path/To/File ...]

List the files seperated by spaces after the options.  Available options:

    -duplexNoTumble     Portrait style, long edge binding double sided printing
    -duplexTumble       Landscape style, short edge binding double sided printing
    -file [path...]     Optional tag to use before file path to be printed 
                        (don't use this, just list the files seperated by spaces)

Use this code however you like.  It is a little scrappy as it's my first objective C application.  

Pull requests are very welcome, should you wish to tidy up or add functionality to this code.

Currently working on tidying up, setting command line arguments and commenting the code properly.

If you want to say thanks, just use my service.  http://www.postthisforme.co.uk
