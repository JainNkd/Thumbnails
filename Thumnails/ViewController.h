//
//  ViewController.h
//  Thumnails
//
//  Created by Naveen Kumar Dungarwal on 3/18/15.
//  Copyright (c) 2015 Naveen Kumar Dungarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *thumnail1;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail2;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail3;
- (IBAction)playVideo:(UIButton *)sender;

@end

