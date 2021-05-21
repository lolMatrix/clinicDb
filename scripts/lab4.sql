USE Clinic;
-- 15 из функциональных требований
--1 изменение лекарства
UPDATE Medicians SET Price = 20 WHERE Price <= 3;
--2 Добавление заказа
INSERT INTO Treatment_to_Medician (Treatment_id, Medician_id, Count) VALUES (1, 1, 10);
--3 изменение болезни 
UPDATE Diseases SET Name = 'имя болезни' WHERE Name = 'Да';
--4 Добавить болезнь
INSERT INTO Diseases (Name, Description) VALUES ('имя болезни', 'описание');
--5 отчет по продажам 
SELECT SUM(Price) FROM Medicians 
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Medician_id = Medicians.Id;

--6
SELECT Medicians.Price, Medicians.Id, Medicians.Name, Receptions.Date_Reception FROM Medicians 
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Medician_id = Medicians.Id
    INNER JOIN Treatment ON Treatment.Id = Treatment_to_Medician.Treatment_id
    INNER JOIN Diseases ON Diseases.Id = Treatment.Disease_Id
    INNER JOIN Disease_To_Reception ON Diseases.Id = Disease_To_Reception.Disease_Id
    INNER JOIN Receptions ON Receptions.Id = Disease_To_Reception.Reception_Id
    where Receptions.Date_Reception >= '20200101';
--7 Вычисление итоговой стоимости заказа
SELECT SUM(Price) FROM Medicians
    INNER JOIN Treatment_to_Medician ON Medicians.Id = Treatment_to_Medician.Medician_id
    WHERE Treatment_to_Medician.Treatment_id = 2;

--8 Показ состояния приема
SELECT * FROM Receptions
    INNER JOIN States ON States.Id = Receptions.id_state
    WHERE Receptions.Date_Reception <= '20011213';
--9 Показ лекарственных средств
SELECT * FROM Medicians;
--10 Подробная информация о болезни
SELECT * FROM Diseases
    INNER JOIN Treatment ON Treatment.Disease_Id = Diseases.Id
    WHERE Name = 'Орви';
--11 Запись на прием
INSERT INTO Receptions (Receptions.Emploer_Id, Receptions.Animal_Id, Receptions.Date_Reception, Receptions.[Description])
     VALUES (1, 1, '20210511', 'Все хорошо');

--12 Отмена приема
DELETE FROM Receptions
    WHERE Date_Reception = '20210511';

--13 Вычисление итоговой стоимости
SELECT Sum(Medicians.Price) FROM Medicians 
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Medician_id = Medicians.Id
    INNER JOIN Treatment ON Treatment.Id = Treatment_to_Medician.Treatment_id
    INNER JOIN Diseases ON Diseases.Id = Treatment.Disease_Id
    INNER JOIN Disease_To_Reception ON Diseases.Id = Disease_To_Reception.Disease_Id
    INNER JOIN Receptions ON Receptions.Id = Disease_To_Reception.Reception_Id
    where Receptions.Date_Reception <= '20200101';

--14 Процент от продаж сотрудникам
SELECT Employers.Name, Positions.Name as [Position], sum(Medicians.Price) over(Partition By Employers.Id) * 0.1 as [Percent]    
    FROM Employers 
    INNER JOIN Receptions ON Receptions.Emploer_Id = Employers.Id
    INNER JOIN Disease_To_Reception ON Disease_To_Reception.Reception_Id = Receptions.Id
    INNER JOIN Treatment ON Treatment.Disease_Id = Disease_To_Reception.Disease_Id
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Treatment_id = Treatment.Id
    INNER JOIN Medicians ON Treatment_to_Medician.Medician_Id = Medicians.Id
    Inner Join Positions ON Positions.Id = Employers.Id;

--15 Статистика по заболеваниям 
SELECT Diseases.Name, COUNT(Diseases.Id) as [count]
    FROM Diseases 
    INNER JOIN Disease_To_Reception ON Disease_To_Reception.Disease_Id = Diseases.Id
    INNER JOIN Receptions ON Disease_To_Reception.Reception_Id = Receptions.Id
    WHERE Receptions.Date_Reception BETWEEN '20010101' and '20051231'
    GROUP BY Diseases.Name;
-- 16 Периименовать всех животных с именем Джек
UPDATE Animal 
    SET Name = 'Добрый чел, позитивный'
    WHERE Name = 'Джек';
--17 Переименовать все филиалы с названием Спартановка
UPDATE Branches 
    SET Name = 'Нижний тагил'
    WHERE Name = 'Спартановка';
--18 Изменить стоимость на все препараты с Именем Да
UPDATE Medicians 
    SET Name = 'Да'
    WHERE Price = '20';
--19 Переименовать все Должности с именем Чумной доктор
UPDATE Positions 
    SET Name = 'Врач'
    WHERE Name = 'Чумной доктор';
--20 Переименовать все состояния с названием Удовлетворительное
UPDATE States 
    SET Name = 'Что'
    WHERE Name = 'Удовлетворительное';
      
--21 Удалить все приемы которые произошли 11 мая 2021 года
DELETE FROM Receptions
    WHERE Date_Reception = '20210511';
--22 Удалить все лечения с описанием Кашель
DELETE FROM Treatment
    WHERE [Description] = 'Кашель';
--23 удалить всех пользователь у которых др 13 12 2001
DELETE FROM Users
    WHERE Birthday >= '20011213';
--24 Удалить все заболевания с названием да
DELETE FROM Diseases
    WHERE Name = 'Да';
--25 Удалить все позиции с названием чумной доктор
DELETE FROM Positions
    WHERE Name = 'Чумной доктор';

---26 Вывести все имена работников через запятую
SELECT string_agg(Name, ',') as [name] FROM Employers;
---27 вывести первые 3 имени
SELECT top(3) [Name] FROM Employers;
--28 Вывести количество повторяющихся имен и эти же имена
SELECT COUNT(Name) as [count],  [Name] FROM Employers
    GROUP BY Name;

---29 вывести уникальные имена
SELECT DISTINCT Name from Employers;
--30 вывести количество уникальных состояний
SELECT count(Distinct Name) as [count of uneqiuls states] FROM States;    
--31 Вывести все приемы, которые не повторялись
Select Description FROM Receptions
    WHERE Reception_Id IS NULL;
--32 вывести все приемы у которых состояние плохое или удовлетворительное
SELECT * FROM Receptions 
    INNER JOIN States ON id_state = States.Id
    WHERE States.Name IN ('Плохое', 'Удовлетворительное')
--33 вывести все приемы которые произошли в 2001 году
SELECT * FROM Receptions 
    INNER JOIN States ON id_state = States.Id
    WHERE Date_Reception BETWEEN '20010101' AND '20011231';
--34 вывести все препораты у которых срок годности больше 10 или меньше 5
SELECT * from Medicians
    WHERE Shelf_life > 10 or Shelf_life < 5;

--34 вывести все препораты у которых срок годности в промежутке от 10 до 30
SELECT * from Medicians
    WHERE Shelf_life > 10 and Shelf_life < 30;
--35 вывести имена и количество повторений этих имен
SELECT DISTINCT Name, COUNT(Name) AS [Count repeats] FROM Employers
    GROUP BY Name;
--36 вывсти все филиалы с именами спартановка ворошиловский и городище
SELECT * FROM Branches
    WHERE Name IN ('Спартановка', 'Ворошиловский', 'Городище');
--37 вывести все приемы с 2018 года
SELECT * FROM Receptions 
    WHERE Date_Reception > '20180101'
--38 вывести все приемы с повторными приемами 
SELECT * FROM Receptions 
    WHERE Reception_Id is not null;
--39 вывести имена работников и количество приемов ими обслужанных 
SELECT Name as [nAmE], COUNT(Name) as [count nAmE] FROM Employers
    INNER JOIN Receptions ON Receptions.Emploer_Id = Employers.Id
    GROUP BY Name
    Order by [count nAmE] Desc;
-- 40 вывести имена работников и количество приемов ими обслужанных у которых приемов не меньше 2 
SELECT Name as [nAmE], COUNT(Name) as [count nAmE] FROM Employers
    INNER JOIN Receptions ON Receptions.Emploer_Id = Employers.Id
    GROUP BY Name
    HAVING count(Name) >= 2
    Order by [count nAmE] Desc;

--41 вывести все препараты срок годности которых в пределе от 20 до 100 дней
SELECT * FROM Medicians
    WHERE Shelf_life BETWEEN 20 and 100;
-- 42 вывести все заболевание с именем миша или процессор
SELECT * FROM Diseases 
    WHERE Name IN ('Процессор', 'Миша');
--43 вывести все породы и количество жывотных с этими породами у которых кол-во животных не меньше 2
SELECT Breeds.Name AS [Breed], COUNT(Breeds.Name) AS [Count Breeds] FROM Breeds
    INNER JOIN Animal ON Breeds.Id = Animal.Breed_Id
    GROUP BY Breeds.Name
    HAVING COUNT(Breeds.Name) >= 2;
--44 вывести все препораты с названиями 'Спутник г', 'Глицин'
SELECT * FROM Medicians
    WHERE Name IN ('Спутник г', 'Глицин');

---45 вывести все приемы в которых не меньше 3 пробелов
SELECT * FROM Receptions
    WHERE [Description] LIKE '% % % %';
--46 вывести всех работников имя которых начинается на А
SELECT * FROM Employers
    WHERE Name LIKE 'А%';
--47 вывести все имена работников в верхнем регистре
SELECT UPPER(Name) as [bugurt name] FROM Employers;
--48 вывести все имена пользователей в нижнем регистре
SELECT LOWER(Name) AS [puk puk name] FROM Users;
--49 вывести все имена и длинны имен животных
SELECT Name, LEN(Name) as [lenght of name] FROM Animal
    GROUP BY Name;

---50 создать таблицу с именами животных и названиями их пород
SELECT Animal.Name as [Animal Name], Breeds.Name 
    Into Animals_With_Breads
    FROM Animal
    INNER JOIN Breeds ON Breeds.Id = Animal.Breed_Id;
--51 создать таблицу с полным описанием названием и ценой лекарств
Select Medicians.Name, Medicians.Price, Treatment.[Description]
    INTO Full_Medecians_Description
    FROM Medicians
    INNER JOIN Treatment_to_Medician ON Medicians.Id = Treatment_to_Medician.Medician_Id
    INNER JOIN Treatment ON Treatment_to_Medician.Treatment_id = Treatment_to_Medician.Treatment_id;

---52 вывести всех животных и по возможности их породы
SELECT * FROM Animal 
    LEFT OUTER JOIN Breeds ON Breeds.Id = Animal.Breed_Id;
--53 вывести все породы и по возможности животных у которых эта порода
SELECT * FROM Animal 
    RIGHT OUTER JOIN Breeds ON Breeds.Id = Animal.Breed_Id;
--54 вывести всех и животных и все порыды
SELECT * FROM Animal 
    FULL OUTER JOIN Breeds ON Breeds.Id = Animal.Breed_Id;
--55 вывести все рецепты и лекарства к ним
SELECT * FROM Treatment_to_Medician 
    RIGHT OUTER JOIN Medicians ON Medicians.Id = Treatment_to_Medician.Medician_Id
    INNER JOIN Treatment ON Treatment.Id = Treatment_to_Medician.Treatment_id; 
--56 вывести все возможные комбинации пород и животных
SELECT * FROM Animal
    CROSS JOIN Breeds;

---58 вывести максимальныю стоимость лекарства, которое прописано хотя бы в одном рецепте
SELECT MAX(Medicians.Price) FROM Treatment
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Treatment_id = Treatment.Id
    INNER JOIN Medicians ON Medicians.Id = Treatment_to_Medician.Medician_Id;
--59 вывести количество и имена всех лекарств которые числятся хотя бы в одном рецепте
SELECT COUNT(Medicians.Id) as [cout selled], Medicians.Name FROM Treatment
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Treatment_id = Treatment.Id
    INNER JOIN Medicians ON Medicians.Id = Treatment_to_Medician.Medician_Id
    group by Medicians.Name;
--60 вывести название и общую стоимость проданных лекарств
SELECT SUM(Medicians.Price) as [total price], Medicians.Name FROM Treatment
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Treatment_id = Treatment.Id
    INNER JOIN Medicians ON Medicians.Id = Treatment_to_Medician.Medician_Id
    group by Medicians.Name;
--61 вывсти рецепт у которогго срок лечения минимален
SELECT min(Count_Days) as [min count days] FROM Treatment;
--62 вывести максимальную стоимость лекарств
SELECT MAX(Price) as [max price] FROM Medicians;
--63 вывести первых 3 пользователей и отсортировать их в порядке возрастания
SELECT top(3) * FROM Users
    ORDER BY NAME ASC; --- ТУТ аналог LIMIT

--64 вывести имена и породы животных 
SELECT Name FROM Breeds
    UNION
    SELECT Name FROM Animal;

--65 вывести имена животных которые совпадают с именами пользователя
SELECT [Name] FROM Animal
    INTERSECT
SELECT Name FROM Users;
--66 вывести имена животных не совпадающие с именами пользователей
SELECT [Name] FROM Animal
    EXCEPT
SELECT Name FROM Users;

---67 Вывести все лечения у которых заболевание Орви
SELECT * FROM Treatment
    WHERE Disease_Id = 
    (SELECT Id FROM Diseases WHERE Name = 'Орви');

--68 вывести всех пользовотелей у которых др было позже хотя бы одного приема
SELECT * FROM Users
    WHERE Birthday < ANY
    (SELECT Date_Reception FROM Receptions);
--69 Вывести всех пользователей у которых длинна имени меньше чем у всех работников
SELECT * FROM Users
    WHERE LEN(Name) < ALL
    (SELECT LEN(Name) FROM Employers);
--70 вевсти всех пользователей у оторых есть животное и имя у него вася
SELECT * FROM Users
    WHERE EXISTS 
    (SELECT User_id FROM Animal
        WHERE User_Id = Users.Id
        AND Name = 'Вася');

---71  вывести первое имя пользователя и разделить имя фамилию и отчество 
SELECT value from string_split((SELECT top (1) Name from Users), ' ');
--72 вывести через запятую все имена пользователей
SELECT STRING_AGG(Name, ',') as [csv format] FROM Users;
---73 заменить у первого пользователя фамилию зубенко на mak$$im и вывести 
SELECT REPLACE((SELECT top (1) Name from Users), 'Зубенко', 'Mak$$im');

---74 вывести сумму всех проданных лекарств котоые были хотя бы в одном рецепте и цена в пределе от 20 до 100 и отсортировать их по возрастанию
SELECT top (100) SUM(Medicians.Price) as [total price], Medicians.Name FROM Treatment
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Treatment_id = Treatment.Id
    INNER JOIN Medicians ON Medicians.Id = Treatment_to_Medician.Medician_Id
    WHERE Price > 20 AND Price < 100
    group by  Medicians.Name
    ORDER by Medicians.Name ASC;
--75 
SELECT Employers.Name, Positions.Name as [Position], sum(Medicians.Price) over(Partition By Employers.Id) * 0.1 as [Percent]    
    FROM Employers 
    INNER JOIN Receptions ON Receptions.Emploer_Id = Employers.Id
    INNER JOIN Disease_To_Reception ON Disease_To_Reception.Reception_Id = Receptions.Id
    INNER JOIN Treatment ON Treatment.Disease_Id = Disease_To_Reception.Disease_Id
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Treatment_id = Treatment.Id
    INNER JOIN Medicians ON Treatment_to_Medician.Medician_Id = Medicians.Id
    Inner Join Positions ON Positions.Id = Employers.Id
    WHERE Receptions.Date_Reception > '19990101'
    ORDER BY Employers.Name DESC;
--76
SELECT top(100) SUM(Medicians.Price) as [total price], Medicians.Name FROM Treatment
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Treatment_id = Treatment.Id
    INNER JOIN Medicians ON Medicians.Id = Treatment_to_Medician.Medician_Id
    WHERE Medicians.Price > 0 and Medicians.Price < 100
    group by Medicians.Price, Medicians.Name
    ORDER BY Medicians.Name ASC;
--77
SELECT Name as [nAmE], COUNT(Name) as [count nAmE] FROM Employers
    INNER JOIN Receptions ON Receptions.Emploer_Id = Employers.Id
    GROUP BY Name
    HAVING count(Name) >= 2
    Order by [count nAmE] Desc;
--78
SELECT top(100) Medicians.Price, Medicians.Id, Medicians.Name, Receptions.Date_Reception FROM Medicians 
    INNER JOIN Treatment_to_Medician ON Treatment_to_Medician.Medician_id = Medicians.Id
    INNER JOIN Treatment ON Treatment.Id = Treatment_to_Medician.Treatment_id
    INNER JOIN Diseases ON Diseases.Id = Treatment.Disease_Id
    INNER JOIN Disease_To_Reception ON Diseases.Id = Disease_To_Reception.Disease_Id
    INNER JOIN Receptions ON Receptions.Id = Disease_To_Reception.Reception_Id
    where Receptions.Date_Reception >= '20200101'
    ORDER BY Medicians.Name ASC;

    --1. Сколько заданный пользователь за месяц  потратил всего 
--2. Для заданного филиала вывести топ 5 сотрудников по кол-ву приемов 
--3. Карточка для заданного животного до заболеваний 
--Добить до 90 запросов
