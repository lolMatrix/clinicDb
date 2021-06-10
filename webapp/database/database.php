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
        $ar = $this->connection->prepare("select * from Treatment order by Id offset ? rows fetch next 10 rows ONLY");
        $ar->bindValue(1, $offset, PDO::PARAM_INT);
        $ar->execute();
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
        $query = "select * from Treatment where Treatment.Id = ?";
        $ar = $this->connection->prepare($query);
        $ar->execute(array($id));
        return $ar->fetchAll();
    }

    public function getMediciansByTreatmentId(int $treatmentId)
    {
        $query = "select * from Treatment_to_Medician join Medicians on Medician_Id = Medicians.Id where Treatment_id = ?";
        $ar = $this->connection->prepare($query);
        $ar->execute(array($treatmentId));
        return $ar->fetchAll();
    }

    public function deleteTreatment(int $id)
    {
        $query = "delete from Treatment_to_Medician where Treatment_id = ?";
        $ar = $this->connection->prepare($query);
        $ar->execute(array($id));
        $query = "delete from Treatment where Id = ?";
        $ar = $this->connection->prepare($query);
        $ar->execute(array($id));
    }
    public function deleteMedician(int $id)
    {
        $query = "delete from Treatment_to_Medician where Medician_Id = ?";
        $ar = $this->connection->prepare($query);
        $ar->execute(array($id));
        $query = "delete from Medicians where Id = ?";
        $ar = $this->connection->prepare($query);
        $ar->execute(array($id));
    }

    public function addMedician(string $name, float $price, int $life)
    {
        $query = "insert into Medicians (Name, Price, Shelf_life) values (?, ?, ?)";
        $this->connection->beginTransaction();
        $ar = $this->connection->prepare($query);
        $ar->execute(array($name, $price, $life));
        $this->connection->commit();
    }

    public function addTreatment(string $name, int $countDays, int $life)
    {
        $query = "insert into Medicians (Name, Count_Days, Disease_Id) values (?, ?, 1)";
        $this->connection->beginTransaction();
        $ar = $this->connection->prepare($query);
        $ar->execute(array($name, $countDays));
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
        $query = "insert into Treatment_to_Medician (Treatment_id, Count, Medician_id) values (?, ?, ?)";
        $this->connection->beginTransaction();
        $ar = $this->connection->prepare($query);
        $ar->execute(array($treatmentId, $count, $medicianId));
        $this->connection->commit();
    }

    public function getTotalPrice(int $id)
    {
        $query = "select sum(Medicians.Price * Treatment_to_Medician.Count) from Treatment_to_Medician join Medicians on Medicians.Id = Medician_Id where Treatment_id = ?";
        $ar = $this->connection->prepare($query);
        $ar->execute(array($id));
        return $ar->fetchAll();
    }

    public function updateTreatment(int $id, string $description, int $days)
    {
        $query = "update Treatment set Description = ?, Count_Days = ? where Id = ?";
        $this->connection->beginTransaction();
        $ar = $this->connection->prepare($query);
        $ar->execute(array($description, $days, $id));
        $this->connection->commit();
    }

    public function getMedicianById(int $id)
    {
        $query = "select * from Medicians where Id = ?";
        $ar = $this->connection->prepare($query);
        $ar->execute(array($id));
        return $ar->fetchAll();
    }

    public function updateMedician(int $id, int $shelf, float $price, string $name)
    {
        $query = "update Medicians set Name = ?, Price = ?, Shelf_life = ? where Id = ?";
        $this->connection->beginTransaction();
        $ar = $this->connection->prepare($query);
        $ar->execute(array($name, $price, $shelf, $id));
        $this->connection->commit();
    }

    public function createTreatment(string $desc, int $count)
    {
        $query = "insert into Treatment (Description, Count_Days, Disease_Id) values (?, ?, 1)";
        $this->connection->beginTransaction();
        $ar = $this->connection->prepare($query);
        $ar->execute(array($desc, $count));
        $this->connection->commit();

        $query = "select * from Treatment";
        $ar = $this->connection->query($query);

        $arr = $ar->fetchAll();
        return end($arr)["Id"];
    }

    public function createMedician(string $name, float $price, int $shelf)
    {
        $query = "insert into Medicians (Name, Price, Shelf_life) values (:name, :price, :shelf)";
        $this->connection->beginTransaction();
        $ar = $this->connection->prepare($query);
        $ar->execute(array(":name" => $name, ":price" => $price, ":shelf" => $shelf));
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

    public function deleteMedicianToTreatment(int $treatmentId, int $medicianId)
    {
        $query = "delete from Treatment_to_Medician where Treatment_id = ? and Medician_Id = ?";
        $ar = $this->connection->prepare($query);
        $this->connection->beginTransaction();
        $ar->execute(array($treatmentId, $medicianId));   
        $this->connection->commit();
    }
}