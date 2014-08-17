//
//  NestedSetModel.h
//  JSONModelDemo
//
//  Created by Marin Todorov on 02/12/2012.
//  Copyright (c) 2012 Underplot ltd. All rights reserved.
//

#import "JSONModel.h"
#import "ImageModel.h"

@interface NestedSetModel : JSONModel

/* JSONModel object */
@property (strong, nonatomic) ImageModel* singleImage;

/* list of JSONModel objects as set */
@property (strong, nonatomic) NSSet<ImageModel>* images;

/* dictionary of JSONModel objects */
@property (strong, nonatomic) NSDictionary<ImageModel>* imagesObject;


@end
