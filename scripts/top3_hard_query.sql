use Clinic;

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