// -----------------------------------------------------------------------------
// VirtualResolutionTarget
// -----------------------------------------------------------------------------

module BaseLib

public abstract class VirtualResolutionTarget {
	protected let m_widget: wref<inkWidget>;

	public func ApplyState(state: ref<VirtualResolutionData>) -> Void
}
