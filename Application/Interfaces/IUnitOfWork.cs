namespace Application.Interfaces; 
public interface IUnitOfWork { 
        IRolRepository rolRepository{ get; }
        IMemberRepository memberRepository{ get; }
        IMemberRolRepository memberRolRepository{ get; }
        Task<int> SaveAsync(); 
} 
