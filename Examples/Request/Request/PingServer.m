/**
 * Copyright (C) 2011 Jonathan Diehl
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is furnished to do
 * so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 * 
 * https://github.com/jdiehl/async-network
 */

#import "PingServer.h"

@implementation PingServer

@synthesize server = _server;

- (void)awakeFromNib;
{
	// create and configure the server
	self.server = [AsyncServer new];
	self.server.port = kPingServerPort;
	self.server.delegate = self;
	self.server.disconnectClientsAfterSend = YES;
	
	// start the server
	[self.server start];
}

- (void)dealloc;
{
	[self.server stop];
	self.server.delegate = nil;
}

#pragma mark AsyncServerDelegate

/**
 @brief The server did receive an object from a client.
 @param theServer The server that received the objet
 @param object The object
 @param tag The transaction tag for the object
 @param connection The connection to the client
 */
- (void)server:(AsyncServer *)theServer didReceiveObject:(id)object tag:(UInt32)tag fromConnection:(AsyncConnection *)connection;
{
	NSString *response = [NSString stringWithFormat:@"Received: %@", object];
	[connection sendObject:response tag:tag];
}

@end