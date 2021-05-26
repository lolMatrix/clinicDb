using ClinicRepository.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicRepository
{
    abstract class Repository<T> : IRepository<T>
    {
        protected List<T> _entities;
        protected IDataMaper<T> _data;

        public Repository(IDataMaper<T> data)
        {
            _data = data;
            _entities = data.GetAll().ToList();
        }

        public void Create(T entity)
        {

        }

        public void Delete(T entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<T> GetAllElements()
        {
            return _entities.ToArray();
        }

        public abstract T GetEntityById(int id);

        public void Update(T entity)
        {
            throw new NotImplementedException();
        }
    }
}
