using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Application.Interfaces;
using Domain.Entities;
using Infrastructure.Data;

namespace Infrastructure.Repositories
{
    public class RolRepository : GenericRepository<Role>, IRolRepository
    {
        protected readonly ApiAuthDbContext _context;
        public RolRepository(ApiAuthDbContext context) : base(context)
        {
            _context = context; 
        }
                                                                  
    }
}