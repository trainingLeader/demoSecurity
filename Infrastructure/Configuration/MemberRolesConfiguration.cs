using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Configuration
{
    public class MemberRolesConfiguration : IEntityTypeConfiguration<MemberRoles>
    {
        public void Configure(EntityTypeBuilder<MemberRoles> builder)
        {
            builder.ToTable("member_roles");
            builder.HasKey(mr => new { mr.RoleId, mr.MemberId });

            builder.HasOne(mr => mr.Role)
               .WithMany(s => s.MemberRoles)
               .HasForeignKey(mr => mr.RoleId);

            builder.HasOne(mr => mr.Member)
               .WithMany(s => s.MemberRoles)
               .HasForeignKey(mr => mr.MemberId);
        }
    }
}