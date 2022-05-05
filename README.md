# Ratio [tests] — тестовое задание

Тестовое задание на летнюю стажировку в VK Group, Почта iOS.

## Примечание

- `accessibityIdentifier` (как и множество acessibility-штукенций) в **SwiftUI** поддерживается только c iOS 14, поэтому для того, чтобы сделать тесты более «гибкими», Build Target пришлось повысить.

> **Георгий Александров**

> Репозиторий: [https://github.com/alxxndrv/Coffee-Ratio](https://github.com/alxxndrv/Coffee-Ratio)

> В приложении установлен test plan с английским языком для нормальной работы с клавиатурой.


# Тесты


- ### testCoffeeAmountInput


Просто проверяем два вычисления: 1 x 1 и 10 x 10.

- ### testMaxValues


Проверяем ввод и реакцию на максимальные значения в текстфилдах. Expected behaviour [см. ниже.](craftdocs://open?blockId=4D10E593-891D-4DED-B6F5-872275E85F22&spaceId=c876827f-6cce-f3cf-19f6-a73ad250c114)

- ### testInputsVisibility


Проверяем видимость textfieldов при их выборе в соответствии с [гайдлайнами](https://developer.apple.com/design/human-interface-guidelines/ios/user-interaction/keyboards/#:~:text=use%20the%20keyboard%20layout%20guide%20to%20make%20the%20keyboard%20feel%20like%20an%20integrated%20part%20of%20your%20interface).

- ### testKeyboardTypes


Проверяем, что у клавиатуры стоит именно тот тип.

*Пояснение: у клавиатуры, отвечающей за ввод **количества** воды, должен быть тип `numeric`, без букв. См. [гайдлайн](https://developer.apple.com/design/human-interface-guidelines/ios/user-interaction/keyboards/#:~:text=match%20the%20onscreen%20keyboard%20to%20the%20type%20of%20content%20people%20are%20editing.).*

- ### testTimerButtons


Проверяем работу таймера. Запускаем, кладем аппу в бг, заходим, ресеттаем.

- ### testStressfullyCalculations


Просто стресс-тестим подсчеты, вдруг кто-то прогулял математику.

## Предлагаемые изменения

- Стоит поставить ограничение на кол-во грамм, >= 1000 — не юзкейс
- Стоит поставить ограничение на пропорцию, >= 50 — не юзкейс


> При привышении указанных лимитов нужно показывать предупреждение с `accesibilityIdentifier` wrongCoffeeAmount и wrongRatio соответственно


Также, если введенный символ сделает число в textfield больше лимита, этот символ не должен вводится.
> Например, имеем текстовое поле с `coffeeAmount`. 

> Вводим 900. 

> Число меньше лимита. 

> Нажимаем 0 на клавиатуре.

> *9000 > 1000.*

> В текстовом поле остается 900.

- В соответствии с гайдлайнами, нужно чтобы выбранный текстфилд был виден всегда
- Нужно изменить тип клавиатур у texfields — они текстовые, нужны нумерические
