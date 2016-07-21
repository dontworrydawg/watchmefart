//
//  InterfaceController.m
//  Watch Extension
//
//  Created by Ber Jr on 2016-07-13.
//  Copyright © 2016 Ber Jr. All rights reserved.
//

#import "InterfaceController.h"
@import WatchConnectivity;


@interface InterfaceController() <WCSessionDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *completeFart;
@property (nonatomic, assign) int counter;

@end


@implementation InterfaceController


- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    

 
   
    // Configure interface objects here.
}
- (IBAction)toFart {
     self.counter = 1;
     [self.completeFart setText: @"Fart Complete"];

    NSString *completeFart = [NSString stringWithFormat:@"%d", self.counter];
    NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[completeFart] forKeys:@[@"counterValue"]];

    [[WCSession defaultSession] sendMessage:applicationData
                               replyHandler:^(NSDictionary *reply) {
                                   //handle reply form Iphone app here
                               }
                               errorHandler:^(NSError *error) {
                                   //catch any errors here
                               }
     ];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    if ([WCSession isSupported])
    {
        WCSession* session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    
    self.counter = 0;
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



