//
//  Foo.h
//  RandomApp
//
//  Created by Nadezhda Z on 03.02.17.
//  Copyright © 2017 Nadezhda Z. All rights reserved.
//

#ifndef Foo_h
#define Foo_h
#import <Foundation/Foundation.h>
#import <AppKit/NSTextField.h>

@interface Foo : NSObject {
    IBOutlet NSTextField *textfield;
}

-(IBAction)seed:(id)sender;
-(IBAction)generate:(id)sender;

@end

#endif /* Foo_h */
