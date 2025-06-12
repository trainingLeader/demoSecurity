using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Security.Claims;
using System.Text;
using ApiAuth.Helpers;
using Application.DTOs.Auth;
using Application.Interfaces;
using Domain.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;

namespace Application.Services;

public class UserService : IUserService
{
    private readonly JWT _jwt;
    private readonly IUnitOfWork _unitOfWork;
    public Task<string> AddRoleAsync(AddRolDto model)
    {
        throw new NotImplementedException();
    }

    public Task<DataUserDto> GetTokenAsync(LoginDto model)
    {
        throw new NotImplementedException();
    }

    public Task<string> RegisterAsync(RegisterDto model)
    {
        throw new NotImplementedException();
    }
}