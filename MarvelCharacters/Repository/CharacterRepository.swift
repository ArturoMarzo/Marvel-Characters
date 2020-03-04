import UIKit

protocol CharacterRepository {
    func characters(offset: Int, withCompletion completion: @escaping (_ characters: Characters?, _ error: Error?) -> Void)
    func characterDetailWith(id: UInt, withCompletion completion: @escaping (_ character: CharacterDetail?, _ error: Error?) -> Void)
}

final class CharacterRepositoryDefault: CharacterRepository {
    static let pageSize = 20
    
    func characters(offset: Int, withCompletion completion: @escaping (_ characters: Characters?, _ error: Error?) -> Void) {
        var parameters = ServerHostURL.authenticationParameters()
        parameters["limit"] = CharacterRepositoryDefault.pageSize
        parameters["offset"] = offset
        
        HTTPRequestService.request(url: ServerHostURL.charactersListURL(), httpMethod: .get, parameters: parameters, headers: nil, success: { (responseJSON, data) in
            // Deserialize the data
            if let characterResponseEntity = try? JSONDecoder().decode(CharactersListResponseEntity.self, from: data) {
                guard let results = characterResponseEntity.data?.results else {
                    completion(nil, HTTPRequestService.genericError())
                    return
                }
                
                let characters = Characters(charactersEntity: results, total: characterResponseEntity.data?.total)
                completion(characters, nil)
            } else {
                // Data retrieved can't be processed
                completion(nil, HTTPRequestService.genericError())
            }
        }) { (errorResponse) in
            completion(nil, errorResponse)
        }
    }
    
    func characterDetailWith(id: UInt, withCompletion completion: @escaping (_ character: CharacterDetail?, _ error: Error?) -> Void) {
        let parameters = ServerHostURL.authenticationParameters()
        
        HTTPRequestService.request(url: ServerHostURL.characterDetailURL(id: id), httpMethod: .get, parameters: parameters, headers: nil, success: { (responseJSON, data) in
            // Deserialize the data
            if let characterDetailResponseEntity = try? JSONDecoder().decode(CharacterDetailResponseEntity.self, from: data) {
                guard let characterDetailEntity = characterDetailResponseEntity.data?.results?.first else {
                    completion(nil, HTTPRequestService.genericError())
                    return
                }
                
                let characterDetailDTO = CharacterDetail(characterDetailEntity: characterDetailEntity)
                completion(characterDetailDTO, nil)
            } else {
                // Data retrieved can't be processed
                completion(nil, HTTPRequestService.genericError())
            }
        }) { (errorResponse) in
            completion(nil, errorResponse)
        }
    }
}
