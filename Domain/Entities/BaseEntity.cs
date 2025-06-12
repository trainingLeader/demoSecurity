namespace Domain.Entities; 
public abstract class BaseEntity { 
      public int Id { get; set; } 
      public DateTime createdAt { get; set; } 
      public DateTime? updatedAt { get; set; } 
 } 
