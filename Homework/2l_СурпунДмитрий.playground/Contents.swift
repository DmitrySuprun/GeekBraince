import UIKit

//1. Написать функцию, которая определяет, четное число или нет.
func checkForEvenNumber(_ input: Int) -> Bool {
    input % 2 == 0 ? true : false
}
var chekingNumber = Int.random(in: -10_000...10_000)
print("Checking number: \(chekingNumber) is enven - \(checkForEvenNumber(chekingNumber))")
print("-----------------------------------------")

//2. Написать функцию, которая определяет, делится ли число без остатка на 3.
func devisibleFor3 (_ input: Int) -> Bool {
    input % 3 == 0 ? true : false
}
print("Checking number: \(chekingNumber) is devisible for 3 - \(devisibleFor3(chekingNumber))")
print("-----------------------------------------")

//3. Создать возрастающий массив из 100 чисел.
// через цикл:
var ascendingArray100: [Int] = []
for i in 1...100 {
    ascendingArray100.append(i)
}
// и более элегантный способ
ascendingArray100 = Array(1...100)

print("Array of 100 ascending element: ", ascendingArray100)

//4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
for i in ascendingArray100 {
    if checkForEvenNumber(i) || !devisibleFor3(i) {
        ascendingArray100.remove(at: ascendingArray100.firstIndex(of: i)!)
    }
}
print("Array of ascending element whithout even and devisible for 3 element: ", ascendingArray100)
print("-----------------------------------------")

//5. Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов
var fibonacci: [Int] = []
func addFiboncciNumer (array: inout [Int]) {
    // Проверка на минимальное колличество элементов массива и добавление в массив
    if array.count == 0 {
        array.append(0)
    } else if array.count == 1 {
        array.append(array[0] + 1)
    } else {
        array.append(array[array.count - 1] + array[array.count - 2])
    }
}
let addCoutElement = 50
for _ in 1...addCoutElement {
    addFiboncciNumer(array: &fibonacci)
}
print("Fibonacci array: ", fibonacci)
print("-----------------------------------------")

//6. Заполнить массив элементов различными простыми числами.
// следуя методу Эратосфена

// создаем массив с возрастающими элементами

let countOfElement = 100
var arrayOfPrimeNumbers: [Int] = []
arrayOfPrimeNumbers.append(contentsOf: 2...(countOfElement + 1))

var primeNumber: Int
var i = 0
var j = 0
repeat {
    primeNumber = arrayOfPrimeNumbers[i]
    j = primeNumber
// удаляем все элементы кратные p
    while j < arrayOfPrimeNumbers.last! {
        if let i = arrayOfPrimeNumbers.firstIndex(of: j + primeNumber) {
            arrayOfPrimeNumbers.remove(at: i)
        }
        j += primeNumber
    }
    i += 1
} while i < arrayOfPrimeNumbers.count - 1

print("Array of prime element: ", arrayOfPrimeNumbers)
