using System.IO.Pipes;

Console.WriteLine("CLIENTE");

// El "." quiere decir que el servidor está en este mismo ordenador
using var cliente = new NamedPipeClientStream(".", "TuberiaPrueba", PipeDirection.InOut);

Console.WriteLine("Conectando con el servidor...");
try
{
    // Si en 5 segundos no encuentra el servidor salta una TimeoutException
    await cliente.ConnectAsync(5000);
}
catch (TimeoutException)
{
    Console.WriteLine("No se ha encontrado el servidor, ¿está abierto?");
    return;
}
Console.WriteLine("Conectado");

var escritor = new StreamWriter(cliente) { AutoFlush = true };
var lector = new StreamReader(cliente);

Console.Write("Escribe un mensaje: ");
string? mensaje = Console.ReadLine();

// Enviamos el mensaje en una línea y esperamos la respuesta
await escritor.WriteLineAsync(mensaje);
string? respuesta = await lector.ReadLineAsync();
Console.WriteLine("Respuesta: " + respuesta);
