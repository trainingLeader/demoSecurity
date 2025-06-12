using Application.Interfaces; 
using Infrastructure.Data; 
namespace Infrastructure.UnitOfWork; 
public class UnitOfWork : IUnitOfWork,IDisposable 
{ 
   private readonly ApiAuthDbContext _context; 
   public UnitOfWork(ApiAuthDbContext context) 
   { 
       _context = context; 
   } 
   public void Dispose() 
   { 
       _context.Dispose(); 
   } 
   public async Task<int> SaveAsync() 
   { 
       return await _context.SaveChangesAsync(); 
   } 
} 
