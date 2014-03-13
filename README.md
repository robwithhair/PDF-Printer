PDF-Printer
===========

A command line tool for printing PDF's full size in duplex mode
Written in Objective C / Cocoa for OSX

Usage: ./PDF\ Printer [-duplexTumble -duplexNoTumble] [/Absolute/Or/Relative/Path/To/File ...]

List the files seperated by spaces after the options.  Available options:

    -duplexNoTumble     Portrait style, long edge binding double sided printing
    -duplexTumble       Landscape style, short edge binding double sided printing
    -file [path...]     Optional tag to use before file path to be printed 
                        (don't use this, just list the files seperated by spaces)

Use this code however you like.  It is a little scrappy as it's my first objective C application.  

Pull requests are very welcome, should you wish to tidy up or add functionality to this code.

If you want to say thanks, just use my service.  http://post-this-for-me.appspot.com < Temporary URL
