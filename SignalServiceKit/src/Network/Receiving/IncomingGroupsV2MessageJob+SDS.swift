//
//  Copyright (c) 2020 Open Whisper Systems. All rights reserved.
//

import Foundation
import GRDB
import SignalCoreKit

// NOTE: This file is generated by /Scripts/sds_codegen/sds_generate.py.
// Do not manually edit it, instead run `sds_codegen.sh`.

// MARK: - Record

public struct IncomingGroupsV2MessageJobRecord: SDSRecord {
    public weak var delegate: SDSRecordDelegate?

    public var tableMetadata: SDSTableMetadata {
        return IncomingGroupsV2MessageJobSerializer.table
    }

    public static let databaseTableName: String = IncomingGroupsV2MessageJobSerializer.table.tableName

    public var id: Int64?

    // This defines all of the columns used in the table
    // where this model (and any subclasses) are persisted.
    public let recordType: SDSRecordType
    public let uniqueId: String

    // Properties
    public let createdAt: Double
    public let envelopeData: Data
    public let plaintextData: Data?
    public let wasReceivedByUD: Bool
    public let groupId: Data?

    public enum CodingKeys: String, CodingKey, ColumnExpression, CaseIterable {
        case id
        case recordType
        case uniqueId
        case createdAt
        case envelopeData
        case plaintextData
        case wasReceivedByUD
        case groupId
    }

    public static func columnName(_ column: IncomingGroupsV2MessageJobRecord.CodingKeys, fullyQualified: Bool = false) -> String {
        return fullyQualified ? "\(databaseTableName).\(column.rawValue)" : column.rawValue
    }

    public func didInsert(with rowID: Int64, for column: String?) {
        guard let delegate = delegate else {
            owsFailDebug("Missing delegate.")
            return
        }
        delegate.updateRowId(rowID)
    }
}

// MARK: - Row Initializer

public extension IncomingGroupsV2MessageJobRecord {
    static var databaseSelection: [SQLSelectable] {
        return CodingKeys.allCases
    }

    init(row: Row) {
        id = row[0]
        recordType = row[1]
        uniqueId = row[2]
        createdAt = row[3]
        envelopeData = row[4]
        plaintextData = row[5]
        wasReceivedByUD = row[6]
        groupId = row[7]
    }
}

// MARK: - StringInterpolation

public extension String.StringInterpolation {
    mutating func appendInterpolation(incomingGroupsV2MessageJobColumn column: IncomingGroupsV2MessageJobRecord.CodingKeys) {
        appendLiteral(IncomingGroupsV2MessageJobRecord.columnName(column))
    }
    mutating func appendInterpolation(incomingGroupsV2MessageJobColumnFullyQualified column: IncomingGroupsV2MessageJobRecord.CodingKeys) {
        appendLiteral(IncomingGroupsV2MessageJobRecord.columnName(column, fullyQualified: true))
    }
}

// MARK: - Deserialization

// TODO: Rework metadata to not include, for example, columns, column indices.
extension IncomingGroupsV2MessageJob {
    // This method defines how to deserialize a model, given a
    // database row.  The recordType column is used to determine
    // the corresponding model class.
    class func fromRecord(_ record: IncomingGroupsV2MessageJobRecord) throws -> IncomingGroupsV2MessageJob {

        guard let recordId = record.id else {
            throw SDSError.invalidValue
        }

        switch record.recordType {
        case .incomingGroupsV2MessageJob:

            let uniqueId: String = record.uniqueId
            let createdAtInterval: Double = record.createdAt
            let createdAt: Date = SDSDeserialization.requiredDoubleAsDate(createdAtInterval, name: "createdAt")
            let envelopeData: Data = record.envelopeData
            let groupId: Data? = SDSDeserialization.optionalData(record.groupId, name: "groupId")
            let plaintextData: Data? = SDSDeserialization.optionalData(record.plaintextData, name: "plaintextData")
            let wasReceivedByUD: Bool = record.wasReceivedByUD

            return IncomingGroupsV2MessageJob(grdbId: recordId,
                                              uniqueId: uniqueId,
                                              createdAt: createdAt,
                                              envelopeData: envelopeData,
                                              groupId: groupId,
                                              plaintextData: plaintextData,
                                              wasReceivedByUD: wasReceivedByUD)

        default:
            owsFailDebug("Unexpected record type: \(record.recordType)")
            throw SDSError.invalidValue
        }
    }
}

// MARK: - SDSModel

extension IncomingGroupsV2MessageJob: SDSModel {
    public var serializer: SDSSerializer {
        // Any subclass can be cast to it's superclass,
        // so the order of this switch statement matters.
        // We need to do a "depth first" search by type.
        switch self {
        default:
            return IncomingGroupsV2MessageJobSerializer(model: self)
        }
    }

    public func asRecord() throws -> SDSRecord {
        return try serializer.asRecord()
    }

    public var sdsTableName: String {
        return IncomingGroupsV2MessageJobRecord.databaseTableName
    }

    public static var table: SDSTableMetadata {
        return IncomingGroupsV2MessageJobSerializer.table
    }
}

// MARK: - Table Metadata

extension IncomingGroupsV2MessageJobSerializer {

    // This defines all of the columns used in the table
    // where this model (and any subclasses) are persisted.
    static let idColumn = SDSColumnMetadata(columnName: "id", columnType: .primaryKey)
    static let recordTypeColumn = SDSColumnMetadata(columnName: "recordType", columnType: .int64)
    static let uniqueIdColumn = SDSColumnMetadata(columnName: "uniqueId", columnType: .unicodeString, isUnique: true)
    // Properties
    static let createdAtColumn = SDSColumnMetadata(columnName: "createdAt", columnType: .double)
    static let envelopeDataColumn = SDSColumnMetadata(columnName: "envelopeData", columnType: .blob)
    static let plaintextDataColumn = SDSColumnMetadata(columnName: "plaintextData", columnType: .blob, isOptional: true)
    static let wasReceivedByUDColumn = SDSColumnMetadata(columnName: "wasReceivedByUD", columnType: .int)
    static let groupIdColumn = SDSColumnMetadata(columnName: "groupId", columnType: .blob, isOptional: true)

    // TODO: We should decide on a naming convention for
    //       tables that store models.
    public static let table = SDSTableMetadata(collection: IncomingGroupsV2MessageJob.collection(),
                                               tableName: "model_IncomingGroupsV2MessageJob",
                                               columns: [
        idColumn,
        recordTypeColumn,
        uniqueIdColumn,
        createdAtColumn,
        envelopeDataColumn,
        plaintextDataColumn,
        wasReceivedByUDColumn,
        groupIdColumn
        ])
}

// MARK: - Save/Remove/Update

@objc
public extension IncomingGroupsV2MessageJob {
    func anyInsert(transaction: SDSAnyWriteTransaction) {
        sdsSave(saveMode: .insert, transaction: transaction)
    }

    // Avoid this method whenever feasible.
    //
    // If the record has previously been saved, this method does an overwriting
    // update of the corresponding row, otherwise if it's a new record, this
    // method inserts a new row.
    //
    // For performance, when possible, you should explicitly specify whether
    // you are inserting or updating rather than calling this method.
    func anyUpsert(transaction: SDSAnyWriteTransaction) {
        let isInserting: Bool
        if IncomingGroupsV2MessageJob.anyFetch(uniqueId: uniqueId, transaction: transaction) != nil {
            isInserting = false
        } else {
            isInserting = true
        }
        sdsSave(saveMode: isInserting ? .insert : .update, transaction: transaction)
    }

    // This method is used by "updateWith..." methods.
    //
    // This model may be updated from many threads. We don't want to save
    // our local copy (this instance) since it may be out of date.  We also
    // want to avoid re-saving a model that has been deleted.  Therefore, we
    // use "updateWith..." methods to:
    //
    // a) Update a property of this instance.
    // b) If a copy of this model exists in the database, load an up-to-date copy,
    //    and update and save that copy.
    // b) If a copy of this model _DOES NOT_ exist in the database, do _NOT_ save
    //    this local instance.
    //
    // After "updateWith...":
    //
    // a) Any copy of this model in the database will have been updated.
    // b) The local property on this instance will always have been updated.
    // c) Other properties on this instance may be out of date.
    //
    // All mutable properties of this class have been made read-only to
    // prevent accidentally modifying them directly.
    //
    // This isn't a perfect arrangement, but in practice this will prevent
    // data loss and will resolve all known issues.
    func anyUpdate(transaction: SDSAnyWriteTransaction, block: (IncomingGroupsV2MessageJob) -> Void) {

        block(self)

        guard let dbCopy = type(of: self).anyFetch(uniqueId: uniqueId,
                                                   transaction: transaction) else {
            return
        }

        // Don't apply the block twice to the same instance.
        // It's at least unnecessary and actually wrong for some blocks.
        // e.g. `block: { $0 in $0.someField++ }`
        if dbCopy !== self {
            block(dbCopy)
        }

        dbCopy.sdsSave(saveMode: .update, transaction: transaction)
    }

    // This method is an alternative to `anyUpdate(transaction:block:)` methods.
    //
    // We should generally use `anyUpdate` to ensure we're not unintentionally
    // clobbering other columns in the database when another concurrent update
    // has occured.
    //
    // There are cases when this doesn't make sense, e.g. when  we know we've
    // just loaded the model in the same transaction. In those cases it is
    // safe and faster to do a "overwriting" update
    func anyOverwritingUpdate(transaction: SDSAnyWriteTransaction) {
        sdsSave(saveMode: .update, transaction: transaction)
    }

    func anyRemove(transaction: SDSAnyWriteTransaction) {
        sdsRemove(transaction: transaction)
    }

    func anyReload(transaction: SDSAnyReadTransaction) {
        anyReload(transaction: transaction, ignoreMissing: false)
    }

    func anyReload(transaction: SDSAnyReadTransaction, ignoreMissing: Bool) {
        guard let latestVersion = type(of: self).anyFetch(uniqueId: uniqueId, transaction: transaction) else {
            if !ignoreMissing {
                owsFailDebug("`latest` was unexpectedly nil")
            }
            return
        }

        setValuesForKeys(latestVersion.dictionaryValue)
    }
}

// MARK: - IncomingGroupsV2MessageJobCursor

@objc
public class IncomingGroupsV2MessageJobCursor: NSObject {
    private let cursor: RecordCursor<IncomingGroupsV2MessageJobRecord>?

    init(cursor: RecordCursor<IncomingGroupsV2MessageJobRecord>?) {
        self.cursor = cursor
    }

    public func next() throws -> IncomingGroupsV2MessageJob? {
        guard let cursor = cursor else {
            return nil
        }
        guard let record = try cursor.next() else {
            return nil
        }
        return try IncomingGroupsV2MessageJob.fromRecord(record)
    }

    public func all() throws -> [IncomingGroupsV2MessageJob] {
        var result = [IncomingGroupsV2MessageJob]()
        while true {
            guard let model = try next() else {
                break
            }
            result.append(model)
        }
        return result
    }
}

// MARK: - Obj-C Fetch

// TODO: We may eventually want to define some combination of:
//
// * fetchCursor, fetchOne, fetchAll, etc. (ala GRDB)
// * Optional "where clause" parameters for filtering.
// * Async flavors with completions.
//
// TODO: I've defined flavors that take a read transaction.
//       Or we might take a "connection" if we end up having that class.
@objc
public extension IncomingGroupsV2MessageJob {
    class func grdbFetchCursor(transaction: GRDBReadTransaction) -> IncomingGroupsV2MessageJobCursor {
        let database = transaction.database
        do {
            let cursor = try IncomingGroupsV2MessageJobRecord.fetchCursor(database)
            return IncomingGroupsV2MessageJobCursor(cursor: cursor)
        } catch {
            owsFailDebug("Read failed: \(error)")
            return IncomingGroupsV2MessageJobCursor(cursor: nil)
        }
    }

    // Fetches a single model by "unique id".
    class func anyFetch(uniqueId: String,
                        transaction: SDSAnyReadTransaction) -> IncomingGroupsV2MessageJob? {
        assert(uniqueId.count > 0)

        switch transaction.readTransaction {
        case .yapRead(let ydbTransaction):
            return IncomingGroupsV2MessageJob.ydb_fetch(uniqueId: uniqueId, transaction: ydbTransaction)
        case .grdbRead(let grdbTransaction):
            let sql = "SELECT * FROM \(IncomingGroupsV2MessageJobRecord.databaseTableName) WHERE \(incomingGroupsV2MessageJobColumn: .uniqueId) = ?"
            return grdbFetchOne(sql: sql, arguments: [uniqueId], transaction: grdbTransaction)
        }
    }

    // Traverses all records.
    // Records are not visited in any particular order.
    class func anyEnumerate(transaction: SDSAnyReadTransaction,
                            block: @escaping (IncomingGroupsV2MessageJob, UnsafeMutablePointer<ObjCBool>) -> Void) {
        anyEnumerate(transaction: transaction, batched: false, block: block)
    }

    // Traverses all records.
    // Records are not visited in any particular order.
    class func anyEnumerate(transaction: SDSAnyReadTransaction,
                            batched: Bool = false,
                            block: @escaping (IncomingGroupsV2MessageJob, UnsafeMutablePointer<ObjCBool>) -> Void) {
        let batchSize = batched ? Batching.kDefaultBatchSize : 0
        anyEnumerate(transaction: transaction, batchSize: batchSize, block: block)
    }

    // Traverses all records.
    // Records are not visited in any particular order.
    //
    // If batchSize > 0, the enumeration is performed in autoreleased batches.
    class func anyEnumerate(transaction: SDSAnyReadTransaction,
                            batchSize: UInt,
                            block: @escaping (IncomingGroupsV2MessageJob, UnsafeMutablePointer<ObjCBool>) -> Void) {
        switch transaction.readTransaction {
        case .yapRead(let ydbTransaction):
            IncomingGroupsV2MessageJob.ydb_enumerateCollectionObjects(with: ydbTransaction) { (object, stop) in
                guard let value = object as? IncomingGroupsV2MessageJob else {
                    owsFailDebug("unexpected object: \(type(of: object))")
                    return
                }
                block(value, stop)
            }
        case .grdbRead(let grdbTransaction):
            do {
                let cursor = IncomingGroupsV2MessageJob.grdbFetchCursor(transaction: grdbTransaction)
                try Batching.loop(batchSize: batchSize,
                                  loopBlock: { stop in
                                      guard let value = try cursor.next() else {
                                        stop.pointee = true
                                        return
                                      }
                                      block(value, stop)
                })
            } catch let error {
                owsFailDebug("Couldn't fetch models: \(error)")
            }
        }
    }

    // Traverses all records' unique ids.
    // Records are not visited in any particular order.
    class func anyEnumerateUniqueIds(transaction: SDSAnyReadTransaction,
                                     block: @escaping (String, UnsafeMutablePointer<ObjCBool>) -> Void) {
        anyEnumerateUniqueIds(transaction: transaction, batched: false, block: block)
    }

    // Traverses all records' unique ids.
    // Records are not visited in any particular order.
    class func anyEnumerateUniqueIds(transaction: SDSAnyReadTransaction,
                                     batched: Bool = false,
                                     block: @escaping (String, UnsafeMutablePointer<ObjCBool>) -> Void) {
        let batchSize = batched ? Batching.kDefaultBatchSize : 0
        anyEnumerateUniqueIds(transaction: transaction, batchSize: batchSize, block: block)
    }

    // Traverses all records' unique ids.
    // Records are not visited in any particular order.
    //
    // If batchSize > 0, the enumeration is performed in autoreleased batches.
    class func anyEnumerateUniqueIds(transaction: SDSAnyReadTransaction,
                                     batchSize: UInt,
                                     block: @escaping (String, UnsafeMutablePointer<ObjCBool>) -> Void) {
        switch transaction.readTransaction {
        case .yapRead(let ydbTransaction):
            ydbTransaction.enumerateKeys(inCollection: IncomingGroupsV2MessageJob.collection()) { (uniqueId, stop) in
                block(uniqueId, stop)
            }
        case .grdbRead(let grdbTransaction):
            grdbEnumerateUniqueIds(transaction: grdbTransaction,
                                   sql: """
                    SELECT \(incomingGroupsV2MessageJobColumn: .uniqueId)
                    FROM \(IncomingGroupsV2MessageJobRecord.databaseTableName)
                """,
                batchSize: batchSize,
                block: block)
        }
    }

    // Does not order the results.
    class func anyFetchAll(transaction: SDSAnyReadTransaction) -> [IncomingGroupsV2MessageJob] {
        var result = [IncomingGroupsV2MessageJob]()
        anyEnumerate(transaction: transaction) { (model, _) in
            result.append(model)
        }
        return result
    }

    // Does not order the results.
    class func anyAllUniqueIds(transaction: SDSAnyReadTransaction) -> [String] {
        var result = [String]()
        anyEnumerateUniqueIds(transaction: transaction) { (uniqueId, _) in
            result.append(uniqueId)
        }
        return result
    }

    class func anyCount(transaction: SDSAnyReadTransaction) -> UInt {
        switch transaction.readTransaction {
        case .yapRead(let ydbTransaction):
            return ydbTransaction.numberOfKeys(inCollection: IncomingGroupsV2MessageJob.collection())
        case .grdbRead(let grdbTransaction):
            return IncomingGroupsV2MessageJobRecord.ows_fetchCount(grdbTransaction.database)
        }
    }

    // WARNING: Do not use this method for any models which do cleanup
    //          in their anyWillRemove(), anyDidRemove() methods.
    class func anyRemoveAllWithoutInstantation(transaction: SDSAnyWriteTransaction) {
        switch transaction.writeTransaction {
        case .yapWrite(let ydbTransaction):
            ydbTransaction.removeAllObjects(inCollection: IncomingGroupsV2MessageJob.collection())
        case .grdbWrite(let grdbTransaction):
            do {
                try IncomingGroupsV2MessageJobRecord.deleteAll(grdbTransaction.database)
            } catch {
                owsFailDebug("deleteAll() failed: \(error)")
            }
        }

        if shouldBeIndexedForFTS {
            FullTextSearchFinder.allModelsWereRemoved(collection: collection(), transaction: transaction)
        }
    }

    class func anyRemoveAllWithInstantation(transaction: SDSAnyWriteTransaction) {
        // To avoid mutationDuringEnumerationException, we need
        // to remove the instances outside the enumeration.
        let uniqueIds = anyAllUniqueIds(transaction: transaction)

        var index: Int = 0
        do {
            try Batching.loop(batchSize: Batching.kDefaultBatchSize,
                              loopBlock: { stop in
                                  guard index < uniqueIds.count else {
                                    stop.pointee = true
                                    return
                                  }
                                  let uniqueId = uniqueIds[index]
                                  index = index + 1
                                  guard let instance = anyFetch(uniqueId: uniqueId, transaction: transaction) else {
                                      owsFailDebug("Missing instance.")
                                      return
                                  }
                                  instance.anyRemove(transaction: transaction)
            })
        } catch {
            owsFailDebug("Error: \(error)")
        }

        if shouldBeIndexedForFTS {
            FullTextSearchFinder.allModelsWereRemoved(collection: collection(), transaction: transaction)
        }
    }

    class func anyExists(uniqueId: String,
                        transaction: SDSAnyReadTransaction) -> Bool {
        assert(uniqueId.count > 0)

        switch transaction.readTransaction {
        case .yapRead(let ydbTransaction):
            return ydbTransaction.hasObject(forKey: uniqueId, inCollection: IncomingGroupsV2MessageJob.collection())
        case .grdbRead(let grdbTransaction):
            let sql = "SELECT EXISTS ( SELECT 1 FROM \(IncomingGroupsV2MessageJobRecord.databaseTableName) WHERE \(incomingGroupsV2MessageJobColumn: .uniqueId) = ? )"
            let arguments: StatementArguments = [uniqueId]
            return try! Bool.fetchOne(grdbTransaction.database, sql: sql, arguments: arguments) ?? false
        }
    }
}

// MARK: - Swift Fetch

public extension IncomingGroupsV2MessageJob {
    class func grdbFetchCursor(sql: String,
                               arguments: StatementArguments = StatementArguments(),
                               transaction: GRDBReadTransaction) -> IncomingGroupsV2MessageJobCursor {
        do {
            let sqlRequest = SQLRequest<Void>(sql: sql, arguments: arguments, cached: true)
            let cursor = try IncomingGroupsV2MessageJobRecord.fetchCursor(transaction.database, sqlRequest)
            return IncomingGroupsV2MessageJobCursor(cursor: cursor)
        } catch {
            Logger.error("sql: \(sql)")
            owsFailDebug("Read failed: \(error)")
            return IncomingGroupsV2MessageJobCursor(cursor: nil)
        }
    }

    class func grdbFetchOne(sql: String,
                            arguments: StatementArguments = StatementArguments(),
                            transaction: GRDBReadTransaction) -> IncomingGroupsV2MessageJob? {
        assert(sql.count > 0)

        do {
            let sqlRequest = SQLRequest<Void>(sql: sql, arguments: arguments, cached: true)
            guard let record = try IncomingGroupsV2MessageJobRecord.fetchOne(transaction.database, sqlRequest) else {
                return nil
            }

            return try IncomingGroupsV2MessageJob.fromRecord(record)
        } catch {
            owsFailDebug("error: \(error)")
            return nil
        }
    }
}

// MARK: - SDSSerializer

// The SDSSerializer protocol specifies how to insert and update the
// row that corresponds to this model.
class IncomingGroupsV2MessageJobSerializer: SDSSerializer {

    private let model: IncomingGroupsV2MessageJob
    public required init(model: IncomingGroupsV2MessageJob) {
        self.model = model
    }

    // MARK: - Record

    func asRecord() throws -> SDSRecord {
        let id: Int64? = model.grdbId?.int64Value

        let recordType: SDSRecordType = .incomingGroupsV2MessageJob
        let uniqueId: String = model.uniqueId

        // Properties
        let createdAt: Double = archiveDate(model.createdAt)
        let envelopeData: Data = model.envelopeData
        let plaintextData: Data? = model.plaintextData
        let wasReceivedByUD: Bool = model.wasReceivedByUD
        let groupId: Data? = model.groupId

        return IncomingGroupsV2MessageJobRecord(delegate: model, id: id, recordType: recordType, uniqueId: uniqueId, createdAt: createdAt, envelopeData: envelopeData, plaintextData: plaintextData, wasReceivedByUD: wasReceivedByUD, groupId: groupId)
    }
}
