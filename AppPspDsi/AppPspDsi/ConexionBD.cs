using MySqlConnector;

namespace AppPspDsi
{
    /// <summary>
    /// Guarda los datos de conexión a la base de datos MySQL local (puerto 3306)
    /// y crea las conexiones que usan el resto de pestañas.
    /// Los métodos son síncronos: es la ventana la que los lanza en otro hilo
    /// con Task.Run para no congelar la interfaz.
    /// </summary>
    public static class ConexionBD
    {
        public const int Puerto = 3306;
        public const string BaseDatos = "clinica_veterinaria";

        // Cadena de conexión que se guarda cuando la prueba de conexión sale bien
        private static string? cadenaConexion;

        public static bool Conectado => cadenaConexion != null;

        /// <summary>
        /// Monta la cadena de conexión con los datos de la pestaña Conexión
        /// y comprueba que se puede abrir. Si falla lanza la excepción de MySQL.
        /// </summary>
        public static void Conectar(string servidor, string usuario, string contrasena)
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
            using (var conexion = new MySqlConnection(cadena))
            {
                conexion.Open();
            }

            cadenaConexion = cadena;
        }

        public static void Desconectar()
        {
            cadenaConexion = null;
        }

        /// <summary>
        /// Devuelve una conexión nueva ya abierta. Hay que usarla con using
        /// para que se cierre al terminar (el pool de MySQL la reutiliza).
        /// </summary>
        public static MySqlConnection AbrirConexion()
        {
            if (cadenaConexion == null)
                throw new InvalidOperationException("No hay conexión con la base de datos. Conéctate primero en la pestaña Conexión.");

            var conexion = new MySqlConnection(cadenaConexion);
            conexion.Open();
            return conexion;
        }
    }
}
