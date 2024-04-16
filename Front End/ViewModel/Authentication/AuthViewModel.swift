import Foundation

class AuthViewModel: ObservableObject, Observable{
    @Published var currentUser: User?
    @Published var error: String?
    
    
    // This function will be called to perform the login operation.
    func login(email: String, password: String) async throws{
        let urlString = "http://35.246.81.166:8080/auth/login"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let loginDetails : [String: Any] = [
            "email" : email,
            "password" : password
        ]
        
        guard let httpBody = try?
                JSONSerialization.data(withJSONObject: loginDetails,
                                       options: []) else {
            print("Failed to serialize login data to JSON")
            throw NSError(domain: "Serialization Error", code: 0, userInfo: nil)
        }
        
        request.httpBody = httpBody
        
        do{
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                DispatchQueue.main.async{
                    self.error = "Could not find user"
                }
                throw NSError(domain: "Response Error", code: 0, userInfo: nil)
               
            }
            print("got data")
            if let jsonString = try JSONSerialization.jsonObject(with: data, options: []) as? [String : String] {
                do{
                    print("Trying to fetch user")
                    if let jwtToken = jsonString["jwt"]{
                        try await fetchUser(token: jwtToken)
                        print("fetched user")
                    }
                }catch{
                    throw error
                }
            }
        } catch {
            print("Error occurred while loggin in: \(error.localizedDescription)")
            throw error
        }
        
    }
        
     
    func fetchUser(token: String) async throws{
        print(token)
        guard let url = URL(string: "http://35.246.81.166:8080/auth/me") else {
            print("Invalid URL")
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let headers = [
            "content-type" : "application/json",
            "authorization" : "Bearer \(token)"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        
        
        do{
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else{
                print("Error with the response, unexpected status code: \(String(describing: response))")
                throw NSError(domain: "Response Error", code: 0, userInfo: nil)
            }
            
            do{
                print("trying to decode json resoonse")
                print("data:\(data)")
                let user = try JSONDecoder().decode(User.self, from: data) //FEIL HER
                print("User \(user)")
                DispatchQueue.main.async{
                    self.currentUser = user
                }
            }catch{
                print("AAAA MISTAKE")
                throw error
            }
        }
    }
    
    
        
        // Works but should be updated
    func logout() -> Bool{
        currentUser = nil
        if currentUser == nil{
            return true
        }else{
            return false
        }
    }
        
    func createUser(email: String, firstName: String, lastName: String, password: String, store: Store) async throws {
            let urlString = "http://35.246.81.166:8080/auth/register"
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let newUserDetails: [String: Any] = [
                "email": email,
                "firstName": firstName,
                "lastName": lastName,
                "password": password,
                "storeId": store.storeId
            ]
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: newUserDetails, options: []) else {
                print("Failed to serialize user data to JSON")
                throw NSError(domain: "Serialization Error", code: 0, userInfo: nil)
            }
            request.httpBody = httpBody
            
            do {
                let (_, response) = try await URLSession.shared.data(for: request)
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                    DispatchQueue.main.async{
                        self.error = "Unable to create user"
                    }
                    throw NSError(domain: "Response Error", code: 0, userInfo: nil)
                }
                
                DispatchQueue.main.async {
                    self.currentUser = User(email: email, firstName: firstName, lastName: lastName, store: Store(name: store.name, address: store.address, country: store.country, city: store.city, postalCode: store.postalCode, storeId: store.storeId))
                }
                
                
                do{
                    try await login(email: email, password: password)
                }catch{
                    throw error
                }
                
            } catch {
                print("Error occurred while creating user: \(error.localizedDescription)")
                throw error
            }
        }
    
    
    }

