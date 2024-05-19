import Foundation

/**
 Viewmodel for handeling user authentication and creation
 */
class AuthViewModel: ObservableObject, Observable{
    @Published var currentUser: User?
    @Published var error: String = ""
    
    /**
     Validates the email wit regular expression
     Parameter email (String) to validate
     Returns true or false (Bool)
     */
    func validateEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    /**
     Validates the password with regular expression
     Parameter password (String) to validate
     Returns true or false (Bool)
     */
    func validatePassword(password: String) -> Bool {
        let passwordRegex = "(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    /**
     Validates name based on length
     Parameter name (String) to validate
     Returns true or false (Bool)
     */
    func validateName(name: String) -> Bool {
        return !name.isEmpty && name.count >= 2
    }
    
    
    /**
     Log in a user
     Parameter email (String) and password (String)
     Throws error if unsuccessfull
     */
    func login(email: String, password: String) async throws{
        
        //Create and validate URL
        guard let url = URL(string: "http://35.246.81.166:8080/auth/login") else {
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
        
        // Serializes loginDetails to JSON
        guard let httpBody = try?
                JSONSerialization.data(withJSONObject: loginDetails,
                                       options: []) else {
            print("Failed to serialize login data to JSON")
            throw NSError(domain: "Serialization Error", code: 0, userInfo: nil)
        }
        
        //Sets the requestbody
        request.httpBody = httpBody
        
        do{
            //Tries to log in user
            let (data, response) = try await URLSession.shared.data(for: request)
            //Validatee the response code
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                DispatchQueue.main.async{
                    self.error = "Could not find user"
                }
                throw NSError(domain: "Response Error", code: 0, userInfo: nil)
                
            }
            // Tries to decode JSON
            if let jsonString = try JSONSerialization.jsonObject(with: data, options: []) as? [String : String] {
                do{
                    if let jwtToken = jsonString["jwt"]{
                        //Save token in keychainManager
                        try KeychainManager.shared.saveToken(jwtToken, for: email)
                        //Fetch user
                        try await fetchUser(email: email)
                    }
                }catch{
                    DispatchQueue.main.async {
                        self.error = "Failed to save token or fetch user details"
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.error = "Failed to parse login response or token missing"
                }
            }
        } catch {
            print("Error occurred while loggin in: \(error.localizedDescription)")
            throw error
        }
        
    }
    
    /**
     Tries to fetch a user
     Paramterer email (String), email of the user to fetch
     */
    func fetchUser(email: String) async throws {
        print("Fetching user for email: \(email)")
        
        // Retrieve the token from Keychain
        let token: String
        do {
            token = try KeychainManager.shared.loadToken(for: email)
        } catch {
            print("Failed to retrieve token: \(error)")
            DispatchQueue.main.async {
                self.error = "Authentication error: Unable to retrieve token"
            }
            throw NSError(domain: "Token Retrieval Error", code: 0, userInfo: nil)
        }
        
        // Prepare the URL and request
        guard let url = URL(string: "http://35.246.81.166:8080/auth/me") else {
            print("Invalid URL")
            DispatchQueue.main.async {
                self.error = "Network error: Invalid URL"
            }
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        // Perform the network request
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            // Checks Http response
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Failed to cast response to HTTPURLResponse")
                DispatchQueue.main.async {
                    self.error = "Network error: Invalid response type"
                }
                throw NSError(domain: "Response Error", code: 0, userInfo: nil)
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                do {
                    // Tries to Decode
                    let user = try JSONDecoder().decode(User.self, from: data)
                    DispatchQueue.main.async {
                        self.currentUser = user
                    }
                } catch {
                    print("Error decoding JSON response: \(error)")
                    DispatchQueue.main.async {
                        self.error = "Data error: Error decoding user data"
                    }
                    throw error
                }
            } else {
                print("Error with the response, unexpected status code: \(httpResponse.statusCode)")
                DispatchQueue.main.async {
                    self.error = "Network error: HTTP status code \(httpResponse.statusCode)"
                }
                throw NSError(domain: "Response Error", code: httpResponse.statusCode, userInfo: nil)
            }
        } catch {
            print("Network request failed: \(error)")
            DispatchQueue.main.async {
                self.error = "Network error: \(error.localizedDescription)"
            }
            throw error
        }
    }
    
    /**
     Get and return token of current user
     */
    func getToken() -> String? {
        guard let email = currentUser?.email else {
            print("No current user")
            return nil
        }
        do {
            return try KeychainManager.shared.loadToken(for: email)
        } catch {
            DispatchQueue.main.async {
                print("Did not get loadtoken")
                self.error = "Failed to retrieve token"
            }
            return nil
        }
    }
    
    
    
    /**
     Log out a user
     Parameter email (String), user to log out
     Returns true or false (Bool) wether the user was logged out or not
     */
    func logout(email: String) -> Bool {
        do {
            // Tries to delete token from keychain
            try KeychainManager.shared.deleteToken(for: email)
            
            /**
             Removes user on main thread
             */
            DispatchQueue.main.async {
                self.currentUser = nil
            }
            
            return true
        } catch {
            
            DispatchQueue.main.async {
                self.error = "Failed to delete token"
            }
            
            return false
        }
    }
    
    /**
     Creates a new user
     Parameter email (String), firstname (String), lastname (String), password (String) and store (Store)
     */
    func createUser(email: String, firstName: String, lastName: String, password: String, store: Store) async throws {
       
        // Create and validate URL
        guard let url = URL(string: "http://35.246.81.166:8080/auth/register") else {
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
        
        //Sets the http body
        request.httpBody = httpBody
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            
            //Checks http response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                DispatchQueue.main.async{
                    self.error = "Unable to create user"
                }
                throw NSError(domain: "Response Error", code: 0, userInfo: nil)
            }
            
            // Sets current user to the newly created user on the main thread
            DispatchQueue.main.async {
                self.currentUser = User(email: email, firstName: firstName, lastName: lastName, store: Store(name: store.name, address: store.address, country: store.country, city: store.city, postalCode: store.postalCode, storeId: store.storeId))
            }
            
            do{
                //After succesasfusll creation of user the user is logged in
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

