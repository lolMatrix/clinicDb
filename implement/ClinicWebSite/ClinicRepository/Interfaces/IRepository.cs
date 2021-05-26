using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicRepository.Interfaces
{
    interface IRepository<T>
    {
        T GetEntityById(int id);
        void Update(T entity);
        IEnumerable<T> GetAllElements();
        void Create(T entity);
        void Delete(T entity);
    }
}
