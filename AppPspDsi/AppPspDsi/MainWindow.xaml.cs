using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace AppPspDsi
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private async void btnConectar_Click(object sender, RoutedEventArgs e)
        {
            // Si ya estamos conectados el botón sirve para desconectar
            if (ConexionBD.Conectado)
            {
                ConexionBD.Desconectar();
                MostrarEstadoConexion(false, "Sin conectar");
                return;
            }

            string servidor = txtServidor.Text.Trim();
            string usuario = txtUsuario.Text.Trim();

            if (servidor == "" || usuario == "")
            {
                MessageBox.Show("Rellena el servidor y el usuario.", "Conexión",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            btnConectar.IsEnabled = false;
            lblEstadoConexion.Content = "Conectando...";

            try
            {
                // Se hace con await para que la ventana no se congele mientras conecta
                await ConexionBD.ConectarAsync(servidor, usuario, pwdContrasena.Password);
                MostrarEstadoConexion(true, $"Conectado a {ConexionBD.BaseDatos} ({servidor}:{ConexionBD.Puerto})");
            }
            catch (Exception ex)
            {
                MostrarEstadoConexion(false, "Error de conexión");
                MessageBox.Show("No se ha podido conectar a la base de datos:\n" + ex.Message, "Conexión",
                    MessageBoxButton.OK, MessageBoxImage.Error);
            }
            finally
            {
                btnConectar.IsEnabled = true;
            }
        }

        private void MostrarEstadoConexion(bool conectado, string texto)
        {
            lblEstadoConexion.Content = texto;
            elpEstadoConexion.SetResourceReference(Shape.FillProperty,
                conectado ? "SystemFillColorSuccessBrush" : "SystemFillColorCriticalBrush");
            btnConectar.Content = conectado ? "Desconectar" : "Conectar";

            // Mientras estamos conectados no se pueden cambiar los datos
            txtServidor.IsEnabled = !conectado;
            txtUsuario.IsEnabled = !conectado;
            pwdContrasena.IsEnabled = !conectado;
        }
    }
}