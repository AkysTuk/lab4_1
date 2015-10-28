//
//  Student.m
//  lab4_1
//
//  Created by Admin on 28.10.15.
//  Copyright © 2015 Admin. All rights reserved.
//

#import "Student.h"

@implementation Student

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init]; if (self)
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.surname = [aDecoder decodeObjectForKey:@"surname"]; }
    return self; }
-(void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.surname forKey:@"surname"]; }
@end