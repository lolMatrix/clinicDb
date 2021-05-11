USE Clinic;
-- 15 из функциональных требований
-- изменение лекарства
UPDATE Medicians SET Price = 20 WHERE Price <= 3;
-- Добавление заказа
INSERT INTO Treatment_to_Medician (Treatment_id, Medician_id, Count) VALUES (1, 1, 10);
-- изменение болезни 
UPDATE Diseases SET Name = 'имя болезни' WHERE Name = "Да";
-- Добавить болезнь
INSERT INTO Diseases (Name, Description) VALUES ('имя болезни', 'описание');
-- отчет по продажам 
SELECT SUM(Price) FROM Medicians 
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Medician_id = Medician.Id;

SELECT Medicians.Price, Medicians.Id, Medicians.Name, Receptions.Date_Reception FROM Medicians 
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Medician_id = Medicians.Id
    INNER JOIN Treatment ON Treatment.Id = Treatment_to_Medician.Treatment_id
    INNER JOIN Diseases ON Diseases.Id = Treatment.Disease_Id
    INNER JOIN Disease_To_Reception ON Diseases.Id = Disease_To_Reception.Disease_Id
    INNER JOIN Receptions ON Receptions.Id = Disease_To_Reception.Reception_Id
    where Receptions.Date_Reception >= '20200101';
-- Вычисление итоговой стоимости заказа
SELECT SUM(Price) FROM Medicians
    INNER JOIN Treatment_to_Medician ON Medicians.Id = Treatment_to_Medician.Medician_id
    WHERE Treatment_to_Medician.Treatment_id = 2;

-- Показ состояния приема
SELECT * FROM Receptions
    INNER JOIN States ON States.Id = Receptions.id_state
    WHERE Receptions.Date_Reception = '20011213';
--Показ лекарственных средств
SELECT * FROM Medicians;
--Подробная информация о болезни
SELECT * FROM Diseases
    INNER JOIN Treatment ON Treatment.Disease_Id = Diseases.Id
    WHERE Name = 'Орви';
--Запись на прием
INSERT INTO Receptions (Receptions.Emploer_Id, Receptions.Animal_Id, Receptions.Date_Reception, Receptions.[Description])
     VALUES (1, 1, '20210511', 'Все хорошо');

--Отмена приема
DELETE FROM Receptions
    WHERE Date_Reception = '20210511';

--Вычисление итоговой стоимости
SELECT Sum(Medicians.Price) FROM Medicians 
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Medician_id = Medicians.Id
    INNER JOIN Treatment ON Treatment.Id = Treatment_to_Medician.Treatment_id
    INNER JOIN Diseases ON Diseases.Id = Treatment.Disease_Id
    INNER JOIN Disease_To_Reception ON Diseases.Id = Disease_To_Reception.Disease_Id
    INNER JOIN Receptions ON Receptions.Id = Disease_To_Reception.Reception_Id
    where Receptions.Date_Reception = '20200101';

--Процент от продаж сотрудникам
SELECT Employers.Name, Positions.Name as [Position], sum(Medicians.Price) over(Partition By Employers.Id) * 0.1 as [Percent]    
    FROM Employers 
    INNER JOIN Receptions ON Receptions.Emploer_Id = Employers.Id
    INNER JOIN Disease_To_Reception ON Disease_To_Reception.Reception_Id = Receptions.Id
    INNER JOIN Treatment ON Treatment.Disease_Id = Disease_To_Reception.Disease_Id
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Treatment_id = Treatment.Id
    INNER JOIN Medicians ON Treatment_to_Medician.Medician_Id = Medicians.Id
    Inner Join Positions ON Positions.Id = Employers.Id;

--Статистика по заболеваниям 
SELECT Diseases.Name, COUNT(Diseases.Id) as [count]
    FROM Diseases 
    INNER JOIN Disease_To_Reception ON Disease_To_Reception.Disease_Id = Diseases.Id
    INNER JOIN Receptions ON Disease_To_Reception.Reception_Id = Receptions.Id
    WHERE Receptions.Date_Reception BETWEEN '20010101' and '20051231'
    GROUP BY Diseases.Name;
--UPDATE в разных таблицах, с WHERE, можно условно, например, изменить заранее созданные некорректные данные (5 шт.)
--DELETE в разных таблицах, с WHERE, можно условно, например, удалить заранее созданные некорректные данные (5 шт.)