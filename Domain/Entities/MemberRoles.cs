using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Domain.Entities
{
    public class MemberRoles : BaseEntity
    {
        public int MemberId { get; set; }
        public Member? Member { get; set; } 
        public int RoleId { get; set; }
        public Role? Role { get; set; }
    }
}