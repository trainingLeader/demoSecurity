using Application.Interfaces;
using Application.Services;
using AutoMapper.Execution;
using Domain.Entities;
using Infrastructure.Repositories;
using Infrastructure.UnitOfWork;
using Microsoft.AspNetCore.Identity;
namespace ApiAuth.Extensions;

public static class ApplicationServiceExtensions
{
    public static void ConfigureCors(this IServiceCollection services) =>
        services.AddCors(options =>
        {
            options.AddPolicy("CorsPolicy", builder =>
                builder.AllowAnyOrigin()   // WithOrigins("https://dominio.com") 
                       .AllowAnyMethod()   // WithMethods("GET","POST") 
                       .AllowAnyHeader()); // WithHeaders("accept","content-type") 
        });

    public static void AddAplicationServices(this IServiceCollection services)
    {
        services.AddScoped<IPasswordHasher<UserMember>, PasswordHasher<UserMember>>();
        services.AddScoped <IUserService, UserService>();
        services.AddScoped<IUnitOfWork, UnitOfWork>();
        
    }
}
