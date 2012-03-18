@class AsyncConnection;

/**
 @brief AsyncConnection Delegate Protocol.
 @author Jonathan Diehl
 @date 10.08.11
 
 The delegate of an AsyncConnection object has the following responsibilities:
 - Respond to successful connection initiation and loss of connection
 - React to incoming objects
 - React to socket errors
 */
@protocol AsyncConnectionDelegate <NSObject>

@optional

#pragma mark AsyncConnectionDelegate

/**
 @brief The AsyncConnection has successfully initiated a connection to the target host.
 @param theConnection The AsyncConnection object that initiated a connection
 */
- (void)connectionDidConnect:(AsyncConnection *)theConnection;

/**
 @brief The AsyncConnection has lost its connection to the target host.
 @param theConnection The AsyncConnection object that lost its connection
 */
- (void)connectionDidDisconnect:(AsyncConnection *)theConnection;

/**
 @brief The AsyncConnection has received an object from its target host.
 @param theConnection The AsyncConnection object that received an object
 @param object The object that was received
 @param tag The tag can be used to identify a coherent transaction
 */
- (void)connection:(AsyncConnection *)theConnection didReceiveObject:(id)object tag:(UInt32)tag;

/**
 @brief The AsyncConnection did send an object to its target host.
 @param theConnection The AsyncConnection object that sent the object
 @param tag The tag that was used when sending the object
 */
- (void)connection:(AsyncConnection *)theConnection didSendObjectWithTag:(UInt32)tag;

/**
 @brief The AsyncConnection encountered an error.
 
 Errors can occur in the following situations:
 - In -[AsyncConnection start] if the initialization of the AsyncSocket fails
 - If the AsyncSocket reports an error
 
 @param theConnection The AsyncConnection object that encountered the error
 @param error An object describing the error
 */
- (void)connection:(AsyncConnection *)theConnection didFailWithError:(NSError *)error;

@end