using Microsoft.EntityFrameworkCore; 
namespace Infrastructure.Data { 
    public class ApiAuthDbContext : DbContext { 
        public ApiAuthDbContext(DbContextOptions<ApiAuthDbContext> options) : base(options) {} 
    } 
} 
