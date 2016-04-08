import windows.runtime;
import std.stdio;

void main()
{
	RoInitialize();
	writeln("Hello World!");
	auto temp = WinString("Hello Windows Runtime!");
	writeln(temp.toString());
	RoUninitialize();
}