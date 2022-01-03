//
//  main.swift
//  GeekBraince
//
//  Created by Дмитрий Супрун on 6.12.21.
//

import Foundation
// Решить квадратное уравнение
// Quadratic equation solution
// Генерируем рандомные целочисленные коэффициенты, приводим к типу Double для простоты дальнейших вычислений

var a: Double = Double(Int.random(in: -10...10))
// Приведение к квадратному уравнение (если а == 0, то уравнение линейное)
if a == 0 {a = 1}

let b: Double = Double(Int.random(in: -10...10))
let c: Double = Double(Int.random(in: -10...10))

// выводим на печать уравнение с использованием интерполяции и конкатенации строк, вставкой юникод символа надстрочная двойка
// тернарный оператор используем для добавления знака + на печать если коэффициент не отрицательный
let equation: String = "\(a)x\u{00B2}\(b < 0 ? "\(b)x" : "+\(b)x")\(c < 0 ? "\(c)" : "+\(c)") = 0"
print("Equation: " + equation )

// Решаем уравнение, выводим результаты в консоль

let discriminant: Double = Double(b * b - 4 * a * c)
let x1 = (-b + sqrt(discriminant) / 2 * a)
let x2 = (-b - sqrt(discriminant) / 2 * a)
if discriminant < 0 {
    print("Equation has no roots\n")
    } else if discriminant == 0 {
        print("Equation has one root \(round(x1 * 100) / 100)")
    } else {
        print("Equation has two root. First root: \(round(x1 * 100) / 100)")
        print("Equation has one root. Second root: \(round(x2 * 100) / 100)\n")
}

// Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.
// Генерируем рандомные целочисленные значения

let cathetus1: Double = Double(Int.random(in: 1...10))
let cathetus2: Double = Double(Int.random(in: 1...10))

// Площадь треугольника
let square: Double = (cathetus1 * cathetus2) / 2
// Гипотенуза
let hipotenuse: Double = sqrt(cathetus1 * cathetus1 + cathetus2 * cathetus2)
// Периметр
let perimetr: Double = cathetus1 + cathetus2 + hipotenuse

// Печатаем результат
print("Катет 1: \(cathetus1)\nКатет 2: \(cathetus2)\nГипотенуза: \(round(hipotenuse * 100) / 100)\nПлощадь: \(square)\nПериметр: \(round(perimetr * 100) / 100)")

// Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.
// Генерируем рандомные значения вклада и процентов, на печать выводим округленное до сотых число

var money: Double = Double.random(in: 100...100_000)
let percent: Double = Double.random(in: 1...25)
print("Начальная сумма вклада: ", round(money * 100) / 100)
print("Процентная ставка: ", round(percent * 100) / 100)
// Период 5 лет по 12 месяцев

let period: Int = 12 * 5

// Расчет дохода с ежемесячной капитализацией

for _ in 1...period {
    money += money * percent / (12 * 100)
}

print("Сумма вклада составит:", round(money * 100) / 100)
