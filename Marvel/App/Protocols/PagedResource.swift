import Foundation

protocol PagedResource: Decodable {

    var identifier: Int32 { get }
    static func resource(for page: Int) -> Resource<DataWrapperResource<Self>>
    static func resource(nameStartingWith name: String) -> Resource<DataWrapperResource<Self>>
}
