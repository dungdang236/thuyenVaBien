//
//  ViewController.m
//  thuyenVaBien
//
//  Created by student on 16/12/2015.
//  Copyright © 2015 dungdang. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()

@end

@implementation ViewController
{
    UIImageView *ship;
    UIImageView *sea1, *sea2;
    AVAudioPlayer* audioPlayer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawShipAndSea];
    [self playSong];
    [self animateShip];
    [self animateSea];
}

- (void) drawShipAndSea {
    sea1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seapic1.jpg"]];
    sea1.frame = self.view.bounds;
    [self.view addSubview:sea1];
    
    sea2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seapics2.jpg"]];
    sea2.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:sea2];
    ship = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ship_PNG5405.png"]];
    
    ship.center = CGPointMake(200, 600);
    
    [self.view addSubview:ship];
}

-(void) animateShip {
    [UIView animateWithDuration:1 animations:^{
        ship.transform = CGAffineTransformMakeRotation(-0.08);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1
                         animations:^{
                             ship.transform = CGAffineTransformMakeRotation(0.08);
                         } completion:^(BOOL finished) {
                             [self animateShip];
                         }];
    }];
}

- (void) animateSea {
    [UIView animateWithDuration:10
                     animations:^{
                         sea1.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                         sea2.frame = self.view.bounds;
                     } completion:^(BOOL finished) {
                         sea1.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                         [UIView animateWithDuration:10 animations:^{
                             sea1.frame = self.view.bounds;
                             sea2.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                         } completion:^(BOOL finished) {
                             sea2.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                             [self animateSea];
                         }];
                         
                     }];
}

- (void) playSong {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"seasounds" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                         error:&error];
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}
- (void) viewWillDisappear:(BOOL)animated {
    [audioPlayer stop];
}
@end
