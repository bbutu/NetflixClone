//
//  DataPersistenceManager.swift
//  Netflix Clone
//
//  Created by Beka Buturishvili on 18.11.22.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(model: Title, completion: @escaping(Result<Void,Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let item = TitleItem(context: context)
        
        item.original_title = model.original_title
        item.overview = model.overview
        item.id = Int64(model.id ?? 0)
        item.poster_path = model.poster_path
        item.media_type = model.media_type
        item.original_language = model.original_language
        item.release_date = model.release_date
        item.vote_avarage = model.vote_avarage ?? 0.0
        item.vote_count = Int64(model.vote_count ?? 0)
        
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    func fetchingTitlesFromDatabase(completion: @escaping(Result<[TitleItem],Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
       
        let request: NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        }catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    func deleteTitleWith(model: TitleItem, completion: @escaping(Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        }catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
}
