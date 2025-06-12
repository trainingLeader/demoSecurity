using Application.DTOs.Auth;

namespace Application.Services;

public interface IUserService
{
    Task<string> RegisterAsync(RegisterDto model);
    Task <DataUserDto> GetTokenAsync(LoginDto model);
    Task<string> AddRoleAsync(AddRolDto model);
    //Task<DataUserDto> RefreshTokenAsync(string refreshToken);

}