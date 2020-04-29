//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

var phoneNumbersBySecondName = ["0937153423" : "Alex",
                                "0967489333" : "Viktor",
                                "0504657893" : "Anna"]
func addOrUpdateElement(dict: inout [String : String], key: String, value: String) {
    dict[key] = value              //добавить или изменить элемент
}

addOrUpdateElement(dict: &phoneNumbersBySecondName, key: "0667568401", value: "Olga")
print(phoneNumbersBySecondName)

//---------------------------------------------

func removeElement(dict: inout [String : String], key: String){   //удалить элемент
    dict.removeValue(forKey: key)                                 //часть 1
}
removeElement(dict: &phoneNumbersBySecondName, key: "0504657893")
print(phoneNumbersBySecondName)

func removeElementNew(dict: inout [String : String], key: String){  //удалить элемент
    if let removedValue = dict.removeValue(forKey: key) {           //часть 2
      print("Удаленное значение - \(removedValue).")
    } else {
      print("В словаре нет такого ключа")
    }
}

removeElementNew(dict: &phoneNumbersBySecondName, key: "0667568401")
removeElementNew(dict: &phoneNumbersBySecondName, key: "066756841")

//---------------------------------------------

func findElement(dict: [String : String], key: String) -> (String?){    //найти элемент по ключу
    return dict.first{$0.key == key}?.value
}

if let findedElement = findElement(dict: phoneNumbersBySecondName, key: "0967489333") {
    print("Значение по заданному ключу - \(findedElement)")
} else {
    print("Такого ключа не существует")
}

//----------------------------------------------

func printCountOfPairs(dict: [String : String]){    //распечатать количество пар
    print(dict.count)
}
printCountOfPairs(dict: phoneNumbersBySecondName)

//---------------------------------------------

func printAllKeys(dict: [String : String]){
    for key in dict.keys {                       //распечатать все ключи
        print(key)
    }
    for value in dict.values {                    //распечатать все значения
        print(value)
    }
}

printAllKeys(dict: phoneNumbersBySecondName)
