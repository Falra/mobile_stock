﻿
#Область ОбработчикиСобытийФормы
//Раздел содержит процедурыобработчики событий формы:
//ПриСозданииНаСервере, ПриОткрытии и т.п.

&НаКлиенте
Процедура ПриОткрытии(Отказ)
    ЗаполнитьБалансовуюСтоимостьБумаг();
    ЗаполнитьОстаткиДенежныхСредств();
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
    ДатаОстатков = ТекущаяДата();
    ДатаОстатковДеньги = ТекущаяДата();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы
//Раздел содержит процедурыобработчики
//элементов, расположенных в основной части формы (все, что не связано с таблицами на форме).

&НаКлиенте
Процедура ДатаОстатковПриИзменении(Элемент)
    ЗаполнитьБалансовуюСтоимостьБумаг();
КонецПроцедуры

&НаКлиенте
Процедура ДатаОстатковДеньгиПриИзменении(Элемент)
     ЗаполнитьОстаткиДенежныхСредств();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы
//Раздел содержит процедурыобработчики команд формы (имена
//которых задаются в свойстве Действие команд формы).

&НаКлиенте
Процедура ОбновитьБалансовуюСтоимость(Команда)
    ЗаполнитьБалансовуюСтоимостьБумаг();    
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьОстаткиДенежныхСредств(Команда)
    ЗаполнитьОстаткиДенежныхСредств();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
//Раздел содержит процедуры и функции, составляющие
//внутреннюю реализацию общего модуля. В тех случаях, когда общий модуль является частью
//некоторой функциональной подсистемы, включающей в себя несколько объектов метаданных, в этом
//разделе также могут быть размещены служебные экспортные процедуры и функции,
//предназначенные только для вызова из других объектов данной подсистемы. 
//
//Для объемных общих модулей рекомендуется разбивать этот раздел на подразделы, по
//функциональному признаку.

&НаСервере
Процедура ЗаполнитьБалансовуюСтоимостьБумаг()
    Запрос = Новый Запрос;
    Запрос.Текст = 
    "ВЫБРАТЬ РАЗРЕШЕННЫЕ
    |   БалансоваяСтоимостьБумагОстатки.Бумага КАК Бумага,
    |   БалансоваяСтоимостьБумагОстатки.КоличествоОстаток КАК Количество,
    |   БалансоваяСтоимостьБумагОстатки.СуммаОстаток КАК БалансоваяСтоимость,
    |   БалансоваяСтоимостьБумагОстатки.КоличествоОстаток * ЕСТЬNULL(КотировкиЦенныхБумагСрезПоследних.Закрытие, 0) КАК РасчетнаяСтоимость
    |ИЗ
    |   РегистрНакопления.БалансоваяСтоимостьБумаг.Остатки(&ДатаОстатков, ) КАК БалансоваяСтоимостьБумагОстатки
    |       ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КотировкиЦенныхБумаг.СрезПоследних(&ДатаОстатков, ) КАК КотировкиЦенныхБумагСрезПоследних
    |       ПО БалансоваяСтоимостьБумагОстатки.ТорговаяПлощадка = КотировкиЦенныхБумагСрезПоследних.ТорговаяПлощадка
    |           И БалансоваяСтоимостьБумагОстатки.Бумага = КотировкиЦенныхБумагСрезПоследних.Бумага
    |           И (КотировкиЦенныхБумагСрезПоследних.ТипПериода = ЗНАЧЕНИЕ(Перечисление.ТипыПериода.ОдинДень))
    |
    |УПОРЯДОЧИТЬ ПО
    |   Бумага
    |АВТОУПОРЯДОЧИВАНИЕ";
    
    Запрос.УстановитьПараметр("ДатаОстатков", Новый Граница(КонецДня(ДатаОстатков), ВидГраницы.Включая));
    
    РезультатЗапроса = Запрос.Выполнить();
    
    ОстаткиБумаг.Загрузить(РезультатЗапроса.Выгрузить());  
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьОстаткиДенежныхСредств()
    Запрос = Новый Запрос;
    Запрос.Текст = 
    "ВЫБРАТЬ РАЗРЕШЕННЫЕ
    |   ОстаткиДенежныхСредствОстатки.Счет КАК Счет,
    |   ОстаткиДенежныхСредствОстатки.СуммаОстаток КАК Сумма
    |ИЗ
    |   РегистрНакопления.ОстаткиДенежныхСредств.Остатки(&ДатаОстатков, ) КАК ОстаткиДенежныхСредствОстатки
    |АВТОУПОРЯДОЧИВАНИЕ";
    
    Запрос.УстановитьПараметр("ДатаОстатков", Новый Граница(КонецДня(ДатаОстатковДеньги), ВидГраницы.Включая));
    
    РезультатЗапроса = Запрос.Выполнить();
    
    ОстаткиДенег.Загрузить(РезультатЗапроса.Выгрузить());  
КонецПроцедуры

#КонецОбласти
 
