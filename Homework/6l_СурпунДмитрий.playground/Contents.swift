import UIKit

// * Код реализован без обработки ошибок!!!

//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
//
//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.


// 1.
struct Queue<T: Equatable> {
    
    private var elements: [T] = []
// Добавляет елемент в конец очереди
    mutating func push (element: T) {
        elements.append(element)
    }
// Возвращает элемент из начала очереди и удаляет его
    mutating func poll () -> T? {
        elements.removeFirst()
    }
// Возвращает элемент из начала очереди, но не удаляет
    mutating func peek () -> T? {
        elements.first
    }
// Возвращает длину очереди
    mutating func count () -> Int {
        elements.count
    }
    
    
// 2.
// Фильтрация элементов
    mutating func filter (_ isIncluded: (T) -> Bool) -> Self {
        elements = elements.filter(isIncluded)
        return self
    }
// Сортировка элементов
    mutating func sorted (by: (T, T) -> Bool) -> Self {
        elements = elements.sorted(by: by)
        return self
    }
// Реверс
    mutating func reverse () -> Self {
        elements.reverse()
        return self
    }
    
// 3.
// Доступ к элементам очереди по их индексу // Расширенный функционал очереди, который изначально не предусматривается данной коллекцией
    subscript (index: Int) -> T? {
        get {
            if 0...(elements.count - 1) ~= index {
                return elements[index]
            } else {
                return nil
            }
        }
        set {
            elements[index] = newValue!
        }
    }
}

var queueExample = Queue<Int>()

// Заполняем очередь случайными числами
for _ in 0...24 {
    queueExample.push(element: Int.random(in: 0...10))
}
print("Начальный порядок в очереди из \(queueExample.count()) элементов:")
print(queueExample)
print("")
print("peek - возвращает первый элемент: \(queueExample.peek()!), количество элементов в очереди: \(queueExample.count())")
print(queueExample)
print("")
print("pool - возвращает первый элемент и удаляет его: \(queueExample.poll()!), количество элементов в очереди: \(queueExample.count())")
print(queueExample)
print("")
print("sorted - сортирует очередь в соответствие с переданным клоужером(замыканием):")
print(queueExample.sorted(by: >))
print("")
print("filter - фильтрует элементы в соответствие с переданным клоужером:")
// отфильтровать элементы попадающие в диапазон от 1 до 5
print(queueExample.filter {1...5 ~= $0})
// строчка выше может привести к удалению всех элементов очереди, что приведет к завершению программы, добавим один элемент
queueExample.push(element: 0)
print("")
print("Обращение к очереди по индексу")
print(queueExample[0]!)
queueExample[0] = 100
print(queueExample[0]!)
