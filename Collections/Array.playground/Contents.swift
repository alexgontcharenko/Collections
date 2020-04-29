//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

var arrayOfStudents = ["Ivanov", "Semenov", "Sidorov", "Antonov", "Kulikov"]
func addElement(add: String) {       //добавление элемента
    arrayOfStudents.append(add)         // часть 1
}
addElement(add: "Semerenko")
print(arrayOfStudents)




func addNewElement(array: inout [String], add: String) {    //добавление элемента
    array.append(add)                                           //часть 2
}

addNewElement(array: &arrayOfStudents, add: "Viktorov")
print(arrayOfStudents)

//------------------------------------------------------------

func removeElement(array: [String], index: Int) -> ([String]){    //удаление элемента
    var newArrayOfStudents = array
    if index < newArrayOfStudents.count {
    newArrayOfStudents.remove(at: index)
    }
    return newArrayOfStudents
}
arrayOfStudents = removeElement(array: arrayOfStudents, index: 4)
print(arrayOfStudents)

//-------------------------------------------------------------

func findElement(array: [String], find: String) -> (String?){      //поиск элемента
    return array.first {$0 == find}
}
var noname = "Viktorov"
if let nameFind = findElement(array: arrayOfStudents, find: noname) {
    print("\(nameFind) есть в нашем массиве")
} else {
    print("\(noname) отсуствует в массиве")
}

//------------------------------------------------------------

func printAllElements(array: [String]){               //распечатать все элементы массива
    array.forEach {print($0)}                         //часть 1
}
printAllElements(array: arrayOfStudents)



func printAllElementsFor(array: [String]){           //распечатать все элементы массива
    for value in array {                             //часть 2
        print(value)
    }
}

printAllElementsFor(array: arrayOfStudents)

//------------------------------------------------------------

func printOneElementByIndex(array: [String], index: Int){   //распечатать один элемент по индексу
    if index < array.count {
        print(array[index])
    } else {
        print("Элемента по такому индексу не существует")
    }
}

printOneElementByIndex(array: arrayOfStudents, index: 3)
printOneElementByIndex(array: arrayOfStudents, index: 6)

//-------------------------------------------------------------

func printCountOfStudents(array: [String]) {                 //распечатать число студентов
    print("Массив содержит \(array.count) студентов")
}

printCountOfStudents(array: arrayOfStudents)

//-------------------------------------------------------------

func filterByLenght(array: [String], lenght: Int) -> ([String]){  //фильтр по длине значений
    return array.filter {$0.count < lenght}
}

let filteredArray = filterByLenght(array: arrayOfStudents, lenght: 8)
print(filteredArray)

//-------------------------------------------------------------

func sortByDesc(array: [String]) -> ([String]){     //сортировка по убыванию
    return array.sorted(by: <)
}

var sortedArray = sortByDesc(array: arrayOfStudents)
print(sortedArray)
