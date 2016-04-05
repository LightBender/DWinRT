module windows.runtime.iinspectable;

import windows.com;
import windows.runtime.types;
import windows.runtime.hstring;

mixin(uuid!(IInspectable, "AF86E2E0-B12D-4c6a-9C5A-D7AA65101E90"));
public interface IInspectable : IUnknown
{
	extern(Windows)
	{
		HRESULT GetIids(ulong *iidCount, IID **iids);
		HRESULT GetRuntimeClassName(HSTRING *className);
		HRESULT GetTrustLevel(TrustLevel *trustLevel);
	}
}