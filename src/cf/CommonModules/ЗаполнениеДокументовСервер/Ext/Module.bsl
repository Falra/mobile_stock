﻿
#Область Заголовок
////////////////////////////////////////////////////////////////////////////////
// Серверные процедуры и функции заполнения документов:
#КонецОбласти

#Область ПрограммныйИнтерфейс

//Раздел содержит экспортные процедуры и функции, предназначенные
//для использования другими объектами конфигурации или другими программами (например, через
//внешнее соединение).
Процедура ЗаполнитьШапкуДокумента(Объект) Экспорт 
    //Заполнение реквизитов докуммента
    //TODO Торговая площадка, Брокер
    #Если НИКОГДА Тогда
        Объект = Документы.ВводСредств.СоздатьДокумент();    
    #КонецЕсли    
    МетаданныеДокумента = Объект.Ссылка.Метаданные();
    // ТорговаяПлощадка
    Если МетаданныеДокумента.Реквизиты.Найти("ТорговаяПлощадка") <> Неопределено Тогда
        Объект.ТорговаяПлощадка = ОбщегоНазначенияСерверПовтИсп.ТорговаяПлощадка();
    КонецЕсли;
    // Брокер
    Если МетаданныеДокумента.Реквизиты.Найти("Брокер") <> Неопределено Тогда
        Объект.Брокер = ОбщегоНазначенияСерверПовтИсп.Брокер();
    КонецЕсли;
    // Счет
    Если МетаданныеДокумента.Реквизиты.Найти("Счет") <> Неопределено Тогда
        Объект.Счет = ОбщегоНазначенияСерверПовтИсп.Счет();
    КонецЕсли;
КонецПроцедуры

Функция РасчетПоРеквизитам(РеквизитыРасчета, ВидРасчета)Экспорт
    Если ВидРасчета = "РасчетЦены" Тогда
        Возврат ?(РеквизитыРасчета.Количество = 0, 0, РеквизитыРасчета.Сумма/РеквизитыРасчета.Количество);    
    ИначеЕсли ВидРасчета = "РасчетСуммы" Тогда
        Возврат РеквизитыРасчета.Цена * РеквизитыРасчета.Количество;   
    ИначеЕсли ВидРасчета = "РасчетКомиссии" Тогда
        Запрос = Новый Запрос;
        Запрос.Текст = 
        "ВЫБРАТЬ РАЗРЕШЕННЫЕ
        |   ЕСТЬNULL(КомиссияБрокераСрезПоследних.ПроцентКомиссии, 0) КАК ПроцентКомиссии
        |ИЗ
        |   РегистрСведений.КомиссияБрокера.СрезПоследних(
        |           &Дата,
        |           ТорговаяПлощадка = &ТорговаяПлощадка
        |               И Брокер = &Брокер
        |               И ВидБумаг = &ВидБумаг) КАК КомиссияБрокераСрезПоследних";
        Запрос.УстановитьПараметр("Дата", РеквизитыРасчета.ДатаСреза);
        Запрос.УстановитьПараметр("ТорговаяПлощадка", РеквизитыРасчета.ТорговаяПлощадка);
        Запрос.УстановитьПараметр("Брокер", РеквизитыРасчета.Брокер);
        Запрос.УстановитьПараметр("ВидБумаг", РеквизитыРасчета.Бумага.Вид);
        РезультатЗапроса = Запрос.Выполнить();
        Если НЕ РезультатЗапроса.Пустой() Тогда
            Выборка = РезультатЗапроса.Выбрать();
            Если Выборка.Следующий() Тогда
                Возврат РеквизитыРасчета.Сумма * Выборка.ПроцентКомиссии / 100; 
            КонецЕсли; 
        Иначе    
            Возврат 0;
        КонецЕсли;       
    КонецЕсли; 
КонецФункции // РасчетПоРеквизитам()
#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс
//Раздел предназначен для модулей, которые являются
//частью некоторой функциональной подсистемы. В нем должны быть размещены экспортные процедуры
//и функции, которые допустимо вызывать только из других функциональных подсистем этой же
//библиотеки.
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
#КонецОбласти
