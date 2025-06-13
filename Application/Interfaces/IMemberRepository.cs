using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Domain.Entities;

namespace Application.Interfaces
{
    public interface IMemberRepository : IGenericRepository<UserMember>
    {
        Task<UserMember> GetByUserNameAsync (string userName);
    }
}