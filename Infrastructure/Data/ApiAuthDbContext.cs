using Microsoft.EntityFrameworkCore; 
using Domain.Entities;
namespace Infrastructure.Data {
    public class ApiAuthDbContext : DbContext
    {
        public ApiAuthDbContext(DbContextOptions<ApiAuthDbContext> options) : base(options) { }

        public DbSet<Member> Members { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<MemberRoles> MembersRoles { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.ApplyConfigurationsFromAssembly(typeof(ApiAuthDbContext).Assembly);
        }

    } 
} 
