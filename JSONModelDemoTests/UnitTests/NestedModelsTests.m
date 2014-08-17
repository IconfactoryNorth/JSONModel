//
//  NestedModelsTests.m
//  JSONModelDemo
//
//  Created by Marin Todorov on 02/12/2012.
//  Copyright (c) 2012 Underplot ltd. All rights reserved.
//

#import "NestedModelsTests.h"

#import "NestedModel.h"
#import "NestedSetModel.h"
#import "ImageModel.h"
#import "CopyrightModel.h"

@implementation NestedModelsTests
{
    NestedModel* n;
	NestedSetModel* ns;
}

-(void)setUp
{
    [super setUp];
    
    NSString* filePath = [[NSBundle bundleForClass:[JSONModel class]].resourcePath stringByAppendingPathComponent:@"nestedData.json"];
    NSString* jsonContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    XCTAssertNotNil(jsonContents, @"Can't fetch test data file contents.");
    
    NSError* err;
    n = [[NestedModel alloc] initWithString: jsonContents error:&err];
    XCTAssertNil(err, "%@", [err localizedDescription]);
    XCTAssertNotNil(n, @"Could not load the test data file.");
	
    ns = [[NestedSetModel alloc] initWithString: jsonContents error:&err];
    XCTAssertNil(err, "%@", [err localizedDescription]);
    XCTAssertNotNil(ns, @"Could not load the test data file for set.");
}

-(void)testNestedStructures
{
    XCTAssertTrue([n.singleImage isKindOfClass:[ImageModel class]], @"singleImage is not an ImageModel instance");
    XCTAssertTrue([n.singleImage.name isEqualToString:@"lake.jpg"], @"singleImage.name is not 'lake.jpg'");
    
    XCTAssertTrue([n.images isKindOfClass:[NSArray class]], @"images is not an NSArray");
    XCTAssertTrue([n.images[0] isKindOfClass:[ImageModel class]], @"images[0] is not an ImageModel instance");
    XCTAssertTrue([[n.images[0] name] isEqualToString:@"house.jpg"], @"images[0].name is not 'house.jpg'");
    CopyrightModel* copy = [n.images[0] copyright];
    XCTAssertTrue([copy.author isEqualToString:@"Marin Todorov"], @"images[0].name.copyright is not 'Marin Todorov'");
    
    XCTAssertTrue([n.imagesObject isKindOfClass:[NSDictionary class]], @"imagesObject is not an NSDictionary");
    ImageModel* img = n.imagesObject[@"image2"];
    XCTAssertTrue([img isKindOfClass:[ImageModel class]], @"images[image2] is not an ImageModel instance");
    XCTAssertTrue([img.name isEqualToString:@"lake.jpg"], @"imagesObject[image2].name is not 'lake.jpg'");
    
}

-(void)testNestedSetStructures
{
    XCTAssertTrue([ns.images isKindOfClass:[NSSet class]], @"images is not an NSSet");
    XCTAssertTrue([[ns.images anyObject] isKindOfClass:[ImageModel class]], @"[images anyObject] is not an ImageModel instance");
    XCTAssertTrue([ns.images count] == 3, @"images count is not 3");
    NSSet* objectsPassingTest = [ns.images objectsPassingTest:^BOOL(ImageModel *obj, BOOL *stop) {
		return obj.copyright != nil;
	}];
	CopyrightModel* copy = [[objectsPassingTest anyObject] copyright];
    XCTAssertTrue([copy.author isEqualToString:@"Marin Todorov"], @"images object-with-copyright name is not 'Marin Todorov'");
}

@end
