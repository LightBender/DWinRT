import windows.runtime;
import std.stdio;

void main(string[] args)
{
	RoInitialize();

	WinString tln = new WinString("Windows");
	WinString[] namespaces;
	WinString[] mdfiles;

	writeln("Resolved Namespaces:");
	ResolveNamespaces(tln, namespaces, mdfiles);
	writeln("Total Namespaces: ", namespaces.length);
	foreach(WinString n; namespaces)
	{
		writeln(n.toString());
	}

	foreach(WinString n; mdfiles)
	{
		auto mdi = OpenWindowsMetadata(n);
		if(mdi is null) continue;

	}

	RoUninitialize();
}

void ResolveNamespaces(WinString rootNamespace, ref WinString[] namespaces, ref WinString[] mdfiles)
{
	uint mdfplc;
	HSTRING* mdfpl;
	uint snlc;
	HSTRING* snl;

	HRESULT rrnr = RoResolveNamespace(rootNamespace.toHString(), null, 0, null, &mdfplc, &mdfpl, &snlc, &snl);
	if(rrnr != S_OK)
	{
		writeln("Error resolving namespaces!");
		return;
	}

	HSTRING[] mdfl;
	mdfl = mdfpl[0..mdfplc];
	foreach(HSTRING mdf; mdfl)
		mdfiles ~= new WinString(mdf);

	HSTRING[] snls = snl[0..snlc];
	foreach(HSTRING sn; snls)
	{
		WinString t = rootNamespace ~ new WinString(".") ~ new WinString(sn);
		namespaces ~= t;
		ResolveNamespaces(t, namespaces, mdfiles);
	}
}

IMetaDataImport OpenWindowsMetadata(WinString mdfile)
{
	writeln("Opening WinMD File: " ~ mdfile.toString());

	LPVOID mddp = null;
	HRESULT mddr = MetaDataGetDispenser(&CLSID_IMetaDataDispenserEx, &IID_IMetaDataDispenserEx, &mddp);
	if(mddr != S_OK)
	{
		writeln(mddr);
	}
	IMetaDataDispenserEx mdd = cast(IMetaDataDispenserEx)mddp;
	if(mdd is null)
	{
		writeln("Metadata Dispenser is null");
		return null;
	}

	IUnknown imdi;
	HRESULT mddosr = mdd.OpenScope(mdfile.toString16().toStringz(), CorOpenFlags.ofReadOnly, &IID_IMetaDataImport2, &imdi);
	if(mddosr != S_OK)
	{
		writeln(mddr);
	}
	IMetaDataImport2 mdi = cast(IMetaDataImport2)imdi;
	if(mdi is null)
	{
		writeln("Metadata Importer is null");
		return null;
	}
	return mdi;
}