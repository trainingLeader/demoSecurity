
namespace Domain.Entities
{
    public class Role : BaseEntity
    {
        public int Id { get; set; }
        public string? Name { get; set; }
        public string? Description { get; set; }
        public ICollection<MemberRoles>? MemberRoles { get; set; }
    }
}