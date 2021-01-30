# Keychain
  Store and retrieve data 

# How to use

  Store data 
 
    //save value in keychain (String)
    KeyChain.set(token, forKey: "token")
            
    //save value in keychain (Int)
    KeyChain.set(age, forKey: "age")
      
  Retrieve data 
 
    //retrieve value from keychain (String)
    KeyChain.get(forKey: "token", type: String.self)
            
    //retrieve value from keychain (Int)
    KeyChain.get(forKey: "age", type: Int.self)
            
  Delete data 
   
    //delete value from keychain
    KeyChain.delete(forKey: "age")
      
    //delete all values from keychain
    KeyChain.deleteAll()
