using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Application.Interfaces;
using Domain.Entities;
using Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Repositories
{
    public class MemberRepository : GenericRepository<UserMember>, IMemberRepository
    {
        protected readonly ApiAuthDbContext _context;

        public MemberRepository(ApiAuthDbContext context) : base(context)
        {
            _context = context;
        }

        public async Task<UserMember> GetByUserNameAsync(string userName)
        {
            return await _context.Members.Include(u => u.MemberRoles).ThenInclude(mr => mr.Role).FirstOrDefaultAsync(u => u.Username.ToLower() == userName.ToLower());
        }
    }
}