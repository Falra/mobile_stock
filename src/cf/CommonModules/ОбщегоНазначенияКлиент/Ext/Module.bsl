﻿
#Область Заголовок
////////////////////////////////////////////////////////////////////////////////
// Клиентские процедуры и функции общего назначения:
#КонецОбласти

#Область ПрограммныйИнтерфейс
//Раздел содержит экспортные процедуры и функции, предназначенные
//для использования другими объектами конфигурации или другими программами (например, через
//внешнее соединение).
Процедура ОткрытьWebАдрес(WebАдрес) Экспорт 
    Если ЗначениеЗаполнено(WebАдрес) Тогда
        ОписаниеОповещения = Новый ОписаниеОповещения("ПустойОбработчикОповещения", ЭтотОбъект);
        НачатьЗапускПриложения(ОписаниеОповещения, WebАдрес); 
    КонецЕсли;     
КонецПроцедуры
#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс
//Раздел предназначен для модулей, которые являются
//частью некоторой функциональной подсистемы. В нем должны быть размещены экспортные процедуры
//и функции, которые допустимо вызывать только из других функциональных подсистем этой же
//библиотеки.
Процедура ПустойОбработчикОповещения(Рузультат, ДополнительныеПараметры) Экспорт 
    ПустойОбработчик = Истина;    
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
#КонецОбласти
 