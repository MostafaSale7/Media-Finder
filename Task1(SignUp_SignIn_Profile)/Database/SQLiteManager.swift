//
//  SQLiteManager.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 7/5/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//
import Foundation
import SQLite
class SQLiteManager {
    
   private static let sharedInstance = SQLiteManager()
    
    var database:Connection!
    let userTable = Table("Users")
    let id = Expression<Int>("ID")
    let userName = Expression<String>("UserName")
    let email = Expression<String>("E-mail")
    let password = Expression<String>("Password")
    let phoneNumber = Expression<String>("PhoneNumber")
    let address = Expression<String>("Address")
    let gender = Expression<String>("Gender")
    let profileImage = Expression<String>("Image")
    
    
    //searchMovies
    let searchResultTable = Table("LastSearchResults")
    let artworkUrl100 = Expression<String>("artworkUrl100")
    let artistName = Expression<String>("artistName")
    let trackName = Expression<String>("E-trackName")
    let longDescription = Expression<String>("longDescription")
    let previewUrl = Expression<String>("previewUrl")

    
    
   public static func getSharedInstance() -> SQLiteManager {
        return SQLiteManager.sharedInstance
    }
    
   public func setUpConnection() {
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("Users5").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
            print("The Connection has been Started to Database")
        }
        catch{
            print(error,"While Connecting to the Database")
            
        }
    }
   public func creatTable() {
        let createTable =  self.userTable.create{ (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.userName)
            table.column(self.email, unique: true)
            table.column(self.password)
            table.column(self.phoneNumber)
            table.column(self.address)
            table.column(self.gender)
            table.column(self.profileImage)
         }
    
         do{
            try self.database.run(createTable)
            print("Table has been Created")
         }
         catch{
            print(error,"While Creating Table in the database")
        }
    }
    
    
    
    public func convertImageToString(image:UIImage) -> String {
        let imageData:NSData = image.pngData()! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        return strBase64
    }
    public func insertRecord(user:User) {
        
        let insertUser = self.userTable.insert(self.userName <- user.userName, self.email <- user.email, self.password <- user.password, self.phoneNumber <- user.phoneNumber, self.address <- user.address, self.gender <- user.gender, self.profileImage <- user.imageString!)
        do {
            try self.database.run(insertUser)
            print("User has been Inserted")
        } catch {
             print(error,"While Inserting Record in the database")
        }
    }
    
 
    
    public func selectAllRecords()-> Int {
        do {
            let users = try self.database.prepare(self.userTable)
            var count = 0
            for user in users {
                print("User-ID: \(user[self.id]), User-Name: \(user[self.userName]), E-mail: \(user[self.email]), Password: \(user[self.password]), Phone-Number: \(user[self.phoneNumber]), Address: \(user[self.address]), Gender: \(user[self.gender]), Profile-Iamge: \(user[self.profileImage])")
                count+=1
            }
            return count
        }
        catch {
             print(error,"While Retriving all Records in the database")
        }
        return 0 
    }
    
    public func selectSpecificRecord(id:Int) -> Row? {
        do {
            let users = try self.database.prepare(self.userTable)
            for user in users {
                if user[self.id] == id {
                    return user
                }
            }
        }
        catch {
            print(error,"While Retriving Specific Record in the database")
        }
        return nil
    }

    public func updateRecord(id:Int, Name:String, email:String, password:String, phoneNumber:String, address:String, gender:String, profileImage:String) {
            let user = self.userTable.filter(self.id == id)
            let updateUser = user.update(self.userName <- userName, self.email <- email, self.password <- password, self.phoneNumber <- phoneNumber, self.address <- address, self.gender <- gender, self.profileImage <- profileImage)
            do {
                try self.database.run(updateUser)
                print("Record has been Successfully Updated")
            }
            catch{
                 print(error,"While Updating Record in the database")
            }
        }
    
    public func deleteRecord(id:Int) {
            let user = self.userTable.filter(self.id == id)
            let deleteUser = user.delete()
            do {
                try self.database.run(deleteUser)
                print("The Recprd has been Succsessfully Deleated")
            }
            catch{
                 print(error,"While Deleting Record in the database")
            }
        }
    public func checkIfTheGivenEmailIsUniqueOrNot(email:String) -> Bool {
        do {
            let users = try self.database.prepare(self.userTable)
            for user in users {
                if user[self.email].isEqual(email){
                    return false
                }
            }
        }
        catch {
            print(error,"While Checking if the Given E-mail is Unique or not")
        }
        return true
    }
    
    public func getUserData(email:String) -> Row?  {
        do {
            let users = try self.database.prepare(self.userTable)
            for user in users {
                if user[self.email].isEqual(email){
                    return user
                }
            }
        }
        catch {
            print(error,"While Checking if the Given E-mail is Unique or not")
        }
        return nil
    }
    
    
    public func creatLastResultTable() {
        let createTable =  self.searchResultTable.create{ (table) in
            table.column(self.artworkUrl100)
            table.column(self.artistName)
            table.column(self.trackName)
            table.column(self.longDescription)
            table.column(self.previewUrl)
        }
        do{
            try self.database.run(createTable)
            print("Last Search Result Table has been Created")
        }
        catch{
            print(error,"While Creating Last Search Result Table in the database")
        }
    }
    
    public func insertLastSearchResultsRecords(media:Media) {
        let insertUser = self.searchResultTable.insert(self.artworkUrl100 <- media.artworkUrl100 ?? "", self.artistName <- media.artistName ?? "", self.trackName <- media.trackName ?? "", self.longDescription <- media.longDescription ?? "", self.previewUrl <- media.previewUrl ?? "")
        do {
            try self.database.run(insertUser)
            print("search Result has been Inserted")
        } catch {
            print(error,"While inserting Last Search Results Record in the database")
        }
    }
    
    public func updateLastSearchResultsRecords(media:Media) {
        let insertUser = self.searchResultTable.update(self.artworkUrl100 <- media.artworkUrl100 ?? "", self.artistName <- media.artistName ?? "", self.trackName <- media.trackName ?? "", self.longDescription <- media.longDescription ?? "", self.previewUrl <- media.previewUrl ?? "")
        do {
            try self.database.run(insertUser)
            print("search Result has been Inserted")
        } catch {
            print(error,"While inserting Last Search Results Record in the database")
        }
    }
    
    public func deleteRecord() {
        let deleteAllLastSearchResults = self.searchResultTable.delete()
        do {
            try self.database.run(deleteAllLastSearchResults)
            print(" all last search Records has been Succsessfully Deleated")
        }
        catch{
            print(error,"While Deleting last search result Record in the database")
        }
    }
    
    public func selectLsatSearchHistoryRecords() -> ([Media]?,Int?) {
        var mediaNode:Media
        var mediaArray:[Media] = []
        do {
            let searchResults = try self.database.prepare(self.searchResultTable)
            for searchResult in searchResults {
                mediaNode = Media()
                mediaNode.artworkUrl100 = searchResult[self.artworkUrl100]
                mediaNode.artistName = searchResult[self.artistName]
                mediaNode.trackName = searchResult[self.trackName]
                mediaNode.longDescription = searchResult[self.longDescription]
                mediaNode.previewUrl = searchResult[self.previewUrl]
               mediaArray.append(mediaNode)
            }
            return (mediaArray, mediaArray.count)
        }
        catch {
            print(error,"While Retriving all Records in the database")
        }
         return (nil, 0)
    }
}

