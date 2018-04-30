import Foundation

protocol PagedResource: Decodable {

    var identifier: Int32 { get }
    static func resource(for page: Int) -> Resource<DataWrapperResource<Self>>
    static func search(with id: Int) -> Resource<Self>
    static func search(with text: String) -> Resource<Self>
}
