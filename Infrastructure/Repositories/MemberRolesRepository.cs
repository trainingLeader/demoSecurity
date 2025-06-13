using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Application.Interfaces;
using Domain.Entities;
using Infrastructure.Data;

namespace Infrastructure.Repositories
{
    public class MemberRolesRepository : GenericRepository<MemberRoles>, IMemberRolRepository
    {
        protected readonly ApiAuthDbContext _context;

        public MemberRolesRepository(ApiAuthDbContext context) : base(context)
        {
            _context = context;
        }
        
    }
}