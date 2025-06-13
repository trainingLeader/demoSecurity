using Application.Interfaces;
using Domain.Entities;
using Infrastructure.Data;
using Infrastructure.Repositories;
namespace Infrastructure.UnitOfWork;

public class UnitOfWork : IUnitOfWork, IDisposable
{
    private readonly ApiAuthDbContext _context;
    public UnitOfWork(ApiAuthDbContext context)
    {
        _context = context;
    }
    private IMemberRepository _memberRepository;
    private IRolRepository _roleRepository;
    private IMemberRolRepository _memberRolRepository;

    public void Dispose()
    {
        _context.Dispose();
    }
    public async Task<int> SaveAsync()
    {
        return await _context.SaveChangesAsync();
    }

    public IRolRepository Role
    {
        get
        {
            if (_roleRepository == null)
            {
                _roleRepository = new RolRepository(_context);
            }
            return _roleRepository;
        }
    }

    public IMemberRepository Member
    {
        get
        {
            if (_memberRepository == null)
            {
                _memberRepository = new MemberRepository(_context);
            }
            return _memberRepository;
        }
    }

    public IMemberRolRepository MemberRol
    {
        get
        {
            if (_memberRolRepository == null)
            {
                _memberRolRepository = new MemberRolesRepository(_context);
            }
            return _memberRolRepository;
        }
    }
   

} 
