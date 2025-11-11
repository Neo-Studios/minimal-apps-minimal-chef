import Foundation

struct Cookbook: Codable, Identifiable {
    var id: String?
    let name: String
    let description: String?
    let recipeIds: [String]
    let userId: String
    let isPublic: Bool
    let coverImageUrl: String?
    let createdAt: Date
    let updatedAt: Date
    
    init(id: String? = nil, name: String, description: String? = nil, recipeIds: [String] = [], userId: String, isPublic: Bool = false, coverImageUrl: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.recipeIds = recipeIds
        self.userId = userId
        self.isPublic = isPublic
        self.coverImageUrl = coverImageUrl
        self.createdAt = Date()
        self.updatedAt = Date()
    }
    
    func toDict() -> [String: Any] {
        return [
            "name": name,
            "description": description as Any,
            "recipeIds": recipeIds,
            "userId": userId,
            "isPublic": isPublic,
            "coverImageUrl": coverImageUrl as Any,
            "createdAt": Timestamp(date: createdAt),
            "updatedAt": Timestamp(date: updatedAt)
        ]
    }
    
    static func fromDict(_ dict: [String: Any], id: String) -> Cookbook? {
        guard let name = dict["name"] as? String,
              let userId = dict["userId"] as? String else {
            return nil
        }
        
        return Cookbook(
            id: id,
            name: name,
            description: dict["description"] as? String,
            recipeIds: dict["recipeIds"] as? [String] ?? [],
            userId: userId,
            isPublic: dict["isPublic"] as? Bool ?? false,
            coverImageUrl: dict["coverImageUrl"] as? String
        )
    }
}
