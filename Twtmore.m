//
//  Twtmore.m
//  Tweetie Twtmore
//
//  Created by Tom Arnfeld on 18/12/2010.
//  Copyright 2010 Tom Arnfeld. All rights reserved.
//

#import "Twtmore.h"


@implementation Twtmore

@synthesize username, content, link, shortLink, identifier;

+ (id)applicationKey {

	NSLog(@"Called to get app key");
	return [NSString stringWithString:@"API_KEY_HERE"];
	
}

- (void)parseXML:(id)arg1 info:(id)arg2{

	NSLog(@"Called to parse XML");
	
}

@end
