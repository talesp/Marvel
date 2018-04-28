import Foundation

protocol PagedResource: Codable {

    var id: Int { get }
    static func resource(for page: Int) -> Resource<DataWrapperResource<Self>>
    static func search(with id: Int) -> Resource<Self>
    static func search(with text: String) -> Resource<Self>
}
