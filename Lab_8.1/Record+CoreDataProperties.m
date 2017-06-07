//
//  Record+CoreDataProperties.m
//  Lab_8.1
//
//  Created by Admin on 07.06.17.
//  Copyright © 2017 Oleg Kiselevich. All rights reserved.
//

#import "Record+CoreDataProperties.h"

@implementation Record (CoreDataProperties)

+ (NSFetchRequest<Record *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Record"];
}

@dynamic aviaCompany;
@dynamic cityFrom;
@dynamic cityTo;
@dynamic price;

@end
