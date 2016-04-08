import windows.runtime;
import std.stdio;

void main()
{
	writeln("Hello World!");
	auto temp = WinString("Hello Windows Runtime!");
	writeln(temp.toString());
}