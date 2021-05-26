using Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicRepository.Interfaces
{
    class EmployersData : IDataMaper<Employer>
    {
        private List<Employer> _employers;
        private string _connectionString;

        public EmployersData(string connection)
        {
            _connectionString = connection;
        }

        public void Create(Employer entity)
        {
            List<Employer> employers = new List<Employer>();
            using (SqlConnection sqlConnection = new SqlConnection(_connectionString))
            {
                sqlConnection.Open();

                using (var command = sqlConnection.CreateCommand())
                {
                    command.CommandText = $"INSERT INTO Positions (...) VALUES ('{entity.position.Name}')";
                    command.ExecuteNonQuery();
                }

                using(var command = sqlConnection.CreateCommand())
                {
                    command.CommandText = $"INSERT INTO Employers (Id, Name, Position_Id) VALUES ({entity.Id}, '{entity.Name}', {entity.position.Id})";
                    command.ExecuteNonQuery();
                }

                _employers.Add(entity);
            }
        }

        public void Delete(Employer entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Employer> GetAll()
        {
            List<Employer> employers = new List<Employer>();
            using (SqlConnection sqlConnection = new SqlConnection(_connectionString))
            {
                sqlConnection.Open();

                using (var command = sqlConnection.CreateCommand())
                {
                    command.CommandText = "SELECT * FROM Employers";
                    
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Employer e = new Employer();
                            e.Id = reader.GetInt32(0);
                            e.Name = reader.GetString(1);
                            employers.Add(e);
                        }
                    }
                }
            }

            return employers;
        }

        public void Update(Employer entity)
        {
            throw new NotImplementedException();
        }
    }
}
