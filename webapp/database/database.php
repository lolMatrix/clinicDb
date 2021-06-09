<?
class Database{
    private $connection;
    

    public function __construct($username, $password, $host, $db)
    {
        $this->connection = new PDO("sqlsrv:Server=$host;Database=$db", $username, $password); 
    }

    public function checkConnect(){
        return $this->connection->errorInfo();
    }

    public function getAllTreatments(int $page = 1){
        $offset = ($page - 1) * 10;
        $query = "select * from Treatment order by Id offset $offset rows fetch next 10 rows ONLY";
        $ar = $this->connection->query($query);
        return $ar->fetchAll();
    }

    public function countTreatments()
    {
        $query = "select count(Id) from Treatment";
        $ar = $this->connection->query($query);
        return $ar->fetchAll();
    }

    public function getTreatmentById(int $id)
    {
        $query = "select * from Treatment where Treatment.Id = $id";
        $ar = $this->connection->query($query);
        return $ar->fetchAll();
    }

    public function getMediciansByTreatmentId(int $treatmentId)
    {
        $query = "select * from Treatment_to_Medician join Medicians on Medician_Id = Medicians.Id where Treatment_id = $treatmentId";
        $ar = $this->connection->query($query);
        return $ar->fetchAll();
    }

    public function deleteTreatment(int $id)
    {
        $query = "delete from Treatment_to_Medician where Treatment_id = $id";
        $this->connection->query($query);
        $query = "delete from Treatment where Id = $id";
        $this->connection->query($query);
    }
    public function deleteMedician(int $id)
    {
        $query = "delete from Treatment_to_Medician where Medician_Id = $id";
        $this->connection->query($query);
        $query = "delete from Medicians where Id = $id";
        $this->connection->query($query);
    }

    public function addMedician(string $name, float $price, int $life)
    {
        $query = "insert into Medicians (Name, Price, Shelf_life) values ('$name', $price, $life)";
        $this->connection->beginTransaction();
        $this->connection->exec($query);
        $this->connection->commit();
    }

    public function addTreatment(string $name, int $countDays, int $life)
    {
        $query = "insert into Medicians (Name, Count_Days, Disease_Id) values ('$name', $countDays, 1)";
        $this->connection->beginTransaction();
        $this->connection->exec($query);
        $this->connection->commit();
    }

    public function getAllMedicians()
    {
        $query = "select * from Medicians";
        $ar = $this->connection->query($query);
        return $ar->fetchAll();
    }

    public function addMedicianToTreatment(int $treatmentId, int $medicianId, int $count)
    {
        $query = "insert into Treatment_to_Medician (Treatment_id, Count, Medician_id) values ($treatmentId, $count, $medicianId)";
        $this->connection->beginTransaction();
        $this->connection->exec($query);
        $this->connection->commit();
    }

    public function getTotalPrice(int $id)
    {
        $query = "select sum(Medicians.Price * Treatment_to_Medician.Count) from Treatment_to_Medician join Medicians on Medicians.Id = Medician_Id where Treatment_id = $id";
        $ar = $this->connection->query($query);
        return $ar->fetchAll();
    }

    public function updateTreatment(int $id, string $description, int $days)
    {
        $query = "update Treatment set Description = '$description', Count_Days = $days where Id = $id";
        $this->connection->beginTransaction();
        $this->connection->exec($query);
        $this->connection->commit();
    }

    public function getMedicianById(int $id)
    {
        $query = "select * from Medicians where Id = $id";
        $ar = $this->connection->query($query);
        return $ar->fetchAll();
    }

    public function updateMedician(int $id, int $shelf, float $price, string $name)
    {
        $query = "update Medicians set Name = '$name', Price = $price, Shelf_life = $shelf where Id = $id";
        $this->connection->beginTransaction();
        $this->connection->exec($query);
        $this->connection->commit();
    }

    public function createTreatment(string $desc, int $count)
    {
        $query = "insert into Treatment (Description, Count_Days, Disease_Id) values ('$desc', $count, 1)";
        $this->connection->beginTransaction();
        $this->connection->exec($query);
        $this->connection->commit();

        $query = "select * from Treatment";
        $ar = $this->connection->query($query);

        $arr = $ar->fetchAll();
        return end($arr)["Id"];
    }

    public function createMedician(string $name, float $price, int $shelf)
    {
        $query = "insert into Medicians (Name, Price, Shelf_life) values ('$name', $price, $shelf)";
        $this->connection->beginTransaction();
        $this->connection->exec($query);
        $this->connection->commit();

        $query = "select * from Medicians";
        $ar = $this->connection->query($query);

        $arr = $ar->fetchAll();
        return end($arr)["Id"];
    }

    public function getStats()
    {
        $query = "select sum(Treatment_to_Medician.Count) as count, sum(Treatment_to_Medician.Count * Medicians.Price) as totalSum, Medicians.Name from Medicians join Treatment_to_Medician on Medician_Id = Id Group By Name Order by totalSum desc";
        $ar = $this->connection->query($query);
        return $ar->fetchAll();
    }
}