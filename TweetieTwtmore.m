//
//  TweetieTwtmore.m
//  TweetieTwtmore
//
//  Created by Tom Arnfeld on 18/12/2010.
//  Copyright 2010 Tom Arneld. All rights reserved.
//

#import "TweetieTwtmore.h"
#import "SynthesizeSingleton.h"
#import "JRSwizzle.h"
#import "Twitlonger.h"
#import "ABCallback.h"
#import "Twtmore.h"
#import <objc/runtime.h>

@implementation TweetieTwtmore

SYNTHESIZE_SINGLETON_FOR_CLASS(TweetieTwtmore, sharedInstance);

+ (void)load {

	[TweetieTwtmore sharedInstance];

	// Swizzle the methods from the Twitlonger class, to this class.
	method_exchangeImplementations(
							class_getClassMethod(NSClassFromString(@"Twitlonger"), @selector(post:twitterUsername:callback:)),
							class_getClassMethod(NSClassFromString(@"TweetieTwtmore"), @selector(post:twitterUsername:callback:))
					);
	method_exchangeImplementations(
								   class_getClassMethod(NSClassFromString(@"Twitlonger"), @selector(didPost:info:)),
								   class_getClassMethod(NSClassFromString(@"TweetieTwtmore"), @selector(didPost:info:))
								   );

}

- (id)init {
	if (self = [super init]) {
		
	}
	return self;
}
								   
+ (void)post:(NSString *)tweetText twitterUsername:(NSString *)username callback:(ABCallback *)tweetieCallback {

	NSString *apiKey = [NSString stringWithString:@"__API__KEY__HERE__"];
	
	NSURLResponse *response = nil;
	NSError *error = nil;
	
	// Make a request to the twtmore API to shorten the tweet
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"http://api.twtmore.com/shorten/%@", apiKey]]];
	
	[request setHTTPMethod: @"POST"];
	[request setHTTPBody: [[NSString stringWithFormat:@"user=%@&tweet=%@", username, tweetText] dataUsingEncoding: NSUTF8StringEncoding]];

	NSData *dataReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString *stringReply = [[NSString alloc] initWithData:dataReply encoding:NSUTF8StringEncoding];  
	
	// Trick tweetie into thinking it's got a twitlonger object here...
	Twtmore *twitlonger_thing = [[Twtmore alloc] init];
	twitlonger_thing.content = [NSString stringWithString:stringReply];
	
	[stringReply release];
	
	[tweetieCallback invoke:twitlonger_thing];
	
}

+ (void)didPost:(id)arg1 info:(id)arg2 {

	// Stop tweetie trying to tell twitlonger about stuff...
	
}

@end
