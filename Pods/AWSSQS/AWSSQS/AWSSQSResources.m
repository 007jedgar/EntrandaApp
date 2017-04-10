//
// Copyright 2010-2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
// http://aws.amazon.com/apache2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "AWSSQSResources.h"
#import <AWSCore/AWSLogging.h>

@interface AWSSQSResources ()

@property (nonatomic, strong) NSDictionary *definitionDictionary;

@end

@implementation AWSSQSResources

+ (instancetype)sharedInstance {
    static AWSSQSResources *_sharedResources = nil;
    static dispatch_once_t once_token;

    dispatch_once(&once_token, ^{
        _sharedResources = [AWSSQSResources new];
    });

    return _sharedResources;
}

- (NSDictionary *)JSONObject {
    return self.definitionDictionary;
}

- (instancetype)init {
    if (self = [super init]) {
        //init method
        NSError *error = nil;
        _definitionDictionary = [NSJSONSerialization JSONObjectWithData:[[self definitionString] dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:kNilOptions
                                                                  error:&error];
        if (_definitionDictionary == nil) {
            if (error) {
                AWSLogError(@"Failed to parse JSON service definition: %@",error);
            }
        }
    }
    return self;
}

- (NSString *)definitionString {
    return @"{\
  \"version\":\"2.0\",\
  \"metadata\":{\
    \"apiVersion\":\"2012-11-05\",\
    \"endpointPrefix\":\"sqs\",\
    \"protocol\":\"query\",\
    \"serviceAbbreviation\":\"Amazon SQS\",\
    \"serviceFullName\":\"Amazon Simple Queue Service\",\
    \"signatureVersion\":\"v4\",\
    \"xmlNamespace\":\"http://queue.amazonaws.com/doc/2012-11-05/\"\
  },\
  \"operations\":{\
    \"AddPermission\":{\
      \"name\":\"AddPermission\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"AddPermissionRequest\"},\
      \"errors\":[\
        {\"shape\":\"OverLimit\"}\
      ],\
      \"documentation\":\"<p>Adds a permission to a queue for a specific <a href=\\\"http://docs.aws.amazon.com/general/latest/gr/glos-chap.html#P\\\">principal</a>. This allows for sharing access to the queue.</p> <p>When you create a queue, you have full control access rights for the queue. Only you (as owner of the queue) can grant or deny permissions to the queue. For more information about these permissions, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/acp-overview.html\\\">Shared Queues</a> in the <i>Amazon SQS Developer Guide</i>.</p> <note> <p> <code>AddPermission</code> writes an Amazon SQS-generated policy. If you want to write your own policy, use <a>SetQueueAttributes</a> to upload your policy. For more information about writing your own policy, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AccessPolicyLanguage.html\\\">Using The Access Policy Language</a> in the <i>Amazon SQS Developer Guide</i>.</p> </note> <note> <p>Some API actions take lists of parameters. These lists are specified using the <code>param.n</code> notation. Values of <code>n</code> are integers starting from 1. For example, a parameter list with two elements looks like this:</p> </note> <p> <code>&amp;amp;Attribute.1=this</code> </p> <p> <code>&amp;amp;Attribute.2=that</code> </p>\"\
    },\
    \"ChangeMessageVisibility\":{\
      \"name\":\"ChangeMessageVisibility\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ChangeMessageVisibilityRequest\"},\
      \"errors\":[\
        {\"shape\":\"MessageNotInflight\"},\
        {\"shape\":\"ReceiptHandleIsInvalid\"}\
      ],\
      \"documentation\":\"<p>Changes the visibility timeout of a specified message in a queue to a new value. The maximum allowed timeout value you can set the value to is 12 hours. This means you can't extend the timeout of a message in an existing queue to more than a total visibility timeout of 12 hours. (For more information visibility timeout, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html\\\">Visibility Timeout</a> in the <i>Amazon SQS Developer Guide</i>.)</p> <p>For example, let's say you have a message and its default message visibility timeout is 5 minutes. After 3 minutes, you call <code>ChangeMessageVisiblity</code> with a timeout of 10 minutes. At that time, the timeout for the message would be extended by 10 minutes beyond the time of the ChangeMessageVisibility call. This results in a total visibility timeout of 13 minutes. You can continue to call ChangeMessageVisibility to extend the visibility timeout to a maximum of 12 hours. If you try to extend beyond 12 hours, the request will be rejected.</p> <note> <p>There is a 120,000 limit for the number of inflight messages per queue. Messages are inflight after they have been received from the queue by a consuming component, but have not yet been deleted from the queue. If you reach the 120,000 limit, you will receive an OverLimit error message from Amazon SQS. To help avoid reaching the limit, you should delete the messages from the queue after they have been processed. You can also increase the number of queues you use to process the messages.</p> </note> <important> <p>If you attempt to set the <code>VisibilityTimeout</code> to an amount more than the maximum time left, Amazon SQS returns an error. It will not automatically recalculate and increase the timeout to the maximum time remaining.</p> </important> <important> <p>Unlike with a queue, when you change the visibility timeout for a specific message, that timeout value is applied immediately but is not saved in memory for that message. If you don't delete a message after it is received, the visibility timeout for the message the next time it is received reverts to the original timeout value, not the value you set with the <code>ChangeMessageVisibility</code> action.</p> </important>\"\
    },\
    \"ChangeMessageVisibilityBatch\":{\
      \"name\":\"ChangeMessageVisibilityBatch\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ChangeMessageVisibilityBatchRequest\"},\
      \"output\":{\
        \"shape\":\"ChangeMessageVisibilityBatchResult\",\
        \"resultWrapper\":\"ChangeMessageVisibilityBatchResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"TooManyEntriesInBatchRequest\"},\
        {\"shape\":\"EmptyBatchRequest\"},\
        {\"shape\":\"BatchEntryIdsNotDistinct\"},\
        {\"shape\":\"InvalidBatchEntryId\"}\
      ],\
      \"documentation\":\"<p>Changes the visibility timeout of multiple messages. This is a batch version of <a>ChangeMessageVisibility</a>. The result of the action on each message is reported individually in the response. You can send up to 10 <a>ChangeMessageVisibility</a> requests with each <code>ChangeMessageVisibilityBatch</code> action.</p> <important> <p>Because the batch request can result in a combination of successful and unsuccessful actions, you should check for batch errors even when the call returns an HTTP status code of 200.</p> </important> <note> <p>Some API actions take lists of parameters. These lists are specified using the <code>param.n</code> notation. Values of <code>n</code> are integers starting from 1. For example, a parameter list with two elements looks like this:</p> </note> <p> <code>&amp;amp;Attribute.1=this</code> </p> <p> <code>&amp;amp;Attribute.2=that</code> </p>\"\
    },\
    \"CreateQueue\":{\
      \"name\":\"CreateQueue\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CreateQueueRequest\"},\
      \"output\":{\
        \"shape\":\"CreateQueueResult\",\
        \"resultWrapper\":\"CreateQueueResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"QueueDeletedRecently\"},\
        {\"shape\":\"QueueNameExists\"}\
      ],\
      \"documentation\":\"<p>Creates a new standard or FIFO queue or returns the URL of an existing queue. You can pass one or more attributes in the request.</p> <ul> <li> <p>If you don't specify the <code>FifoQueue</code> attribute, Amazon SQS creates a standard queue.</p> <note> <p> You can't change the queue type after you create it and you can't convert an existing standard queue into a FIFO queue. You must either create a new FIFO queue for your application or delete your existing standard queue and recreate it as a FIFO queue. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues-moving.html\\\"> Moving From a Standard Queue to a FIFO Queue</a> in the <i>Amazon SQS Developer Guide</i>. </p> </note> </li> <li> <p>If you don't provide a value for an attribute, the queue is created with the default value for the attribute.</p> </li> <li> <p>If you delete a queue, you must wait at least 60 seconds before creating a queue with the same name.</p> </li> </ul> <p>To successfully create a new queue, you must provide a queue name that adheres to the <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/limits-queues.html\\\">limits related to queues</a> and is unique within the scope of your queues.</p> <p>To get the queue URL, use the <a>GetQueueUrl</a> action. <a>GetQueueUrl</a> requires only the <code>QueueName</code> parameter.</p> <ul> <li> <p>If you provide the name of an existing queue along with the exact names and values of all the queue's attributes, <code>CreateQueue</code> returns the queue URL for the existing queue.</p> </li> <li> <p>If the queue name, attribute names, or attribute values don't match an existing queue, <code>CreateQueue</code> returns an error.</p> </li> </ul> <p>Some API actions take lists of parameters. Specify these lists using the <code>param.n</code> notation. Values of <code>n</code> are integers starting from 1. The following is an example of a parameter list with two elements:</p> <p> <code>&amp;amp;Attribute.1=this</code> </p> <p> <code>&amp;amp;Attribute.2=that</code> </p>\"\
    },\
    \"DeleteMessage\":{\
      \"name\":\"DeleteMessage\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteMessageRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidIdFormat\"},\
        {\"shape\":\"ReceiptHandleIsInvalid\"}\
      ],\
      \"documentation\":\"<p> Deletes the specified message from the specified queue. You specify the message by using the message's <code>receipt handle</code> and not the <code>message ID</code> you received when you sent the message. Even if the message is locked by another reader due to the visibility timeout setting, it is still deleted from the queue. If you leave a message in the queue for longer than the queue's configured retention period, Amazon SQS automatically deletes it. </p> <note> <p> The receipt handle is associated with a specific instance of receiving the message. If you receive a message more than once, the receipt handle you get each time you receive the message is different. When you request <code>DeleteMessage</code>, if you don't provide the most recently received receipt handle for the message, the request will still succeed, but the message might not be deleted. </p> </note> <important> <p>It is possible you will receive a message even after you have deleted it. This might happen on rare occasions if one of the servers storing a copy of the message is unavailable when you request to delete the message. The copy remains on the server and might be returned to you again on a subsequent receive request. You should create your system to be idempotent so that receiving a particular message more than once is not a problem.</p> </important>\"\
    },\
    \"DeleteMessageBatch\":{\
      \"name\":\"DeleteMessageBatch\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteMessageBatchRequest\"},\
      \"output\":{\
        \"shape\":\"DeleteMessageBatchResult\",\
        \"resultWrapper\":\"DeleteMessageBatchResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"TooManyEntriesInBatchRequest\"},\
        {\"shape\":\"EmptyBatchRequest\"},\
        {\"shape\":\"BatchEntryIdsNotDistinct\"},\
        {\"shape\":\"InvalidBatchEntryId\"}\
      ],\
      \"documentation\":\"<p>Deletes up to ten messages from the specified queue. This is a batch version of <a>DeleteMessage</a>. The result of the delete action on each message is reported individually in the response.</p> <important> <p>Because the batch request can result in a combination of successful and unsuccessful actions, you should check for batch errors even when the call returns an HTTP status code of 200.</p> </important> <note> <p>Some API actions take lists of parameters. These lists are specified using the <code>param.n</code> notation. Values of <code>n</code> are integers starting from 1. For example, a parameter list with two elements looks like this:</p> </note> <p> <code>&amp;amp;Attribute.1=this</code> </p> <p> <code>&amp;amp;Attribute.2=that</code> </p>\"\
    },\
    \"DeleteQueue\":{\
      \"name\":\"DeleteQueue\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteQueueRequest\"},\
      \"documentation\":\"<p> Deletes the queue specified by the <b>queue URL</b>, regardless of whether the queue is empty. If the specified queue doesn't exist, Amazon SQS returns a successful response. </p> <important> <p> Use <code>DeleteQueue</code> with care; once you delete your queue, any messages in the queue are no longer available. </p> </important> <p> When you delete a queue, the deletion process takes up to 60 seconds. Requests you send involving that queue during the 60 seconds might succeed. For example, a <a>SendMessage</a> request might succeed, but after the 60 seconds, the queue and that message you sent no longer exist. Also, when you delete a queue, you must wait at least 60 seconds before creating a queue with the same name. </p> <p>We reserve the right to delete queues that have had no activity for more than 30 days. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSConcepts.html\\\">How Amazon SQS Queues Work</a> in the <i>Amazon SQS Developer Guide</i>. </p>\"\
    },\
    \"GetQueueAttributes\":{\
      \"name\":\"GetQueueAttributes\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetQueueAttributesRequest\"},\
      \"output\":{\
        \"shape\":\"GetQueueAttributesResult\",\
        \"resultWrapper\":\"GetQueueAttributesResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"InvalidAttributeName\"}\
      ],\
      \"documentation\":\"<p>Gets attributes for the specified queue.</p> <note> <p>Some API actions take lists of parameters. These lists are specified using the <code>param.n</code> notation. Values of <code>n</code> are integers starting from 1. For example, a parameter list with two elements looks like this:</p> </note> <p> <code>&amp;amp;Attribute.1=this</code> </p> <p> <code>&amp;amp;Attribute.2=that</code> </p>\"\
    },\
    \"GetQueueUrl\":{\
      \"name\":\"GetQueueUrl\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetQueueUrlRequest\"},\
      \"output\":{\
        \"shape\":\"GetQueueUrlResult\",\
        \"resultWrapper\":\"GetQueueUrlResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"QueueDoesNotExist\"}\
      ],\
      \"documentation\":\"<p>Returns the URL of an existing queue. This action provides a simple way to retrieve the URL of an Amazon SQS queue.</p> <p> To access a queue that belongs to another AWS account, use the <code>QueueOwnerAWSAccountId</code> parameter to specify the account ID of the queue's owner. The queue's owner must grant you permission to access the queue. For more information about shared queue access, see <a>AddPermission</a> or see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/acp-overview.html\\\">Shared Queues</a> in the <i>Amazon SQS Developer Guide</i>. </p>\"\
    },\
    \"ListDeadLetterSourceQueues\":{\
      \"name\":\"ListDeadLetterSourceQueues\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListDeadLetterSourceQueuesRequest\"},\
      \"output\":{\
        \"shape\":\"ListDeadLetterSourceQueuesResult\",\
        \"resultWrapper\":\"ListDeadLetterSourceQueuesResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"QueueDoesNotExist\"}\
      ],\
      \"documentation\":\"<p>Returns a list of your queues that have the RedrivePolicy queue attribute configured with a dead letter queue.</p> <p>For more information about using dead letter queues, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSDeadLetterQueue.html\\\">Using Amazon SQS Dead Letter Queues</a> in the <i>Amazon SQS Developer Guide</i>.</p>\"\
    },\
    \"ListQueues\":{\
      \"name\":\"ListQueues\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListQueuesRequest\"},\
      \"output\":{\
        \"shape\":\"ListQueuesResult\",\
        \"resultWrapper\":\"ListQueuesResult\"\
      },\
      \"documentation\":\"<p>Returns a list of your queues. The maximum number of queues that can be returned is 1000. If you specify a value for the optional <code>QueueNamePrefix</code> parameter, only queues with a name beginning with the specified value are returned.</p>\"\
    },\
    \"PurgeQueue\":{\
      \"name\":\"PurgeQueue\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PurgeQueueRequest\"},\
      \"errors\":[\
        {\"shape\":\"QueueDoesNotExist\"},\
        {\"shape\":\"PurgeQueueInProgress\"}\
      ],\
      \"documentation\":\"<p>Deletes the messages in a queue specified by the <b>queue URL</b>.</p> <important> <p>When you use the <code>PurgeQueue</code> API, the deleted messages in the queue can't be retrieved.</p> </important> <p>When you purge a queue, the message deletion process takes up to 60 seconds. All messages sent to the queue before calling <code>PurgeQueue</code> will be deleted; messages sent to the queue while it is being purged might be deleted. While the queue is being purged, messages sent to the queue before <code>PurgeQueue</code> was called might be received, but will be deleted within the next minute.</p>\"\
    },\
    \"ReceiveMessage\":{\
      \"name\":\"ReceiveMessage\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ReceiveMessageRequest\"},\
      \"output\":{\
        \"shape\":\"ReceiveMessageResult\",\
        \"resultWrapper\":\"ReceiveMessageResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"OverLimit\"}\
      ],\
      \"documentation\":\"<p>Retrieves one or more messages, with a maximum limit of 10 messages, from the specified queue. Long poll support is enabled by using the <code>WaitTimeSeconds</code> parameter. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-long-polling.html\\\">Amazon SQS Long Poll</a> in the <i>Amazon SQS Developer Guide</i>. </p> <p> Short poll is the default behavior where a weighted random set of machines is sampled on a <code>ReceiveMessage</code> call. This means only the messages on the sampled machines are returned. If the number of messages in the queue is small (less than 1000), it is likely you will get fewer messages than you requested per <code>ReceiveMessage</code> call. If the number of messages in the queue is extremely small, you might not receive any messages in a particular <code>ReceiveMessage</code> response; in which case you should repeat the request. </p> <p>For each message returned, the response includes the following:</p> <ul> <li> <p>Message body</p> </li> <li> <p> MD5 digest of the message body. For information about MD5, see <a href=\\\"https://www.ietf.org/rfc/rfc1321.txt\\\">RFC1321</a>. </p> </li> <li> <p>Message ID you received when you sent the message to the queue.</p> </li> <li> <p>Receipt handle.</p> </li> <li> <p>Message attributes.</p> </li> <li> <p>MD5 digest of the message attributes.</p> </li> </ul> <p> The receipt handle is the identifier you must provide when deleting the message. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/ImportantIdentifiers.html\\\">Queue and Message Identifiers</a> in the <i>Amazon SQS Developer Guide</i>. </p> <p> You can provide the <code>VisibilityTimeout</code> parameter in your request, which will be applied to the messages that Amazon SQS returns in the response. If you don't include the parameter, the overall visibility timeout for the queue is used for the returned messages. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html\\\">Visibility Timeout</a> in the <i>Amazon SQS Developer Guide</i>. </p> <p> A message that is not deleted or a message whose visibility is not extended before the visibility timeout expires counts as a failed receive. Depending on the configuration of the queue, the message might be sent to the dead letter queue. </p> <note> <p>Going forward, new attributes might be added. If you are writing code that calls this action, we recommend that you structure your code so that it can handle new attributes gracefully.</p> </note>\"\
    },\
    \"RemovePermission\":{\
      \"name\":\"RemovePermission\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"RemovePermissionRequest\"},\
      \"documentation\":\"<p>Revokes any permissions in the queue policy that matches the specified <code>Label</code> parameter. Only the owner of the queue can remove permissions.</p>\"\
    },\
    \"SendMessage\":{\
      \"name\":\"SendMessage\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"SendMessageRequest\"},\
      \"output\":{\
        \"shape\":\"SendMessageResult\",\
        \"resultWrapper\":\"SendMessageResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"InvalidMessageContents\"},\
        {\"shape\":\"UnsupportedOperation\"}\
      ],\
      \"documentation\":\"<p>Delivers a message to the specified queue.</p> <important> <p>The following list shows the characters (in Unicode) that are allowed in your message, according to the W3C XML specification:</p> <p> <code>#x9</code> | <code>#xA</code> | <code>#xD</code> | [<code>#x20</code> to <code>#xD7FF</code>] | [<code>#xE000</code> to <code>#xFFFD</code>] | [<code>#x10000</code> to <code>#x10FFFF</code>]</p> <p>For more information, see <a href=\\\"https://www.ietf.org/rfc/rfc1321.txt\\\">RFC1321</a>. If you send any characters that aren't included in this list, your request will be rejected.</p> </important>\"\
    },\
    \"SendMessageBatch\":{\
      \"name\":\"SendMessageBatch\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"SendMessageBatchRequest\"},\
      \"output\":{\
        \"shape\":\"SendMessageBatchResult\",\
        \"resultWrapper\":\"SendMessageBatchResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"TooManyEntriesInBatchRequest\"},\
        {\"shape\":\"EmptyBatchRequest\"},\
        {\"shape\":\"BatchEntryIdsNotDistinct\"},\
        {\"shape\":\"BatchRequestTooLong\"},\
        {\"shape\":\"InvalidBatchEntryId\"},\
        {\"shape\":\"UnsupportedOperation\"}\
      ],\
      \"documentation\":\"<p>Delivers up to ten messages to the specified queue. This is a batch version of <code> <a>SendMessage</a> </code>. For a FIFO queue, multiple messages within a single batch are enqueued in the order they are sent.</p> <p>The result of sending each message is reported individually in the response. Because the batch request can result in a combination of successful and unsuccessful actions, you should check for batch errors even when the call returns an HTTP status code of 200.</p> <p>The maximum allowed individual message size and the maximum total payload size (the sum of the individual lengths of all of the batched messages) are both 256 KB (262,144 bytes).</p> <important> <p>The following list shows the characters (in Unicode) that are allowed in your message, according to the W3C XML specification:</p> <p> <code>#x9</code> | <code>#xA</code> | <code>#xD</code> | [<code>#x20</code> to <code>#xD7FF</code>] | [<code>#xE000</code> to <code>#xFFFD</code>] | [<code>#x10000</code> to <code>#x10FFFF</code>]</p> <p>For more information, see <a href=\\\"https://www.ietf.org/rfc/rfc1321.txt\\\">RFC1321</a>. If you send any characters that aren't included in this list, your request will be rejected.</p> </important> <p>If you don't specify the <code>DelaySeconds</code> parameter for an entry, Amazon SQS uses the default for the queue.</p> <note> <p>Some API actions take lists of parameters. These lists are specified using the <code>param.n</code> notation. Values of <code>n</code> are integers starting from 1. For example, a parameter list with two elements looks like this: </p> </note> <p> <code>&amp;amp;Attribute.1=this</code> </p> <p> <code>&amp;amp;Attribute.2=that</code> </p>\"\
    },\
    \"SetQueueAttributes\":{\
      \"name\":\"SetQueueAttributes\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"SetQueueAttributesRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidAttributeName\"}\
      ],\
      \"documentation\":\"<p>Sets the value of one or more queue attributes. When you change a queue's attributes, the change can take up to 60 seconds for most of the attributes to propagate throughout the SQS system. Changes made to the <code>MessageRetentionPeriod</code> attribute can take up to 15 minutes.</p> <note> <p>In the future, new attributes might be added. When you write code that calls this action, we recommend structuring your code so that it can handle new attributes gracefully.</p> </note>\"\
    }\
  },\
  \"shapes\":{\
    \"AWSAccountIdList\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"String\",\
        \"locationName\":\"AWSAccountId\"\
      },\
      \"flattened\":true\
    },\
    \"ActionNameList\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"String\",\
        \"locationName\":\"ActionName\"\
      },\
      \"flattened\":true\
    },\
    \"AddPermissionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"QueueUrl\",\
        \"Label\",\
        \"AWSAccountIds\",\
        \"Actions\"\
      ],\
      \"members\":{\
        \"QueueUrl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>\"\
        },\
        \"Label\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The unique identification of the permission you're setting (e.g., <code>AliceSendMessage</code>). Constraints: Maximum 80 characters; alphanumeric characters, hyphens (-), and underscores (_) are allowed.</p>\"\
        },\
        \"AWSAccountIds\":{\
          \"shape\":\"AWSAccountIdList\",\
          \"documentation\":\"<p>The AWS account number of the <a href=\\\"http://docs.aws.amazon.com/general/latest/gr/glos-chap.html#P\\\">principal</a> who will be given permission. The principal must have an AWS account, but does not need to be signed up for Amazon SQS. For information about locating the AWS account identification, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AWSCredentials.html\\\">Your AWS Identifiers</a> in the <i>Amazon SQS Developer Guide</i>.</p>\"\
        },\
        \"Actions\":{\
          \"shape\":\"ActionNameList\",\
          \"documentation\":\"<p>The action the client wants to allow for the specified principal. The following are valid values: <code>* | SendMessage | ReceiveMessage | DeleteMessage | ChangeMessageVisibility | GetQueueAttributes | GetQueueUrl</code>. For more information about these actions, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/acp-overview.html#PermissionTypes\\\">Understanding Permissions</a> in the <i>Amazon SQS Developer Guide</i>.</p> <p>Specifying <code>SendMessage</code>, <code>DeleteMessage</code>, or <code>ChangeMessageVisibility</code> for the <code>ActionName.n</code> also grants permissions for the corresponding batch versions of those actions: <code>SendMessageBatch</code>, <code>DeleteMessageBatch</code>, and <code>ChangeMessageVisibilityBatch</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p/>\"\
    },\
    \"AttributeNameList\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"QueueAttributeName\",\
        \"locationName\":\"AttributeName\"\
      },\
      \"flattened\":true\
    },\
    \"BatchEntryIdsNotDistinct\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>Two or more batch entries have the same <code>Id</code> in the request.</p>\",\
      \"error\":{\
        \"code\":\"AWS.SimpleQueueService.BatchEntryIdsNotDistinct\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"BatchRequestTooLong\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The length of all the messages put together is more than the limit.</p>\",\
      \"error\":{\
        \"code\":\"AWS.SimpleQueueService.BatchRequestTooLong\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"BatchResultErrorEntry\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Id\",\
        \"SenderFault\",\
        \"Code\"\
      ],\
      \"members\":{\
        \"Id\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The id of an entry in a batch request.</p>\"\
        },\
        \"SenderFault\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p>Whether the error happened due to the sender's fault.</p>\"\
        },\
        \"Code\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>An error code representing why the action failed on this entry.</p>\"\
        },\
        \"Message\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A message explaining why the action failed on this entry.</p>\"\
        }\
      },\
      \"documentation\":\"<p>This is used in the responses of batch API to give a detailed description of the result of an action on each entry in the request.</p>\"\
    },\
    \"BatchResultErrorEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"BatchResultErrorEntry\",\
        \"locationName\":\"BatchResultErrorEntry\"\
      },\
      \"flattened\":true\
    },\
    \"Binary\":{\"type\":\"blob\"},\
    \"BinaryList\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"Binary\",\
        \"locationName\":\"BinaryListValue\"\
      }\
    },\
    \"Boolean\":{\"type\":\"boolean\"},\
    \"ChangeMessageVisibilityBatchRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"QueueUrl\",\
        \"Entries\"\
      ],\
      \"members\":{\
        \"QueueUrl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>\"\
        },\
        \"Entries\":{\
          \"shape\":\"ChangeMessageVisibilityBatchRequestEntryList\",\
          \"documentation\":\"<p>A list of receipt handles of the messages for which the visibility timeout must be changed.</p>\"\
        }\
      },\
      \"documentation\":\"<p/>\"\
    },\
    \"ChangeMessageVisibilityBatchRequestEntry\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Id\",\
        \"ReceiptHandle\"\
      ],\
      \"members\":{\
        \"Id\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>An identifier for this particular receipt handle. This is used to communicate the result. Note that the <code>Id</code>s of a batch request need to be unique within the request.</p>\"\
        },\
        \"ReceiptHandle\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A receipt handle.</p>\"\
        },\
        \"VisibilityTimeout\":{\
          \"shape\":\"Integer\",\
          \"documentation\":\"<p>The new value (in seconds) for the message's visibility timeout.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Encloses a receipt handle and an entry id for each message in <a>ChangeMessageVisibilityBatch</a>. </p> <important> <p>All of the following parameters are list parameters that must be prefixed with <code>ChangeMessageVisibilityBatchRequestEntry.n</code>, where <code>n</code> is an integer value starting with 1. For example, a parameter list for this action might look like this:</p> </important> <p> <code>&amp;amp;ChangeMessageVisibilityBatchRequestEntry.1.Id=change_visibility_msg_2</code> </p> <p> <code>&amp;amp;ChangeMessageVisibilityBatchRequestEntry.1.ReceiptHandle=&lt;replaceable&gt;Your_Receipt_Handle&lt;/replaceable&gt;</code> </p> <p> <code>&amp;amp;ChangeMessageVisibilityBatchRequestEntry.1.VisibilityTimeout=45</code> </p>\"\
    },\
    \"ChangeMessageVisibilityBatchRequestEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"ChangeMessageVisibilityBatchRequestEntry\",\
        \"locationName\":\"ChangeMessageVisibilityBatchRequestEntry\"\
      },\
      \"flattened\":true\
    },\
    \"ChangeMessageVisibilityBatchResult\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Successful\",\
        \"Failed\"\
      ],\
      \"members\":{\
        \"Successful\":{\
          \"shape\":\"ChangeMessageVisibilityBatchResultEntryList\",\
          \"documentation\":\"<p>A list of <a>ChangeMessageVisibilityBatchResultEntry</a> items.</p>\"\
        },\
        \"Failed\":{\
          \"shape\":\"BatchResultErrorEntryList\",\
          \"documentation\":\"<p>A list of <a>BatchResultErrorEntry</a> items.</p>\"\
        }\
      },\
      \"documentation\":\"<p> For each message in the batch, the response contains a <a>ChangeMessageVisibilityBatchResultEntry</a> tag if the message succeeds or a <a>BatchResultErrorEntry</a> tag if the message fails. </p>\"\
    },\
    \"ChangeMessageVisibilityBatchResultEntry\":{\
      \"type\":\"structure\",\
      \"required\":[\"Id\"],\
      \"members\":{\
        \"Id\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>Represents a message whose visibility timeout has been changed successfully.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Encloses the id of an entry in <a>ChangeMessageVisibilityBatch</a>.</p>\"\
    },\
    \"ChangeMessageVisibilityBatchResultEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"ChangeMessageVisibilityBatchResultEntry\",\
        \"locationName\":\"ChangeMessageVisibilityBatchResultEntry\"\
      },\
      \"flattened\":true\
    },\
    \"ChangeMessageVisibilityRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"QueueUrl\",\
        \"ReceiptHandle\",\
        \"VisibilityTimeout\"\
      ],\
      \"members\":{\
        \"QueueUrl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>\"\
        },\
        \"ReceiptHandle\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The receipt handle associated with the message whose visibility timeout should be changed. This parameter is returned by the <a>ReceiveMessage</a> action.</p>\"\
        },\
        \"VisibilityTimeout\":{\
          \"shape\":\"Integer\",\
          \"documentation\":\"<p>The new value (in seconds - from 0 to 43200 - maximum 12 hours) for the message's visibility timeout.</p>\"\
        }\
      }\
    },\
    \"CreateQueueRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"QueueName\"],\
      \"members\":{\
        \"QueueName\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The name of the new queue. The following limits apply to this name:</p> <ul> <li> <p>A queue name can have up to 80 characters.</p> </li> <li> <p>The following are accepted: alphanumeric chatacters, hyphens (<code>-</code>), and underscores (<code>_</code>).</p> </li> <li> <p>A FIFO queue name must end with the <code>.fifo</code> suffix.</p> </li> </ul> <p>Queue names are case-sensitive.</p>\"\
        },\
        \"Attributes\":{\
          \"shape\":\"QueueAttributeMap\",\
          \"documentation\":\"<p>A map of attributes with their corresponding values.</p> <p>The following lists the names, descriptions, and values of the special request parameters that the <code>CreateQueue</code> action uses:</p> <ul> <li> <p> <code>DelaySeconds</code> - The number of seconds for which the delivery of all messages in the queue is delayed. An integer from 0 to 900 (15 minutes). The default is 0 (zero). </p> </li> <li> <p> <code>MaximumMessageSize</code> - The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1,024 bytes (1 KiB) up to 262,144 bytes (256 KiB). The default is 262,144 (256 KiB). </p> </li> <li> <p> <code>MessageRetentionPeriod</code> - The number of seconds for which Amazon SQS retains a message. An integer representing seconds, from 60 (1 minute) to 120,9600 (14 days). The default is 345,600 (4 days). </p> </li> <li> <p> <code>Policy</code> - The queue's policy. A valid AWS policy. For more information about policy structure, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/PoliciesOverview.html\\\">Overview of AWS IAM Policies</a> in the <i>Amazon IAM User Guide</i>. </p> </li> <li> <p> <code>ReceiveMessageWaitTimeSeconds</code> - The number of seconds for which a <a>ReceiveMessage</a> action will wait for a message to arrive. An integer from 0 to 20 (seconds). The default is 0. </p> </li> <li> <p> <code>RedrivePolicy</code> - The parameters for the dead letter queue functionality of the source queue. For more information about the redrive policy and dead letter queues, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSDeadLetterQueue.html\\\">Using Amazon SQS Dead Letter Queues</a> in the <i>Amazon SQS Developer Guide</i>. </p> <note> <p>The dead letter queue of a FIFO queue must also be a FIFO queue. Similarly, the dead letter queue of a standard queue must also be a standard queue.</p> </note> </li> <li> <p> <code>VisibilityTimeout</code> - The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default is 30. For more information about the visibility timeout, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html\\\">Visibility Timeout</a> in the <i>Amazon SQS Developer Guide</i>.</p> </li> </ul> <p>The following attributes apply only to <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html\\\">FIFO (first-in-first-out) queues</a>:</p> <ul> <li> <p> <code>FifoQueue</code> - Designates a queue as FIFO. You can provide this attribute only during queue creation; you can't change it for an existing queue. When you set this attribute, you must provide a <code>MessageGroupId</code> explicitly.</p> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html#FIFO-queues-understanding-logic\\\">FIFO Queue Logic</a> in the <i>Amazon SQS Developer Guide</i>.</p> </li> <li> <p> <code>ContentBasedDeduplication</code> - Enables content-based deduplication. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html#FIFO-queues-exactly-once-processing\\\">Exactly-Once Processing</a> in the <i>Amazon SQS Developer Guide</i>. </p> <ul> <li> <p>Every message must have a unique <code>MessageDeduplicationId</code>,</p> <ul> <li> <p>You may provide a <code>MessageDeduplicationId</code> explicitly.</p> </li> <li> <p>If you aren't able to provide a <code>MessageDeduplicationId</code> and you enable <code>ContentBasedDeduplication</code> for your queue, Amazon SQS uses a SHA-256 hash to generate the <code>MessageDeduplicationId</code> using the body of the message (but not the attributes of the message). </p> </li> <li> <p>If you don't provide a <code>MessageDeduplicationId</code> and the queue doesn't have <code>ContentBasedDeduplication</code> set, the action fails with an error.</p> </li> <li> <p>If the queue has <code>ContentBasedDeduplication</code> set, your <code>MessageDeduplicationId</code> overrides the generated one.</p> </li> </ul> </li> <li> <p>When <code>ContentBasedDeduplication</code> is in effect, messages with identical content sent within the deduplication interval are treated as duplicates and only one copy of the message is delivered.</p> </li> <li> <p>You can also use <code>ContentBasedDeduplication</code> for messages with identical content to be treated as duplicates.</p> </li> <li> <p>If you send one message with <code>ContentBasedDeduplication</code> enabled and then another message with a <code>MessageDeduplicationId</code> that is the same as the one generated for the first <code>MessageDeduplicationId</code>, the two messages are treated as duplicates and only one copy of the message is delivered. </p> </li> </ul> </li> </ul> <p>Any other valid special request parameters that are specified (such as <code>ApproximateNumberOfMessages</code>, <code>ApproximateNumberOfMessagesDelayed</code>, <code>ApproximateNumberOfMessagesNotVisible</code>, <code>CreatedTimestamp</code>, <code>LastModifiedTimestamp</code>, and <code>QueueArn</code>) will be ignored.</p>\",\
          \"locationName\":\"Attribute\"\
        }\
      },\
      \"documentation\":\"<p/>\"\
    },\
    \"CreateQueueResult\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"QueueUrl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The URL for the created Amazon SQS queue.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Returns the QueueUrl element of the created queue.</p>\"\
    },\
    \"DeleteMessageBatchRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"QueueUrl\",\
        \"Entries\"\
      ],\
      \"members\":{\
        \"QueueUrl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>\"\
        },\
        \"Entries\":{\
          \"shape\":\"DeleteMessageBatchRequestEntryList\",\
          \"documentation\":\"<p>A list of receipt handles for the messages to be deleted.</p>\"\
        }\
      },\
      \"documentation\":\"<p/>\"\
    },\
    \"DeleteMessageBatchRequestEntry\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Id\",\
        \"ReceiptHandle\"\
      ],\
      \"members\":{\
        \"Id\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>An identifier for this particular receipt handle. This is used to communicate the result. Note that the <code>Id</code>s of a batch request need to be unique within the request.</p>\"\
        },\
        \"ReceiptHandle\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A receipt handle.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Encloses a receipt handle and an identifier for it.</p>\"\
    },\
    \"DeleteMessageBatchRequestEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"DeleteMessageBatchRequestEntry\",\
        \"locationName\":\"DeleteMessageBatchRequestEntry\"\
      },\
      \"flattened\":true\
    },\
    \"DeleteMessageBatchResult\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Successful\",\
        \"Failed\"\
      ],\
      \"members\":{\
        \"Successful\":{\
          \"shape\":\"DeleteMessageBatchResultEntryList\",\
          \"documentation\":\"<p>A list of <a>DeleteMessageBatchResultEntry</a> items.</p>\"\
        },\
        \"Failed\":{\
          \"shape\":\"BatchResultErrorEntryList\",\
          \"documentation\":\"<p>A list of <a>BatchResultErrorEntry</a> items.</p>\"\
        }\
      },\
      \"documentation\":\"<p> For each message in the batch, the response contains a <a>DeleteMessageBatchResultEntry</a> tag if the message is deleted or a <a>BatchResultErrorEntry</a> tag if the message can't be deleted. </p>\"\
    },\
    \"DeleteMessageBatchResultEntry\":{\
      \"type\":\"structure\",\
      \"required\":[\"Id\"],\
      \"members\":{\
        \"Id\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>Represents a successfully deleted message.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Encloses the id an entry in <a>DeleteMessageBatch</a>.</p>\"\
    },\
    \"DeleteMessageBatchResultEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"DeleteMessageBatchResultEntry\",\
        \"locationName\":\"DeleteMessageBatchResultEntry\"\
      },\
      \"flattened\":true\
    },\
    \"DeleteMessageRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"QueueUrl\",\
        \"ReceiptHandle\"\
      ],\
      \"members\":{\
        \"QueueUrl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>\"\
        },\
        \"ReceiptHandle\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The receipt handle associated with the message to delete.</p>\"\
        }\
      },\
      \"documentation\":\"<p/>\"\
    },\
    \"DeleteQueueRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"QueueUrl\"],\
      \"members\":{\
        \"QueueUrl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>\"\
        }\
      },\
      \"documentation\":\"<p/>\"\
    },\
    \"EmptyBatchRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>Batch request doesn't contain an entry.</p>\",\
      \"error\":{\
        \"code\":\"AWS.SimpleQueueService.EmptyBatchRequest\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"GetQueueAttributesRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"QueueUrl\"],\
      \"members\":{\
        \"QueueUrl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>\"\
        },\
        \"AttributeNames\":{\
          \"shape\":\"AttributeNameList\",\
          \"documentation\":\"<p>A list of attributes for which to retrieve information.</p> <note> <p>Going forward, new attributes might be added. If you are writing code that calls this action, we recommend that you structure your code so that it can handle new attributes gracefully.</p> </note> <p>The following attributes are supported:</p> <ul> <li> <p> <code>All</code> - Returns all values. </p> </li> <li> <p> <code>ApproximateNumberOfMessages</code> - Returns the approximate number of visible messages in a queue. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/ApproximateNumber.html\\\">Resources Required to Process Messages</a> in the <i>Amazon SQS Developer Guide</i>. </p> </li> <li> <p> <code>ApproximateNumberOfMessagesDelayed</code> - Returns the approximate number of messages that are waiting to be added to the queue. </p> </li> <li> <p> <code>ApproximateNumberOfMessagesNotVisible</code> - Returns the approximate number of messages that have not timed-out and are not deleted. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/ApproximateNumber.html\\\">Resources Required to Process Messages</a> in the <i>Amazon SQS Developer Guide</i>. </p> </li> <li> <p> <code>CreatedTimestamp</code> - Returns the time when the queue was created in seconds (epoch time).</p> </li> <li> <p> <code>DelaySeconds</code> - Returns the default delay on the queue in seconds.</p> </li> <li> <p> <code>LastModifiedTimestamp</code> - Returns the time when the queue was last changed in seconds (epoch time).</p> </li> <li> <p> <code>MaximumMessageSize</code> - Returns the limit of how many bytes a message can contain before Amazon SQS rejects it.</p> </li> <li> <p> <code>MessageRetentionPeriod</code> - Returns the number of seconds for which Amazon SQS retains a message.</p> </li> <li> <p> <code>Policy</code> - Returns the policy of the queue.</p> </li> <li> <p> <code>QueueArn</code> - Returns the Amazon resource name (ARN) of the queue.</p> </li> <li> <p> <code>ReceiveMessageWaitTimeSeconds</code> - Returns the number of seconds for which ReceiveMessage call will wait for a message to arrive. </p> </li> <li> <p> <code>RedrivePolicy</code> - Returns the parameters for dead letter queue functionality of the source queue. For more information about the redrive policy and dead letter queues, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSDeadLetterQueue.html\\\">Using Amazon SQS Dead Letter Queues</a> in the <i>Amazon SQS Developer Guide</i>. </p> </li> <li> <p> <code>VisibilityTimeout</code> - Returns the visibility timeout for the queue. For more information about the visibility timeout, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html\\\">Visibility Timeout</a> in the <i>Amazon SQS Developer Guide</i>. </p> </li> </ul> <p>The following attributes apply only to <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html\\\">FIFO (first-in-first-out) queues</a>:</p> <ul> <li> <p> <code>FifoQueue</code> - Returns whether the queue is FIFO. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html#FIFO-queues-understanding-logic\\\">FIFO Queue Logic</a> in the <i>Amazon SQS Developer Guide</i>.</p> </li> <li> <p> <code>ContentBasedDeduplication</code> - Returns whether content-based deduplication is enabled for the queue. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html#FIFO-queues-exactly-once-processing\\\">Exactly-Once Processing</a> in the <i>Amazon SQS Developer Guide</i>. </p> </li> </ul>\"\
        }\
      },\
      \"documentation\":\"<p/>\"\
    },\
    \"GetQueueAttributesResult\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Attributes\":{\
          \"shape\":\"QueueAttributeMap\",\
          \"documentation\":\"<p>A map of attributes to the respective values.</p>\",\
          \"locationName\":\"Attribute\"\
        }\
      },\
      \"documentation\":\"<p>A list of returned queue attributes.</p>\"\
    },\
    \"GetQueueUrlRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"QueueName\"],\
      \"members\":{\
        \"QueueName\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The name of the queue whose URL must be fetched. Maximum 80 characters; alphanumeric characters, hyphens (-), and underscores (_) are allowed.</p> <p>Queue names are case-sensitive.</p>\"\
        },\
        \"QueueOwnerAWSAccountId\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The AWS account ID of the account that created the queue.</p>\"\
        }\
      },\
      \"documentation\":\"<p/>\"\
    },\
    \"GetQueueUrlResult\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"QueueUrl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The URL for the queue.</p>\"\
        }\
      },\
      \"documentation\":\"<p>For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/UnderstandingResponses.html\\\">Responses</a> in the <i>Amazon SQS Developer Guide</i>.</p>\"\
    },\
    \"Integer\":{\"type\":\"integer\"},\
    \"InvalidAttributeName\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The attribute referred to doesn't exist.</p>\",\
      \"exception\":true\
    },\
    \"InvalidBatchEntryId\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The <code>Id</code> of a batch entry in a batch request doesn't abide by the specification.</p>\",\
      \"error\":{\
        \"code\":\"AWS.SimpleQueueService.InvalidBatchEntryId\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"InvalidIdFormat\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The receipt handle is not valid for the current version.</p>\",\
      \"exception\":true\
    },\
    \"InvalidMessageContents\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The message contains characters outside the allowed set.</p>\",\
      \"exception\":true\
    },\
    \"ListDeadLetterSourceQueuesRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"QueueUrl\"],\
      \"members\":{\
        \"QueueUrl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The queue URL of a dead letter queue.</p> <p>Queue URLs are case-sensitive.</p>\"\
        }\
      },\
      \"documentation\":\"<p/>\"\
    },\
    \"ListDeadLetterSourceQueuesResult\":{\
      \"type\":\"structure\",\
      \"required\":[\"queueUrls\"],\
      \"members\":{\
        \"queueUrls\":{\
          \"shape\":\"QueueUrlList\",\
          \"documentation\":\"<p>A list of source queue URLs that have the RedrivePolicy queue attribute configured with a dead letter queue.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A list of your dead letter source queues.</p>\"\
    },\
    \"ListQueuesRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"QueueNamePrefix\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A string to use for filtering the list results. Only those queues whose name begins with the specified string are returned.</p> <p>Queue names are case-sensitive.</p>\"\
        }\
      },\
      \"documentation\":\"<p/>\"\
    },\
    \"ListQueuesResult\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"QueueUrls\":{\
          \"shape\":\"QueueUrlList\",\
          \"documentation\":\"<p>A list of queue URLs, up to 1000 entries.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A list of your queues.</p>\"\
    },\
    \"Message\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"MessageId\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A unique identifier for the message. Message IDs are considered unique across all AWS accounts for an extended period of time.</p>\"\
        },\
        \"ReceiptHandle\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>An identifier associated with the act of receiving the message. A new receipt handle is returned every time you receive a message. When deleting a message, you provide the last received receipt handle to delete the message.</p>\"\
        },\
        \"MD5OfBody\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>An MD5 digest of the non-URL-encoded message body string.</p>\"\
        },\
        \"Body\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The message's contents (not URL-encoded).</p>\"\
        },\
        \"Attributes\":{\
          \"shape\":\"MessageSystemAttributeMap\",\
          \"documentation\":\"<p> <code>SenderId</code>, <code>SentTimestamp</code>, <code>ApproximateReceiveCount</code>, and/or <code>ApproximateFirstReceiveTimestamp</code>. <code>SentTimestamp</code> and <code>ApproximateFirstReceiveTimestamp</code> are each returned as an integer representing the <a href=\\\"http://en.wikipedia.org/wiki/Unix_time\\\">epoch time</a> in milliseconds.</p>\",\
          \"locationName\":\"Attribute\"\
        },\
        \"MD5OfMessageAttributes\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>An MD5 digest of the non-URL-encoded message attribute string. This can be used to verify that Amazon SQS received the message correctly. Amazon SQS first URL decodes the message before creating the MD5 digest. For information about MD5, see <a href=\\\"https://www.ietf.org/rfc/rfc1321.txt\\\">RFC1321</a>.</p>\"\
        },\
        \"MessageAttributes\":{\
          \"shape\":\"MessageBodyAttributeMap\",\
          \"documentation\":\"<p>Each message attribute consists of a Name, Type, and Value. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSMessageAttributes.html#SQSMessageAttributesNTV\\\">Message Attribute Items</a> in the <i>Amazon SQS Developer Guide</i>.</p>\",\
          \"locationName\":\"MessageAttribute\"\
        }\
      },\
      \"documentation\":\"<p>An Amazon SQS message.</p>\"\
    },\
    \"MessageAttributeName\":{\"type\":\"string\"},\
    \"MessageAttributeNameList\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"MessageAttributeName\",\
        \"locationName\":\"MessageAttributeName\"\
      },\
      \"flattened\":true\
    },\
    \"MessageAttributeValue\":{\
      \"type\":\"structure\",\
      \"required\":[\"DataType\"],\
      \"members\":{\
        \"StringValue\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>Strings are Unicode with UTF8 binary encoding. For a list of code values, see <a href=\\\"http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters\\\">ASCII Printable Characters</a>.</p>\"\
        },\
        \"BinaryValue\":{\
          \"shape\":\"Binary\",\
          \"documentation\":\"<p>Binary type attributes can store any binary data, for example, compressed data, encrypted data, or images.</p>\"\
        },\
        \"StringListValues\":{\
          \"shape\":\"StringList\",\
          \"documentation\":\"<p>Not implemented. Reserved for future use.</p>\",\
          \"flattened\":true,\
          \"locationName\":\"StringListValue\"\
        },\
        \"BinaryListValues\":{\
          \"shape\":\"BinaryList\",\
          \"documentation\":\"<p>Not implemented. Reserved for future use.</p>\",\
          \"flattened\":true,\
          \"locationName\":\"BinaryListValue\"\
        },\
        \"DataType\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>Amazon SQS supports the following logical data types: String, Number, and Binary. For the Number data type, you must use StringValue.</p> <p>You can also append custom labels. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSMessageAttributes.html#SQSMessageAttributes.DataTypes\\\">Message Attribute Data Types</a> in the <i>Amazon SQS Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The user-specified message attribute value. For string data types, the value attribute has the same restrictions on the content as the message body. For more information, see <a>SendMessage</a>.</p> <p>Name, type, and value must not be empty or null. In addition, the message body should not be empty or null. All parts of the message attribute, including name, type, and value, are included in the message size restriction, which is currently 256 KB (262,144 bytes).</p>\"\
    },\
    \"MessageBodyAttributeMap\":{\
      \"type\":\"map\",\
      \"key\":{\
        \"shape\":\"String\",\
        \"locationName\":\"Name\"\
      },\
      \"value\":{\
        \"shape\":\"MessageAttributeValue\",\
        \"locationName\":\"Value\"\
      },\
      \"flattened\":true\
    },\
    \"MessageList\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"Message\",\
        \"locationName\":\"Message\"\
      },\
      \"flattened\":true\
    },\
    \"MessageNotInflight\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The message referred to is not in flight.</p>\",\
      \"error\":{\
        \"code\":\"AWS.SimpleQueueService.MessageNotInflight\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"MessageSystemAttributeMap\":{\
      \"type\":\"map\",\
      \"key\":{\
        \"shape\":\"MessageSystemAttributeName\",\
        \"locationName\":\"Name\"\
      },\
      \"value\":{\
        \"shape\":\"String\",\
        \"locationName\":\"Value\"\
      },\
      \"flattened\":true,\
      \"locationName\":\"Attribute\"\
    },\
    \"MessageSystemAttributeName\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"SenderId\",\
        \"SentTimestamp\",\
        \"ApproximateReceiveCount\",\
        \"ApproximateFirstReceiveTimestamp\",\
        \"SequenceNumber\",\
        \"MessageDeduplicationId\",\
        \"MessageGroupId\"\
      ]\
    },\
    \"OverLimit\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The action that you requested would violate a limit. For example, ReceiveMessage returns this error if the maximum number of messages inflight has already been reached. <a>AddPermission</a> returns this error if the maximum number of permissions for the queue has already been reached. </p>\",\
      \"error\":{\
        \"code\":\"OverLimit\",\
        \"httpStatusCode\":403,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"PurgeQueueInProgress\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>Indicates that the specified queue previously received a <code>PurgeQueue</code> request within the last 60 seconds, the time it can take to delete the messages in the queue.</p>\",\
      \"error\":{\
        \"code\":\"AWS.SimpleQueueService.PurgeQueueInProgress\",\
        \"httpStatusCode\":403,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"PurgeQueueRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"QueueUrl\"],\
      \"members\":{\
        \"QueueUrl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The queue URL of the queue to delete the messages from when using the <code>PurgeQueue</code> API.</p> <p>Queue URLs are case-sensitive.</p>\"\
        }\
      },\
      \"documentation\":\"<p/>\"\
    },\
    \"QueueAttributeMap\":{\
      \"type\":\"map\",\
      \"key\":{\
        \"shape\":\"QueueAttributeName\",\
        \"locationName\":\"Name\"\
      },\
      \"value\":{\
        \"shape\":\"String\",\
        \"locationName\":\"Value\"\
      },\
      \"flattened\":true,\
      \"locationName\":\"Attribute\"\
    },\
    \"QueueAttributeName\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"All\",\
        \"Policy\",\
        \"VisibilityTimeout\",\
        \"MaximumMessageSize\",\
        \"MessageRetentionPeriod\",\
        \"ApproximateNumberOfMessages\",\
        \"ApproximateNumberOfMessagesNotVisible\",\
        \"CreatedTimestamp\",\
        \"LastModifiedTimestamp\",\
        \"QueueArn\",\
        \"ApproximateNumberOfMessagesDelayed\",\
        \"DelaySeconds\",\
        \"ReceiveMessageWaitTimeSeconds\",\
        \"RedrivePolicy\",\
        \"FifoQueue\",\
        \"ContentBasedDeduplication\"\
      ]\
    },\
    \"QueueDeletedRecently\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>You must wait 60 seconds after deleting a queue before you can create another with the same name.</p>\",\
      \"error\":{\
        \"code\":\"AWS.SimpleQueueService.QueueDeletedRecently\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"QueueDoesNotExist\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The queue referred to doesn't exist.</p>\",\
      \"error\":{\
        \"code\":\"AWS.SimpleQueueService.NonExistentQueue\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"QueueNameExists\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>A queue already exists with this name. Amazon SQS returns this error only if the request includes attributes whose values differ from those of the existing queue.</p>\",\
      \"error\":{\
        \"code\":\"QueueAlreadyExists\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"QueueUrlList\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"String\",\
        \"locationName\":\"QueueUrl\"\
      },\
      \"flattened\":true\
    },\
    \"ReceiptHandleIsInvalid\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The receipt handle provided is not valid.</p>\",\
      \"exception\":true\
    },\
    \"ReceiveMessageRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"QueueUrl\"],\
      \"members\":{\
        \"QueueUrl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>\"\
        },\
        \"AttributeNames\":{\
          \"shape\":\"AttributeNameList\",\
          \"documentation\":\"<p>A list of attributes that need to be returned along with each message. These attributes include:</p> <ul> <li> <p> <code>All</code> - Returns all values.</p> </li> <li> <p> <code>ApproximateFirstReceiveTimestamp</code> - Returns the time the message was first received from the queue (epoch time in milliseconds).</p> </li> <li> <p> <code>ApproximateReceiveCount</code> - Returns the number of times a message has been received from the queue but not deleted.</p> </li> <li> <p> <code>SenderId</code> </p> <ul> <li> <p>For an IAM user, returns the IAM user ID, for example <code>ABCDEFGHI1JKLMNOPQ23R</code>.</p> </li> <li> <p>For an IAM role, returns the IAM role ID, for example <code>ABCDE1F2GH3I4JK5LMNOP:i-a123b456</code>.</p> </li> </ul> </li> <li> <p> <code>SentTimestamp</code> - Returns the time the message was sent to the queue (epoch time in milliseconds).</p> </li> <li> <p> <code>MessageDeduplicationId</code> - Returns the value provided by the sender that calls the <code> <a>SendMessage</a> </code> action.</p> </li> <li> <p> <code>MessageGroupId</code> - Returns the value provided by the sender that calls the <code> <a>SendMessage</a> </code> action. Messages with the same <code>MessageGroupId</code> are returned in sequence.</p> </li> <li> <p> <code>SequenceNumber</code> - Returns the value provided by Amazon SQS.</p> </li> </ul> <p>Any other valid special request parameters (such as the following) that are specified are ignored:</p> <ul> <li> <p> <code>ApproximateNumberOfMessages</code> </p> </li> <li> <p> <code>ApproximateNumberOfMessagesDelayed</code> </p> </li> <li> <p> <code>ApproximateNumberOfMessagesNotVisible</code> </p> </li> <li> <p> <code>CreatedTimestamp</code> </p> </li> <li> <p> <code>ContentBasedDeduplication</code> </p> </li> <li> <p> <code>DelaySeconds</code> </p> </li> <li> <p> <code>LastModifiedTimestamp</code> </p> </li> <li> <p> <code>MaximumMessageSize</code> </p> </li> <li> <p> <code>MessageRetentionPeriod</code> </p> </li> <li> <p> <code>Policy</code> </p> </li> <li> <p> <code>QueueArn</code>, </p> </li> <li> <p> <code>ReceiveMessageWaitTimeSeconds</code> </p> </li> <li> <p> <code>RedrivePolicy</code> </p> </li> <li> <p> <code>FifoQueue</code> </p> </li> <li> <p> <code>VisibilityTimeout</code> </p> </li> </ul>\"\
        },\
        \"MessageAttributeNames\":{\
          \"shape\":\"MessageAttributeNameList\",\
          \"documentation\":\"<p>The name of the message attribute, where <i>N</i> is the index. The message attribute name can contain the following characters: A-Z, a-z, 0-9, underscore (_), hyphen (-), and period (.). The name must not start or end with a period, and it should not have successive periods. The name is case sensitive and must be unique among all attribute names for the message. The name can be up to 256 characters long. The name can't start with \\\"AWS.\\\" or \\\"Amazon.\\\" (or any variations in casing), because these prefixes are reserved for use by Amazon Web Services.</p> <p>When using <code>ReceiveMessage</code>, you can send a list of attribute names to receive, or you can return all of the attributes by specifying \\\"All\\\" or \\\".*\\\" in your request. You can also use \\\"bar.*\\\" to return all message attributes starting with the \\\"bar\\\" prefix.</p>\"\
        },\
        \"MaxNumberOfMessages\":{\
          \"shape\":\"Integer\",\
          \"documentation\":\"<p>The maximum number of messages to return. Amazon SQS never returns more messages than this value but might return fewer. Values can be from 1 to 10. Default is 1.</p> <p>All of the messages are not necessarily returned.</p>\"\
        },\
        \"VisibilityTimeout\":{\
          \"shape\":\"Integer\",\
          \"documentation\":\"<p>The duration (in seconds) that the received messages are hidden from subsequent retrieve requests after being retrieved by a <code>ReceiveMessage</code> request.</p>\"\
        },\
        \"WaitTimeSeconds\":{\
          \"shape\":\"Integer\",\
          \"documentation\":\"<p>The duration (in seconds) for which the call will wait for a message to arrive in the queue before returning. If a message is available, the call will return sooner than WaitTimeSeconds.</p>\"\
        },\
        \"ReceiveRequestAttemptId\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>This parameter applies only to FIFO (first-in-first-out) queues.</p> <p>The token used for deduplication of <code>ReceiveMessage</code> calls. If a networking issue occurs after a <code>ReceiveMessage</code> action, and instead of a response you receive a generic error, you can retry the same action with an identical <code>ReceiveRequestAttemptId</code> to retrieve the same set of messages, even if their visibility timeout has not yet expired.</p> <ul> <li> <p>You can use <code>ReceiveRequestAttemptId</code> only for 5 minutes after a <code>ReceiveMessage</code> action.</p> </li> <li> <p>When you set <code>FifoQueue</code>, a caller of the <code>ReceiveMessage</code> action can provide a <code>ReceiveRequestAttemptId</code> explicitly.</p> </li> <li> <p>If a caller of the <code>ReceiveMessage</code> action doesn't provide a <code>ReceiveRequestAttemptId</code>, Amazon SQS generates a <code>ReceiveRequestAttemptId</code>.</p> </li> <li> <p>You can retry the <code>ReceiveMessage</code> action with the same <code>ReceiveRequestAttemptId</code> if none of the messages have been modified (deleted or had their visibility changes).</p> </li> <li> <p>During a visibility timeout, subsequent calls with the same <code>ReceiveRequestAttemptId</code> return the same messages and receipt handles. If a retry occurs within the deduplication interval, it resets the visibility timeout. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html\\\">Visibility Timeout</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p> <important> <p>If a caller of the <code>ReceiveMessage</code> action is still processing messages when the visibility timeout expires and messages become visible, another worker reading from the same queue can receive the same messages and therefore process duplicates. Also, if a reader whose message processing time is longer than the visibility timeout tries to delete the processed messages, the action fails with an error.</p> <p>To mitigate this effect, ensure that your application observes a safe threshold before the visibility timeout expires and extend the visibility timeout as necessary.</p> </important> </li> <li> <p>While messages with a particular <code>MessageGroupId</code> are invisible, no more messages belonging to the same <code>MessageGroupId</code> are returned until the visibility timeout expires. You can still receive messages with another <code>MessageGroupId</code> as long as it is also visible.</p> </li> <li> <p>If a caller of <code>ReceiveMessage</code> can't track the <code>ReceiveRequestAttemptId</code>, no retries will work until the original visibility timeout expires. As a result, delays might occur but the messages in the queue will remain in a strict order.</p> </li> </ul> <p>The length of <code>ReceiveRequestAttemptId</code> is 128 characters. <code>ReceiveRequestAttemptId</code> can contain alphanumeric characters (<code>a-z</code>, <code>A-Z</code>, <code>0-9</code>) and punctuation (<code>!\\\"#$%&amp;'()*+,-./:;&lt;=&gt;?@[\\\\]^_`{|}~</code>).</p> <p>For best practices of using <code>ReceiveRequestAttemptId</code>, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queue-recommendations.html#using-receiverequestattemptid-request-parameter\\\">Using the ReceiveRequestAttemptId Request Parameter</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p/>\"\
    },\
    \"ReceiveMessageResult\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Messages\":{\
          \"shape\":\"MessageList\",\
          \"documentation\":\"<p>A list of messages.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A list of received messages.</p>\"\
    },\
    \"RemovePermissionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"QueueUrl\",\
        \"Label\"\
      ],\
      \"members\":{\
        \"QueueUrl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>\"\
        },\
        \"Label\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The identification of the permission to remove. This is the label added with the <a>AddPermission</a> action.</p>\"\
        }\
      },\
      \"documentation\":\"<p/>\"\
    },\
    \"SendMessageBatchRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"QueueUrl\",\
        \"Entries\"\
      ],\
      \"members\":{\
        \"QueueUrl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>\"\
        },\
        \"Entries\":{\
          \"shape\":\"SendMessageBatchRequestEntryList\",\
          \"documentation\":\"<p>A list of <a>SendMessageBatchRequestEntry</a> items.</p>\"\
        }\
      },\
      \"documentation\":\"<p/>\"\
    },\
    \"SendMessageBatchRequestEntry\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Id\",\
        \"MessageBody\"\
      ],\
      \"members\":{\
        \"Id\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>An identifier for the message in this batch. This is used to communicate the result. Note that the <code>Id</code>s of a batch request need to be unique within the request.</p>\"\
        },\
        \"MessageBody\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>Body of the message.</p>\"\
        },\
        \"DelaySeconds\":{\
          \"shape\":\"Integer\",\
          \"documentation\":\"<p>The number of seconds (0 to 900 - 15 minutes) to delay a specific message. Messages with a positive <code>DelaySeconds</code> value become available for processing after the delay time is finished. If you don't specify a value, the default value for the queue applies. </p> <note> <p>When you set <code>FifoQueue</code>, you can't set <code>DelaySeconds</code> per message. You can set this parameter only on a queue level.</p> </note>\"\
        },\
        \"MessageAttributes\":{\
          \"shape\":\"MessageBodyAttributeMap\",\
          \"documentation\":\"<p>Each message attribute consists of a Name, Type, and Value. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSMessageAttributes.html#SQSMessageAttributesNTV\\\">Message Attribute Items</a> in the <i>Amazon SQS Developer Guide</i>.</p>\",\
          \"locationName\":\"MessageAttribute\"\
        },\
        \"MessageDeduplicationId\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>This parameter applies only to FIFO (first-in-first-out) queues.</p> <p>The token used for deduplication of messages within a 5-minute minimum deduplication interval. If a message with a particular <code>MessageDeduplicationId</code> is sent successfully, subsequent messages with the same <code>MessageDeduplicationId</code> are accepted successfully but aren't delivered. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html#FIFO-queues-exactly-once-processing\\\"> Exactly-Once Processing</a> in the <i>Amazon SQS Developer Guide</i>.</p> <ul> <li> <p>Every message must have a unique <code>MessageDeduplicationId</code>,</p> <ul> <li> <p>You may provide a <code>MessageDeduplicationId</code> explicitly.</p> </li> <li> <p>If you aren't able to provide a <code>MessageDeduplicationId</code> and you enable <code>ContentBasedDeduplication</code> for your queue, Amazon SQS uses a SHA-256 hash to generate the <code>MessageDeduplicationId</code> using the body of the message (but not the attributes of the message). </p> </li> <li> <p>If you don't provide a <code>MessageDeduplicationId</code> and the queue doesn't have <code>ContentBasedDeduplication</code> set, the action fails with an error.</p> </li> <li> <p>If the queue has <code>ContentBasedDeduplication</code> set, your <code>MessageDeduplicationId</code> overrides the generated one.</p> </li> </ul> </li> <li> <p>When <code>ContentBasedDeduplication</code> is in effect, messages with identical content sent within the deduplication interval are treated as duplicates and only one copy of the message is delivered.</p> </li> <li> <p>You can also use <code>ContentBasedDeduplication</code> for messages with identical content to be treated as duplicates.</p> </li> <li> <p>If you send one message with <code>ContentBasedDeduplication</code> enabled and then another message with a <code>MessageDeduplicationId</code> that is the same as the one generated for the first <code>MessageDeduplicationId</code>, the two messages are treated as duplicates and only one copy of the message is delivered. </p> </li> </ul> <note> <p>The <code>MessageDeduplicationId</code> is available to the recipient of the message (this can be useful for troubleshooting delivery issues).</p> <p>If a message is sent successfully but the acknowledgement is lost and the message is resent with the same <code>MessageDeduplicationId</code> after the deduplication interval, Amazon SQS can't detect duplicate messages.</p> </note> <p>The length of <code>MessageDeduplicationId</code> is 128 characters. <code>MessageDeduplicationId</code> can contain alphanumeric characters (<code>a-z</code>, <code>A-Z</code>, <code>0-9</code>) and punctuation (<code>!\\\"#$%&amp;'()*+,-./:;&lt;=&gt;?@[\\\\]^_`{|}~</code>).</p> <p>For best practices of using <code>MessageDeduplicationId</code>, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queue-recommendations.html#using-messagededuplicationid-property\\\">Using the MessageDeduplicationId Property</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p>\"\
        },\
        \"MessageGroupId\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>This parameter applies only to FIFO (first-in-first-out) queues.</p> <p>The tag that specifies that a message belongs to a specific message group. Messages that belong to the same message group are processed in a FIFO manner (however, messages in different message groups might be processed out of order). To interleave multiple ordered streams within a single queue, use <code>MessageGroupId</code> values (for example, session data for multiple users). In this scenario, multiple readers can process the queue, but the session data of each user is processed in a FIFO fashion.</p> <ul> <li> <p>You must associate a non-empty <code>MessageGroupId</code> with a message. If you don't provide a <code>MessageGroupId</code>, the action fails.</p> </li> <li> <p> <code>ReceiveMessage</code> might return messages with multiple <code>MessageGroupId</code> values. For each <code>MessageGroupId</code>, the messages are sorted by time sent. The caller can't specify a <code>MessageGroupId</code>.</p> </li> </ul> <p>The length of <code>MessageGroupId</code> is 128 characters. Valid values are alphanumeric characters and punctuation <code>(!\\\"#$%&amp;'()*+,-./:;&lt;=&gt;?@[\\\\]^_`{|}~)</code>.</p> <p>For best practices of using <code>MessageGroupId</code>, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queue-recommendations.html#using-messagegroupid-property\\\">Using the MessageGroupId Property</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the details of a single Amazon SQS message along with a <code>Id</code>. </p>\"\
    },\
    \"SendMessageBatchRequestEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"SendMessageBatchRequestEntry\",\
        \"locationName\":\"SendMessageBatchRequestEntry\"\
      },\
      \"flattened\":true\
    },\
    \"SendMessageBatchResult\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Successful\",\
        \"Failed\"\
      ],\
      \"members\":{\
        \"Successful\":{\
          \"shape\":\"SendMessageBatchResultEntryList\",\
          \"documentation\":\"<p>A list of <a>SendMessageBatchResultEntry</a> items.</p>\"\
        },\
        \"Failed\":{\
          \"shape\":\"BatchResultErrorEntryList\",\
          \"documentation\":\"<p>A list of <a>BatchResultErrorEntry</a> items with the error detail about each message that could not be enqueued.</p>\"\
        }\
      },\
      \"documentation\":\"<p>For each message in the batch, the response contains a <a>SendMessageBatchResultEntry</a> tag if the message succeeds or a <a>BatchResultErrorEntry</a> tag if the message fails.</p>\"\
    },\
    \"SendMessageBatchResultEntry\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Id\",\
        \"MessageId\",\
        \"MD5OfMessageBody\"\
      ],\
      \"members\":{\
        \"Id\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>An identifier for the message in this batch.</p>\"\
        },\
        \"MessageId\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>An identifier for the message.</p>\"\
        },\
        \"MD5OfMessageBody\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>An MD5 digest of the non-URL-encoded message body string. This can be used to verify that Amazon SQS received the message correctly. Amazon SQS first URL decodes the message before creating the MD5 digest. For information about MD5, see <a href=\\\"https://www.ietf.org/rfc/rfc1321.txt\\\">RFC1321</a>.</p>\"\
        },\
        \"MD5OfMessageAttributes\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>An MD5 digest of the non-URL-encoded message attribute string. This can be used to verify that Amazon SQS received the message batch correctly. Amazon SQS first URL decodes the message before creating the MD5 digest. For information about MD5, see <a href=\\\"https://www.ietf.org/rfc/rfc1321.txt\\\">RFC1321</a>.</p>\"\
        },\
        \"SequenceNumber\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p> <i>This element applies only to FIFO (first-in-first-out) queues.</i> </p> <p>A large, non-consecutive number that Amazon SQS assigns to each message.</p> <p>The length of <code>SequenceNumber</code> is 128 bits. As <code>SequenceNumber</code> continues to increase for a particular <code>MessageGroupId</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Encloses a message ID for successfully enqueued message of a <a>SendMessageBatch</a>.</p>\"\
    },\
    \"SendMessageBatchResultEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"SendMessageBatchResultEntry\",\
        \"locationName\":\"SendMessageBatchResultEntry\"\
      },\
      \"flattened\":true\
    },\
    \"SendMessageRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"QueueUrl\",\
        \"MessageBody\"\
      ],\
      \"members\":{\
        \"QueueUrl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>\"\
        },\
        \"MessageBody\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The message to send. String maximum 256 KB in size. For a list of allowed characters, see the preceding note.</p>\"\
        },\
        \"DelaySeconds\":{\
          \"shape\":\"Integer\",\
          \"documentation\":\"<p> The number of seconds (0 to 900 - 15 minutes) to delay a specific message. Messages with a positive <code>DelaySeconds</code> value become available for processing after the delay time is finished. If you don't specify a value, the default value for the queue applies. </p> <note> <p>When you set <code>FifoQueue</code>, you can't set <code>DelaySeconds</code> per message. You can set this parameter only on a queue level.</p> </note>\"\
        },\
        \"MessageAttributes\":{\
          \"shape\":\"MessageBodyAttributeMap\",\
          \"documentation\":\"<p>Each message attribute consists of a Name, Type, and Value. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSMessageAttributes.html#SQSMessageAttributesNTV\\\">Message Attribute Items</a> in the <i>Amazon SQS Developer Guide</i>.</p>\",\
          \"locationName\":\"MessageAttribute\"\
        },\
        \"MessageDeduplicationId\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>This parameter applies only to FIFO (first-in-first-out) queues.</p> <p>The token used for deduplication of sent messages. If a message with a particular <code>MessageDeduplicationId</code> is sent successfully, any messages sent with the same <code>MessageDeduplicationId</code> are accepted successfully but aren't delivered during the 5-minute deduplication interval. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html#FIFO-queues-exactly-once-processing\\\"> Exactly-Once Processing</a> in the <i>Amazon SQS Developer Guide</i>.</p> <ul> <li> <p>Every message must have a unique <code>MessageDeduplicationId</code>,</p> <ul> <li> <p>You may provide a <code>MessageDeduplicationId</code> explicitly.</p> </li> <li> <p>If you aren't able to provide a <code>MessageDeduplicationId</code> and you enable <code>ContentBasedDeduplication</code> for your queue, Amazon SQS uses a SHA-256 hash to generate the <code>MessageDeduplicationId</code> using the body of the message (but not the attributes of the message). </p> </li> <li> <p>If you don't provide a <code>MessageDeduplicationId</code> and the queue doesn't have <code>ContentBasedDeduplication</code> set, the action fails with an error.</p> </li> <li> <p>If the queue has <code>ContentBasedDeduplication</code> set, your <code>MessageDeduplicationId</code> overrides the generated one.</p> </li> </ul> </li> <li> <p>When <code>ContentBasedDeduplication</code> is in effect, messages with identical content sent within the deduplication interval are treated as duplicates and only one copy of the message is delivered.</p> </li> <li> <p>You can also use <code>ContentBasedDeduplication</code> for messages with identical content to be treated as duplicates.</p> </li> <li> <p>If you send one message with <code>ContentBasedDeduplication</code> enabled and then another message with a <code>MessageDeduplicationId</code> that is the same as the one generated for the first <code>MessageDeduplicationId</code>, the two messages are treated as duplicates and only one copy of the message is delivered. </p> </li> </ul> <note> <p>The <code>MessageDeduplicationId</code> is available to the recipient of the message (this can be useful for troubleshooting delivery issues).</p> <p>If a message is sent successfully but the acknowledgdment is lost and the message is resent with the same <code>MessageDeduplicationId</code> after the deduplication interval, Amazon SQS can't detect duplicate messages.</p> </note> <p>The length of <code>MessageDeduplicationId</code> is 128 characters. <code>MessageDeduplicationId</code> can contain alphanumeric characters (<code>a-z</code>, <code>A-Z</code>, <code>0-9</code>) and punctuation (<code>!\\\"#$%&amp;'()*+,-./:;&lt;=&gt;?@[\\\\]^_`{|}~</code>).</p> <p>For best practices of using <code>MessageDeduplicationId</code>, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queue-recommendations.html#using-messagededuplicationid-property\\\">Using the MessageDeduplicationId Property</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p>\"\
        },\
        \"MessageGroupId\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>This parameter applies only to FIFO (first-in-first-out) queues.</p> <p>The tag that specifies that a message belongs to a specific message group. Messages that belong to the same message group are processed in a FIFO manner (however, messages in different message groups might be processed out of order). To interleave multiple ordered streams within a single queue, use <code>MessageGroupId</code> values (for example, session data for multiple users). In this scenario, multiple readers can process the queue, but the session data of each user is processed in a FIFO fashion.</p> <ul> <li> <p>You must associate a non-empty <code>MessageGroupId</code> with a message. If you don't provide a <code>MessageGroupId</code>, the action fails.</p> </li> <li> <p> <code>ReceiveMessage</code> might return messages with multiple <code>MessageGroupId</code> values. For each <code>MessageGroupId</code>, the messages are sorted by time sent. The caller can't specify a <code>MessageGroupId</code>.</p> </li> </ul> <p>The length of <code>MessageGroupId</code> is 128 characters. Valid values are alphanumeric characters and punctuation <code>(!\\\"#$%&amp;'()*+,-./:;&lt;=&gt;?@[\\\\]^_`{|}~)</code>.</p> <p>For best practices of using <code>MessageGroupId</code>, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queue-recommendations.html#using-messagegroupid-property\\\">Using the MessageGroupId Property</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p/>\"\
    },\
    \"SendMessageResult\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"MD5OfMessageBody\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>An MD5 digest of the non-URL-encoded message body string. This can be used to verify that Amazon SQS received the message correctly. Amazon SQS first URL decodes the message before creating the MD5 digest. For information about MD5, see <a href=\\\"https://www.ietf.org/rfc/rfc1321.txt\\\">RFC1321</a>.</p>\"\
        },\
        \"MD5OfMessageAttributes\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>An MD5 digest of the non-URL-encoded message attribute string. This can be used to verify that Amazon SQS received the message correctly. Amazon SQS first URL decodes the message before creating the MD5 digest. For information about MD5, see <a href=\\\"https://www.ietf.org/rfc/rfc1321.txt\\\">RFC1321</a>.</p>\"\
        },\
        \"MessageId\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>An element containing the message ID of the message sent to the queue. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/ImportantIdentifiers.html\\\">Queue and Message Identifiers</a> in the <i>Amazon SQS Developer Guide</i>. </p>\"\
        },\
        \"SequenceNumber\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p> <i>This element applies only to FIFO (first-in-first-out) queues.</i> </p> <p>A large, non-consecutive number that Amazon SQS assigns to each message.</p> <p>The length of <code>SequenceNumber</code> is 128 bits. <code>SequenceNumber</code> continues to increase for a particular <code>MessageGroupId</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The MD5OfMessageBody and MessageId elements.</p>\"\
    },\
    \"SetQueueAttributesRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"QueueUrl\",\
        \"Attributes\"\
      ],\
      \"members\":{\
        \"QueueUrl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>\"\
        },\
        \"Attributes\":{\
          \"shape\":\"QueueAttributeMap\",\
          \"documentation\":\"<p>A map of attributes to set.</p> <p>The following lists the names, descriptions, and values of the special request parameters that the <code>SetQueueAttributes</code> action uses:</p> <ul> <li> <p> <code>DelaySeconds</code> - The number of seconds for which the delivery of all messages in the queue is delayed. An integer from 0 to 900 (15 minutes). The default is 0 (zero). </p> </li> <li> <p> <code>MaximumMessageSize</code> - The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1,024 bytes (1 KiB) up to 262,144 bytes (256 KiB). The default is 262,144 (256 KiB). </p> </li> <li> <p> <code>MessageRetentionPeriod</code> - The number of seconds for which Amazon SQS retains a message. An integer representing seconds, from 60 (1 minute) to 120,9600 (14 days). The default is 345,600 (4 days). </p> </li> <li> <p> <code>Policy</code> - The queue's policy. A valid AWS policy. For more information about policy structure, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/PoliciesOverview.html\\\">Overview of AWS IAM Policies</a> in the <i>Amazon IAM User Guide</i>. </p> </li> <li> <p> <code>ReceiveMessageWaitTimeSeconds</code> - The number of seconds for which a <a>ReceiveMessage</a> action will wait for a message to arrive. An integer from 0 to 20 (seconds). The default is 0. </p> </li> <li> <p> <code>RedrivePolicy</code> - The parameters for the dead letter queue functionality of the source queue. For more information about the redrive policy and dead letter queues, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSDeadLetterQueue.html\\\">Using Amazon SQS Dead Letter Queues</a> in the <i>Amazon SQS Developer Guide</i>. </p> <note> <p>The dead letter queue of a FIFO queue must also be a FIFO queue. Similarly, the dead letter queue of a standard queue must also be a standard queue.</p> </note> </li> <li> <p> <code>VisibilityTimeout</code> - The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default is 30. For more information about the visibility timeout, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html\\\">Visibility Timeout</a> in the <i>Amazon SQS Developer Guide</i>.</p> </li> </ul> <p>The following attribute applies only to <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html\\\">FIFO (first-in-first-out) queues</a>:</p> <ul> <li> <p> <code>ContentBasedDeduplication</code> - Enables content-based deduplication. For more information, see <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html#FIFO-queues-exactly-once-processing\\\">Exactly-Once Processing</a> in the <i>Amazon SQS Developer Guide</i>. </p> <ul> <li> <p>Every message must have a unique <code>MessageDeduplicationId</code>,</p> <ul> <li> <p>You may provide a <code>MessageDeduplicationId</code> explicitly.</p> </li> <li> <p>If you aren't able to provide a <code>MessageDeduplicationId</code> and you enable <code>ContentBasedDeduplication</code> for your queue, Amazon SQS uses a SHA-256 hash to generate the <code>MessageDeduplicationId</code> using the body of the message (but not the attributes of the message). </p> </li> <li> <p>If you don't provide a <code>MessageDeduplicationId</code> and the queue doesn't have <code>ContentBasedDeduplication</code> set, the action fails with an error.</p> </li> <li> <p>If the queue has <code>ContentBasedDeduplication</code> set, your <code>MessageDeduplicationId</code> overrides the generated one.</p> </li> </ul> </li> <li> <p>When <code>ContentBasedDeduplication</code> is in effect, messages with identical content sent within the deduplication interval are treated as duplicates and only one copy of the message is delivered.</p> </li> <li> <p>You can also use <code>ContentBasedDeduplication</code> for messages with identical content to be treated as duplicates.</p> </li> <li> <p>If you send one message with <code>ContentBasedDeduplication</code> enabled and then another message with a <code>MessageDeduplicationId</code> that is the same as the one generated for the first <code>MessageDeduplicationId</code>, the two messages are treated as duplicates and only one copy of the message is delivered. </p> </li> </ul> </li> </ul> <p>Any other valid special request parameters that are specified (such as <code>ApproximateNumberOfMessages</code>, <code>ApproximateNumberOfMessagesDelayed</code>, <code>ApproximateNumberOfMessagesNotVisible</code>, <code>CreatedTimestamp</code>, <code>LastModifiedTimestamp</code>, and <code>QueueArn</code>) will be ignored.</p>\",\
          \"locationName\":\"Attribute\"\
        }\
      },\
      \"documentation\":\"<p/>\"\
    },\
    \"String\":{\"type\":\"string\"},\
    \"StringList\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"String\",\
        \"locationName\":\"StringListValue\"\
      }\
    },\
    \"TooManyEntriesInBatchRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>Batch request contains more number of entries than permissible.</p>\",\
      \"error\":{\
        \"code\":\"AWS.SimpleQueueService.TooManyEntriesInBatchRequest\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"UnsupportedOperation\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>Error code 400. Unsupported operation.</p>\",\
      \"error\":{\
        \"code\":\"AWS.SimpleQueueService.UnsupportedOperation\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    }\
  },\
  \"documentation\":\"<p>Welcome to the <i>Amazon Simple Queue Service API Reference</i>. This section describes who should read this guide, how the guide is organized, and other resources related to the Amazon Simple Queue Service (Amazon SQS).</p> <p>Amazon SQS offers reliable and scalable hosted queues for storing messages as they travel between computers. By using Amazon SQS, you can move data between distributed components of your applications that perform different tasks without losing messages or requiring each component to be always available.</p> <p> <b>Topics</b> </p> <ul> <li> <p> </p> </li> <li> <p> </p> </li> <li> <p> <a>CommonParameters</a> </p> </li> <li> <p> <a>CommonErrors</a> </p> </li> </ul> <p> <b>Helpful Links</b> </p> <ul> <li> <p> <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/MakingRequestsArticle.html\\\">Making API Requests</a> </p> </li> <li> <p> <a href=\\\"http://aws.amazon.com/sqs/\\\">Amazon SQS product page</a> </p> </li> <li> <p> <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSMessageAttributes.html\\\">Using Amazon SQS Message Attributes</a> </p> </li> <li> <p> <a href=\\\"http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSDeadLetterQueue.html\\\">Using Amazon SQS Dead Letter Queues</a> </p> </li> <li> <p> <a href=\\\"http://docs.aws.amazon.com/general/latest/gr/rande.html#sqs_region\\\">Regions and Endpoints</a> </p> </li> </ul> <p>We also provide SDKs that enable you to access Amazon SQS from your preferred programming language. The SDKs contain functionality that automatically takes care of tasks such as:</p> <ul> <li> <p>Cryptographically signing your service requests</p> </li> <li> <p>Retrying requests</p> </li> <li> <p>Handling error responses</p> </li> </ul> <p>For a list of available SDKs, see <a href=\\\"http://aws.amazon.com/tools/\\\">Tools for Amazon Web Services</a>.</p>\"\
}";
}

@end
