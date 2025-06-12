using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Configuration
{
    public class RoleConfiguration : IEntityTypeConfiguration<Role>
    {
        public void Configure(EntityTypeBuilder<Role> builder)
        {
            builder.ToTable("rols");
            builder.HasKey(r => r.Id); // Establece la clave primaria
            builder.Property(p => p.Id)
                    .IsRequired();
            builder.Property(p => p.Name)
                    .IsRequired()
                    .HasMaxLength(80);
            builder.Property(p => p.Description)
                    .IsRequired();
        }
    }
}