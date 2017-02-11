//
//  Foo.m
//  RandomApp
//
//  Created by Nadezhda Z on 03.02.17.
//  Copyright © 2017 Nadezhda Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Foo.h"

@implementation Foo: NSObject

-(IBAction)generate:(id)sender {
    int generated;
    generated = (random() % 100000) +1;
    [textfield setIntValue:generated];
}

-(IBAction)seed:(id)sender {
    [textfield setIntValue:03022017];
}

-(void)awakeFromNib {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE dd.MM.yyyy HH:mm"];
    NSDate *date = [NSDate date];
    NSString *now = [dateFormatter stringFromDate:date];
   [textfield setObjectValue:now];
}

@end

