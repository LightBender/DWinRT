module windows.config;

version(Windows80)
{
	enum bool Runtime80 = true;
	enum bool Runtime81 = false;
	enum bool Runtime100 = false;
}
else version(Windows81)
{
	enum bool Runtime80 = true;
	enum bool Runtime81 = true;
	enum bool Runtime100 = false;
}
else version(Windows100)
{
	enum bool Runtime80 = true;
	enum bool Runtime81 = true;
	enum bool Runtime100 = true;
}
else{
	static assert(0);
}