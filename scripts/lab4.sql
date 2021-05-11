USE Clinic;
-- 15 из функциональных требований
-- изменение лекарства
UPDATE Medicians SET Price = 20 WHERE Id = 1;
-- Добавление заказа
INSERT INTO Treatment_to_Medician (Treatment_id, Medician_id, Count) VALUES (1, 1, 10);
-- изменение болезни 
UPDATE Diseases SET Name = 'имя болезни' WHERE Id = 1;
-- Добавить болезнь
INSERT INTO Diseases (Name, Description) VALUES ('имя болезни', 'описание');
-- отчет по продажам 
SELECT SUM(Price) FROM Medicians 
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Medician_id = Medician.Id;
SELECT * FROM Medician 
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Medician_id = Medician.Id;
-- Вычисление итоговой стоимости заказа
SELECT SUM(Price) FROM Medicians
    INNER JOIN Treatment_to_Medician ON Medicians.Id = Treatment_to_Medician.Medician_id
    WHERE Treatment_to_Medician.Treatment_id = 2;
