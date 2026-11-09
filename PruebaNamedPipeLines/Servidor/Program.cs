using System.IO.Pipes;

Console.WriteLine("SERVIDOR");

// Creamos la tubería con nombre, en los dos sentidos para poder leer y contestar
using var servidor = new NamedPipeServerStream("TuberiaPrueba", PipeDirection.InOut);

Console.WriteLine("Esperando a que se conecte el cliente...");
await servidor.WaitForConnectionAsync();
Console.WriteLine("Cliente conectado");

var lector = new StreamReader(servidor);
// AutoFlush para que la respuesta se envíe al momento y no se quede en el búfer
var escritor = new StreamWriter(servidor) { AutoFlush = true };

// Leemos el mensaje del cliente, ReadLine espera hasta que llega una línea entera
string? mensaje = await lector.ReadLineAsync();
Console.WriteLine("Mensaje recibido: " + mensaje);

// Le contestamos por la misma tubería
await escritor.WriteLineAsync("El servidor ha recibido: " + mensaje);
Console.WriteLine("Respuesta enviada");
