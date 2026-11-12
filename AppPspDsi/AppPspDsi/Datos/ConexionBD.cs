using MySqlConnector;

namespace AppPspDsi.Datos
{
    // Guarda los datos de conexión a MySQL y crea las conexiones para el resto de la app
    public static class ConexionBD
    {
        public const int Puerto = 3306;
        public const string BaseDatos = "clinica_veterinaria";

        // Cadena de conexión que se guarda cuando la prueba de conexión sale bien
        private static string? cadenaConexion;

        public static bool Conectado => cadenaConexion != null;

        // Monta la cadena con los datos de la pestaña Conexión y prueba a abrirla.
        // Si falla salta la excepción de MySQL
        public static async Task ConectarAsync(string servidor, string usuario, string contrasena)
        {
            var builder = new MySqlConnectionStringBuilder
            {
                Server = servidor,
                Port = Puerto,
                UserID = usuario,
                Password = contrasena,
                Database = BaseDatos,
                ConnectionTimeout = 5
            };

            string cadena = builder.ConnectionString;

            // Abrimos una conexión de prueba para ver que los datos son correctos
            await using (var conexion = new MySqlConnection(cadena))
            {
                await conexion.OpenAsync();
            }

            cadenaConexion = cadena;
        }

        public static void Desconectar()
        {
            cadenaConexion = null;
        }

        // Devuelve una conexión ya abierta, hay que usarla con await using para que se cierre
        public static async Task<MySqlConnection> AbrirConexionAsync()
        {
            if (cadenaConexion == null)
                throw new InvalidOperationException("No hay conexión con la base de datos. Conéctate primero en la pestaña Conexión.");

            var conexion = new MySqlConnection(cadenaConexion);
            await conexion.OpenAsync();
            return conexion;
        }
    }
}
