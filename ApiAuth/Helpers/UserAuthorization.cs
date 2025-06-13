namespace ApiIcfes.Helpers;

public class UserAuthorization
{
    public enum Rols
    {
        Administrator,
        Employee,
        Ceo
    }

    public const Rols rol_predeterminado = Rols.Employee;
}
