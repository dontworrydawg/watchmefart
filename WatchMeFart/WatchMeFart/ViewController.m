//
//  ViewController.m
//  WatchMeFart
//
//  Created by Ber Jr on 2016-07-13.
//  Copyright © 2016 Ber Jr. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@import SpriteKit;
@import UIKit;
@import WatchConnectivity;



@interface ViewController () <WCSessionDelegate>
@property (strong, nonatomic) NSMutableArray *completeFart;
@property (weak, nonatomic) UITableView *mainTableView;
@end

@implementation ViewController
{
    AVAudioPlayer *player;
    NSString *transferedCompleteFart;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    transferedCompleteFart = @"0";
    
    
    if ([WCSession isSupported])
    {
        WCSession* session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    
    if(!self.completeFart) {
        self.completeFart = [[NSMutableArray alloc] init];
    }
    
    [self.mainTableView reloadData];
    
    NSThread* myThread = [[NSThread alloc] initWithTarget:self
                                                  selector:@selector(loopingThread)
                                                    object:nil];
    
    [myThread start];
    //[self loopingThread];

}

- (void)loopingThread{
    UILabel *fartedLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 200, 100)];
    
    while( 1 )
    {
        
        
        if ( [transferedCompleteFart isEqualToString:@"0"] ){
            fartedLabel.text = @"it's zero";
        }
        else if ( [transferedCompleteFart isEqualToString:@"1"]){
            fartedLabel.text = @"it's one";
            [self makeFartSound];
            transferedCompleteFart = @"0";
        }
        
        [self.view addSubview:fartedLabel];
        [NSThread sleepForTimeInterval:0.1];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Fart:(UIButton *)sender {
    int x = 0;
    
    UILabel *fartedLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 200, 100)];
    
   // while( x < 10000)
   // {
        x ++;
    
       if ( [transferedCompleteFart isEqualToString:@"0"] ){
        fartedLabel.text = @"it's zero";
       }
       else if ( [transferedCompleteFart isEqualToString:@"1"]){
        fartedLabel.text = @"it's one";
        [self makeFartSound];
        transferedCompleteFart = @"0";
       }
    
       [self.view addSubview:fartedLabel];
    //}

    

    
    
    
}

-(void)makeFartSound {
    
    NSString *soundFilePath = [NSString stringWithFormat:@"%@/WindyFart.mp3", [[NSBundle mainBundle]resourcePath] ] ;
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                    error:nil];
    player.numberOfLoops = 1;
    
    [player play];
}

- (void)session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary *)message
   replyHandler:(nonnull void (^)(NSDictionary * __nonnull))replyHandler {
    transferedCompleteFart = [message objectForKey:@"counterValue"];
    
    if(!self.completeFart)
    {
        self.completeFart = [[NSMutableArray alloc] init];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.completeFart addObject:transferedCompleteFart];
        [self.mainTableView reloadData];
    });
}
@end
