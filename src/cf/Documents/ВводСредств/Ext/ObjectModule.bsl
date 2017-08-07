﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
    
#Область ОбработчикиСобытий
    
Процедура ОбработкаПроведения(Отказ, Режим)
    
    ДенежныеСредстваСервер.ДвиженияПоДенежнымСредствам(ЭтотОбъект, Отказ);
    
    ЗатратыСервер.ДвиженияПоЗатратам(ЭтотОбъект, Отказ);
    
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
    
    Если ДанныеЗаполнения = Неопределено Тогда
        ЗаполнениеДокументовСервер.ЗаполнитьШапкуДокумента(ЭтотОбъект);
    КонецЕсли; 
    
КонецПроцедуры
    
#КонецОбласти
    
#КонецЕсли