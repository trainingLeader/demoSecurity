@echo off
SETLOCAL EnableDelayedExpansion
set condition=true
cd %~dp0
set DIR_EJECUCION=%cd%
set DIR_EJECUCION=%cd%
set /P API_NAME="Ingrese el nombre del proyecto WebApi: "
for %%I in (%DIR_EJECUCION%) do set nombreCarpeta=%%~nxI
REM Inicializa una variable para el arreglo vacío
title Generador de Proyecto Hexagonal - BreaklineStudio
set misProyectos=""
echo Nota de Recomendacion:
echo - El nombre del proyecto no debe contener simbolos.
echo - Evite usar espacios en blanco.
echo - No incluir numeros.
echo.
pause

:menu
	cls
	echo ==============================
	echo       MENU DE OPCIONES
	echo ==============================
	echo.
	echo 1. Creacion del proyecto base
	echo 2. Creacion de carpetas
	echo 3. Scripts Base
	echo 4. Entity Creator
	echo 5. Salir
	echo.
	SET /P choice="Seleccione una opcion (1-5): "

	IF "%choice%"=="1" GOTO selectName
	IF "%choice%"=="2" GOTO carpetas
    IF "%choice%"=="3" (
        SET /P confirmar="Ya creo el proyecto base y las carpetas iniciales ? (y/N): "
        IF /I "!confirmar!"=="y" (
            GOTO baseScript
        ) ELSE (
            echo Debes crear el proyecto base las carpetas primero. Volviendo al menu...
            pause
            GOTO menu
        )
    )
    IF "%choice%"=="4" GOTO centity
	IF "%choice%"=="5" GOTO endScript
	GOTO menu
:selectName
    dotnet new sln
    SET /P folderName="Introduce el nombre del proyecto WebApi: "
    dotnet new webapi -o !folderName!
    cls
	echo ==============================================
	echo       Agregando paquetes a WebApi Project
	echo ==============================================
	echo A continuacion se instalaran los siguientes paquetes en el proyecto:
    echo Microsoft.EntityFrameworkCore.Design --version 8.0.15
    echo AutoMapper --version 14.0.0
    echo Asp.Versioning.Http --version 8.1.0
    echo Microsoft.AspNetCore.Mvc.Versioning.ApiExplorer --version 5.1.0
    echo Microsoft.AspNetCore.Authentication.JwtBearer --version 8.0.15
    echo System.IdentityModel.Tokens.Jwt --version 8.9.0
    echo Serilog.AspNetCore --version 8.0.3
    pause
    dotnet add !folderName!\!folderName!.csproj package Microsoft.EntityFrameworkCore.Design --version 9.0.2
    SET app=Application
    cls
    echo  ********* Creacion proyecto application *********
    echo.
    dotnet new classlib -o !app!
    cls
	echo ===================================================
	echo       Creacion proyecto Infrastructure
    echo ===================================================
    echo  A continuacion se creara el proyecto de infraestructura
    echo  que contiene la configuracion de la base de datos y los
    echo  repositorios.
    echo  Recuerde que el nombre del proyecto no debe contener simbolos.
    echo  Evite usar espacios en blanco.
    echo  No incluir numeros.
    echo.
	echo ===================================================
    echo.
    pause
    SET persistencia=Infrastructure
    dotnet new classlib -o !persistencia!
	echo ===================================================
	echo       Agregando paquetes a Infrastructure Project
	echo ===================================================
    echo  A continuacion se instalaran los siguientes paquetes en el proyecto:
    echo  Microsoft.EntityFrameworkCore --version 8.0.15
    pause
    dotnet add !persistencia!\!persistencia!.csproj package Microsoft.EntityFrameworkCore --version 9.0.2
    cls
	echo ===================================================
	echo               Selector de SGBD a usar
	echo ===================================================
    echo  A continuacion Debe seleccionar el SGBD a usar:
    echo  P para usar PostgreSQL y M para usar MySQL
    echo  Recuerde que el SGBD debe estar instalado y configurado.
    echo  A continuacion se instalara el driver correspondiente.
    pause
    SET /P motor="Seleccione el SGBD Mysql(M) o Postgres(P) ? (M/P): "
    IF /I "!confirmar!"=="M" (
        echo Se instalara en el proyecto el Driver de MySQL...
        pause
        dotnet add !persistencia!\!persistencia!.csproj package Pomelo.EntityFrameworkCore.MySql --version 9.0.0-preview.3.efcore.9.0.0
    ) ELSE (
        echo Se instalara en el proyecto el Driver de PostgreSQL...
        pause
        dotnet add !persistencia!\!persistencia!.csproj package Npgsql.EntityFrameworkCore.PostgreSQL --version 9.0.2
        pause
    )
    cls
	echo ===================================================
	echo            Creacion del proyecto Domain
	echo ===================================================
    echo.
    pause
    SET dom=Domain
    dotnet new classlib -o !dom!
    cls
	echo ========================================================
	echo       Agregando proyectos API, Domain, Infrastructure 
	echo            y Application a la Solucion principal
	echo ========================================================
    echo.
    pause
    REM Agregando proyectos a la solucion
	echo %DIR_EJECUCION%
	pause
    dotnet sln %DIR_EJECUCION%\%nombreCarpeta%.sln add %folderName%\%folderName%.csproj
    dotnet sln %DIR_EJECUCION%\%nombreCarpeta%.sln add %app%\%app%.csproj
    dotnet sln %DIR_EJECUCION%\%nombreCarpeta%.sln add %dom%\%dom%.csproj
    dotnet sln %DIR_EJECUCION%\%nombreCarpeta%.sln add %persistencia%\%persistencia%.csproj
    cls
    echo  ********* Agregando referencias Entre proyectos *********
    echo.
    pause
    REM Agregando referencias entre proyectos
	echo %DIR_EJECUCION%\%app%
	pause
    cd %DIR_EJECUCION%\%app%
    dotnet add reference %DIR_EJECUCION%\%dom%\%dom%.csproj
    pause
    cd %DIR_EJECUCION%\%persistencia%
    pause
    dotnet add reference %DIR_EJECUCION%\%dom%\%dom%.csproj
    dotnet add reference %DIR_EJECUCION%\%app%\%app%.csproj
    cd %DIR_EJECUCION%\%folderName%
    pause
    dotnet add reference %DIR_EJECUCION%\%app%\%app%.csproj
    dotnet add reference %DIR_EJECUCION%\%persistencia%\%persistencia%.csproj
    pause
	GOTO menu
    :carpetas
        cls
        SET rootDir=%driveLetter%:\%projectName%
        echo ===========================================================
        echo       MENU DE OPCIONES SELECCIONE EL GRUPO DE CARPETAS
        echo ===========================================================
        echo.
        echo 1. Dtos,Services,Extensions,Helpers,Profiles (Recomendado WebApi)
        echo 2. Repository,UnitOfWork (Recomendado Application)
        echo 3. Entities,Interfaces (Recomendado Domain)
        echo 4. Data (Recomendado Persistence)
        echo 5. Folder Creator
        echo 6. Regresar al menu principal
        echo.
        SET /P choice="Seleccione una opción (1-6): "

        IF "%choice%"=="1" GOTO webapi
        IF "%choice%"=="2" GOTO app
        IF "%choice%"=="3" GOTO domain
        IF "%choice%"=="4" GOTO persistence
        IF "%choice%"=="5" GOTO mfolder
        GOTO menu
        :webapi
            SET /P folderName="Introduce el nombre del proyecto WebApi: "
            cd %DIR_EJECUCION%\%folderName%
            mkdir Controllers
            mkdir Middlewares
            mkdir Extensions
            mkdir Helpers
            mkdir Services
            mkdir Profiles
            GOTO carpetas
        :app
            SET folderName=Application
            cd %DIR_EJECUCION%\%folderName%
            mkdir Interfaces
            mkdir DTOs
            mkdir UseCases
            GOTO carpetas
        :domain
            SET folderName=Domain
            cd %DIR_EJECUCION%\%folderName%
            mkdir Entities
            GOTO carpetas
        :persistence
            SET folderName=Infrastructure
            cd %DIR_EJECUCION%\%folderName%
            mkdir Data
            cd %DIR_EJECUCION%\%folderName%
            mkdir Configuration
            cd %DIR_EJECUCION%\%folderName%
            mkdir Repositories
            cd %DIR_EJECUCION%\%folderName%
            mkdir UnitOfWork
            pause
            GOTO carpetas
        :mfolder
            cls
            echo ===========================================================
            echo       MENU DE OPCIONES CREACION DE CARPETAS
            echo ===========================================================
            echo.
            SET /P folderProject="Carpeta o Proyecto donde desea crear la carpeta: "
            cd %DIR_EJECUCION%\%folderProject%
            SET /P folderName="Introduce el nombre de la carpeta: "
            mkdir %folderName%
            pause
        :baseScript
            cls
            echo - El nombre del proyecto no debe contener simbolos.
            echo - Evite usar espacios en blanco.
            echo - No incluir numeros.
            echo.
            pause
            cls
            echo ===========================================================
            echo       MENU DE OPCIONES SELECCIONE EL GRUPO DE SCRIPTS
            echo ===========================================================
            echo.
            echo 1. Agregar script de Entity Base
            echo 2. Generar DbContext
            echo 3. Agregar IGenericRepository
            echo 4. Agregar Implementar GenericRepository
            echo 5. Agregar Extension de metodos
            echo 6. Crear unidad de trabajo
            echo 7. Crear Clase MappingProfiles
            echo 8. Implementar la unidad de trabajo
            echo 9. Crear Interfaces de repositories
            echo 10. Implementacion de los repositorios
            echo 11. Crear controlador de WebApi con UnitOfWork
            echo 12. Regresar al menu principal
            echo.
            SET /P choice="Seleccione una opción (1-12): "

            IF "%choice%"=="1" GOTO ebase
            IF "%choice%"=="2" GOTO confdbcontext
            IF "%choice%"=="3" GOTO grepository
            IF "%choice%"=="4" GOTO igrepository
            IF "%choice%"=="5" GOTO gextension
            IF "%choice%"=="6" GOTO unidadWork
            IF "%choice%"=="7" GOTO mapper
            IF "%choice%"=="8" GOTO iunidadt
            IF "%choice%"=="9" GOTO irepos
            IF "%choice%"=="10" GOTO implrepos
            IF "%choice%"=="11" GOTO cctrluw
            GOTO menu
            :ebase
                cls
                SET folderName=Domain
                cd %DIR_EJECUCION%\%folderName%
                echo ===========================================================
                echo       Agregando script de Entity Base
                echo ===========================================================
                echo.
                echo namespace Domain.Entities; > Entities\BaseEntity.cs
                echo public abstract class BaseEntity { >> Entities\BaseEntity.cs
                echo       public int Id { get; set; } >> Entities\BaseEntity.cs
                echo       public DateTime createdAt { get; set; } >> Entities\BaseEntity.cs
                echo       public DateTime? updatedAt { get; set; } >> Entities\BaseEntity.cs
                echo  } >> Entities\BaseEntity.cs
                echo. 
                echo SE HA CREADO LA ENTIDAD BASE EN EL PROYECTO DOMAIN
                pause
                GOTO basescript
            :confdbcontext
                cls
                SET folderName=Infrastructure
                cd %DIR_EJECUCION%\%folderName%
                echo ===========================================================
                echo       Agregando script de DbContext
                echo ===========================================================
                echo.
                SET /P apiName="Introduce el nombre del proyecto WebApi: "
                echo using Microsoft.EntityFrameworkCore; > Data\%apiName%DbContext.cs
                echo namespace Infrastructure.Data { >> Data\%apiName%DbContext.cs
                echo     public class %apiName%DbContext : DbContext { >> Data\%apiName%DbContext.cs
                echo         public %apiName%DbContext(DbContextOptions^<%apiName%DbContext^> options) : base(options) {} >> Data\%apiName%DbContext.cs
                echo     } >> Data\%apiName%DbContext.cs
                echo } >> Data\%apiName%DbContext.cs
                echo. 
                echo SE HA CREADO EL DbContext EN EL PROYECTO INFRASTRUCTURE
                pause
                GOTO basescript
            :grepository
                cls
                echo ===========================================================
                echo       Agregando script de IGenericRepository
                echo ===========================================================
                echo.
                echo using System.Linq.Expressions; > %DIR_EJECUCION%\Application\Interfaces\IGenericRepository.cs
                echo using Domain.Entities; >> %DIR_EJECUCION%\Application\Interfaces\IGenericRepository.cs
                echo namespace Application.Interfaces; >> %DIR_EJECUCION%\Application\Interfaces\IGenericRepository.cs
                echo public interface IGenericRepository^<T^> where T : BaseEntity { >> %DIR_EJECUCION%\Application\Interfaces\IGenericRepository.cs
                echo       Task^<T^> GetByIdAsync(int id); >> %DIR_EJECUCION%\Application\Interfaces\IGenericRepository.cs
                echo       Task^<IEnumerable^<T^>^> GetAllAsync(); >> %DIR_EJECUCION%\Application\Interfaces\IGenericRepository.cs
                echo       IEnumerable^<T^> Find(Expression^<Func^<T, bool^>^> expression); >> %DIR_EJECUCION%\Application\Interfaces\IGenericRepository.cs
                echo       void Add(T entity); >> %DIR_EJECUCION%\Application\Interfaces\IGenericRepository.cs
                echo       void AddRange(IEnumerable^<T^> entities); >> %DIR_EJECUCION%\Application\Interfaces\IGenericRepository.cs
                echo       void Remove(T entity); >> %DIR_EJECUCION%\Application\Interfaces\IGenericRepository.cs
                echo       void RemoveRange(IEnumerable^<T^> entities); >> %DIR_EJECUCION%\Application\Interfaces\IGenericRepository.cs
                echo       void Update(T entity); >> %DIR_EJECUCION%\Application\Interfaces\IGenericRepository.cs
                echo  } >> %DIR_EJECUCION%\Application\Interfaces\IGenericRepository.cs
                pause
                GOTO basescript
            :igrepository
                cls
                echo ===========================================================
                echo       Agregando Implementacion de IGenericRepository
                echo ===========================================================
                echo.
                REM === Definir carpeta destino ===
                SET folder=%DIR_EJECUCION%\Infrastructure\Repositories
                IF NOT EXIST %folder% (
                    mkdir %folder%
                )
                SET /P apiName="Introduce el nombre del proyecto WebApi: "
                SET file=%folder%\GenericRepository.cs
                echo using System.Linq.Expressions; > %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo using Application.Interfaces;>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo using Infrastructure.Data; >> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo using System.Collections.Generic; >> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo using Domain.Entities; >> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo using Microsoft.EntityFrameworkCore; >> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo namespace Infrastructure.Repositories; >> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo public class GenericRepository^<T^> : IGenericRepository^<T^> where T : BaseEntity { >> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         private readonly %apiName%DbContext _context;>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         public GenericRepository(%apiName%DbContext context)>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         {>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo             _context = context;>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         }>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         public virtual void Add(T entity)>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         {>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo             _context.Set^<T^>().Add(entity);>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         }>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         public virtual void AddRange(IEnumerable^<T^> entities)>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         {>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo             _context.Set^<T^>().AddRange(entities);>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         }>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         public virtual IEnumerable^<T^> Find(Expression^<Func^<T, bool^>^> expression)>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         {>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo             return _context.Set^<T^>().Where(expression);>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         }>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         public virtual async Task^<IEnumerable^<T^>^> GetAllAsync()>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         {>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo             return await _context.Set^<T^>().ToListAsync();>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         }>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         public virtual async Task^<T^> GetByIdAsync(int id)>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         {>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo             var entity = await _context.Set^<T^>().FindAsync(id) ?? throw new KeyNotFoundException($^"Entity with id {id} was not found.^");>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo             return entity;>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         }>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         public virtual Task^<T^> GetByIdAsync(string id)>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         {>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo             throw new NotImplementedException();>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         }>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         public virtual void Remove(T entity)>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         {>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo             _context.Set^<T^>().Remove(entity);>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         }>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         public virtual void RemoveRange(IEnumerable^<T^> entities)>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         {>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo             _context.Set^<T^>().RemoveRange(entities);>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         }>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         public virtual void Update(T entity)>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         {>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo             _context.Set^<T^>().Update(entity);>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo         }>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                echo }>> %DIR_EJECUCION%\Infrastructure\Repositories\GenericRepository.cs
                pause
                GOTO basescript
            :gextension
                cls
                SET /P apiName="Introduce el nombre del proyecto WebApi: "
                echo ===========================================================
                echo            Agregando Archivo de Extension
                echo ===========================================================
                echo.
                echo using Infrastructure.Repositories; > %DIR_EJECUCION%\%apiName%\Extensions\ApplicationServiceExtensions.cs
                echo namespace %apiName%.Extensions; >> %DIR_EJECUCION%\%apiName%\Extensions\ApplicationServiceExtensions.cs
                echo public static class ApplicationServiceExtensions { >> %DIR_EJECUCION%\%apiName%\Extensions\ApplicationServiceExtensions.cs
                echo         public static void ConfigureCors(this IServiceCollection services) ^=^> >> %DIR_EJECUCION%\%apiName%\Extensions\ApplicationServiceExtensions.cs
                echo             services.AddCors(options ^=^> >> %DIR_EJECUCION%\%apiName%\Extensions\ApplicationServiceExtensions.cs
                echo             { >> %DIR_EJECUCION%\%apiName%\Extensions\ApplicationServiceExtensions.cs
                echo                 options.AddPolicy("CorsPolicy", builder ^=^> >> %DIR_EJECUCION%\%apiName%\Extensions\ApplicationServiceExtensions.cs
                echo                     builder.AllowAnyOrigin()   // WithOrigins("https://dominio.com") >> %DIR_EJECUCION%\%apiName%\Extensions\ApplicationServiceExtensions.cs
                echo                            .AllowAnyMethod()   // WithMethods("GET","POST") >> %DIR_EJECUCION%\%apiName%\Extensions\ApplicationServiceExtensions.cs
                echo                            .AllowAnyHeader()); // WithHeaders("accept","content-type") >> %DIR_EJECUCION%\%apiName%\Extensions\ApplicationServiceExtensions.cs
                echo             }); >> %DIR_EJECUCION%\%apiName%\Extensions\ApplicationServiceExtensions.cs
                echo } >> %DIR_EJECUCION%\%apiName%\Extensions\ApplicationServiceExtensions.cs
                pause
                GOTO basescript
            :unidadWork
                cls
                echo ===========================================================
                echo            Agregando Archivo de UnitOfWork
                echo ===========================================================
                echo namespace Application.Interfaces; > %DIR_EJECUCION%\Application\Interfaces\IUnitOfWork.cs
                echo public interface IUnitOfWork { >> %DIR_EJECUCION%\Application\Interfaces\IUnitOfWork.cs
                echo         Task^<int^> SaveAsync(); >> %DIR_EJECUCION%\Application\Interfaces\IUnitOfWork.cs
                echo } >> %DIR_EJECUCION%\Application\Interfaces\IUnitOfWork.cs
                pause
                GOTO basescript
            :mapper
                cls 
                SET /P apiName="Introduce el nombre del proyecto WebApi: "
                echo ===========================================================
                echo            Agregando Archivo de MappingProfiles
                echo ===========================================================
                echo using AutoMapper; > %DIR_EJECUCION%\%apiName%\Profiles\MappingProfiles.cs
                echo using Domain.Entities; >> %DIR_EJECUCION%\%apiName%\Profiles\MappingProfiles.cs
                echo namespace Application.Profiles; >> %DIR_EJECUCION%\%apiName%\Profiles\MappingProfiles.cs
                echo public class MappingProfiles : Profile { >> %DIR_EJECUCION%\%apiName%\Profiles\MappingProfiles.cs
                echo         public MappingProfiles() { >> %DIR_EJECUCION%\%apiName%\Profiles\MappingProfiles.cs
                echo         } >> %DIR_EJECUCION%\%apiName%\Profiles\MappingProfiles.cs
                echo } >> %DIR_EJECUCION%\%apiName%\Profiles\MappingProfiles.cs
                pause
                GOTO basescript
            :iunidadt
                cls 
                SET /P apiName="Introduce el nombre del proyecto WebApi: "
                echo ===========================================================
                echo            Implementando la unidad de trabajo
                echo ===========================================================
                echo using Application.Interfaces; > %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                echo using Infrastructure.Data; >> %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                echo namespace Infrastructure.UnitOfWork; >> %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                echo public class UnitOfWork : IUnitOfWork,IDisposable >> %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                echo { >> %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                echo    private readonly %apiName%DbContext _context; >> %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                echo    public UnitOfWork(%apiName%DbContext context) >> %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                echo    { >> %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                echo        _context = context; >> %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                echo    } >> %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                echo    public void Dispose() >> %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                echo    { >> %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                echo        _context.Dispose(); >> %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                echo    } >> %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                echo    public async Task^<int^> SaveAsync() >> %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                echo    { >> %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                echo        return await _context.SaveChangesAsync(); >> %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                echo    } >> %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                echo } >> %DIR_EJECUCION%\Infrastructure\UnitOfWork\UnitOfWork.cs
                pause
                GOTO basescript
            :irepos
                cls
                SET /P entityName="Introduce el nombre De la entidad: "
                echo ===========================================================
                echo            Crear Interfaces de repositories
                echo ===========================================================
                echo.
                SET folder=%DIR_EJECUCION%\Application\Interfaces
                IF NOT EXIST %folder% (
                    mkdir %folder%
                )
                SET file=%folder%\I%entityName%Repository.cs
                echo using Domain.Entities; > %file%
                echo namespace Application.Interfaces; >> %file%
                echo public interface I%entityName%Repository : IGenericRepository^<%entityName%^> { >> %file%
                echo } >> %file%
                pause
                GOTO basescript
            :implrepos
                cls
                SET /P entityName="Introduce el nombre de la entidad: "
                echo ===========================================================
                echo            Implementacion de los repositorios
                echo ===========================================================
                echo.
                SET folder=%DIR_EJECUCION%\Infrastructure\Repositories
                SET file=%folder%\%entityName%Repository.cs
                IF NOT EXIST %folder% (
                    mkdir %folder%
                )
                IF EXIST %file% (
                    echo El archivo ya existe.
                    pause
                    GOTO implrepos
                ) 
                echo using Application.Interfaces; > %file%
                echo using Domain.Entities; >> %file%
                echo using Infrastructure.Data; >> %file%
                echo namespace Infrastructure.Repositories; >> %file%
                echo public class %entityName%Repository : GenericRepository^<%entityName%^>, I%entityName%Repository { >> %file%
                echo     private readonly %API_NAME%DbContext _context; >> %file%
                echo     public %entityName%Repository(%API_NAME%DbContext context) : base(context) {} >> %file%
                echo } >> %file%
                pause
                SET /P teb="Desea crear otra Implementacion de repositorio ? (y/N): "
                IF /I "!teb!"=="y" (
                    GOTO implrepos
                ) 
                GOTO basescript
            :cctrluw
                cls
                echo ===========================================================
                echo            Crear controlador de WebApi con UnitOfWork
                echo ===========================================================
                echo ===========================================================
                echo El nombre del controlador no debe contener simbolos.
                echo Evite usar espacios en blanco.
                echo No incluir numeros.
                echo Se recomienda usar nombres en plural.
                echo El asistente de creacion agregara el prefijo Controller por defecto.
                echo Recuerde que el nombre del controlador se usara como URL para hace peticiones.
                echo nameController Nombre del controlador, este nombre se usara en la URL.
                echo Recuerde que el nombre del controlador se usara como URL para hace peticiones.
                echo.
                echo nameProperty Nombre de la propiedad que expone el repositorio. Este nombre se.
                echo declara en la IUnityOfWork Ej. ISkillRepository Skills ^{ get; ^}.
                ECHO.
                echo paramTipoEnti Nombre del objeto que recibe los datos al momento de hacer.
                echo peticiones POTS o PUT.
                echo ===========================================================
                SET /P nameController="Introduce el nombre del controlador: "
                SET /P nameProperty="Introduce es el nombre de la propiedad que expone acceso al repositorio: "
                SET /P nameEntity="Introduce es el nombre de la entidad: "
                SET /P nameDto="Introduce el nombre del DTO: "
                SET /P nameVariable="Introduce el nombre de la variable que almacenara los resultados  : "
                SET /P paramTipoEnti="Nombre del paraametro de entrada :  : "
                echo.
                SET folder=%DIR_EJECUCION%\%API_NAME%\Controllers
                IF NOT EXIST %folder% (
                    mkdir %folder%
                )
                SET file=%folder%\%nameController%Controller.cs
                IF EXIST %file% (
                    echo El archivo controlador ya existe.
                    pause
                    GOTO cctrluw
                ) 
                echo using Application.Interfaces; > %file%
                echo using Domain.Entities; >> %file%
                echo using AutoMapper; >> %file%
                echo using Microsoft.AspNetCore.Mvc; >> %file%
                echo namespace %API_NAME%.Controllers; >> %file%
                echo public class %nameController%Controller : BaseApiController { >> %file%
                echo     private readonly IUnitOfWork _unitOfWork; >> %file%
                echo     private readonly IMapper _mapper; >> %file%
                echo     public %nameController%Controller(IUnitOfWork unitOfWork,IMapper mapper) { >> %file%
                echo         _unitOfWork = unitOfWork; >> %file%
                echo          _mapper = mapper; >> %file%
                echo     } >> %file%
                echo     ^[HttpGet^] >> %file%
                echo     ^[ProducesResponseType(StatusCodes.Status200OK)^] >> %file%
                echo     ^[ProducesResponseType(StatusCodes.Status400BadRequest)^] >> %file%
                echo      public async Task^<ActionResult^<IEnumerable^<%nameDto%^>^>^> Get() >> %file%
                echo      {>> %file%
                echo          var %nameVariable% = await _unitOfWork.%nameProperty%.GetAllAsync();>> %file%
                echo          return _mapper.Map^<List^<%nameDto%^>^>(%nameVariable%);>> %file%
                echo       }>> %file%
                echo      ^[HttpGet("{id}")^]>> %file%
                echo      ^[ProducesResponseType(StatusCodes.Status200OK)^]>> %file%
                echo      ^[ProducesResponseType(StatusCodes.Status400BadRequest)^]>> %file%
                echo       public async Task^<ActionResult^<%nameDto%^>^> Get(int id) >> %file%
                echo       {>> %file%
                echo           var %nameVariable% = await _unitOfWork.%nameProperty%.GetByIdAsync(id);>> %file%
                echo           if (%nameVariable% == null)>> %file%
                echo           {>> %file%
                echo               return NotFound($"Country with id {id} was not found.");>> %file%
                echo           }>> %file%
                echo               return _mapper.Map^<%nameDto%^>(%nameVariable%);>> %file%
                echo        }>> %file%
                echo      ^[HttpPost^]>> %file%
                echo      ^[ProducesResponseType(StatusCodes.Status201Created)^]>> %file%
                echo      ^[ProducesResponseType(StatusCodes.Status400BadRequest)^]>> %file%
                echo       public async Task^<ActionResult^<%nameEntity%^>^> Post(%nameDto% %paramTipoEnti%)>> %file%
                echo       {>> %file%
                echo           var %nameVariable% = _mapper.Map^<%nameEntity%^>(%paramTipoEnti%);>> %file%
                echo           _unitOfWork.%nameProperty%.Add(%nameVariable%);>> %file%
                echo           await _unitOfWork.SaveAsync();>> %file%
                echo           if (%paramTipoEnti% == null)>> %file%
                echo           {>> %file%
                echo               return BadRequest();>> %file%
                echo           }>> %file%
                echo           return CreatedAtAction(nameof(Post), new { id = %paramTipoEnti%.Id }, %paramTipoEnti%);>> %file%
                echo        }>> %file%
                echo      ^[HttpPut("{id}")^]>> %file%
                echo      ^[ProducesResponseType(StatusCodes.Status200OK)^]>> %file%
                echo      ^[ProducesResponseType(StatusCodes.Status404NotFound)^]>> %file%
                echo      ^[ProducesResponseType(StatusCodes.Status400BadRequest)^]>> %file%
                echo       public async Task^<IActionResult^> Put(int id, ^[FromBody^] %nameDto% %paramTipoEnti%) >> %file%
                echo       {>> %file%
                echo            if (%paramTipoEnti% == null) >> %file%
                echo                return NotFound(); >> %file%
                echo            var %nameVariable% = _mapper.Map^<%nameEntity%^>(%paramTipoEnti%); >> %file%
                echo            _unitOfWork.%nameProperty%.Update(%nameVariable%); >> %file%
                echo            await _unitOfWork.SaveAsync(); >> %file%
                echo            return Ok(%paramTipoEnti%); >> %file%
                echo        }>> %file%
                echo      ^[HttpDelete("{id}")^]>> %file%
                echo      ^[ProducesResponseType(StatusCodes.Status204NoContent)^]>> %file%
                echo      ^[ProducesResponseType(StatusCodes.Status404NotFound)^]>> %file%
                echo       public async Task^<IActionResult^> Delete(int id)>> %file%
                echo       {>> %file%
                echo           var %nameVariable% = await _unitOfWork.%nameProperty%.GetByIdAsync(id);>> %file%
                echo           if (%nameVariable% == null)>> %file%
                echo               return NotFound();>> %file%
                echo           _unitOfWork.%nameProperty%.Remove(%nameVariable%);>> %file%
                echo           await _unitOfWork.SaveAsync();>> %file%
                echo           return NoContent();>> %file%
                echo       } >> %file%
                echo } >> %file%
                SET /P teb="Desea crear otro Controlador ? (y/N): "
                IF /I "!teb!"=="y" (
                    GOTO cctrluw
                ) 
                GOTO basescript             
    :centity
        cls
        echo ===========================================================
        echo            Generador de Entidades
        echo ===========================================================
        echo.
        SET /P nombreEntidad="Introduce nombre de la entidad: "
        SET /P neb="Ingrese el nombre de la Entity Base: "
        SET file=%DIR_EJECUCION%\Domain\Entities\%nombreEntidad%.cs
        echo namespace Domain.Entities;  > %file%
        SET /P teb="Tiene Endidad Base ? (y/N): "
        IF /I "!teb!"=="y" (
        echo  public class %nombreEntidad% ^:^ %neb% >> %file%
        ) ELSE (
            echo     public class %nombreEntidad% >> %file%
        )
        echo  { >> %file%
        :loop
            cls
            echo.
            set /p dataType=Tipo de dato (ej: string, int, DateTime,double): 
            set /p propName=Nombre de la propiedad: 
            echo         public %dataType% %propName% { get; set; } >> %file%
            SET /P confirmar="Desea agregar otra propiedad ? (y/N): "
            IF /I "!confirmar!"=="y" (
                GOTO loop
            ) ELSE (
                GOTO cerrar
            )
            GOTO loop
        :cerrar
            echo  } >> %file%
            SET /P teb="Desea crear otra entidad ? (y/N): "
                IF /I "!teb!"=="y" (
                    GOTO centity
                ) 
        pause
        GOTO menu
    :endScript
        echo Gracias por usar nuestro selector!
        pause
        exit
ENDLOCAL