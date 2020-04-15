//
//  Copyright (c) 2020 Open Whisper Systems. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class OWSStorage;
@class SDSAnyWriteTransaction;
@class SSKProtoEnvelope;

@interface IncomingGroupsV2MessageJob : BaseModel

@property (nonatomic, readonly) NSDate *createdAt;
@property (nonatomic, readonly) NSData *envelopeData;
@property (nonatomic, readonly, nullable) NSData *plaintextData;
@property (nonatomic, readonly) BOOL wasReceivedByUD;
@property (nonatomic, readonly, nullable) NSData *groupId;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)coder NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithUniqueId:(NSString *)uniqueId NS_UNAVAILABLE;
- (instancetype)initWithGrdbId:(int64_t)grdbId uniqueId:(NSString *)uniqueId NS_UNAVAILABLE;

- (instancetype)initWithEnvelopeData:(NSData *)envelopeData
                       plaintextData:(NSData *_Nullable)plaintextData
                             groupId:(NSData *_Nullable)groupId
                     wasReceivedByUD:(BOOL)wasReceivedByUD NS_DESIGNATED_INITIALIZER;

// --- CODE GENERATION MARKER

// This snippet is generated by /Scripts/sds_codegen/sds_generate.py. Do not manually edit it, instead run
// `sds_codegen.sh`.

// clang-format off

- (instancetype)initWithGrdbId:(int64_t)grdbId
                      uniqueId:(NSString *)uniqueId
                       createdAt:(NSDate *)createdAt
                    envelopeData:(NSData *)envelopeData
                         groupId:(nullable NSData *)groupId
                   plaintextData:(nullable NSData *)plaintextData
                 wasReceivedByUD:(BOOL)wasReceivedByUD
NS_DESIGNATED_INITIALIZER NS_SWIFT_NAME(init(grdbId:uniqueId:createdAt:envelopeData:groupId:plaintextData:wasReceivedByUD:));

// clang-format on

// --- CODE GENERATION MARKER

@property (nonatomic, readonly, nullable) SSKProtoEnvelope *envelope;

@end

NS_ASSUME_NONNULL_END
