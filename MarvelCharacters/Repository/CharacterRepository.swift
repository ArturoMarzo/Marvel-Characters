import UIKit

protocol CharacterRepository {
    func characters(offset: Int, withCompletion completion: @escaping (_ characters: CharactersDTO?, _ error: Error?) -> Void)
    func characterDetailWith(id: UInt, withCompletion completion: @escaping (_ character: CharacterDetailDTO?, _ error: Error?) -> Void)
}

final class CharacterRepositoryDefault: CharacterRepository {
    static let pageSize = 20
    
    func characters(offset: Int, withCompletion completion: @escaping (_ characters: CharactersDTO?, _ error: Error?) -> Void) {
        var parameters = ServerHostURL.authenticationParameters()
        parameters["limit"] = CharacterRepositoryDefault.pageSize
        parameters["offset"] = offset
        
        HTTPRequestService.request(url: ServerHostURL.charactersListURL(), httpMethod: .get, parameters: parameters, headers: nil, success: { (responseJSON, data) in
            // Deserialize the data
            if let characterResponseDAO = try? JSONDecoder().decode(CharactersListResponseDAO.self, from: data) {
                guard let results = characterResponseDAO.data?.results else {
                    completion(nil, HTTPRequestService.genericError())
                    return
                }
                
                let charactersDTO = CharactersDTO(charactersDAO: results, total: characterResponseDAO.data?.total)
                completion(charactersDTO, nil)
            } else {
                // Data retrieved can't be processed
                completion(nil, HTTPRequestService.genericError())
            }
        }) { (errorResponse) in
            completion(nil, errorResponse)
        }
    }
    
    func characterDetailWith(id: UInt, withCompletion completion: @escaping (_ character: CharacterDetailDTO?, _ error: Error?) -> Void) {
        let parameters = ServerHostURL.authenticationParameters()
        
        HTTPRequestService.request(url: ServerHostURL.characterDetailURL(id: id), httpMethod: .get, parameters: parameters, headers: nil, success: { (responseJSON, data) in
            // Deserialize the data
            if let characterDetailResponseDAO = try? JSONDecoder().decode(CharacterDetailResponseDAO.self, from: data) {
                guard let characterDetailDAO = characterDetailResponseDAO.data?.results?.first else {
                    completion(nil, HTTPRequestService.genericError())
                    return
                }
                
                let characterDetailDTO = CharacterDetailDTO(characterDetailDAO: characterDetailDAO)
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
