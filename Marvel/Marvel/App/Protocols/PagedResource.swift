import Foundation

protocol PagedResource: Codable {
    static func resource(for page: Int) -> Resource<DataWrapperResource<Self>>
}
