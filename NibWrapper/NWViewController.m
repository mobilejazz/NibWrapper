// Copyright 2014 MobileJazz S.L.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
