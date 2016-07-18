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



@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *completeFart;
@property (nonatomic, assign) int counter;
@end

@implementation ViewController
{
    AVAudioPlayer *player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 200, 100)];
    
    label.text = @"Testing Fart";

    self.counter = 0;
    
    [self.view addSubview:label];
    
    if ([WCSession isSupported])
    {
        WCSession* session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    
    if(!self.completeFart) {
        self.completeFart = [[NSMutableArray alloc] init];
        self.counter = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Fart:(UIButton *)sender {
    
    UILabel *fartedLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 200, 100)];
    
    fartedLabel.text = @"Farted For Real";
    if(self.counter == 1){
        fartedLabel.text = @"watch Button clicked";
    } 
    [self.view addSubview:fartedLabel];
    
    NSString *soundFilePath = [NSString stringWithFormat:@"%@/WindyFart.mp3", [[NSBundle mainBundle]resourcePath] ] ;
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                                   error:nil];
    player.numberOfLoops = 1;
    

    
    [player play];
    
}

@end
