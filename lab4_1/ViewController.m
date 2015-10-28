//
//  ViewController.m
//  lab4_1
//
//  Created by Admin on 28.10.15.
//  Copyright © 2015 Admin. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"

@interface ViewController ()
{
    NSMutableArray *_string;
    NSMutableArray *_students;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    NSData *plistData = [NSData dataWithContentsOfURL:[self plistURL]];
    _students = [[NSKeyedUnarchiver unarchiveObjectWithData:plistData] mutableCopy];
    if (!_students)
        _students = [NSMutableArray array];
    NSMutableString *str = [NSMutableString string]; for (Student *stud in _students)
        [str appendFormat:@"Name: %@, surname: %@.\n", stud.name, stud.surname]; self.textVuew2.text = str;
    self.textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"text"];
    [super viewDidLoad];
    _string = [NSMutableArray arrayWithContentsOfURL:[self plistURL]]; if (!_string)
        _string = [NSMutableArray array];
    self.textView.text = [_string componentsJoinedByString:@"\n"];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonSave:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:self.textField.text forKey:@"text"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_string addObject:self.textField.text];
    self.textView.text = [_string componentsJoinedByString:@"\n"]; [_string writeToURL:[self plistURL] atomically:YES];
}
- (IBAction)buttonSave2:(id)sender {
    Student *s = [[Student alloc] init];
    s.name = self.Name.text;
    s.Surname = self.Surname.text;
    [_students addObject:s];
    
    NSMutableData *data = [NSMutableData data]; NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data]; archiver.outputFormat = NSPropertyListXMLFormat_v1_0;
    [archiver encodeObject:_students forKey:@"root"]; [archiver finishEncoding];
    [data writeToURL:[self plistURL] atomically:YES];
    
    NSMutableString *str = [NSMutableString string];
    
    for (Student *stud in _students)
        [str appendFormat:@"Name: %@, surname: %@.\n", stud.name, stud.surname];
    
    self.textVuew2.text = str;

    NSString *SQL = [NSString stringWithFormat:@"INSERT INTO students (name, surname) VALUES ('%@', '%@')", self.Name.text,self.Surname.text];
//    [_db executeUpdate:SQL];
}

- (NSURL *)plistURL {
    return [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"data.plist"];
}



@end
