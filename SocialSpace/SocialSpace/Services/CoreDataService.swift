//
//  CoreDataService.swift
//  SocialSpace
//
//  Created by Вадим Игнатенко on 17.03.25.
//

import UIKit
import CoreData

final class CoreDataService {
    
    static let shared = CoreDataService()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private init() {}
    
    func requetCoreData<T: AnyObject> (with request: NSFetchRequest<T> , completion: @escaping ([T]) -> ()) {
        do {
            var array = try context.fetch(request)
            completion(array)
        } catch {
            let error = error as NSError
            fatalError(" * \(#function) : \(error)")
        }
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            let error = error as NSError
            fatalError("-- ошибка метода \(#function) класса SecondVC: \(error)")
        }
    }
}
