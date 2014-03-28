//
//  NWViewController.m
//  NibWrapper
//
//  Created by Joan Martin on 27/03/14.
//  Copyright (c) 2014 Mobile Jazz. All rights reserved.
//

#import "NWViewController.h"

#import "UINibWrapper.h"
#import "UITestView.h"

@interface NWViewController ()

@property (weak, nonatomic) IBOutlet UINibWrapper *testViewWrapper;

@end


@implementation NWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_testViewWrapper.contentView foo];
}

@end
