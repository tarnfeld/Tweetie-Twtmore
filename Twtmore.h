//
//  Twtmore.h
//  Tweetie Twtmore
//
//  Created by Tom Arnfeld on 18/12/2010.
//  Copyright 2010 Tom Arnfeld. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Twtmore : NSObject {

    NSString *identifier;
	
    NSURL *link;
    NSString *shortLink;
    
	NSString *content;
    NSString *username;
	
}

+ (id)applicationKey;
- (void)parseXML:(id)arg1 info:(id)arg2;

@property(copy, nonatomic) NSString *username;
@property(copy, nonatomic) NSString *content;

@property(copy, nonatomic) NSString *shortLink;
@property(copy, nonatomic) NSURL *link;

@property(copy, nonatomic) NSString *identifier;

@end
