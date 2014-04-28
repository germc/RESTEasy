//
//  main.m
//  sandbox
//
//  Created by John Tumminaro on 4/24/14.
//
//

#import <Foundation/Foundation.h>
#import "RESTEasy.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        TGRESTResource *people = [TGRESTResource newResourceWithName:@"people"
                                                                 model:@{
                                                                         @"name": [NSNumber numberWithInteger:TGPropertyTypeString],
                                                                         @"email": [NSNumber numberWithInteger:TGPropertyTypeString]
                                                                         }];
        
        TGRESTResource *cars = [TGRESTResource newResourceWithName:@"cars"
                                                              model:@{
                                                                      @"name": [NSNumber numberWithInteger:TGPropertyTypeString],
                                                                      @"color": [NSNumber numberWithInteger:TGPropertyTypeString]
                                                                      }
                                                            actions:TGResourceRESTActionsDELETE | TGResourceRESTActionsGET | TGResourceRESTActionsPOST | TGResourceRESTActionsPUT
                                                         primaryKey:nil
                                                    parentResources:@[people]];
        
        [[TGRESTServer sharedServer] addResource:people];
        [[TGRESTServer sharedServer] addResource:cars];
        
        [[TGRESTServer sharedServer] startServerWithOptions:nil];
        
        __block BOOL serverRunning = YES;
        
        [[NSNotificationCenter defaultCenter] addObserverForName:TGRESTServerDidShutdownNotification
                                                          object:nil
                                                           queue:nil
                                                      usingBlock:^(NSNotification *note) {
                                                          serverRunning = NO;
                                                      }];
        
        while (serverRunning) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        
    }
    return 0;
}

