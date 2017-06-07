//
//  Record+CoreDataProperties.h
//  Lab_8.1
//
//  Created by Admin on 07.06.17.
//  Copyright © 2017 Oleg Kiselevich. All rights reserved.
//

#import "Record+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Record (CoreDataProperties)

+ (NSFetchRequest<Record *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *aviaCompany;
@property (nullable, nonatomic, copy) NSString *cityFrom;
@property (nullable, nonatomic, copy) NSString *cityTo;
@property (nonatomic) float price;

@end

NS_ASSUME_NONNULL_END
