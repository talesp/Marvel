import Foundation

protocol PagedResource: Decodable {

    static func resource(for page: Int, pageSize: Int) -> Resource<DataWrapperResource<Self>>
    static func resource(nameStartingWith name: String) -> Resource<DataWrapperResource<Self>>
}
