﻿
#Область Заголовок
// Модуль расчета и отражения затрат.
#КонецОбласти

#Область ПрограммныйИнтерфейс
//Раздел содержит экспортные процедуры и функции, предназначенные
//для использования другими объектами конфигурации или другими программами (например, через
//внешнее соединение).

// <Формирование движений по регистру Затраты>
//
// Параметры:
//  <Источник>  - <ДокументОбъект> - <документ который проводится по регистру затрат>
//  <Отказ>  - <Булево> - <признак отказа от формирования движений в случае ошибок>
//
Процедура ДвиженияПоЗатратам(Источник, Отказ) Экспорт
    
    Движения = Источник.Движения;
    Движения.Затраты.Записывать = Истина;
    // Затраты на приобритение 
    Если ТипЗнч(Источник) = Тип("ДокументОбъект.ПокупкаЦенныхБумаг") Тогда 
        Движение = Движения.Затраты.Добавить();
        ЗаполнитьЗначенияСвойств(Движение, Источник);
        Движение.Период     = Источник.Дата;
        Движение.ТипЗатрат  = Перечисления.ТипыЗатрат.ЗатратыНаПриобритение;
    КонецЕсли;

    // Комиссия
    Если Источник.Комиссия > 0 Тогда
        // регистр ОстаткиДенежныхСредств Расход 
        Движение = Движения.Затраты.Добавить();
        ЗаполнитьЗначенияСвойств(Движение, Источник);
        Движение.Период     = Источник.Дата;
        Движение.Сумма      = Источник.Комиссия;
        Движение.ТипЗатрат  = Перечисления.ТипыЗатрат.КомиссияБрокера;
        Движение.Сумма      = Источник.Комиссия;
    КонецЕсли;
    
КонецПроцедуры // ДвиженияПоЗатратам()
 
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
 