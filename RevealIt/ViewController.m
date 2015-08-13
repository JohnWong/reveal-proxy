//
//  ViewController.m
//  RevealIt
//
//  Created by John Wong on 8/9/15.
//  Copyright (c) 2015 John Wong. All rights reserved.
//

#import "ViewController.h"
#import "JWBonjourManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect rect = _label.frame;
    rect.origin.x = 10.5;
    rect.origin.y = 102.1;
    _label.frame = rect;
//    [[JWBonjourManager sharedInstance] start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
