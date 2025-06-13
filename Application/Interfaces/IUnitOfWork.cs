namespace Application.Interfaces; 
public interface IUnitOfWork { 
        IRolRepository Role{ get; }
        IMemberRepository UserMember{ get; }
        IMemberRolRepository MemberRol{ get; }
        Task<int> SaveAsync(); 
} 
